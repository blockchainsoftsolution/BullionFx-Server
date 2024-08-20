<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserCard extends Model
{
    use HasFactory;
    protected $fillable = ['user_id', 'card_holder_name', 'card_number', 'expiry_month', 'expiry_year', 'type', 'status'];
}
