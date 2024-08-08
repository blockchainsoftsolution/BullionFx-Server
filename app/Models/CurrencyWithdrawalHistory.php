<?php

namespace App\Models;

use App\Models\User;
use App\Models\Bank;
use App\Models\Coin;
use App\Models\Wallet;
use App\Models\UserBank;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class CurrencyWithdrawalHistory extends Model
{
    use HasFactory;
    protected $fillable = [
        "user_id",
        "wallet_id",
        "coin_id",
        "bank_id",
        "coin_type",
        "amount",
        "fees",
        "status",
        "receipt",
        'payment_info'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function wallet()
    {
        return $this->belongsTo(Wallet::class, 'wallet_id');
    }

    public function coin()
    {
        return $this->belongsTo(Coin::class, 'coin_id');
    }

    public function bank()
    {
        return $this->belongsTo(UserBank::class, 'bank_id');
    }

}
