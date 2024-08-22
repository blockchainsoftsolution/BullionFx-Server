<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\admin\TransactionController;
use App\Http\Controllers\admin\DepositController;

Route::group(['group' => 'transaction_all'], function () {
    Route::get('transaction-export', [TransactionController::class, 'adminTransactionHistoryExport'])->name('adminTransactionHistoryExport');
    Route::get('transaction-history', [TransactionController::class, 'adminTransactionHistory'])->name('adminTransactionHistory');
    Route::get('withdrawal-history', [TransactionController::class, 'adminWithdrawalHistory'])->name('adminWithdrawalHistory');

    Route::get('currency-transaction-history', [TransactionController::class, 'adminTransactionHistoryCurrency'])->name('adminTransactionHistoryCurrency');
    Route::get('currency-withdrawal-history', [TransactionController::class, 'adminWithdrawalHistoryCurrency'])->name('adminWithdrawalHistoryCurrency');
});
Route::group(['group' => 'transaction_withdrawal'], function () {
    Route::get('pending-withdrawal', [TransactionController::class, 'adminPendingWithdrawal'])->name('adminPendingWithdrawal');
    Route::get('rejected-withdrawal', [TransactionController::class, 'adminRejectedWithdrawal'])->name('adminRejectedWithdrawal');
    Route::get('active-withdrawal', [TransactionController::class, 'adminActiveWithdrawal'])->name('adminActiveWithdrawal');
    Route::get('reject-pending-withdrawal-{id}', [TransactionController::class, 'adminRejectPendingWithdrawal'])->name('adminRejectPendingWithdrawal')->middleware('check_demo');
    Route::get('accept-pending-withdrawal-{id}', [TransactionController::class, 'adminAcceptPendingWithdrawal'])->name('adminAcceptPendingWithdrawal');
    Route::get('withdrawal-referral-history', [TransactionController::class, 'adminWithdrawalReferralHistory'])->name('adminWithdrawalReferralHistory');

    Route::get('currrency-pending-withdrawal', [TransactionController::class, 'adminPendingWithdrawalCurrency'])->name('adminPendingWithdrawalCurrency');
    Route::get('currrency-rejected-withdrawal', [TransactionController::class, 'adminRejectedWithdrawalCurrency'])->name('adminRejectedWithdrawalCurrency');
    Route::get('currrency-active-withdrawal', [TransactionController::class, 'adminActiveWithdrawalCurrency'])->name('adminActiveWithdrawalCurrency');
    Route::get('currrency-reject-pending-withdrawal-{id}', [TransactionController::class, 'adminRejectPendingWithdrawalCurrency'])->name('adminRejectPendingWithdrawalCurrency')->middleware('check_demo');
    Route::post('currrency-accept-pending-withdrawal', [TransactionController::class, 'adminAcceptPendingWithdrawalCurrency'])->name('adminAcceptPendingWithdrawalCurrency');
    Route::get('currrency-withdrawal-referral-history', [TransactionController::class, 'adminWithdrawalReferralHistoryCurrency'])->name('adminWithdrawalReferralHistoryCurrency');
});
Route::group(['group' => 'transaction_deposit'], function () {
    Route::get('pending-deposit', [TransactionController::class, 'adminPendingDeposit'])->name('adminPendingDeposit');
    Route::get('accept-pending-deposit-{id}', [TransactionController::class, 'adminPendingDepositAcceptProcess'])->name('adminPendingDepositAcceptProcess')->middleware('check_demo');

    Route::get('pending-currency-deposit', [TransactionController::class, 'adminPendingCurrencyDeposit'])->name('adminPendingCurrencyDeposit');
    Route::get('accept-pending-currency-deposit-{id}', [TransactionController::class, 'adminPendingCurrencyDepositAcceptProcess'])->name('adminPendingCurrencyDepositAcceptProcess')->middleware('check_demo');
    Route::post('reject-pending-currency-deposit', [TransactionController::class, 'adminPendingCurrencyDepositRejectProcess'])->name('adminPendingCurrencyDepositRejectProcess')->middleware('check_demo');
    Route::get('download-pending-bank-deposit-{id}', [TransactionController::class, 'downloadCurrencyDeposit'])->name('downloadCurrencyDeposit')->middleware('check_demo');
});


Route::group(['group' => 'check_deposit'], function () {
    Route::get('check-deposit', [DepositController::class,'adminCheckDeposit'])->name('adminCheckDeposit');
    Route::get('submit-check-deposit', [DepositController::class,'submitCheckDeposit'])->name('submitCheckDeposit');
});

// pending deposit report and action
Route::group(['group' => 'pending_token_deposit'], function () {
    Route::get('pending-token-deposit-history', [DepositController::class,'adminPendingDepositHistory'])->name('adminPendingDepositHistory');
    Route::get('pending-token-deposit-accept-{id}', [DepositController::class,'adminPendingDepositAccept'])->name('adminPendingDepositAccept')->middleware('check_demo');
    Route::get('pending-token-deposit-reject-{id}', [DepositController::class,'adminPendingDepositReject'])->name('adminPendingDepositReject')->middleware('check_demo');

    Route::get('ico-token-buy-list-accept', [DepositController::class,'icoTokenBuyListAccept'])->name('icoTokenBuyListAccept');
    Route::get('admin-ico-token-receive-process/{id}', [DepositController::class,'adminReceiveBuyTokenAmount'])->name('adminReceiveBuyTokenAmount');
});
Route::group(['group' => 'token_gas'], function () {
    Route::get('gas-send-history', [DepositController::class,'adminGasSendHistory'])->name('adminGasSendHistory');
});
Route::group(['group' => 'token_receive_history'], function () {
    Route::get('token-receive-history', [DepositController::class,'adminTokenReceiveHistory'])->name('adminTokenReceiveHistory');
});
