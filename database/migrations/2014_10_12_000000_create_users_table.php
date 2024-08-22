<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('nickname')->nullable()->unique();
            $table->string('first_name');
            $table->string('last_name');
            $table->string('email')->unique();
            $table->string('reset_code', 180)->unique()->nullable();
            $table->integer('role')->default(2);
            $table->integer('status')->default(1);
            $table->tinyInteger('api_access_allow_user')->after('status')->default(0);
            $table->string('phone')->nullable();
            $table->tinyInteger('phone_verified')->default(0);
            $table->string('country')->nullable();
            $table->tinyInteger('gender')->default(1);
            $table->string('birth_date')->nullable();
            $table->string('photo')->nullable();
            $table->enum('g2f_enabled', [0, 1]);
            $table->string('google2fa_secret')->nullable();
            $table->tinyInteger('is_verified')->default(0);
            $table->string('password');
            $table->string('language')->default('en');
            $table->string('currency_code',180)->default('AUD');
            $table->string('device_id')->nullable();
            $table->tinyInteger('device_type')->default(1);
            $table->tinyInteger('push_notification_status')->default(1);
            $table->tinyInteger('email_notification_status')->default(1);
            $table->tinyInteger('earn')->default(0)->comment("0 = not registered to yield program, 1 = registered");
            $table->rememberToken();
            $table->timestamps();
        });

        Schema::create('password_reset_tokens', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
        });

        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->foreignId('user_id')->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->longText('payload');
            $table->integer('last_activity')->index();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('sessions');
    }
}
