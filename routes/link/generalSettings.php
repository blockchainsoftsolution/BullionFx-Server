<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\admin\SettingsController;
use App\Http\Controllers\admin\ThemeSettingsController;

//FAQ
Route::group(['group' => 'faq'], function () {
    Route::get('faq-list', [SettingsController::class, 'adminFaqList'])->name('adminFaqList');
    Route::get('faq-add', [SettingsController::class, 'adminFaqAdd'])->name('adminFaqAdd');
    Route::get('faq-type-add', [SettingsController::class, 'adminFaqTypeAdd'])->name('adminFaqTypeAdd');
    Route::get('faq-edit-{id}', [SettingsController::class, 'adminFaqEdit'])->name('adminFaqEdit');
    Route::get('faq-type-edit-{id}', [SettingsController::class, 'adminFaqTypeEdit'])->name('adminFaqTypeEdit');

    Route::group(['group' => 'faq','middleware' => 'check_demo'], function () {
        Route::get('faq-delete-{id}', [SettingsController::class, 'adminFaqDelete'])->name('adminFaqDelete');
        Route::get('faq-type-delete-{id}', [SettingsController::class, 'adminFaqTypeDelete'])->name('adminFaqTypeDelete');
        Route::post('faq-type-save', [SettingsController::class, 'adminFaqTypeSave'])->name('adminFaqTypeSave');
        Route::post('faq-save', [SettingsController::class, 'adminFaqSave'])->name('adminFaqSave');
    });
});

Route::group(['group' => 'general'], function () {
    Route::get('general-settings', [SettingsController::class, 'adminSettings'])->name('adminSettings');

    Route::group(['middleware' => 'check_demo', 'group' => 'general'], function () {
        Route::post('admin-save-common-setting', [SettingsController::class, 'adminSettingsSaveCommon'])->name('adminSettingsSaveCommon');
        Route::post('common-settings', [SettingsController::class, 'adminCommonSettings'])->name('adminCommonSettings');
        Route::post('recaptcha-settings', [SettingsController::class, 'adminCapchaSettings'])->name('adminCapchaSettings');
        Route::post('email-save-settings', [SettingsController::class, 'adminSaveEmailSettings'])->name('adminSaveEmailSettings');
        Route::post('email-template-save-settings', [SettingsController::class, 'adminSaveEmailTemplateSettings'])->name('adminSaveEmailTemplateSettings');
        Route::post('sms-save-settings', [SettingsController::class, 'adminSaveSmsSettings'])->name('adminSaveSmsSettings');
        Route::post('referral-fees-settings', [SettingsController::class, 'adminReferralFeesSettings'])->name('adminReferralFeesSettings');
        Route::post('trade-referral-fees-settings', [SettingsController::class, 'adminTradeReferralFeesSettings'])->name('adminTradeReferralFeesSettings');
        Route::post('cron-save-settings', [SettingsController::class, 'adminSaveCronSettings'])->name('adminSaveCronSettings');
        Route::post('save-wallet-overview-settings', [SettingsController::class, 'adminSaveWalletOverviewSettings'])->name('adminSaveWalletOverviewSettings');
        Route::post('fiat-widthdraw-save-settings', [SettingsController::class, 'adminSaveFiatWithdrawalSettings'])->name('adminSaveFiatWithdrawalSettings');
        Route::post('admin-exchange-layout-setting', [SettingsController::class, 'adminExchangeLayoutSettings'])->name('adminExchangeLayoutSettings');
        Route::post('admin-api-overview-setting', [SettingsController::class, 'adminApiOverviewSettings'])->name('adminApiOverviewSettings');

        // Route::post('choose-sms-settings-save', [SMSController::class, 'adminChooseSmsSettings'])->name('adminChooseSmsSettings');
        // Route::post('nexmo-settings-save', [SMSController::class, 'adminNexmoSmsSettingsSave'])->name('adminNexmoSmsSettingsSave');
        // Route::post('send-test-sms', [SMSController::class, 'adminSendTestSms'])->name('adminSendTestSms');
        // Route::post('africa-talk-sms-settings-save', [SMSController::class, 'adminAfricaTalkSmsSettingsSave'])->name('adminAfricaTalkSmsSettingsSave');

    });
});

Route::group(['group' => 'feature_settings'], function () {
    Route::get('admin-feature-settings', [SettingsController::class, 'adminFeatureSettings'])->name('adminFeatureSettings');
    Route::post('admin-cookie-settings-save', [SettingsController::class, 'adminCookieSettingsSave'])->name('adminCookieSettingsSave')->middleware('check_demo');
    Route::get('delete-bot-orders', [SettingsController::class, 'deleteBotOrders'])->name('adminDeleteBotOrders')->middleware('check_demo');
});

Route::group(['group' => 'api_settings'], function () {
    Route::get('api-settings', [SettingsController::class, 'adminCoinApiSettings'])->name('adminCoinApiSettings');
    // Route::get('network-fees', [CoinPaymentNetworkFee::class, 'list'])->name('networkFees');

    Route::group(['middleware' => 'check_demo', 'group' => 'api_settings'], function () {
        Route::post('save-payment-settings', [SettingsController::class, 'adminSavePaymentSettings'])->name('adminSavePaymentSettings');
        Route::post('save-bitgo-settings', [SettingsController::class, 'adminSaveBitgoSettings'])->name('adminSaveBitgoSettings');
        Route::post('admin-erc20-api-settings', [SettingsController::class, 'adminSaveERC20ApiSettings'])->name('adminSaveERC20ApiSettings');
        Route::post('admin-other-api-settings', [SettingsController::class, 'adminSaveOtherApiSettings'])->name('adminSaveOtherApiSettings');
        Route::post('admin-stripe-api-settings', [SettingsController::class, 'adminSaveStripeApiSettings'])->name('adminSaveStripeApiSettings');
        Route::post('admin-razorpay-api-settings', [SettingsController::class, 'adminSaveRazorpayApiSettings'])->name('adminSaveRazorpayApiSettings');
        // Route::get('network-fees-update', [CoinPaymentNetworkFee::class, 'createOrUpdate'])->name('networkFeesUpdate');
        Route::post('admin-paystack-api-settings', [SettingsController::class, 'adminSavePaystackApiSettings'])->name('adminSavePaystackApiSettings');
        Route::post('currency-exchange-rate-api-update', [SettingsController::class, 'adminSaveCurrencyExchangeApiSettings'])->name('adminSaveCurrencyExchangeApiSettings');
    });
});

// // language
// Route::group(['group' => 'lang_list'], function () {
//     Route::get('lang-list', [AdminLangController::class, 'adminLanguageList'])->name('adminLanguageList');
//     Route::get('lang-add', [AdminLangController::class, 'adminLanguageAdd'])->name('adminLanguageAdd');
//     Route::get('lang-edit-{id}', [AdminLangController::class, 'adminLanguageEdit'])->name('adminLanguageEdit');
//     Route::post('lang-save', [AdminLangController::class, 'adminLanguageSave'])->name('adminLanguageSave')->middleware('check_demo');
//     Route::get('lang-delete-{id}', [AdminLangController::class, 'adminLanguageDelete'])->name('adminLanguageDelete')->middleware('check_demo');
//     Route::get('lang-synchronize', [AdminLangController::class, 'adminLanguageSynchronize'])->name('adminLanguageSynchronize')->middleware('check_demo');
//     Route::post('lang-status-change', [AdminLangController::class, 'adminLangStatus'])->name('adminLangStatus')->middleware('check_demo');
// });

//Bank settings
// Route::group(['group' => 'bank_list'], function () {
//     Route::get('bank-list', [BankController::class, 'bankList'])->name('bankList');
//     Route::get('bank-add', [BankController::class, 'bankAdd'])->name('bankAdd');
//     Route::get('bank-edit-{id}', [BankController::class, 'bankEdit'])->name('bankEdit');
//     Route::post('bank-save', [BankController::class, 'bankStore'])->name('bankStore')->middleware('check_demo');
//     Route::post('bank-status-change', [BankController::class, 'bankStatusChange'])->name('bankStatusChange')->middleware('check_demo');
//     Route::get('bank-delete-{id}', [BankController::class, 'bankDelete'])->name('bankDelete')->middleware('check_demo');
// });

// // Two Factor Setting
// Route::group(['group' => 'two_factor'], function () {
//     Route::get("two-factor-settings", [TwoFactorController::class, "index"])->name("twoFactor");
//     Route::post("two-factor-settings", [TwoFactorController::class, "saveTwoFactorList"])->name("SaveTwoFactor")->middleware('check_demo');
//     Route::post("two-factor-data", [TwoFactorController::class, "saveTwoFactorData"])->name("SaveTwoFactorData")->middleware('check_demo');
// });


Route::group(['group' => 'theme_setting'], function () {
    Route::get('themes-settings', [ThemeSettingsController::class, 'themesSettingsPage'])->name('themesSettingsPage');
    Route::get('theme-settings', [ThemeSettingsController::class, 'addEditThemeSettings'])->name('addEditThemeSettings');
    Route::get('reset-theme-color-settings', [ThemeSettingsController::class, 'resetThemeColorSettings'])->name('resetThemeColorSettings');
    Route::post('theme-navebar-settings-save', [ThemeSettingsController::class, 'themeNavebarSettingsSave'])->name('themeNavebarSettingsSave')->middleware('check_demo');
    Route::post('theme-settings-store', [ThemeSettingsController::class, 'addEditThemeSettingsStore'])->name('addEditThemeSettingsStore')->middleware('check_demo');
    Route::post('themes-settings-save', [ThemeSettingsController::class, 'themesSettingSave'])->name('themesSettingSave')->middleware('check_demo');
    Route::post('themes-settings-save', [ThemeSettingsController::class, 'themesSettingSave'])->name('themesSettingSave')->middleware('check_demo');
    Route::post('save-settings-admin', [SettingsController::class, 'saveAdminSettingsCommon'])->name('saveAdminSettingsCommon');

});

//progress status
// Route::group(['group' => 'progress-status-list'], function () {
//     Route::get('progress-status-list', 'ProgressStatusController@progressStatusList')->name('progressStatusList');
//     Route::get('progress-status-add', 'ProgressStatusController@progressStatusAdd')->name('progressStatusAdd');
//     Route::get('progress-status-edit/{id}', 'ProgressStatusController@progressStatusEdit')->name('progressStatusEdit');
//     Route::get('progress-status-settings', 'ProgressStatusController@progressStatusSettings')->name('progressStatusSettings')->middleware('check_demo');
//     Route::post('progress-status-settings-update', 'ProgressStatusController@progressStatusSettingsUpdate')->name('progressStatusSettingsUpdate')->middleware('check_demo');
//     Route::get('progress-status-delete/{id}', 'ProgressStatusController@progressStatusDelete')->name('progressStatusDelete')->middleware('check_demo');
//     Route::post('progress-status-save', 'ProgressStatusController@progressStatusSave')->name('progressStatusSave')->middleware('check_demo');
// });
