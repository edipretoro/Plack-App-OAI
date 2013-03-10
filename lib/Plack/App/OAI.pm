use strict;
use warnings;
package Plack::App::OAI;

use parent 'Plack::Component';

sub call {
    return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'Hello' ] ];
}

1;
