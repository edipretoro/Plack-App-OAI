use strict;
use warnings;
package Plack::App::OAI;

use parent 'Plack::Component';
use Plack::Request;

sub call {
    my ( $self, $env ) = @_;
    my $req = Plack::Request->new( $env );

    my $verb = $req->param('verb') || '';
    return
        [ 200,
          [ 'Content-Type' => 'text/xml' ],
          [ '<?xml version="1.0" encoding="utf-8"?>' . "\n" . '<OAI-PMH>' . $verb . '</OAI->can-PMH>' ]
      ];
}

1;
