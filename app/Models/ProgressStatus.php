<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProgressStatus extends Model
{
    protected $fillable = ['title', 'description', 'status', 'progress_type_id'];
}
