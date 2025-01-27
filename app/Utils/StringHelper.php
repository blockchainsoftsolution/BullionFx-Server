<?php

namespace App\Utils;

class StringHelper
{
    public static function toShortAddr(string $string): string
    {
        return substr($string, 0, 6) . "..." . substr($string, -6);
    }
}
