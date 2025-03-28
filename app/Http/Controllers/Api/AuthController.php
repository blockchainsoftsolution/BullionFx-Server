<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\EmailVerifyRequest;
use App\Http\Requests\Api\ForgotPasswordRequest;
use App\Http\Requests\Api\ResetPasswordRequest;
use App\Http\Requests\Api\ResendVerificationEmailCodeRequest;
use App\Http\Requests\Api\SignUpRequest;
use App\Http\Requests\Api\LoginRequest;
use App\Http\Services\AuthService;
use App\Http\Services\Logger;
use App\Http\Services\MyCommonService;
use App\Http\Services\User2FAService;
use App\Http\Services\ThirdPartyKYCService;
use App\Models\UserVerificationCode;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Session;
use PharIo\Version\Exception;
use PragmaRX\Google2FA\Google2FA;
use Illuminate\Support\Facades\RateLimiter;
use App\Http\Services\GeeTestService;

class AuthController extends Controller
{
    public $service;
    public $myCommonService;
    public $geeTestService;
    public function __construct()
    {
        $this->service = new AuthService;
        $this->myCommonService = new MyCommonService;
        $this->geeTestService = new GeeTestService;
        $this->thirdPartyKYCService = new ThirdPartyKYCService;
    }
    // sign up api
    public function signUp(SignUpRequest $request)
    {
        try {
            if (!filter_var($request['email'], FILTER_VALIDATE_EMAIL)) {
                $response = ['success' => false, 'message' => __('Invalid email address'), 'data' => (object) []];
                return response()->json($response);
            }
            $agent = checkUserAgent($request);
            if ($agent == 'android' || $agent == 'ios') {
            } else {
                if (isset(allsetting()['select_captcha_type']) && (allsetting()['select_captcha_type'] == CAPTCHA_TYPE_GEETESTCAPTCHA)) {
                    $geetest_response = $this->geeTestService->checkValidation($request);
                    if (!$geetest_response['success']) {
                        return response()->json($geetest_response);
                    }
                }
            }
            $result = $this->service->signUpProcess($request);
            return response()->json($result);
        } catch (\Exception $e) {
            storeException('signUp', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => (object) []];
            return response()->json($response);
        }
    }

    // verify email
    public function verifyEmail(EmailVerifyRequest $request)
    {
        try {
            if (!filter_var($request['email'], FILTER_VALIDATE_EMAIL)) {
                $response = ['success' => false, 'message' => __('Invalid email address'), 'data' => (object) []];
                return response()->json($response);
            }
            $agent = checkUserAgent($request);
            if ($agent == 'android' || $agent == 'ios') {
            } else {
                if (isset(allsetting()['select_captcha_type']) && (allsetting()['select_captcha_type'] == CAPTCHA_TYPE_GEETESTCAPTCHA)) {
                    $geetest_response = $this->geeTestService->checkValidation($request);
                    if (!$geetest_response['success']) {
                        return response()->json($geetest_response);
                    }
                }
            }

            $result = $this->service->verifyEmailProcess($request);
            return response()->json($result);
        } catch (\Exception $e) {
            storeException('verifyEmail', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => (object) []];
            return response()->json($response);
        }
    }

    // login process
    public function signIn(LoginRequest $request)
    {
        try {
            $agent = checkUserAgent($request);
            if ($agent == 'android' || $agent == 'ios') {
            } else {
                if (isset(allsetting()['select_captcha_type']) && (allsetting()['select_captcha_type'] == CAPTCHA_TYPE_GEETESTCAPTCHA)) {
                    $geetest_response = $this->geeTestService->checkValidation($request);

                    if (!$geetest_response['success']) {
                        return response()->json($geetest_response);
                    }
                }
            }

            $data['success'] = false;
            $data['message'] = '';
            $data['user'] = (object) [];
            $user = User::where('email', $request->email)->first();

            if (!empty($user)) {
                if (!$request->login_type || $user->login_type == $request->login_type) {
                    if ($user->role == USER_ROLE_USER) {
                        if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
                            $token = $user->createToken($request->email)->plainTextToken;
                            //Check email verification
                            if ($user->status == STATUS_SUCCESS) {
                                // if (!empty($user->is_verified)) {
                                $data['success'] = true;
                                $data['message'] = __('Login successful');
                                $data['email_verified'] = $user->is_verified;
                                create_user_wallet(Auth::id(), $request->wallet_address, $request->chainId);
                                if ($user->g2f_enabled == STATUS_ACTIVE) {
                                    $data['g2f_enabled'] = $user->g2f_enabled;
                                    $data['message'] = __('Please verify two factor authentication to get access ');
                                }
                                if ($user->email_enabled == STATUS_ACTIVE) {
                                    $data['email_enabled'] = $user->email_enabled;
                                    $data['message'] = __('Please verify two factor authentication to get access ');
                                }
                                if ($user->phone_enabled == STATUS_ACTIVE) {
                                    $data['phone_enabled'] = $user->phone_enabled;
                                    $data['message'] = __('Please verify two factor authentication to get access ');
                                }
                                if ($user->g2f_enabled == STATUS_DEACTIVE && $user->email_enabled == STATUS_DEACTIVE && $user->phone_enabled == STATUS_DEACTIVE) {
                                    $data['token'] = $token;
                                    $data['access_type'] = 'Bearer';
                                }
    
                                $data['user'] = $user;
                                $data['user']->photo = show_image_path($user->photo, IMG_USER_PATH);
                                createUserActivity(Auth::user()->id, (int) $request->chainId, USER_ACTIVITY_LOGIN);
    
                                return response()->json($data);
                            } elseif ($user->status == STATUS_SUSPENDED) {
                                $data['email_verified'] = 1;
                                $data['success'] = false;
                                $data['message'] = __("Your account has been suspended. please contact support team to active again");
                                Auth::logout();
                                return response()->json($data, 401);
                            } elseif ($user->status == STATUS_DELETED) {
                                $data['email_verified'] = 1;
                                $data['success'] = false;
                                $data['message'] = __("Your account has been deleted. please contact support team to active again");
                                Auth::logout();
                                return response()->json($data, 401);
                            } elseif ($user->status == STATUS_PENDING) {
                                $data['email_verified'] = 1;
                                $data['success'] = false;
                                $data['message'] = __("Your account has been pending for admin approval. please contact support team to active again");
                                Auth::logout();
                                return response()->json($data, 401);
                            } elseif ($user->status == STATUS_USER_DEACTIVATE) {
                                $data['email_verified'] = 1;
                                $data['success'] = false;
                                $data['message'] = __("Your account has been deactivated. please contact support team to active again");
                                Auth::logout();
                                return response()->json($data, 401);
                            } else {
                                $data['success'] = false;
                                $data['message'] = __("User not found!");
                                return response()->json($data, 401);
                            }
                        } else {
                            $data['success'] = false;
                            $data['message'] = __("Email or Password doesn't match");
                            return response()->json($data, 400);
                        }
                    } else {
                        $data['success'] = false;
                        $data['message'] = __("You have no login access");
                        Auth::logout();
                        return response()->json($data, 404);
                    }
                }
                else {
                    return response()->json(['error' => 'The login type is not correct. Please keep the first login type.'], 401);
                }
            } else {
                $result = $this->service->signUpProcess($request);
                if ($result['success']) {
                    $user = $result['data'];
                    create_user_wallet($user->id, $request->wallet_address, $request->chainId);
                    $kycStatus = $this->thirdPartyKYCService->createApplicant($user);
                    if ($kycStatus['success']) $response = $this->signIn($request);
                    return $response;
                } else {
                    $data['success'] = false;
                    $data['message'] = __("An error while creating a new account");
                    return response()->json($data, 500);
                }
            }
        } catch (\Exception $e) {
            storeException('signIn', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong with signin'), 'data' => []];
            return response()->json($response, 500);
        }

    }

    // forgot password
    public function forgotPassword(ForgotPasswordRequest $request)
    {
        try {
            $agent = checkUserAgent($request);
            if ($agent == 'android' || $agent == 'ios') {
            } else {
                if (isset(allsetting()['select_captcha_type']) && (allsetting()['select_captcha_type'] == CAPTCHA_TYPE_GEETESTCAPTCHA)) {
                    $geetest_response = $this->geeTestService->checkValidation($request);
                    if (!$geetest_response['success']) {
                        return response()->json($geetest_response);
                    }
                }
            }

            $response = $this->service->sendForgotMailProcess($request);
            return response()->json($response);
        } catch (\Exception $e) {
            storeException('forgotPassword', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => (object) []];
            return response()->json($response);
        }
    }
    //verfiy email resend code
    public function resendVerifyEmailCode(ResendVerificationEmailCodeRequest $request)
    {
        try {
            $executed = RateLimiter::attempt(
                'send-message:' . $request->ip(),
                $perMinute = 1,
                function () {
                }
            );
            if (!$executed) {
                $response = ['success' => false, 'message' => __('You requested too many times, please wait a minute!')];
            } else {
                $response = $this->service->resendVerifyEmailCode($request);
            }
        } catch (\Exception $e) {
            storeException('resendVerifyEmailCode', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong')];
        }

        return response()->json($response);
    }

    // reset password
    public function resetPassword(ResetPasswordRequest $request)
    {
        try {
            $agent = checkUserAgent($request);
            if ($agent == 'android' || $agent == 'ios') {
            } else {
                if (isset(allsetting()['select_captcha_type']) && (allsetting()['select_captcha_type'] == CAPTCHA_TYPE_GEETESTCAPTCHA)) {
                    $geetest_response = $this->geeTestService->checkValidation($request);
                    if (!$geetest_response['success']) {
                        return response()->json($geetest_response);
                    }
                }
            }

            $response = $this->service->passwordResetProcess($request);
            return response()->json($response);
        } catch (\Exception $e) {
            storeException('resetPassword', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => (object) []];
            return response()->json($response);
        }
    }

    // verify g2fa code
    public function g2fVerify(Request $request)
    {
        try {
            $response = $this->service->g2fVerifyProcess($request);
            return response()->json($response);
        } catch (\Exception $e) {
            storeException('g2fVerify', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => (object) []];
            return response()->json($response);
        }
    }

    public function twoFactorList()
    {
        $twoFactor = new User2FAService();
        $response = $twoFactor->twoFactorList(Auth::user());
        return response()->json($response);
    }

    public function twoFactorSave(Request $request)
    {
        try {
            $two_factor = new User2FAService();
            $response = $two_factor->updateTwoFactor($request, Auth('api')->user());
            return response()->json($response);
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => (object) []];
            storeException("twoFactorSave : ", $e->getMessage());
            return response()->json($response);
        }
    }

    public function twoFactorGoogleSetup(Request $request)
    {
        try {
            if ($request->isMethod("post")) {
                $two_factor = new User2FAService();
                $response = $two_factor->g2fSecretSave($request);
                return response()->json($response);
            }
            $google2fa = new Google2FA();
            // $google2fa->setAllowInsecureCallToGoogleApis(true);
            $data['google2fa_secret'] = $google2fa->generateSecretKey();
            $default = settings();
            // $google2fa_url = $google2fa->getQRCodeGoogleUrl(
            //     isset($default['app_title']) && !empty($default['app_title']) ? $default['app_title'] : 'Tredexpro',
            //     isset(Auth::user()->email) && !empty(Auth::user()->email) ? Auth::user()->email : 'admin@bullionfx.com',
            //     $data['google2fa_secret']
            // );
            $issuer = urlencode(isset($default['app_title']) && !empty($default['app_title']) ? $default['app_title'] : 'BullionFX');
            $accountName = urlencode(isset(Auth::user()->email) && !empty(Auth::user()->email) ? Auth::user()->email : 'admin@bullionfx.com');
            $secret = urlencode($data['google2fa_secret']);
            $google2fa_url = "otpauth://totp/{$issuer}:{$accountName}?secret={$secret}&issuer={$issuer}";
            $data['qrcode'] = $google2fa_url;
            return response()->json(["success" => true, "message" => __("Google authentication setup get successfully"), "data" => $data]);
        } catch (\Exception $e) {
            storeException("twoFactorSave : ", $e->getMessage());
            return response()->json(["success" => false, "message" => __("Something went wrong"), "data" => []]);
        }
    }

    public function twoFactorSend(Request $request)
    {
        try {
            if (isset($request->type) && !empty($request->type)) {
                $otp = new User2FAService();
                if ($request->type == EMAIL_AUTH) {
                    if ($otp->sendOtpCodeEmail())
                        return response()->json(["success" => true, "message" => __("Email sent successfully"), "data" => []]);
                    else
                        return response()->json(["success" => false, "message" => __("Email send failed"), "data" => []]);
                } else if ($request->type == PHONE_AUTH) {
                    if ($otp->sendOtpCode())
                        return response()->json(["success" => true, "message" => __("SMS sent successfully"), "data" => []]);
                    else
                        return response()->json(["success" => false, "message" => __("SMS send failed"), "data" => []]);
                } else {
                    return response()->json(["success" => false, "message" => __("Type is invalid"), "data" => []]);
                }
            } else {
                return response()->json(["success" => false, "message" => __("Type is required"), "data" => []]);
            }
        } catch (\Exception $e) {
            storeException("twoFactorSend : ", $e->getMessage());
            return response()->json(["success" => false, "message" => __("Something went wrong"), "data" => []]);
        }
    }

    public function twoFactorCheck(Request $request)
    {
        try {
            if (!isset($request->code) || empty($request->code))
                return response()->json(["success" => false, "message" => __("Code is required")]);
            if (!isset($request->code_type) || empty($request->code_type))
                return response()->json(["success" => false, "message" => __("Code Type is required")]);

            $two_factor = new User2FAService();
            $response = $two_factor->userOtpVerification($request, Auth::guard('api')->user());
            return response()->json($response);
        } catch (\Exception $e) {
            storeException("twoFactorCheck : ", $e->getMessage());
            return response()->json(["success" => false, "message" => __("Something went wrong")]);
        }
    }

    public function logOutApp(Request $request)
    {
        Session::forget('g2f_checked');
        Session::flush();
        Cookie::queue(Cookie::forget('accesstokenvalue'));
        $request->user()->currentAccessToken()->delete();
        return response()->json(['success' => true, 'data' => [], 'message' => __('Logout successfully!'), 'user' => $request->user()->email]);
    }
}
