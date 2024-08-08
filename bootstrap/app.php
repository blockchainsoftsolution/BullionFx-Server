<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',
        api: __DIR__ . '/../routes/api.php',
        apiPrefix: 'api',
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->alias([
            'auth' => App\Http\Middleware\Authenticate::class,
            'admin' => App\Http\Middleware\Admin::class,
            'default_lang' => App\Http\Middleware\DefaultLanguage::class,
            'permission' => App\Http\Middleware\PermissionAdmin::class,
            'check_demo' => App\Http\Middleware\CheckDemoMiddleware::class,
            'checkApi' => App\Http\Middleware\CheckApi::class,
            'maintenanceMode' => App\Http\Middleware\MaintenanceModeCheckMiddleware::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();
