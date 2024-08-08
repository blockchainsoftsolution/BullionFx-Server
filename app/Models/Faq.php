<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Faq extends Model
{
    protected $fillable = ['question', 'answer', 'status', 'author', 'faq_type_id'];

    public function faqType()
    {
        return $this->belongsTo(FaqType::class, 'faq_type_id');
    }
}
