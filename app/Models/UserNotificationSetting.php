<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserNotificationSetting extends Model
{
    protected $table = 'user_notification_settings';

    public $timestamps = false; 

    protected $fillable = [
        'user_id',
        'disabled'
    ];
}
