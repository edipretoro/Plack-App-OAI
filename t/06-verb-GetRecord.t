#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Plack::Test;
use HTTP::Request::Common;
use XML::Simple;

BEGIN {
    use_ok( 'Plack::App::OAI' ) or exit;
}

my $app = Plack::App::OAI->new();
test_psgi $app, sub {
    my $cb = shift;
    my $res = $cb->( GET '/?verb=GetRecord' );
    my $response = XMLin( $res->content );
    ok( defined( $response->{'GetRecord'} ), 'Checking if we received a GetRecord element in the response' );
};

done_testing( 2 );
