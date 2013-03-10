#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Plack::App::OAI' ) or exit;
}

done_testing( 1 );
