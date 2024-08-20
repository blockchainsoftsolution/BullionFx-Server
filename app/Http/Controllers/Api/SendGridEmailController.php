<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

use App\Mail\TestEmail;

use Illuminate\Support\Facades\Mail;

class SendGridEmailController extends Controller
{
    public function sendMail()
    {
        $data = ['message' => 'This is a test!'];

        Mail::to('MY GMAIL ACCONT')->send(new TestEmail($data));
    }
}
