use strict;
use warnings;
package Plack::App::OAI;

use parent 'Plack::Component';
use Plack::Request;

sub call {
    my ( $self, $env ) = @_;
    my $req = Plack::Request->new( $env );

    my $verb = $req->param('verb') || '';
    if ($verb eq 'Identify') {
        my $content = <<'IDENTIFY';
<?xml version="1.0" encoding="UTF-8"?>
<OAI-PMH xmlns="http://www.openarchives.org/OAI/2.0/" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/
         http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd">
  <responseDate>2002-02-08T12:00:01Z</responseDate>
  <request verb="Identify">http://memory.loc.gov/cgi-bin/oai</request>
  <Identify>
    <repositoryName>Library of Congress Open Archive Initiative 
                    Repository 1</repositoryName>
    <baseURL>http://memory.loc.gov/cgi-bin/oai</baseURL>
    <protocolVersion>2.0</protocolVersion>
    <adminEmail>somebody@loc.gov</adminEmail>
    <adminEmail>anybody@loc.gov</adminEmail>
    <earliestDatestamp>1990-02-01T12:00:00Z</earliestDatestamp>
    <deletedRecord>transient</deletedRecord>
    <granularity>YYYY-MM-DDThh:mm:ssZ</granularity>
    <compression>deflate</compression>
    <description>
      <oai-identifier 
        xmlns="http://www.openarchives.org/OAI/2.0/oai-identifier"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation=
            "http://www.openarchives.org/OAI/2.0/oai-identifier
        http://www.openarchives.org/OAI/2.0/oai-identifier.xsd">
        <scheme>oai</scheme>
        <repositoryIdentifier>lcoa1.loc.gov</repositoryIdentifier>
        <delimiter>:</delimiter>
        <sampleIdentifier>oai:lcoa1.loc.gov:loc.music/musdi.002</sampleIdentifier>
      </oai-identifier>
    </description>
    <description>
      <eprints 
         xmlns="http://www.openarchives.org/OAI/1.1/eprints"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://www.openarchives.org/OAI/1.1/eprints 
         http://www.openarchives.org/OAI/1.1/eprints.xsd">
        <content>
          <URL>http://memory.loc.gov/ammem/oamh/lcoa1_content.html</URL>
          <text>Selected collections from American Memory at the Library 
                of Congress</text>
        </content>
        <metadataPolicy/>
        <dataPolicy/>
      </eprints>
    </description>
    <description>
      <friends 
          xmlns="http://www.openarchives.org/OAI/2.0/friends/" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/friends/
         http://www.openarchives.org/OAI/2.0/friends.xsd">
       <baseURL>http://oai.east.org/foo/</baseURL>
       <baseURL>http://oai.hq.org/bar/</baseURL>
       <baseURL>http://oai.south.org/repo.cgi</baseURL>
     </friends>
   </description>
 </Identify>
</OAI-PMH>
IDENTIFY
        return
            [ 200,
              [ 'Content-Type' => 'text/xml' ],
              [ $content ]
          ];
    } elsif ($verb eq 'GetRecord') {
        my $content = <<'GETRECORD';
<?xml version="1.0" encoding="UTF-8"?> 
<OAI-PMH xmlns="http://www.openarchives.org/OAI/2.0/" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/
         http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd">
  <responseDate>2002-02-08T08:55:46Z</responseDate>
  <request verb="GetRecord" identifier="oai:arXiv.org:cs/0112017"
           metadataPrefix="oai_dc">http://arXiv.org/oai2</request>
  <GetRecord>
   <record> 
    <header>
      <identifier>oai:arXiv.org:cs/0112017</identifier> 
      <datestamp>2001-12-14</datestamp>
      <setSpec>cs</setSpec> 
      <setSpec>math</setSpec>
    </header>
    <metadata>
      <oai_dc:dc 
         xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" 
         xmlns:dc="http://purl.org/dc/elements/1.1/" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
         xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai_dc/ 
         http://www.openarchives.org/OAI/2.0/oai_dc.xsd">
        <dc:title>Using Structural Metadata to Localize Experience of 
                  Digital Content</dc:title> 
        <dc:creator>Dushay, Naomi</dc:creator>
        <dc:subject>Digital Libraries</dc:subject> 
        <dc:description>With the increasing technical sophistication of 
            both information consumers and providers, there is 
            increasing demand for more meaningful experiences of digital 
            information. We present a framework that separates digital 
            object experience, or rendering, from digital object storage 
            and manipulation, so the rendering can be tailored to 
            particular communities of users.
        </dc:description> 
        <dc:description>Comment: 23 pages including 2 appendices, 
            8 figures</dc:description> 
        <dc:date>2001-12-14</dc:date>
      </oai_dc:dc>
    </metadata>
  </record>
 </GetRecord>
</OAI-PMH>
GETRECORD
        return
            [ 200,
              [ 'Content-Type' => 'text/xml' ],
              [ $content ]
          ];
    } else {
        return
            [ 200,
              [ 'Content-Type' => 'text/xml' ],
              [ '<?xml version="1.0" encoding="utf-8"?>' . "\n" . '<OAI-PMH>' . $verb . '</OAI->can-PMH>' ]
          ];
    }
}

1;
