<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('token_transfers', function (Blueprint $table) {
            $table->id(); // Auto-increment primary key
            $table->integer('block');
            $table->string('hash');
            $table->string('from');
            $table->string('to');
            $table->string('asset');
            $table->string('address');
            $table->float('value');
            $table->integer('decimal');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('token_transfers');
    }
};
