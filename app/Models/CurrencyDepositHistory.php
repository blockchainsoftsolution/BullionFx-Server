<?php

namespace App\Models;

use App\Models\User;
use App\Models\Bank;
use App\Models\Coin;
use App\Models\Wallet;
use Illuminate\Database\Eloquent\Model;
use App\Models\CurrencyDepositPaymentMethod;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class CurrencyDepositHistory extends Model
{
    use HasFactory;
    protected $fillable = [
        "user_id",
        "payment_id",
        "payment_type",
        "wallet_id",
        "coin_id",
        "coin_type",
        "bank_id",
        "bank_recipt",
        "amount",
        "status",
        "note",
        "transaction_id"
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
        return $this->belongsTo(Bank::class, 'bank_id');
    }

    public function payment_method()
    {
        return $this->belongsTo(CurrencyDepositPaymentMethod::class, 'payment_id');
    }
}
