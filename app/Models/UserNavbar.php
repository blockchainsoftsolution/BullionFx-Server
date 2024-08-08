<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserNavbar extends Model
{
    use HasFactory;
    protected $fillable = ['title', 'slug', 'sub', 'main_id', 'status'];
}
