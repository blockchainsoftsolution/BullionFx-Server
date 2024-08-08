<?php

namespace App\Http\Repositories;


use App\Models\Bank;
use App\Models\FiatWithdrawal;

class FiatWithdrawalRepository extends CommonRepository
{
    function __construct($model)
    {
        parent::__construct($model);
    }


}
