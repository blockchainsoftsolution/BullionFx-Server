<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TokenTransfer extends Model
{

    public $timestamps = false;
    
    protected $fillable = [
        'block',
        'hash',
        'from',
        'to',
        'asset',
        'address',
        'value',
        'decimal',
        'checked'
    ];

    // public function co_users()
    // {
    //     return $this->hasMany(WalletCoUser::class);
    // }
    // public function coin()
    // {
    //     return $this->belongsTo(Coin::class, 'coin_id');
    // }
}
