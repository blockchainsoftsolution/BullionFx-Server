<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{



    public $timestamps = false;
    protected $fillable = [
        'user_id',
        'title',
        'notification_body',
        'notification_option_id',
        'status',
        'time'
    ];
}
