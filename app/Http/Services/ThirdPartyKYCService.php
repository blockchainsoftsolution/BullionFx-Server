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

    public function banxaKYCProcess($request)
    {
        $subdomain = 'alchemy';
        $sandboxApiKey = 'alchemy@TEST//26082024-806*#!';
        $sandboxApiSecret = 'w1oQZdP954aPhpEBOMTnEcW95LmOL4DH';
        $testMode = true;

        // $client = new Client([
        //     'base_uri' => '"https://alchemy.banxa-sandbox.com/api', // or the appropriate Banxa API base URI
        // ]);

        // $apiKey = $sandboxApiKey;
        // $secretKey = $sandboxApiSecret;

        // $method = 'POST'; // or POST, PUT, etc.
        // $url = '/identities'; // the specific API endpoint you're accessing
        // $timestamp = round(microtime(true) * 1000);

        // $signature = $this->generateSignature($secretKey, $method, $url, $timestamp);

        // $response = $client->request($method, $url, [
        //     'headers' => [
        //         'X-Banxa-Api-Key' => $apiKey,
        //         'X-Banxa-Api-Timestamp' => $timestamp,
        //         'X-Banxa-Api-Signature' => $signature,
        //         'Content-Type' => 'application/json',
        //     ]
        // ]);
        // return $response;











        $banxa = Banxa::create($subdomain, $sandboxApiKey, $sandboxApiSecret, $testMode);
        // // KYC
        // $response = $banxa->createIdentity(
        //     IdentitySharingCollection::create([
        //         IdentitySharingProvider::create('sumsub', 'bar')
        //     ]),
        //     CustomerDetail::create('test02342340100122', '61431000022', 'phenix2017pr@gmail.com'),
        //     ResidentialAddress::create('FO', '21 FooBarBaz FizBuz', 'Foobaz', '3000 VIC', 'BAZ'),
        //     CustomerIdentity::create('FooBarBaz', 'FizBuz', '2001-01-01'),
        //     IdentityDocumentCollection::create([IdentityDocument::create(IdentityDocument::DOCUMENT_TYPE_PASSPORT, ['https://www.orimi.com/pdf-test.pdf'], 'BTCBaz007')]),
        // );

        // // Retrieve a list of countries
        // $response = $banxa->getCountries();
        // $response = $banxa->getBuyPaymentMethods('AUD', 'USDC');
        // $response = $banxa->getAllBuyPrices(
        //     'AUD',
        //     'USDC',
        //     '2000',
        //     'base'
        // );
        // $response = $banxa->getBuyPrice(
        //     'AUD',
        //     'USDC',
        //     '2000',
        //     '7538',
        //     'base'
        // );

        //create a buy order
        $accountReference = 'test0234223423423434111233';
        $fiatCode = 'AUD';
        $coinCode = 'USDC';
        $fiatAmount = '2000';
        $walletAddress = '0x823A49375832391AC4962e34B309098115107C88';
        $paymentMethodId = '7538';
        $sourceAddress = '';
        $sourceAddressTag = '';
        $email = 'phenix2017pr@gmail.com';
        $mobile = '';
        $returnUrlOnSuccess = 'https://example.com';
        $returnUrlOnFailure = 'https://example.com';
        $returnUrlOnCancelled = 'https://example.com';
        $metadata = '';
        $readOnlyAmounts = false;
        $iframeRefererDomain = '';
        $buyOrderTransaction = BuyOrderTransaction::createFromFiatAmount(
            $accountReference,
            $fiatCode,
            $coinCode,
            $fiatAmount,
            $walletAddress,
            $paymentMethodId
        );
        $optionalOrderParameters = OptionalOrderParameters::create($sourceAddress, $sourceAddressTag, $email, $mobile);
        $response = $banxa->createBuyOrder(
            $buyOrderTransaction,
            $returnUrlOnSuccess,
            $returnUrlOnFailure,
            $returnUrlOnCancelled,
            $metadata,
            $readOnlyAmounts,
            $iframeRefererDomain,
            $optionalOrderParameters
        );
        return json_encode($response);


        // $httpClient = new HttpClient($subdomain, $sandboxApiKey, $sandboxApiSecret, $testMode);
        // $createIdentity = new CreateIdentity($httpClient);
        // $response = $createIdentity->create(
        //     IdentitySharingCollection::create([
        //         IdentitySharingProvider::create('sumsub', 'bar')
        //     ]),
        //     CustomerDetail::create('test00100122', '61431000022', 'test@bitcoin.com'),
        //     ResidentialAddress::create('FO', '21 FooBarBaz FizBuz', 'Foobaz', '3000 VIC', 'BAZ'),
        //     CustomerIdentity::create('FooBarBaz', 'FizBuz', '2001-01-01'),
        //     IdentityDocumentCollection::create([IdentityDocument::create(IdentityDocument::DOCUMENT_TYPE_PASSPORT, ['https://www.orimi.com/pdf-test.pdf'], 'BTCBaz007')]),
        // );

        // return $response;
        // return 'sdf';


        // $banxa->createIdentity(
        //     $identitySharingCollection,
        //     $customerDetail,
        //     $residentialAddress,
        //     $customerIdentity,
        //     $identityDocumentCollection
        // );

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

    public function curl_test() {
        $subdomain = 'alchemy';
        $sandboxApiKey = 'alchemy@TEST//26082024-806*#!';
        $sandboxApiSecret = 'w1oQZdP954aPhpEBOMTnEcW95LmOL4DH';
        $testMode = true;

        $headers = [
            'Authorization: Bearer ' . $sandboxApiKey,
            'accept: application/json',
        ];

        // User data to be verified or submitted
        $data = [
            'account_reference' => 'test001001',
            'mobile_number' => '61431000001',
            'email' => 'test@bitcoin.com.au',
            'customer_identity' => [
                'given_name' => 'Joe',
                'surname' => 'Bloggs',
                'dob' => '1990-01-31',
                'residential_address' => [
                   'address_line_1' => '44 Gwynne Street',
                   'suburb' => 'Cremorne',
                   'post_code' => '3121',
                   'state' => 'VIC',
                   'country' => 'AU',

                ]
            ],
            'identity_documents' => [
                [
                    'type' => 'PASSPORT',
                    'data' => [
                        'number' => '123456789',
                    ],
                    'images' => [
                    'link' => 'https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png',
                    ]
                ],
            ],
            // 'document_image' => base64_encode(file_get_contents('path/to/document_image.jpg')),
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://{$subdomain}.banxa-sandbox.com/api/identities");
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        $result = curl_exec($ch);
        $result = json_decode($result);
        curl_close($ch);
        return $result;
    }
}
