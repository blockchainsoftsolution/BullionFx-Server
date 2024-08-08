<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ActivityLog extends Model
{
    protected $fillable = ['action', 'user_id', 'source', 'ip_address', 'location', 'created_at'];
}
