use strict;
use warnings;
package Plack::App::OAI;

use parent 'Plack::Component';

sub call {
    return [ 200, [ 'Content-Type' => 'text/xml' ], [ '<?xml version="1.0" encoding="utf-8"?>' ] ];
}

1;
