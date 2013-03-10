#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Plack::App::OAI' ) or exit;
}

can_ok( 'Plack::App::OAI', qw( call ) );

my $app = Plack::App::OAI->new();
isa_ok( $app, 'Plack::App::OAI' );
isa_ok( $app, 'Plack::Component' );

done_testing( 4 );
