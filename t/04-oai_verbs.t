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
    my $res = $cb->( GET '/?verb=Identify' );
    like( $res->content, qr{Identify}ms, 'Checking if the Identify verb is recognized' );
    $res = $cb->( GET '/?verb=GetRecord' );
    like( $res->content, qr{GetRecord}ms, 'Checking if the GetRecord verb is recognized' );
    $res = $cb->( GET '/?verb=ListIdentifiers' );
    like( $res->content, qr{ListIdentifiers}ms, 'Checking if the ListIdentifiers verb is recognized' );
    $res = $cb->( GET '/?verb=ListMetadataFormats' );
    like( $res->content, qr{ListMetadataFormats}ms, 'Checking if the ListMetadataFormats verb is recognized' );
    $res = $cb->( GET '/?verb=ListRecords' );
    like( $res->content, qr{ListRecords}ms, 'Checking if the ListRecords verb is recognized' );
    $res = $cb->( GET '/?verb=ListSets' );
    like( $res->content, qr{ListSets}ms, 'Checking if the ListSets verb is recognized' );
};

done_testing( 7 );
