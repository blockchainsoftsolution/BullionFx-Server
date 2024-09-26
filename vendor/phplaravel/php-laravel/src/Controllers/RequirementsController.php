<?php

namespace Laravel\PhpLaravel\Controllers;

use Illuminate\Routing\Controller;
use Laravel\PhpLaravel\Helpers\RequirementsChecker;

class RequirementsController extends Controller
{
    /**
     * @var RequirementsChecker
     */
    protected $requirements;

    /**
     * @param RequirementsChecker $checker
     */
    public function __construct(RequirementsChecker $checker)
    {
        $this->requirements = $checker;
    }

    /**
     * Display the requirements page.
     *
     * @return \Illuminate\View\View
     */
    public function requirements()
    {
        $phpSupportInfo = $this->requirements->checkPHPversion(
            config('phplaravel.core.minPhpVersion')
        );
        $requirements = $this->requirements->check(
            config('phplaravel.requirements')
        );

        return view('php-laravel.phplaravel.requirements', compact('requirements', 'phpSupportInfo'));
    }
}
