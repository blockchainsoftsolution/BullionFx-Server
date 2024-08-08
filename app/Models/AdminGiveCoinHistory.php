<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdminGiveCoinHistory extends Model
{
    protected $fillable = ['user_id', 'wallet_id', 'amount'];

    public function wallet()
    {
        return $this->belongsTo(Wallet::class, 'wallet_id');
    }
}
