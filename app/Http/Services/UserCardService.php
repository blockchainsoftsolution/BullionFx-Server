<?php

namespace App\Http\Services;

use App\Models\UserCard;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class UserCardService
{
    public function __construct()
    {
    }

    public function getUserCard($card_id = null)
    {
        try {
            $id = Auth::id();
            if ($card_id) {
                $card = UserCard::where(['id' => $card_id, 'user_id' => $id, 'status' => STATUS_ACTIVE])->first();
                if ($card)
                    return ['success' => true, 'data' => $card, 'message' => __("User card get successfully")];
                else
                    return ['success' => false, 'data' => (Object) [5], 'message' => __("User card get successfully")];
            }
            $card = UserCard::where('user_id', $id)->whereStatus(STATUS_ACTIVE)->get();
            if ($card)
                return ['success' => true, 'data' => $card, 'message' => __("User card get successfully")];
            else
                return ['success' => false, 'data' => (Object) [], 'message' => __("User card get successfully")];
        } catch (\Exception $e) {
            storeException('UserCard get :', $e->getMessage());
            return ['success' => false, 'data' => (Object) [], 'message' => __('User card get failed !!')];
        }
    }


    public function SaveUserCard($request)
    {
        $id = Auth::id();
        $message = isset($request->id) ? __('Card update successfully') : __('Card created successfully');
        $failmessage = isset($request->id) ? __('Card update failed !!') : __('Card create failed !!');
        DB::beginTransaction();
        try {
            $request->merge(['user_id' => $id]);
            $find = isset($request->id) ? ['id' => $request->id] : ['card_number' => $request->card_number];
            $save = UserCard::updateOrCreate($find, $request->except(['_token']));
        } catch (\Exception $e) {
            DB::rollBack();
            storeException('UserCard :', $e->getMessage());
            return ['success' => false, 'message' => $failmessage];
        }
        DB::commit();
        return ['success' => true, 'message' => $message];
    }


    public function DeleteUserCard($id)
    {
        DB::beginTransaction();
        try {
            if ($data = UserCard::find($id)) {
                if ($data->user_id == Auth::id())
                    $update = UserCard::findOrFail($id)->update(['status' => STATUS_DELETED]);
                else
                    return ['success' => false, 'message' => __('Card not found !!')];
            } else {
                return ['success' => false, 'message' => __('Card not found !!')];
            }
        } catch (\Exception $e) {
            DB::rollBack();
            storeException('UserCard delete :', $e->getMessage());
            return ['success' => false, 'message' => __('Card delete failed !!')];
        }
        DB::commit();
        return ['success' => true, 'message' => __('Card deleted successfully !!')];
    }
}
