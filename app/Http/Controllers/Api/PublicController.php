<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\NotificationOption;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class PublicController extends Controller
{
    private $token_prices;
    private $last_time_token_prices; // in seconds
    private $token_prices_interval = 30; // seconds
    public function __construct()
    {
        $this->last_time_token_prices = 0;
    }

    /**
     * token prices
     */
    private function getTokenPrices() {
        $current_time = now() -> timestamp;
        if ( $current_time - $this->last_time_token_prices < $this->token_prices_interval) {
            return $this->token_prices;
        } else {
            try {
                $new_token_prices = Http::retry(3, 3000)->get('https://api.coingecko.com/api/v3/simple/price?ids=pax-gold,usd-coin,ethereum&vs_currencies=usd');
                $this->token_prices = $new_token_prices;
                $this->last_time_token_prices = $current_time;
                return $new_token_prices;
            } catch (\Exception $e) {
                storeException('tokenPrices', $e->getMessage());
                return $this->token_prices;
            }
        }
    }

    /**
     * token list
     * @return \Illuminate\Http\JsonResponse
     */
    public function tokenList()
    {
        $token_prices = $this->getTokenPrices();

        $token_list = [
            [
                'coingecko' => "pax-gold",
                'icon' => "https://i.postimg.cc/WzvPbrYG/gold.png",
                'symbol' => "GOLD",
                'fullName' => "Gold",
                'price' => $token_prices['pax-gold']['usd'],
                'isShow' => true,
                'address' => "0xDe991c4F25FC01CeB004f93d147E9125FF823D2D",
            ],
            [
                'coingecko' => "usd-coin",
                'icon' => "https://i.postimg.cc/Gm2n2bK5/usdc.png",
                'symbol' => "USDC",
                'fullName' => "USD Coin",
                'price' => $token_prices['usd-coin']['usd'],
                'isShow' => true,
                'address' => "0x2979508DE07B8fE905F54Cc7099E5A76638847E4",
            ],
            [
                'coingecko' => "ethereum",
                'icon' => "https://i.postimg.cc/TYxRR8Bz/eth.png",
                'symbol' => "ETH",
                'fullName' => "Ethereum",
                'price' => $token_prices['ethereum']['usd'],
                'address' => "ETH",
            ],
        ];
        
        return response()->json($token_list);
    }

    /**
     * notification list
     * @return \Illuminate\Http\JsonResponse
     */
    public function notificationOptions() {
        try {
            $result = NotificationOption::get();
            $response = ['success' => true,'message' => __('read'), 'data' => $result];
        } catch (\Exception $e) {
            $response = ['success' => false,'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }
}
