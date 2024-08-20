<?php

namespace App\Http\Controllers\Api\User;

use App\Http\Controllers\Controller;
use App\Http\Services\UserCardService as userCardService;
use Illuminate\Http\Request;

class UserCardController
{
    protected $service ;
    public function __construct(){
        $this->service = new userCardService();
    }

    public function UserCardGet(Request $request){
        $response = $this->service->getUserCard($request->id ?? null);
        return response()->json($response);
    }

    public function UserCardSave(Request $request){
        $response = $this->service->SaveUserCard($request);
        return response()->json($response);
    }

    public function UserCardDelete(Request $request){
        if(isset($request->id))
            $response = $this->service->DeleteUserCard($request->id);
        else
            return response()->json(['success' => false, 'message' =>__('Card id not found')]);
        return response()->json($response);
    }
}
