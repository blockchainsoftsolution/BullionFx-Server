<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Activity extends Model
{

    protected $table = 'activity';


    public $timestamps = false; 

    protected $fillable = [
        'user_id',
        'type',
        'fromAmount',
        'toAmount',
        'fromAsset',
        'toAsset',
        'to',
        'status',
        'time',
        'gasFee',
        'conversionFee',
        'transactionHash',
        'exchangeRate'
    ];
}
