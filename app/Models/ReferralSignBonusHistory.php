<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ReferralSignBonusHistory extends Model
{
    protected $fillable = [
        'parent_id',
        'user_id',
        'wallet_id',
        'amount',
        'status'
    ];
}
