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
use Illuminate\Support\Facades\Auth;

class ThirdPartyKYCService
{
    protected $guzzleClient;
    protected const BASE_URL = 'https://api.sumsub.com';
    protected $appToken;
    protected $secretKey;

    public function __construct()
    {
        $this->guzzleClient = new Client(['base_uri' => self::BASE_URL]);
        $settings = allsetting(['sumsub_token', 'sumsub_secret', 'banxa_api', 'banxa_secret', 'banxa_api_v2']);
        $this->appToken = $settings['sumsub_token'];
        $this->secretKey = $settings['sumsub_secret'];

        $this->subdomain = 'alchemy';
        $this->sandboxApiKey = $settings['banxa_api'];
        $this->sandboxApiSecret = $settings['banxa_secret'];
        $this->sandboxApiKeyV2 = $settings['banxa_api_v2'];
        $this->testMode = true;
        $this->banxa = Banxa::create($this->subdomain, $this->sandboxApiKey, $this->sandboxApiSecret, $this->testMode);
    }

    public function verifiedSumsubKYC($userId, $applicant)
    {
        $status = STATUS_PENDING;
        $thirdPartyKYCDetails = new ThirdPartyKycDetails;
        $thirdPartyKYCDetails->user_id = $userId;
        $thirdPartyKYCDetails->applicant_id = $applicant['id'];
        $thirdPartyKYCDetails->is_verified = $status;
        $thirdPartyKYCDetails->key = $applicant['key'];
        $thirdPartyKYCDetails->save();
        $response = ['success' => true, 'message' => 'Sumsub verification record added.'];
        return $response;

    }

    public function generateSignature($secretKey, $method, $url, $timestamp, $body = '')
    {
        $data = $timestamp . strtoupper($method) . $url . $body;
        return hash_hmac('sha256', $data, $secretKey);
    }

    public function createApplicant($user, $levelName)
    {
        $requestBody = [
            'externalUserId' => $user->id,
            "email"=> $user->email,
            // "phone"=> "+449112081223",
            // "fixedInfo"=> [
            //     "country"=> "GBR",
            //     "placeOfBirth"=> "London"
            // ]
        ];

        $url = '/resources/applicants?' . http_build_query(['levelName' => $levelName]);

        $request = (new Request('POST', $url))
            ->withHeader('Content-Type', 'application/json')
            ->withBody(Utils::streamFor(json_encode($requestBody)));

        $response = $this->sendRequest($request);
        $body = $this->parseBody($response);
        $response = $this->verifiedSumsubKYC($user->id, $body);
        return $response;
    }

    public function getAccessToken($userId, $levelName)
    {
        $url = '/resources/accessTokens?' . http_build_query(['userId' => $userId, 'levelName' => $levelName]);
        $request = new Request('POST', $url);

        $response = $this->sendRequest($request);
        return $this->parseBody($response);
    }

    public function getApplicantStatus($applicantId)
    {
        $url = '/resources/applicants/' . urlencode($applicantId) . '/requiredIdDocsStatus';
        $request = new Request('GET', $url);

        $response = $this->sendRequest($request);
        return $this->parseBody($response);
    }

    public function getApplicantInfo($applicantId)
    {
        $url = '/resources/applicants/' . urlencode($applicantId) . '/one';
        $request = new Request('GET', $url);

        $response = $this->sendRequest($request);
        return $this->parseBody($response);
    }


    protected function sendRequest($request)
    {
        $now = time();
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

    public function banxaAuthenticator($method, $url, $body, $nonce)
    {
        $sign = hash_hmac('SHA256', $method . '\n' . $url . '\n' . $nonce . '\n' . $body, $this->sandboxApiSecret);
        return $this->sandboxApiKey.':'.$sign.':'.$nonce;

    }

    public function banxaKYCProcess() {
        $client = new Client();
        $method = 'POST';
        $url = '/api/identities';
        $body = '{"account_reference":"70","email":"traininggroup1992@gmail.com","identity_sharing":[{"provider":"sumsub","token":"66fc133fa6408070acf81235"}]}';
        $nonce = time();
        $response = $client->request('POST', 'https://ALCHEMY.banxa-sandbox.com' . $url, [
          'body' => $body,
          'headers' => [
            'Accept' => 'application/json',
            'content-type' => 'application/json',
            'Authorization' => 'Bearer ' . $this->sandboxApiKey . ':' . $this->banxaAuthenticator($method, $url, $body, $nonce) . $nonce,
          ],
        ]);
        
        $body = $response->getBody();
        $data = json_decode($body, true);
        return $data;
    }

    public function banxaCreateBuyOrder($user, $fiat, $crypto, $wallet_address) {
        $client = new Client();
        $response = $client->request('POST', 'https://api.banxa-sandbox.com/ALCHEMY/v2/buy', [
            'body' => '{"crypto":"' . $crypto .'","fiat":"'. $fiat .'","fiatAmount":"2000","walletAddress":"'. $wallet_address .'","redirectUrl":"https://bullionfx.com","email":"'. $user->email .'","externalCustomerId":"'. $user->id .'"}',
            'headers' => [
                'Accept' => 'application/json',
                'content-type' => 'application/json',
                'x-api-key' => $this->sandboxApiKeyV2,
            ],
        ]);

        $body = $response->getBody();
        $data = json_decode($body, true);
        return $data;
    }

    public function banxaCreateSellOrder($user, $fiat, $crypto, $wallet_address) {
        $client = new Client();
        $response = $client->request('POST', 'https://api.banxa-sandbox.com/ALCHEMY/v2/buy', [
            'body' => '{"crypto":' . $crypto .',"fiat":'. $fiat .',"fiatAmount":"2000","walletAddress":'. $wallet_address .',"redirectUrl":"https://bullionfx.com","email":'. $user->email .',"externalCustomerId":'. $user->id .'}',
            'headers' => [
                'Accept' => 'application/json',
                'content-type' => 'application/json',
                'x-api-key' => $this->sandboxApiKeyV2,
            ],
        ]);

        echo $response->getBody();
    }

    public function banxaKYCProcess1()
    {        // // KYC
        // $data = $this->banxa->createIdentity(
        //     IdentitySharingCollection::create([
        //         IdentitySharingProvider::create('sumsub', '66fc133fa6408070acf81235')
        //     ]),
        //     CustomerDetail::create('70', '', 'traininggroup1992@gmail.com'),
        //     ResidentialAddress::create('', '', '', '', ''),
        //     CustomerIdentity::create('', '', ''),
        // );
        // $response = ['success' => true, 'message' => __('KYC data submitted!'), 'data' => $data];
        // return $response;
        $response = $data = $this->banxa->createIdentity(
            IdentitySharingCollection::create([
                IdentitySharingProvider::create('sumsub', 'bar')
            ]),
            CustomerDetail::create('test023423401003122', '61212345678', 'phenix2017pr@gmail.com'),
            ResidentialAddress::create('FO', '21 FooBarBaz FizBuz', 'Foobaz', '3000 VIC', 'BAZ'),
            CustomerIdentity::create('FooBarBaz', 'FizBuz', '2001-01-01'),
            IdentityDocumentCollection::create([IdentityDocument::create(IdentityDocument::DOCUMENT_TYPE_PASSPORT, ['https://www.orimi.com/pdf-test.pdf'], 'BTCBaz007')]),
        );
        $response = ['success' => true, 'message' => __('Banxa KYC data submitted!'), 'data' => $response];
        return $response;
    }
}
