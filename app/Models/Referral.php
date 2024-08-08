<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Referral extends Model
{
   protected $fillable = ['user_id', 'parent_user_id'];
}
