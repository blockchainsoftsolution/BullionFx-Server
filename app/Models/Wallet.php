<?php

namespace App\Models;

use App\Models\User;
use Illuminate\Database\Eloquent\Model;

class Wallet extends Model
{
    protected $fillable = [
        'user_id',
        'address',
        'is_primary',
        'chainId',
        'status'
    ];

    public function user()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }

    // public function co_users()
    // {
    //     return $this->hasMany(WalletCoUser::class);
    // }
    // public function coin()
    // {
    //     return $this->belongsTo(Coin::class, 'coin_id');
    // }
}
