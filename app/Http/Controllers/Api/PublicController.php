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
    private function getTokenPrices()
    {
        $current_time = now()->timestamp;
        if ($current_time - $this->last_time_token_prices < $this->token_prices_interval) {
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

    private function getGoldToken($chainId) {
        $token_prices = $this->getTokenPrices();
        switch ($chainId) {
            case 1: return [
                'coingecko' => "pax-gold",
                'icon' => "https://raw.githubusercontent.com/blockchainsoftsolution/bullionfx-images/main/coins/gold.svg",
                'symbol' => "GOLD",
                'fullName' => "Gold",
                'price' => $token_prices['pax-gold']['usd'] ?? 0,
                'isShow' => true,
                'address' => "0xA5D5FA1307948fa447CA87601aD646bde66b362C",
            ];
            default: return [
                'coingecko' => "pax-gold",
                'icon' => "https://raw.githubusercontent.com/blockchainsoftsolution/bullionfx-images/main/coins/gold.svg",
                'symbol' => "GOLD",
                'fullName' => "Gold",
                'price' => $token_prices['pax-gold']['usd'] ?? 0,
                'isShow' => true,
                'address' => "0xC2F25646323F4F1e03cdDf03b886Ad4E5043F214",
            ];
        }
    }

    private function getUsdcToken($chainId) {
        $token_prices = $this->getTokenPrices();
        switch ($chainId) {
            case 1: return [
                'coingecko' => "usd-coin",
                'icon' => "https://raw.githubusercontent.com/blockchainsoftsolution/bullionfx-images/main/coins/usdc.svg",
                'symbol' => "USDC",
                'fullName' => "USD Coin",
                'price' => $token_prices['usd-coin']['usd'] ?? 0,
                'isShow' => true,
                'address' => "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
            ];
            default: return [
                'coingecko' => "usd-coin",
                'icon' => "https://raw.githubusercontent.com/blockchainsoftsolution/bullionfx-images/main/coins/usdc.svg",
                'symbol' => "USDC",
                'fullName' => "USD Coin",
                'price' => $token_prices['usd-coin']['usd'] ?? 0,
                'isShow' => true,
                'address' => "0x41d393ae236d08155301529a33B15DE4504696c7",
            ];
        }
    }

    /**
     * token list
     * @return \Illuminate\Http\JsonResponse
     */
    public function tokenList(Request $request)
    {
        $chainId = (int) $request->input('chain_id');

        $token_list = [
            $this->getGoldToken($chainId),
            $this->getUsdcToken($chainId),
            // [
            //     'coingecko' => "ethereum",
            //     'icon' => "https://raw.githubusercontent.com/blockchainsoftsolution/bullionfx-images/main/coins/eth.svg",
            //     'symbol' => "ETH",
            //     'fullName' => "Ethereum",
            //     'price' => $token_prices['ethereum']['usd'],
            //     'address' => "ETH",
            // ],
        ];

        return response()->json($token_list);
    }

    /**
     * notification list
     * @return \Illuminate\Http\JsonResponse
     */
    public function notificationOptions()
    {
        try {
            $result = NotificationOption::get();
            $response = ['success' => true, 'message' => __('read'), 'data' => $result];
        } catch (\Exception $e) {
            $response = ['success' => false, 'message' => __('Something went wrong'), 'data' => []];
        }
        return response()->json($response);
    }
}
