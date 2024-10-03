<?php

namespace App\Http\Repositories;


use App\Models\CoinPaymentNetworkFee;

class CoinPaymentNetworkFeeRepository extends CommonRepository
{
    function __construct($model)
    {
        parent::__construct($model);
    }

    public function getCoinPaymentNetworkFeeList()
    {
        return CoinPaymentNetworkFee::get();
    }

}