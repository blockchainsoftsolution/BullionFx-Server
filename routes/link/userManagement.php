<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\admin\DashboardController;
use App\Http\Controllers\admin\UserController;

Route::group(['group' => 'user'], function () {
    Route::get('users', [UserController::class, 'adminUsers'])->name('adminUsers');
    Route::get('user-profile', [UserController::class, 'adminUserProfile'])->name('adminUserProfile');
    Route::get('user-edit', [UserController::class, 'UserEdit'])->name('admin.UserEdit');
    Route::get('user-active-{id}', [UserController::class, 'adminUserActive'])->name('admin.user.active');
    Route::get('user-api-access-{id}', [UserController::class, 'adminUserApiAccess'])->name('admin.user.api.access');
    Route::get('user-remove-gauth-set-{id}', [UserController::class, 'adminUserRemoveGauth'])->name('admin.user.remove.gauth');
    Route::get('user-email-verify-{id}', [UserController::class, 'adminUserEmailVerified'])->name('admin.user.email.verify');
    Route::get('user-phone-verify-{id}', [UserController::class, 'adminUserPhoneVerified'])->name('admin.user.phone.verify');
    Route::get('deleted-users', [UserController::class, 'adminDeletedUser'])->name('adminDeletedUser');
    Route::get('user-export', [UserController::class, 'userExport'])->name('userExport');

    Route::group(['group' => 'user', 'middleware' => 'check_demo'], function () {
        Route::get('user-add', [UserController::class, 'UserAddEdit'])->name('admin.UserAddEdit');
        Route::get('user-delete-{id}', [UserController::class, 'adminUserDelete'])->name('admin.user.delete');
        Route::get('user-force-delete-{id}', [UserController::class, 'adminUserForceDelete'])->name('adminUserForceDelete');
        Route::get('user-suspend-{id}', [UserController::class, 'adminUserSuspend'])->name('admin.user.suspend');

        Route::get('profile-delete-request-deactive-{id}', [UserController::class, 'adminUserDeleteRequestDeactive'])->name('adminUserDeleteRequestDeactive');
        Route::get('profile-delete-request-sofdelete-{id}', [UserController::class, 'adminUserDeleteRequestSoftDelete'])->name('adminUserDeleteRequestSoftDelete');
        Route::get('profile-delete-request-force-delete-{id}', [UserController::class, 'adminUserDeleteRequestForceDelete'])->name('adminUserDeleteRequestForceDelete');
        Route::get('profile-delete-request-rejected-{id}', [UserController::class, 'adminUserDeleteRequestRejected'])->name('adminUserDeleteRequestRejected');

        Route::post('user-white-list-add', [UserController::class, 'addUserWhiteList'])->name('addUserWhiteList');
        Route::get('delete-user-white-list-{id?}', [UserController::class, 'deleteUserWhiteList'])->name('deleteUserWhiteList');
        Route::get('update-user-white-list-status', [UserController::class, 'updateUserWhiteListStatus'])->name('updateUserWhiteListStatus');
        Route::post('user-api-access-update', [UserController::class, 'userApiAccessUpdate'])->name('userApiAccessUpdate');
    });
});

Route::group(['group' => 'profile'], function () {
    Route::get('profile', [DashboardController::class, 'adminProfile'])->name('adminProfile');

    Route::group(['group' => 'profile', 'middleware' => 'check_demo'], function () {
        Route::post('user-profile-update', [DashboardController::class, 'UserProfileUpdate'])->name('UserProfileUpdate');
        Route::post('upload-profile-image', [DashboardController::class, 'uploadProfileImage'])->name('uploadProfileImage');
        Route::post("google-two-factor-enable", [DashboardController::class, 'g2fa_enable'])->name("SaveTwoFactorAdmin");
        Route::post('update-two-factor', [DashboardController::class, 'updateTwoFactor'])->name("UpdateTwoFactor");
    });
});


// ID Varification
Route::group(['group' => 'pending_id'], function () {
    Route::get('verification-details-{id}', [UserController::class, 'VerificationDetails'])->name('adminUserDetails');
    Route::get('pending-id-verified-user', [UserController::class, 'adminUserIdVerificationPending'])->name('adminUserIdVerificationPending');
    Route::get('verification-active-{id}-{type}', [UserController::class, 'adminUserVerificationActive'])->name('adminUserVerificationActive');
    Route::get('verification-reject', [UserController::class, 'varificationReject'])->name('varificationReject');
});
