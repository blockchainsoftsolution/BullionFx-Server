<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DynamicMenu extends Model
{
    protected $fillable = ['name', 'data_order', 'status', 'login_type'];
}
