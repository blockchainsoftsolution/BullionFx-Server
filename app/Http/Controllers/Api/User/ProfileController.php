<?php

namespace App\Http\Controllers\Api\User;

use App\Models\TokenTransfer;
use App\Models\User;
use App\Models\ActivityLog;
use App\Models\Activity;
use App\Models\Notification;
use App\Models\ThirdPartyKycDetails;
use App\Models\Wallet;
use App\Models\UserNotificationSetting;

use App\Http\Controllers\Controller;
use App\Http\Repositories\AffiliateRepository;
use App\Http\Requests\driveingVerification;
use App\Http\Requests\passportVerification;
use App\Http\Requests\ProfileDeleteRequest;
use App\Http\Requests\verificationNid;
use App\Http\Requests\voterCardVerification;
use App\Http\Requests\Api\apiWhiteListRequest;
use App\Http\Requests\Api\ChangePasswordRequest;
use App\Http\Requests\Api\ProfileUpdateRequest;
use App\Http\Requests\Api\UpdateCurrencyRequest;
use App\Http\Services\Logger;
use App\Http\Services\ThirdPartyKYCService;
use App\Http\Services\UserService;

use App\Utils\StringHelper;

use Carbon\Carbon;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class ProfileController extends Controller
{
    protected $id = 0;
    private $service;
    protected $affiliateRepository;
    protected $thirdPartyKYCService;
    public function __construct(AffiliateRepository $affiliateRepository)
    {
        $this->affiliateRepository = $affiliateRepository;
        $this->service = new UserService();
        $this->thirdPartyKYCService = new ThirdPartyKYCService;
    }

    /**
     * user profile
     * @return \Illuminate\Http\JsonResponse
     */
    public function profile()
    {
        try {
            $response = $this->service->userProfile(Auth::id());
        } catch (\Exception $e) {
            storeException('profile', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * update profile
     * @param ProfileUpdateRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateProfile(ProfileUpdateRequest $request)
    {
        try {
            $response = $this->service->userProfileUpdate($request, Auth::id());
        } catch (\Exception $e) {
            storeException('updateProfile', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * change password
     * @param ChangePasswordRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function changePassword(ChangePasswordRequest $request)
    {
        try {
            $response = $this->service->userChangePassword($request, Auth::id());
        } catch (\Exception $e) {
            storeException('changePassword', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * send phone verification sms
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function sendPhoneVerificationSms(Request $request)
    {
        try {
            $response = $this->service->sendPhoneVerificationSms(Auth::user());
        } catch (\Exception $e) {
            storeException('sendPhoneVerificationSms', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * phone verification
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function phoneVerifyProcess(Request $request)
    {
        try {
            $response = $this->service->phoneVerifyProcess($request, Auth::user());
        } catch (\Exception $e) {
            storeException('phoneVerifyProcess', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * upload nid
     * @param verificationNid $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadNid(verificationNid $request)
    {
        try {
            $response = $this->service->nidUploadProcess($request, Auth::user());
        } catch (\Exception $e) {
            storeException('uploadNid', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * upload passport
     * @param passportVerification $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadPassport(passportVerification $request)
    {
        try {
            $response = $this->service->passportUploadProcess($request, Auth::user());
        } catch (\Exception $e) {
            storeException('uploadPassport', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * upload driving licence
     * @param driveingVerification $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadDrivingLicence(driveingVerification $request)
    {
        try {
            $response = $this->service->drivingUploadProcess($request, Auth::user());
        } catch (\Exception $e) {
            storeException('uploadDrivingLicence', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * upload driving licence
     * @param voterCardVerification $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadVoterCard(voterCardVerification $request)
    {
        try {
            $response = $this->service->voterCardUploadProcess($request, Auth::user());
        } catch (\Exception $e) {
            storeException('uploadDrivingLicence', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * kyc details
     * @return \Illuminate\Http\JsonResponse
     */
    public function kycDetails()
    {
        try {
            $response = $this->service->kycStatusDetails(Auth::user());
        } catch (\Exception $e) {
            storeException('kycDetails', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    /**
     * user setting
     * @return \Illuminate\Http\JsonResponse
     */
    public function userSetting()
    {
        try {
            $response = $this->service->userSettingDetails(Auth::user());
        } catch (\Exception $e) {
            storeException('userSetting', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    /**
     * language list
     * @return \Illuminate\Http\JsonResponse
     */
    public function languageList()
    {
        try {
            $response = $this->service->languageList();
        } catch (\Exception $e) {
            storeException('languageList', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    /**
     * user gauth setup
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function google2faSetup(Request $request)
    {
        try {
            $response = $this->service->setupGoogle2fa($request);
        } catch (\Exception $e) {
            storeException('google2faSetup', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    /**
     * user preferred currency setup
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function updatePreferredCurrency(Request $request)
    {
        try {
            $response = $this->service->setupPreferredCurrency($request);
        } catch (\Exception $e) {
            storeException('preferredCurrencySetup', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    /**
     * user preferred language setup
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function updatePreferredLanguage(Request $request)
    {
        try {
            $response = $this->service->setupPreferredLanguage($request);
        } catch (\Exception $e) {
            storeException('preferredLanguageSetup', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    /**
     * user language setup
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function languageSetup(Request $request)
    {
        try {
            $response = $this->service->languageSetup($request);
        } catch (\Exception $e) {
            storeException('languageSetup', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    /**
     * user 2fa login setup
     * @return \Illuminate\Http\JsonResponse
     */
    public function setupGoogle2faLogin()
    {
        try {
            $response = $this->service->setupGoogle2faLogin(Auth::user());
        } catch (\Exception $e) {
            storeException('setupGoogle2faLogin', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    /**
     * user 2fa login setup
     * @return \Illuminate\Http\JsonResponse
     */
    public function myReferralApp()
    {
        $response = $this->affiliateRepository->myReferral();
        return response()->json($response);
    }

    /**
     * @return void
     */
    public function activityList()
    {
        try {
            $result = ActivityLog::where('user_id', '=', Auth::id())->get();
            $response = ['success' => true, 'message' => __('Activity List'), 'data' => $result];
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }
    
    public function getUserActivities()
    {
        try {
            $result = Activity::where('user_id', '=', Auth::id())->orderBy("time", 'desc')->get();
            $response = ['success' => true, 'message' => __('Activity'), 'data' => $result];
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    // user notification
    public function userNotification()
    {
        // try {
        $result = Notification::leftJoin('notification_options', 'notifications.notification_option_id', '=', 'notification_options.id')->where(['user_id' => Auth::id(), 'status' => 0])->select('notifications.*', 'notification_options.icon')->orderBy('id', 'desc')->get();
        // Log::info($result);
        // if(function_exists("getNotificationListt"))
        // {
        //     $support = getNotificationListt();
        //     $result = $support->merge($result);

        // }

        // $result->map(function($query){
        //     if(isset($query->ticket_id))
        //     {
        //         $query->notification_type = 'support';
        //     }else{
        //         $query->notification_type = 'old';
        //     }
        // });
        $response = ['success' => true, 'message' => __('Notification List'), 'data' => $result];
        // } catch (\Exception $e) {
        //     $response = ['success' => false,'message' => __('Something went wrong'), 'data' => []];
        // }
        return response()->json($response);
    }

    public function addActivity(Request $request)
    {
        // Log::info($request);
        try {
            $result = Activity::create(['user_id' => Auth::id(), 'type' => $request->type, 'fromAmount' => $request->fromAmount, 'toAmount' => $request->toAmount, 'fromAsset' => $request->fromAsset,
            'fromAssetSymbol' => $request->fromAssetSymbol, 'toAsset' => $request->toAsset, 'toAssetSymbol' => $request->toAssetSymbol, 'toAddress' => $request->toAddress, 'status' => $request->status, 'time' => $request->time, 'transactionHash' => $request->transactionHash]);
            if ($request->type === "Sent") {
                Notification::create([
                    'user_id' => Auth::id(),
                    'title' => "Sent {$request->fromAmount} {$request->fromAssetSymbol}",
                    'notification_body' => "You sent {$request->fromAmount} {$request->fromAssetSymbol} to" . " " . StringHelper::toShortAddr($request->toAddress),
                    'notification_option_id' => 3,
                    'time' => $request->time
                ]);
            }
            // if ($request->type === 'Received') {
            //     Notification::create([
            //         'user_id' => Auth::id(),
            //         'title' => "Received {$request->toAmount} {$request->toAsset}",
            //         'notification_body' => "You received {$request->toAmount} {$request->toAsset} from {$request->from}",
            //         'notification_option_id' => 3,
            //         'time' => $request->time
            //     ]);
            // }
            if ($request->type === 'Withdrew') {
                Notification::create([
                    'user_id' => Auth::id(),
                    'title' => "Withdrawal Complete",
                    'notification_body' => "Your withdrawal of {$request->fromAmount} {$request->fromAssetSymbol} has been completed and will arrive in the nominated bank account soon.",
                    'notification_option_id' => 3,
                    'time' => $request->time
                ]);
            }
            if ($request->type === 'Swapped') {
                Notification::create([
                    'user_id' => Auth::id(),
                    'title' => "Swap Completed",
                    'notification_body' => "Swapped {$request->fromAmount} {$request->fromAssetSymbol} for {$request->toAmount} {$request->toAssetSymbol}",
                    'notification_option_id' => 3,
                    'time' => $request->time
                ]);
            }
            if ($request->type === 'Deposited') {
                Notification::create([
                    'user_id' => Auth::id(),
                    'title' => "Deposit Complete",
                    'notification_body' => "Your deposit of {$request->fromAmount} {$request->fromAssetSymbol} has been received and added to your wallet as USDC.",
                    'notification_option_id' => 3,
                    'time' => $request->time
                ]);
            }

            $response = ['success' => true, 'message' => __('Add Activity Success')];
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong')];
            Log::error("Notification Creation Error: " . $e->getMessage());
        }
    }

    // user notification settings
    public function userNotificationSettings(Request $request)
    {
        try {
            $result = UserNotificationSetting::where(['user_id' => Auth::id()])->get();
            if ($result->isNotEmpty()) {
                $response = ['success' => true, 'message' => __('Read'), 'data' => $result[0]];
            } else {
                $response = ['success' => true, 'message' => __('Read'), 'data' => null];
            }
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    // user notification settings
    public function setUserNotificationSettings(Request $request)
    {
        try {
            $result = UserNotificationSetting::updateOrCreate(['user_id' => Auth::id()], ['disabled' => $request->disabled]);
            $response = ['success' => true, 'message' => __('Updated'), 'data' => $result];
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    // user notification
    public function userNotificationSeen(Request $request)
    {
        $hashs = $request->hashs;
        $user = Auth::user();
        $wallet = Wallet::where('user_id', $user->id)->first();
        try {
            if ($hashs) {
                $result = TokenTransfer::where(function ($query) use ($wallet) {
                    $query->where("from", strtolower(($wallet->address)))->orWhere("to", strtolower(($wallet->address))); 
                })->whereIn('hash', $hashs)->update(['checked' => true]);
                $response = ['success' => true, 'message' => __('Updated'), 'data' => $result];
            } else {
                $response = ['success' => false, 'message' => __('hash is required'), 'data' => []];
            }
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    // update fiat currency
    public function updateFiatCurrency(UpdateCurrencyRequest $request)
    {
        try {
            $response = $this->service->updateFiatCurrency($request);
            if ($response['success'] == true) {
                $response = ['success' => true, 'message' => $response['message'], 'data' => []];
            } else {
                $response = ['success' => false, 'message' => $response['message'], 'data' => []];
            }
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }

    public function getSumsubAccessToken()
    {
        $externalUserId = Auth::id();
        $response = $this->thirdPartyKYCService->getAccessToken($externalUserId);
        return response()->json($response);
    }

    public function updateSumsubApplicantStatus()
    {
        $user = Auth::user();
        $thirdPartyKYCDetails = ThirdPartyKycDetails::where('user_id', $user->id)->first();
        if (!isset($thirdPartyKYCDetails)) {
            return $user;
            $kycStatus = $this->thirdPartyKYCService->createApplicant($user);
            if ($kycStatus['success'])
                $thirdPartyKYCDetails = ThirdPartyKycDetails::where('user_id', $user->id)->first();
        }
        // $response = ['success' => false, 'message' => 'Couldn\'t find KYC record'];
        $applicantStatus = $this->thirdPartyKYCService->getApplicantStatus($thirdPartyKYCDetails->applicant_id);
        if ($applicantStatus['IDENTITY'] && count($applicantStatus['IDENTITY']['reviewResult']) > 0) {
            $status = $applicantStatus['IDENTITY']['reviewResult']['reviewAnswer'] == 'GREEN' ? 2 : 1;
            $thirdPartyKYCDetails->is_verified = $status;
            if ($status == 2) {
                // $response = $this->thirdPartyKYCService->banxaKYCProcess($user, $thirdPartyKYCDetails->applicant_id);
                // $response = $this->thirdPartyKYCService->banxaKYCProcess();
                $response = $this->thirdPartyKYCService->banxaKYCProcess1();
                if ($response['success']) {
                    $thirdPartyKYCDetails->banxa_id = $response['data']['account_id'];
                } else {
                    $response = ['success' => false, 'message' => 'Something went wrong with Banxa'];
                    return response()->json($response);
                }
                $applicantInfo = $this->thirdPartyKYCService->getApplicantInfo($thirdPartyKYCDetails->applicant_id);
                $user = User::find($user->id);
                $user->first_name = $applicantInfo['info']['firstName'];
                $user->last_name = $applicantInfo['info']['lastName'];
                $user->save();
                $response = ['success' => true, 'message' => 'Successfully completed KYC', 'data' => $user];
            } else {
                $response = ['success' => false, 'message' => 'KYC not verified yet', 'data' => ''];
            }
            $thirdPartyKYCDetails->save();
            return response()->json($response);
        } else {
            $response = ['success' => false, 'message' => 'KYC data not submitted yet', 'data' => ''];
            return response()->json($response);
        }
    }

    // public function createSumsubApplicant(Request $request) {
    //     $externalUserId = Auth::id();
    //     $response = $this->thirdPartyKYCService->createApplicant($externalUserId);
    //     return response()->json($response);
    // }

    public function sumsubWebhookApplicantCreated(Request $request)
    {
        echo json_encode($request);
    }

    public function banxaKYCProcess(Request $request)
    {
        // $response = $this->thirdPartyKYCService->banxaKYCProcess($request);
        $response = $this->thirdPartyKYCService->banxaKYCProcess();
        return response()->json($response);
    }

    public function banxaCreateBuyOrder(Request $request)
    {
        try {
            $user = Auth::user();
            $wallet = Wallet::where('user_id', $user->id)->first();
            $order_detail = $this->thirdPartyKYCService->banxaCreateBuyOrder($user, $request->fiat, $request->crypto, $wallet->address);
            $response = ['success' => true, 'message' => 'Successfully created a buy order', 'data' => $order_detail];
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong with creating a buy order'), 'data' => []];
        }
        return response()->json($response);
    }

    public function banxaCreateSellOrder(Request $request)
    {
        $userId = Auth::id();
        $response = $this->thirdPartyKYCService->banxaCreateSellOrder($request);
        return response()->json($response);
    }

    public function userKycSettingsDetails()
    {
        $response = $this->service->userKycSettingsDetails();

        return response()->json($response);
    }
    public function thirdPartyKycVerified(Request $request)
    {
        if (isset($request->inquiry_id)) {
            $response = $this->thirdPartyKYCService->verifiedPersonaKYC($request);

        } else {
            $response = ['success' => false, 'message' => __('Inquiry id is required!')];

        }
        return response()->json($response);
    }

    public function profileDeleteRequest(ProfileDeleteRequest $request)
    {
        $response = $this->service->profileDeleteRequest($request);

        return response()->json($response);
    }

    /**
     * generate secret key for api access
     * @param ChangePasswordRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function generateSecretKey(Request $request)
    {
        try {
            $response = $this->service->generateSecretKeyToAccessApi($request, Auth::id());
        } catch (\Exception $e) {
            storeException('generateSecretKey', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * show secret key for api access
     * @param ChangePasswordRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function showSecretKey(Request $request)
    {
        try {
            $response = $this->service->showSecretKeyToAccessApi($request, Auth::id());
        } catch (\Exception $e) {
            storeException('showSecretKeyToAccessApi', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    public function getApiSettings()
    {
        try {
            $response = $this->service->getApiSettings();
        } catch (\Exception $e) {
            storeException('getApiSettings', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    public function updateApiSettings(Request $request)
    {
        try {
            $response = $this->service->updateApiSettings($request);
        } catch (\Exception $e) {
            storeException('updateApiSettings', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    public function getApiWhiteList(Request $request)
    {
        try {
            $response = $this->service->getApiWhiteList($request);
        } catch (\Exception $e) {
            storeException('getApiWhiteList', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    public function addApiWhiteList(apiWhiteListRequest $request)
    {
        try {
            $response = $this->service->addApiWhiteList($request);
        } catch (\Exception $e) {
            storeException('getApiWhiteList', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    public function changeApiWhiteListStatus($id, $type, $value)
    {
        try {
            $response = $this->service->changeApiWhiteListStatus($id, $type, $value);
        } catch (\Exception $e) {
            storeException('changeApiWhiteListStatus', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    public function deleteApiWhiteList($id)
    {
        try {
            $response = $this->service->deleteApiWhiteList($id);
        } catch (\Exception $e) {
            storeException('deleteApiWhiteList', $e->getMessage());
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    // update yield program registration status
    public function updateYieldStatus(Request $request)
    {
        try {
            $response = $this->service->setupYieldStatus($request);
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => ''];
        }
        return response()->json($response);
    }

    /**
     * user balance
     * @return \Illuminate\Http\JsonResponse
     */
    public function userTokenBalances(Request $request)
    {
        $user = Auth::user();
        $wallet = Wallet::where('user_id', $user->id)->first();
        $chain_id = $request->query('chain_id');
        $result = $this->fetchUserTokenBalances($chain_id, $wallet->address);
        if ($result["status"] == "success") {
            return response()->json($result["data"]);
        } else {
            return response()->json(['error' => 'Alchemy request failed'], $result["data"]);
        }
    }

    public function userTokenBalanceHistory(Request $request) {
        // Get User wallet from database
        $user = Auth::user();
        $wallet = Wallet::where('user_id', $user->id)->first();
        
        // Retrieve values from the request
        $chain_id = $request->input('chain_id');  // Get chain_id
        $tokens = $request->input('tokens');    // Get tokens array

        $user_token_transfer_history = $this->fetchUserTokenTransfers($chain_id, $wallet->address);
        if ($user_token_transfer_history['status'] == "success") {
            $user_token_balance_history = [];
            foreach ($tokens as $token) {
                $user_token_balance_history[strtolower($token)] = [];
            }
            foreach ($user_token_transfer_history['data'] as $transfer) {
                $block = $transfer['block'];
                $token = strtolower($transfer['address']);
                $amount = $transfer['value'];
                if (!array_key_exists($token, $user_token_balance_history)) continue;
                if (strtolower($transfer['to']) == strtolower($wallet->address)) { // receive
                    if (count($user_token_balance_history[$token]) == 0) { // first receive
                        array_push($user_token_balance_history[$token], [
                            "block" => $block,
                            "balance" => $amount
                        ]);
                        continue;
                    }
                    $last_balance_data = end($user_token_balance_history[$token]);
                    $last_balance = $last_balance_data['balance'];
                    if ($last_balance_data['block'] == $block) { // same block number
                        array_pop($user_token_balance_history[$token]);
                    }
                    array_push($user_token_balance_history[$token], [
                        "block" => $block,
                        "balance" => $last_balance + $amount
                    ]);
                }
                if (strtolower($transfer['from']) == strtolower($wallet->address)) {
                    $last_balance_data = end($user_token_balance_history[$token]);
                    $last_balance = $last_balance_data['balance'];
                    if ($last_balance_data['block'] == $block) { // same block number
                        array_pop($user_token_balance_history[$token]);
                    }
                    array_push($user_token_balance_history[$token], [
                        "block" => $block,
                        "balance" => $last_balance - $amount
                    ]);
                }
            }
            return response()->json($user_token_balance_history);
        }
        return response()->json(['error' => 'Alchemy request failed'], $user_token_transfer_history["data"]);
    }

    public function userTokenTransactionHistory(Request $request) {
        
        // Get User wallet from database
        $user = Auth::user();
        $wallet = Wallet::where('user_id', $user->id)->first();
        
        // Retrieve values from the request
        $chain_id = $request->input('chain_id');  // Get chain_id
        $tokens = $request->input('tokens');    // Get tokens array
        $tokens = array_map(function($t) {
            return strtolower($t);
        }, $tokens);

        $user_token_transfer_history = $this->fetchUserTokenTransfers($chain_id, $wallet->address);
        if ($user_token_transfer_history['status'] == "success") {
            // Log::info("check: ", [$token_transfers]);
            $user_token_transactions = [];
            foreach ($user_token_transfer_history['data'] as $transfer) {
                $key = $transfer['block'] . '-' . $transfer['hash'];
                if (!array_key_exists($key, $user_token_transactions)) {
                    $user_token_transactions[$key] = [
                        'block' => $transfer['block'],
                        'hash' => $transfer['hash'],
                        'checked' => $transfer['checked'],
                        'data' => [
                        ]
                    ];
                }
                array_push($user_token_transactions[$key]['data'], [
                    'from' => $transfer['from'],
                    'to' => $transfer['to'],
                    'asset' => $transfer['asset'],
                    'address' => $transfer['address'],
                    'value' => $transfer['value'],
                    'decimal' => $transfer['decimal']
                ]);
            }

            $result = [];
            foreach ($user_token_transactions as $transaction) {
                if (count($transaction['data']) == 1) {
                    $is_send = $transaction['data'][0]['from'] == strtolower($wallet->address);
                    array_push($result, [
                        'type' => $is_send ? 'send' : 'receive',
                        'block' => $transaction['block'],
                        'hash' => $transaction['hash'],
                        'data' => $transaction['data'],
                        'checked' => $transaction['checked']
                    ]);
                } else {
                    if (count($transaction['data']) == 2 && $transaction['data'][0]['from'] === strtolower($wallet->address) && $transaction['data'][1]['from'] === strtolower($wallet->address) && $transaction['data'][0]['asset'] == "GOLD" && $transaction['data'][1]['asset'] == "GOLD") {
                    array_push($result, [
                        'type' => "send",
                        'block' => $transaction['block'],
                        'hash' => $transaction['hash'],
                        'data' => [$transaction['data'][0]],
                        'checked' => $transaction['checked']
                    ]);
                    array_push($result, [
                        'type' => "send",
                        'block' => $transaction['block'],
                        'hash' => $transaction['hash'],
                        'data' => [$transaction['data'][1]],
                        'checked' => $transaction['checked']
                    ]);
                    continue;
                    }
                    $type = 'contract_interaction';
                    if ($transaction['data'][0]['from'] == strtolower(env('TRADER')) || $transaction['data'][0]['to'] == strtolower(env('TRADER')) || $transaction['data'][1]['from'] == strtolower(env('TRADER')) || $transaction['data'][1]['to'] == strtolower(env('TRADER'))) {
                        $type = 'swap';
                        foreach($transaction['data'] as $each) {
                            if ($each['asset'] != 'USDC' && $each['asset'] != 'GOLD') {
                                $type = 'contract_interaction';
                                break;
                            }
                        }
                    }
                    array_push($result, [
                        'type' => $type,
                        'block' => $transaction['block'],
                        'hash' => $transaction['hash'],
                        'data' => $transaction['data'],
                        'checked' => $transaction['checked']
                    ]);
                }
            }
            return response()->json($result);
        }
        return response()->json(['error' => 'Alchemy request failed'], $user_token_transfer_history["data"]);
    }

    public function fetchUserTokenBalances($chain_id, $wallet_address) {
        $cache_key = "user_token_balances_" . md5($chain_id . $wallet_address);
        $data = Cache::remember($cache_key, env('ALCHEMY_API_DEFAULT_CACHE') ?? 60, function () use ($chain_id, $wallet_address) {
            $url = "https://eth-mainnet.g.alchemy.com/v2/" . env('ALCHEMY_KEY');
            switch($chain_id) {
                case "11155111":
                    $url = "https://eth-sepolia.g.alchemy.com/v2/" . env('ALCHEMY_KEY');
                    break;
                default:
                    break;
            }
        
            $payload = [
                "jsonrpc" => "2.0",
                "method" => "alchemy_getTokenBalances",
                "params" => [
                  $wallet_address
                ],
                "id" => $this->id++
            ];
            if ($this->id > 10000) $this->id = 0;
    
            $response = Http::post($url, $payload);
            $response_decoded = $response->json();
            if ($response->successful()) {
                return [
                    "status" => "success",
                    "data" => $response_decoded['result']
                ];
            } else {
                return [
                    "status" => "error",
                    "data" => $response->status()
                ];
            }
        });
        return $data;
    }

    public function fetchUserTokenTransfers($chain_id, $wallet_address) {
        $cache_key = "user_token_transfers_" . md5($chain_id . $wallet_address);
        $data = Cache::remember($cache_key, env('ALCHEMY_API_DEFAULT_CACHE') ?? 60, function () use ($chain_id, $wallet_address) {
            $url = "https://eth-mainnet.g.alchemy.com/v2/" . env('ALCHEMY_KEY');
            $last_block = 0;
            $token_transfers = TokenTransfer::where('from', $wallet_address)->orWhere('to', $wallet_address)->orderBy('block', 'asc')->get();
            if (count($token_transfers) > 0) {
                $lastTransfer = $token_transfers[count($token_transfers) - 1];
                $last_block = $lastTransfer->block;
            }
            switch($chain_id) {
                case "11155111":
                    $url = "https://eth-sepolia.g.alchemy.com/v2/" . env('ALCHEMY_KEY');
                    break;
                default:
                    break;
            }
            $payload_from = [
                "jsonrpc" => "2.0",
                "method" => "alchemy_getAssetTransfers",
                "params" => [[
                    "fromBlock" => "0x" . dechex($last_block + 1),
                    "fromAddress" => $wallet_address,
                    "category" => ["erc20"]
                ]],
                "id" => $this->id++
            ];
            if ($this->id > 10000) $this->id = 0;

            $response_from = Http::post($url, $payload_from);
            $response_from_decoded = $response_from->json();
            
            $payload_to = [
                "jsonrpc" => "2.0",
                "method" => "alchemy_getAssetTransfers",
                "params" => [[
                    "fromBlock" => "0x" . dechex($last_block + 1),
                    "toAddress" => $wallet_address,
                    "category" => ["erc20"]
                ]],
                "id" => $this->id++
            ];
            if ($this->id > 10000) $this->id = 0;
            $response_to = Http::post($url, $payload_to);
            $response_to_decoded = $response_to->json();

            $result = array_merge($response_from_decoded['result']['transfers'], $response_to_decoded['result']['transfers']);
            usort($result, function($a, $b) {
                return hexdec($a['blockNum']) - hexdec($b['blockNum']);
            });
            if (count($result) > 0) {
                $last_block = $result[count($result) - 1]['blockNum'];
                $new_token_transfers = [];
                foreach($result as $transfer) {
                    $token_transfer = [
                        'block' => hexdec($transfer['blockNum']),
                        'hash' => $transfer['hash'],
                        'from' => $transfer['from'],
                        'to' => $transfer['to'],
                        'asset' => $transfer['asset'],
                        'address' => $transfer['rawContract']['address'],
                        'value' => $transfer['value'],
                        'decimal' => hexdec($transfer['rawContract']['decimal']),
                        'checked' => false,
                    ];
                    TokenTransfer::create($token_transfer);
                    array_push($new_token_transfers, $token_transfer);
                }
                $token_transfers = array_merge($token_transfers->toArray(), $new_token_transfers);
            }

            if ($response_from->successful() && $response_to->successful()) {
                return [
                    "status" => "success",
                    "data" => $token_transfers
                ];
            } else {
                $error_status = $response_from->successful() ? $response_to->status() : $response_from->status();
                return [
                    "status" => "error",
                    "data" => $error_status
                ];
            }
        });
        return $data;
    }

    // public function getBlockTimestamp($blockNumber = 'latest')
    // {
    //     $url = "https://eth-sepolia.g.alchemy.com/v2/" . env('ALCHEMY_KEY');

    //     $data = [
    //         'jsonrpc' => '2.0',
    //         'id' => 1,
    //         'method' => 'eth_getBlockByNumber',
    //         'params' => [$blockNumber, false],
    //     ];

    //     $response = Http::post($url, $data);

    //     $result = json_decode($response->getBody()->getContents(), true);

    //     if (isset($result['result'])) {
    //         // Convert hex timestamp to decimal
    //         return hexdec($result['result']['timestamp']);
    //     }

    //     return null; // Handle error appropriately
    // }
}
