<?php
namespace App\Http\Services;

use App\Models\ThirdPartyKycDetails;
use Banxa\Banxa;
use Banxa\Client\HttpClient;
use Banxa\Domains\Identity\Builders\CustomerDetail;
use Banxa\Domains\Identity\Builders\CustomerIdentity;
use Banxa\Domains\Identity\Builders\IdentityDocument;
use Banxa\Domains\Identity\Builders\IdentityDocumentCollection;
use Banxa\Domains\Identity\Builders\IdentitySharingCollection;
use Banxa\Domains\Identity\Builders\IdentitySharingProvider;
use Banxa\Domains\Identity\Builders\ResidentialAddress;
use Banxa\Domains\Identity\CreateIdentity;
use Banxa\Domains\Orders\Builders\BuyOrderTransaction;
use Banxa\Domains\Orders\Builders\OptionalOrderParameters;
use GuzzleHttp\Client;
use GuzzleHttp\Psr7\Request;
use GuzzleHttp\Psr7\Utils;
use GuzzleHttp\Exception\GuzzleException;
use function GuzzleHttp\Psr7\stream_for;
use RuntimeException;
use Illuminate\Support\Facades\Storage;

class ThirdPartyKYCService
{
    protected $guzzleClient;
    protected const BASE_URL = 'https://api.sumsub.com';
    protected $appToken;
    protected $secretKey;

    public function __construct()
    {
        $this->guzzleClient = new Client(['base_uri' => self::BASE_URL]);
        $settings = allsetting(['sumsub_token', 'sumsub_secret']);
        $this->appToken = $settings['sumsub_token'];
        $this->secretKey = $settings['sumsub_secret'];
    }

    public function verifiedPersonaKYC($request)
    {
        $user = auth()->user();

        $settings = allsetting(['persona_kyc_api_key', 'persona_kyc_version']);
        $headers = [
            'Authorization: Bearer ' . $settings['PERSONA_KYC_API_KEY'],
            'Persona-Version: ' . $settings['PERSONA_KYC_VERSION'],
            'accept: application/json',
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://withpersona.com/api/v1/inquiries/' . $request->inquiry_id);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        $result = curl_exec($ch);
        $result = json_decode($result);
        curl_close($ch);

        if (isset($result->data)) {
            $status = STATUS_PENDING;
            if ($result->data->attributes->status == 'completed') {
                $status = STATUS_SUCCESS;
            }
            $thirdPartyKYCDetails = ThirdPartyKycDetails::where('user_id', $user->id)->where('kyc_type', KYC_TYPE_PERSONA)->first();
            if (isset($thirdPartyKYCDetails)) {
                $thirdPartyKYCDetails->is_verified = $status;
                $thirdPartyKYCDetails->key = $request->inquiry_id;
                $thirdPartyKYCDetails->save();
            } else {
                $thirdPartyKYCDetails = new ThirdPartyKycDetails;
                $thirdPartyKYCDetails->user_id = $user->id;
                $thirdPartyKYCDetails->kyc_type = KYC_TYPE_PERSONA;
                $thirdPartyKYCDetails->is_verified = $status;
                $thirdPartyKYCDetails->key = $request->inquiry_id;
                $thirdPartyKYCDetails->save();
            }
            $response = ['success' => true, 'message' => 'Verification ' . $result->data->attributes->status];
        } else {
            $response = ['success' => false, 'message' => $result->errors[0]->title];
        }

        return $response;

    }

    public function generateSignature($secretKey, $method, $url, $timestamp, $body = '')
    {
        $data = $timestamp . strtoupper($method) . $url . $body;
        return hash_hmac('sha256', $data, $secretKey);
    }

    public function createApplicant($externalUserId, $levelName)
    {
        $requestBody = [
            'externalUserId' => $externalUserId,
            "email"=> "john.smith@sumsub.com",
            "phone"=> "+449112081223",
            "fixedInfo"=> [
                "country"=> "GBR",
                "placeOfBirth"=> "London"
            ]
        ];

        $url = '/resources/applicants?' . http_build_query(['levelName' => $levelName]);

        $request = (new Request('POST', $url))
            ->withHeader('Content-Type', 'application/json')
            ->withBody(Utils::streamFor(json_encode($requestBody)));

        $response = $this->sendRequest($request);
        $body = $this->parseBody($response);
        return $body['id'];
    }

    public function getAccessToken($externalUserId, $levelName)
    {
        $url = '/resources/accessTokens?' . http_build_query(['userId' => $externalUserId, 'levelName' => $levelName]);
        $request = new Request('POST', $url);

        $response = $this->sendRequest($request);
        return $this->parseBody($response);
    }


    protected function sendRequest($request)
    {
        $now = time()+180;
        $request = $request->withHeader('X-App-Token', $this->appToken)
            ->withHeader('X-App-Access-Sig', $this->createSignature($request, $now))
            ->withHeader('X-App-Access-Ts', $now);

        try {
            $response = $this->guzzleClient->send($request);
            if ($response->getStatusCode() != 200 && $response->getStatusCode() != 201) {
                // https://docs.sumsub.com/reference/review-api-health#errors
                // If an unsuccessful answer is received, please log the value of the `correlationId` parameter.

                throw new RuntimeException('Invalid status code received: ' . $response->getStatusCode() . '. Body: ' . $response->getBody());
            }

            return $response;
        } catch (GuzzleException $e) {
            throw new RuntimeException('Error occurred during the request', 0, $e);
        }
    }

    protected function createSignature($request, $ts)
    {
        // var_dump($ts . strtoupper($request->getMethod()) . $request->getUri() . $request->getBody());
        // die;
        return hash_hmac('sha256', $ts . strtoupper($request->getMethod()) . $request->getUri() . $request->getBody(), $this->secretKey);
    }

    protected function parseBody($response)
    {
        $data = (string)$response->getBody();
        $json = json_decode($data, true, JSON_THROW_ON_ERROR);
        if (!is_array($json)) {
            throw new RuntimeException('Invalid response received: ' . $data);
        }

        return $json;
    }

    // Function to verify Sumsub signature
    // function verify_sumsub_signature($requestBody, $signature, $secretKey) {
    //     // Create a hash using HMAC with the secret key and SHA256
    //     $calculatedSignature = base64_encode(hash_hmac('sha256', $requestBody, $secretKey, true));

    //     // Compare the calculated signature with the received one
    //     return hash_equals($calculatedSignature, $signature);
    // }

    // public function sumsubWebhookApplicantCreated($request)
    // {
    //     $headers = getallheaders();
    //     $sumsubSignature = isset($headers['X-Signature-SHA256']) ? $headers['X-Signature-SHA256'] : '';
    //     if (!$this->verify_sumsub_signature($request, $sumsubSignature, $this->secretKey)) {
    //         // Respond with an error if signature verification fails
    //         http_response_code(403);
    //         echo json_encode(['error' => 'Invalid signature']);
    //         exit;
    //     }

    //     // Parse the JSON webhook payload
    //     $data = json_decode($request, true);

    //     if (json_last_error() !== JSON_ERROR_NONE) {
    //         // Respond with an error if the JSON is invalid
    //         http_response_code(400);
    //         echo json_encode(['error' => 'Invalid JSON']);
    //         exit;
    //     }

    //     // Handle different webhook event types
    //     if (isset($data['reviewStatus'])) {
    //         $applicantId = $data['applicantId'];
    //         $reviewStatus = $data['reviewStatus'];

    //         // Process based on the review status (example: approve, reject, etc.)
    //         if ($reviewStatus === 'completed') {
    //             // Example: Mark the user as verified in your database
    //             // updateUserVerificationStatus($applicantId, true);
    //         } elseif ($reviewStatus === 'pending') {
    //             // Handle pending status
    //         } elseif ($reviewStatus === 'rejected') {
    //             // Handle rejection
    //         }

    //         // Respond with a success status
    //         http_response_code(200);
    //         echo json_encode(['message' => 'Webhook handled successfully']);
    //     } else {
    //         // Handle unknown events
    //         http_response_code(400);
    //         echo json_encode(['error' => 'Unknown event type']);
    //     }
    // }
    public function sumsubWebhookApplicantCreated($request)
    {
        Storage::put('file123.txt', json_encode($request));
        return 'success';
        // $algo = match($request->headers->get('X-Payload-Digest-Alg')) {
        //     'HMAC_SHA1_HEX' => 'sha1',
        //     'HMAC_SHA256_HEX' => 'sha256',
        //     'HMAC_SHA512_HEX' => 'sha512',
        //     default => throw new RuntimeException('Unsupported algorithm'),
        // };

        // $res = $request->headers->get('X-Signature') === hash_hmac(
        //     $algo,
        //     $content,
        //     $this->secretKey
        // );

        // if (!$res) {
        //     // $this->logger->error('Webhook sumsub sign ' . $content);
        //     // throw new LogicProfileException('Webhook sumsub sign ' . $content);
        //     return 'failed';
        // } else {
        //     return $res;
        // }
    }
}
