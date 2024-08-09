<?php
namespace App\Http\Services;

use App\Models\ThirdPartyKycDetails;

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

    public function banxaKYCVerification($request)
    {
        $user = auth()->user();

        $settings = allsetting(['banxa_api_key', 'banxa_partner_name']);
        $headers = [
            'Authorization: Bearer ' . $settings['banxa_api_key'],
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
                    'type' => 'DRIVING_LICENSE',
                    'data' => [
                        'number' => '123456789',
                    ],
                    'images' => [
                    'link' => 'https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png',
                    'link' => 'https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png',
                    ]
                ],
                [
                    'type' => 'type',
                    'images' => [
                    'link' => 'https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png',
                    ]
                ],
            ],
            // 'document_image' => base64_encode(file_get_contents('path/to/document_image.jpg')),
        ];
        return $data;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://{$settings['banxa_partner_name']}.banxa.com/api/identities");
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        $result = curl_exec($ch);
        $result = json_decode($result);
        curl_close($ch);

        if (curl_error($ch)) {
            echo 'Error: ' . curl_error($ch);
        } else if (isset($result->data)) {
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
}
