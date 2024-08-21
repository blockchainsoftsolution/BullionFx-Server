<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\admin\DashboardController;
use App\Http\Controllers\admin\TradingBotController;
use App\Http\Controllers\api\user\ProfileController;

Route::group(['prefix' => 'admin', 'namespace' => 'admin', 'middleware' => ['auth', 'admin', 'default_lang']], function () {

    // Logs
    Route::group(['group' => 'log'], function () {
        Route::get('logs', '\Rap2hpoutre\LaravelLogViewer\LogViewerController@index')->name('adminLogs');
    });

    Route::group(['group' => 'dashboard'], function () {
        Route::get('test-bot', [TradingBotController::class, 'botOrder'])->name('botOrder');
        Route::get('dashboard', [DashboardController::class, 'adminDashboard'])->name('adminDashboard');
        Route::get('dashboard-check', [DashboardController::class, 'adminDashboardCheck'])->name('adminDashboardCheck');
        Route::get('pending-withdrawals', 'TransactionController@adminPendingWithdrawal')->name('adminPendingWithdrawals');
    });
    Route::get('earning-report', [DashboardController::class, 'adminEarningReport'])->name('adminEarningReport');

    // user management
    require base_path('routes/link/userManagement.php');

    // coin management
    require base_path('routes/link/coinManagement.php');

    // // wallet deposit withdrawal management
    // require base_path('routes/link/walletManagement.php');

    // // general settings
    require base_path('routes/link/generalSettings.php');

    // // landing settings
    // require base_path('routes/link/landingManagement.php');

    // // fiat management
    // require base_path('routes/link/fiatManagement.php');

    // trade management
    require base_path('routes/link/tradeManagement.php');

    // // trade management
    // require base_path('routes/link/roleManagement.php');

    // // staking management
    // require base_path('routes/link/stakingManagement.php');

    // // gift card
    // require base_path('routes/link/gift_card.php');

    // // future trade management
    // require base_path('routes/link/futureTradeManagement.php');

    // // notification
    // Route::group(['group' => 'notify'], function () {
    //     Route::get('send-notification', [DashboardController::class, 'sendNotification'])->name('sendNotification');
    //     Route::post('send-notification-process', [DashboardController::class, 'sendNotificationProcess'])->name('sendNotificationProcess');
    // });
    // Route::group(['group' => 'email'], function () {
    //     Route::get('send-email', [DashboardController::class, 'sendEmail'])->name('sendEmail');
    //     Route::get('clear-email', [DashboardController::class, 'clearEmailRecord'])->name('clearEmailRecord');
    //     Route::post('send-email-process', [DashboardController::class, 'sendEmailProcess'])->name('sendEmailProcess')->middleware('check_demo');
    // });

});

Route::group(['middleware' => ['auth', 'lang']], function () {
//     Route::get('/send-sms-for-verification', 'user\ProfileController@sendSMS')->name('sendSMS');
//     Route::get('test', 'TestController@index')->name('test');
//     Route::group(['middleware' => 'check_demo'], function () {
//         Route::post('/user-profile-update', 'user\ProfileController@userProfileUpdate')->name('userProfileUpdate');
//         Route::post('/upload-profile-image', 'user\ProfileController@uploadProfileImage')->name('uploadProfileImage');
        Route::post('change-password-save', [ProfileController::class, 'changePasswordSave'])->name('changePasswordSave');
//         Route::post('/phone-verify', 'user\ProfileController@phoneVerify')->name('phoneVerify');
//     });
});

// Route::get('/invocie', function () {
//     return view('email.template-three.index');
// });

// Route::group(['prefix' => 'admin', 'namespace' => 'admin', 'middleware' => ['auth', 'admin', 'default_lang']], function () {
//     // addon settings
//     Route::group(['group' => 'addons_settings'], function () {
//         Route::get('addons-list', 'AddonsController@addonsLists')->name('addonsLists');
//         Route::get('addons-settings', 'AddonsController@addonsSettings')->name('addonsSettings');
//         Route::post('addons-settings-save', 'AddonsController@saveAddonsSettings')->name('saveAddonsSettings')->middleware('check_demo');
//     });
// });
