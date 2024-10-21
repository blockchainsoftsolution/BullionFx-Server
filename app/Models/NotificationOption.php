<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class NotificationOption extends Model
{
    protected $fillable = [
        'title',
        'description',
        'icon'
    ];
}
