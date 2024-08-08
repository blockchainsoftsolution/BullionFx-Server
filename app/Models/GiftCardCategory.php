<?php

namespace App\Models;

use App\Models\GiftCardBanner;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class GiftCardCategory extends Model
{
    use HasFactory;
    protected $fillable = ['uid', 'name', 'status'];

    public function banner()
    {
        return $this->hasMany(GiftCardBanner::class, 'category_id', 'uid');
    }
}
