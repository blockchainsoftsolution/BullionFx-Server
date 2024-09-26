<?php

namespace Laravel\PhpLaravel\Controllers;

use Illuminate\Routing\Controller;
use Laravel\PhpLaravel\Events\LaravelInstallerFinished;
use Laravel\PhpLaravel\Helpers\EnvironmentManager;
use Laravel\PhpLaravel\Helpers\FinalInstallManager;
use Laravel\PhpLaravel\Helpers\InstalledFileManager;

class FinalController extends Controller
{
    function __construct()
    {
        set_time_limit(300);
    }

    /**
     * Update installed file and display finished view.
     *
     * @param \Laravel\PhpLaravel\Helpers\InstalledFileManager $fileManager
     * @param \Laravel\PhpLaravel\Helpers\FinalInstallManager $finalInstall
     * @param \Laravel\PhpLaravel\Helpers\EnvironmentManager $environment
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function finish(InstalledFileManager $fileManager, FinalInstallManager $finalInstall, EnvironmentManager $environment)
    {
        $finalMessages = $finalInstall->runFinal();
        $finalStatusMessage = $fileManager->update();
        $finalEnvFile = $environment->getEnvContent();

        event(new LaravelInstallerFinished);

        return view('php-laravel.phplaravel.finished', compact('finalMessages', 'finalStatusMessage', 'finalEnvFile'));
    }
}
