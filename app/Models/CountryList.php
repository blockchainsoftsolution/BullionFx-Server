<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CountryList extends Model
{
    use HasFactory;
    protected $fillable = [
        'key',
        'value',
        'status'
    ];

    public function setKeyAttribute($value)
    {
        $this->attributes['key'] = strtoupper($value);
    }
}
