<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserVerificationCode extends Model
{

    protected $fillable = [
        'user_id',
        'code',
        'status',
        'expired_at',
        'type'
    ];
}
