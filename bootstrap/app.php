<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use App\Http\Middleware\ApiUser;
use App\Http\Middleware\UserLastActivity;
use Illuminate\Support\Facades\Cache;
use Illuminate\Console\Scheduling\Schedule;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',
        api: __DIR__ . '/../routes/api.php',
        apiPrefix: 'api',
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->alias([
            'auth' => App\Http\Middleware\Authenticate::class,
            'admin' => App\Http\Middleware\Admin::class,
            'default_lang' => App\Http\Middleware\DefaultLanguage::class,
            'permission' => App\Http\Middleware\PermissionAdmin::class,
            'check_demo' => App\Http\Middleware\CheckDemoMiddleware::class,
            'checkApi' => App\Http\Middleware\CheckApi::class,
            'maintenanceMode' => App\Http\Middleware\MaintenanceModeCheckMiddleware::class,
            'api-user' => ApiUser::class,
            'generateSecret' => \App\Http\Middleware\GenerateSecretKey::class,
            'last_seen' => UserLastActivity::class,
        ]);
    })
    ->withSchedule(function (Schedule $schedule) {
        $schedule->call(function () {
            $end_time = time();
            $start_time = $end_time - 3600; // 1 hour ago
            $url = "https://gsxau.sakaralabs.xyz/api/udf/history?symbol=XAUUSD&resolution=1&from={$start_time}&to={$end_time}";
            try {
                $response = Http::get($url);
                
                if ($response->successful()) {
                    Cache::put('coingecko_1H_gold_price', $response->json(), now()->addHour()); // Store 1 hour data
                    Log::info('CoinGecko 1H gold price updated successfully.');
                } else {
                    Log::error('Failed to fetch CoinGecko 1H Gold Price', ['status' => $response->status()]);
                }
            } catch (\Exception $e) {
                Log::error('Error fetching CoinGecko 1H gold price', ['message' => $e->getMessage()]);
            }
        })->everyMinute();
        $schedule->call(function () {
            $end_time = time();
            $start_time = $end_time - 86400; // 1 day ago
            $url = "https://gsxau.sakaralabs.xyz/api/udf/history?symbol=XAUUSD&resolution=5&from={$start_time}&to={$end_time}";
            try {
                $response = Http::get($url);
                
                if ($response->successful()) {
                    Cache::put('coingecko_1D_gold_price', $response->json(), now()->addHour()); // Store 1 day
                    Log::info('CoinGecko 1D gold price updated successfully.');
                } else {
                    Log::error('Failed to fetch CoinGecko 1D Gold Price', ['status' => $response->status()]);
                }
            } catch (\Exception $e) {
                Log::error('Error fetching CoinGecko 1D gold price', ['message' => $e->getMessage()]);
            }
        })->everyMinute();
        $schedule->call(function () {
            $end_time = time();
            $start_time = $end_time - 86400 * 7; // 7 day ago
            $url = "https://gsxau.sakaralabs.xyz/api/udf/history?symbol=XAUUSD&resolution=60&from={$start_time}&to={$end_time}";
            try {
                $response = Http::get($url);
                
                if ($response->successful()) {
                    Cache::put('coingecko_1W_gold_price', $response->json(), now()->addHour()); // Store 1 week
                    Log::info('CoinGecko 1W gold price updated successfully.');
                } else {
                    Log::error('Failed to fetch CoinGecko 1W Gold Price', ['status' => $response->status()]);
                }
            } catch (\Exception $e) {
                Log::error('Error fetching CoinGecko 1W gold price', ['message' => $e->getMessage()]);
            }
        })->everyMinute();
        $schedule->call(function () {
            $end_time = time();
            $start_time = $end_time - 86400 * 30; // 30 day ago
            $url = "https://gsxau.sakaralabs.xyz/api/udf/history?symbol=XAUUSD&resolution=240&from={$start_time}&to={$end_time}";
            try {
                $response = Http::get($url);
                
                if ($response->successful()) {
                    Cache::put('coingecko_1M_gold_price', $response->json(), now()->addHour()); // Store 1 month
                    Log::info('CoinGecko 1M gold price updated successfully.');
                } else {
                    Log::error('Failed to fetch CoinGecko 1M Gold Price', ['status' => $response->status()]);
                }
            } catch (\Exception $e) {
                Log::error('Error fetching CoinGecko 1M gold price', ['message' => $e->getMessage()]);
            }
        })->everyMinute();
        $schedule->call(function () {
            $end_time = time();
            $start_time = $end_time - 86400 * 90; // 90 day ago
            $url = "https://gsxau.sakaralabs.xyz/api/udf/history?symbol=XAUUSD&resolution=D&from={$start_time}&to={$end_time}";
            try {
                $response = Http::get($url);
                
                if ($response->successful()) {
                    Cache::put('coingecko_3M_gold_price', $response->json(), now()->addHour()); // Store 3 months
                    Log::info('CoinGecko 3M gold price updated successfully.');
                } else {
                    Log::error('Failed to fetch CoinGecko 3M Gold Price', ['status' => $response->status()]);
                }
            } catch (\Exception $e) {
                Log::error('Error fetching CoinGecko 3M gold price', ['message' => $e->getMessage()]);
            }
        })->everyMinute();
        $schedule->call(function () {
            $end_time = time();
            $start_time = $end_time - 86400 * 360; // 360 day ago
            $url = "https://gsxau.sakaralabs.xyz/api/udf/history?symbol=XAUUSD&resolution=D&from={$start_time}&to={$end_time}";
            try {
                $response = Http::get($url);
                
                if ($response->successful()) {
                    Cache::put('coingecko_1Y_gold_price', $response->json(), now()->addHour()); // Store 1 year
                    Log::info('CoinGecko 1Y gold price updated successfully.');
                } else {
                    Log::error('Failed to fetch CoinGecko 1Y Gold Price', ['status' => $response->status()]);
                }
            } catch (\Exception $e) {
                Log::error('Error fetching CoinGecko 1Y gold price', ['message' => $e->getMessage()]);
            }
        })->everyMinute();
        $schedule->call(function () {
            $end_time = time();
            $url = "https://gsxau.sakaralabs.xyz/api/udf/history?symbol=XAUUSD&resolution=D&from=1&to={$end_time}";
            try {
                $response = Http::get($url);
                
                if ($response->successful()) {
                    Cache::put('coingecko_All_gold_price', $response->json(), now()->addHour()); // Store 1 year
                    Log::info('CoinGecko all gold price updated successfully.');
                } else {
                    Log::error('Failed to fetch CoinGecko all Gold Price', ['status' => $response->status()]);
                }
            } catch (\Exception $e) {
                Log::error('Error fetching CoinGecko all gold price', ['message' => $e->getMessage()]);
            }
        })->everyMinute();
        
        // $schedule->call(function () {
        //     $end_time = time();
        //     $start_time = $end_time - 86400 * 90; // 3 months ago
        //     $url = "https://api.coingecko.com/api/v3/coins/pax-gold/market_chart/range?vs_currency=usd&from={$start_time}&to={$end_time}";
        //     try {
        //         $response = Http::get($url);
                
        //         if ($response->successful()) {
        //             Cache::put('coingecko_houly_gold_price', $response->json(), now()->addDay()); // Store for 3 months
        //             Log::info('CoinGecko hourly gold price updated successfully.');
        //         } else {
        //             Log::error('Failed to fetch CoinGecko hourly Gold Price', ['status' => $response->status()]);
        //         }
        //     } catch (\Exception $e) {
        //         Log::error('Error fetching CoinGecko hourly gold price', ['message' => $e->getMessage()]);
        //     }
        // })->hourly();

        // $schedule->call(function () {
        //     $end_time = time();
        //     $start_time = $end_time - 86400 * 365; // 1 year ago
        //     $url = "https://api.coingecko.com/api/v3/coins/pax-gold/market_chart/range?vs_currency=usd&from={$start_time}&to={$end_time}";
        //     try {
        //         $response = Http::get($url);
                
        //         if ($response->successful()) {
        //             Cache::put('coingecko_daily_gold_price', $response->json(), now()->addDay()); // Store for 1 day
        //             Log::info('CoinGecko daily gold price updated successfully.');
        //         } else {
        //             Log::error('Failed to fetch CoinGecko daily Gold Price', ['status' => $response->status()]);
        //         }
        //     } catch (\Exception $e) {
        //         Log::error('Error fetching CoinGecko daily gold price', ['message' => $e->getMessage()]);
        //     }
        // })->twiceDailyAt(0, 12, 35);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();
