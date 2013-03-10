#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Plack::App::OAI' ) or exit;
}

can_ok( 'Plack::App::OAI', qw( call ) );

done_testing( 2 );
