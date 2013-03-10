#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Plack::Test;
use HTTP::Request::Common;

BEGIN {
    use_ok( 'Plack::App::OAI' ) or exit;
}

my $app = Plack::App::OAI->new();
test_psgi $app, sub {
    my $cb = shift;
    my $res = $cb->( GET '/' );
    is( $res->content_type, 'text/plain', 'Checking if we get the right content type' );
    is( $res->content, 'Hello', 'Checking if we get the right content' );
};

done_testing( 3 );
