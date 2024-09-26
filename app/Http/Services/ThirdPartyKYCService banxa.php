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

class ThirdPartyKYCService
{
    private $subdomain;
    private $sandboxApiKey;
    private $sandboxApiSecret;
    private $testMode;
    private $banxa;

    public function __construct()
    {
        $this->subdomain = 'alchemy';
        $this->sandboxApiKey = 'bullionfx-api';
        $this->sandboxApiSecret = 'KcrtBkXRO81Iy6Ir4s9k53xPZIaZvHbQ';
        $this->testMode = true;
        $this->banxa = Banxa::create($this->subdomain, $this->sandboxApiKey, $this->sandboxApiSecret, $this->testMode);
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

    public function sdk_test($request)
    {        // // KYC
        $data = $this->banxa->createIdentity(
            IdentitySharingCollection::create([
                IdentitySharingProvider::create('sumsub', 'bar')
            ]),
            CustomerDetail::create('test02342340100122', '61431000022', 'phenix2017pr@gmail.com'),
            ResidentialAddress::create('FO', '21 FooBarBaz FizBuz', 'Foobaz', '3000 VIC', 'BAZ'),
            CustomerIdentity::create('FooBarBaz', 'FizBuz', '2001-01-01'),
            IdentityDocumentCollection::create([IdentityDocument::create(IdentityDocument::DOCUMENT_TYPE_PASSPORT, ['https://www.orimi.com/pdf-test.pdf'], 'BTCBaz007')]),
        );
        $response = ['success' => true, 'message' => __('KYC data submitted!'), 'data' => $data];
        return $response;



        // if (curl_error($ch)) {
        //     echo 'Error: ' . curl_error($ch);
        // } else if (isset($result->data)) {
        //     $status = STATUS_PENDING;
        //     if ($result->data->attributes->status == 'completed') {
        //         $status = STATUS_SUCCESS;
        //     }
        //     $thirdPartyKYCDetails = ThirdPartyKycDetails::where('user_id', $user->id)->where('kyc_type', KYC_TYPE_PERSONA)->first();
        //     if (isset($thirdPartyKYCDetails)) {
        //         $thirdPartyKYCDetails->is_verified = $status;
        //         $thirdPartyKYCDetails->key = $request->inquiry_id;
        //         $thirdPartyKYCDetails->save();
        //     } else {
        //         $thirdPartyKYCDetails = new ThirdPartyKycDetails;
        //         $thirdPartyKYCDetails->user_id = $user->id;
        //         $thirdPartyKYCDetails->kyc_type = KYC_TYPE_PERSONA;
        //         $thirdPartyKYCDetails->is_verified = $status;
        //         $thirdPartyKYCDetails->key = $request->inquiry_id;
        //         $thirdPartyKYCDetails->save();
        //     }
        //     $response = ['success' => true, 'message' => 'Verification ' . $result->data->attributes->status];
        // } else {
        //     $response = ['success' => false, 'message' => $result->errors[0]->title];
        // }

        // return $response;
    }

    public function banxaCreateBuyOrder($request) {
        // //create a buy order
        // $accountReference = 'test0234223423423434111233';
        // $fiatCode = 'AUD';
        // $coinCode = 'USDC';
        // $fiatAmount = '2000';
        // $walletAddress = '0x823A49375832391AC4962e34B309098115107C88';
        // $paymentMethodId = '7538';
        // $sourceAddress = '';
        // $sourceAddressTag = '';
        // $email = 'phenix2017pr@gmail.com';
        // $mobile = '';
        // $returnUrlOnSuccess = 'https://example.com';
        // $returnUrlOnFailure = 'https://example.com';
        // $returnUrlOnCancelled = 'https://example.com';
        // $metadata = '';
        // $readOnlyAmounts = false;
        // $iframeRefererDomain = '';

        // // Retrieve a list of countries
        // $response = $this->banxa->getCountries();
        // $response = $this->banxa->getBuyPaymentMethods('AUD', 'USDC');
        // $response = $this->banxa->getAllBuyPrices(
        //     'AUD',
        //     'USDC',
        //     '2000',
        //     'base'
        // );
        // $response = $this->banxa->getBuyPrice(
        //     'AUD',
        //     'USDC',
        //     '2000',
        //     '7538',
        //     'base'
        // );

        // //create a buy order
        $accountReference = 'test02342340100122';
        $fiatCode = 'AUD';
        $coinCode = 'USDC';
        $fiatAmount = 2000;
        $walletAddress = '0x823A49375832391AC4962e34B309098115107C88';
        $paymentMethodId = 7538;
        $sourceAddress = 'test02342340100122';
        $sourceAddressTag = '12345';
        $email = 'phenix2017pr@gmail.com';
        $mobile = '61431000022';
        $returnUrlOnSuccess = 'https://example.com';
        $returnUrlOnFailure = 'https://example.com';
        $returnUrlOnCancelled = 'https://example.com';
        $metadata = 'metastring';
        $readOnlyAmounts = false;
        $iframeRefererDomain = 'https://google.com';
        $buyOrderTransaction = BuyOrderTransaction::createFromFiatAmount(
            $accountReference,
            $fiatCode,
            $coinCode,
            $fiatAmount,
            $walletAddress,
            $paymentMethodId,
            null,
            null
        );
        $optionalOrderParameters = OptionalOrderParameters::create($sourceAddress, $sourceAddressTag, $email, $mobile);
        $response = $this->banxa->createBuyOrder(
            $buyOrderTransaction,
            $returnUrlOnSuccess,
            $returnUrlOnFailure,
            $returnUrlOnCancelled,
            $metadata,
            $readOnlyAmounts,
            $iframeRefererDomain,
            $optionalOrderParameters
        );
        return $response;
        // return json_encode($response);

    }

    public function banxaKYCProcess() {
        $subdomain = 'alchemy';
        $sandboxApiKey = '78b2f18b72e67648c1e3f1ca72449ac3532605ce';
        $sandboxApiSecret = 'w1oQZdP954aPhpEBOMTnEcW95LmOL4DH';
        $client = new Client();

        $response = $client->request('POST', 'https://alchemy.banxa-sandbox.com/api/identities', [
          'body' => '{"customer_identity":{"taxId":"456-44-4564","taxState":"CA","residential_address":{"country":"GB"},"given_name":"Joe","surname":"Bloggs","dob":"1990-01-01"},"account_reference":"test0010011234","email":"kane.smartdev@gmail.com","identity_documents":[{"images":{"link":"https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png"},"data":{"number":"123456789"},"type":"PASSPORT"}]}',
          'headers' => [
            'Accept' => 'application/json',
            'content-type' => 'application/json',
            'x-api-key' => 'Token 78b2f18b72e67648c1e3f1ca72449ac3532605ce',
          ],
        ]);

        echo $response->getBody();

    }
}
