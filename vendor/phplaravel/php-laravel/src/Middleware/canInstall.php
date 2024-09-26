<?php

namespace Laravel\PhpLaravel\Middleware;

use Closure;
use Redirect;

class canInstall
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return \Illuminate\Http\RedirectResponse|mixed
     */
    public function handle($request, Closure $next)
    {
        if ($this->alreadyInstalled()) {
            $installedRedirect = config('phplaravel.installedAlreadyAction');

            switch ($installedRedirect) {

                case 'route':
                    $routeName = config('phplaravel.installed.redirectOptions.route.name');
                    $data = config('phplaravel.installed.redirectOptions.route.message');

                    return redirect()->route($routeName)->with(['data' => $data]);
                    break;

                case 'abort':
                    abort(config('phplaravel.installed.redirectOptions.abort.type'));
                    break;

                case 'dump':
                    $dump = config('phplaravel.installed.redirectOptions.dump.data');
                    
                    break;

                case '404':
                case 'default':
                default:
                    abort(404);
                    break;
            }
        }

        return $next($request);
    }

    /**
     * If application is already installed.
     *
     * @return bool
     */
    public function alreadyInstalled()
    {
        return file_exists(storage_path('installed'));
    }
}
