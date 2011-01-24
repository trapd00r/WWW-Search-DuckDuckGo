package WWW::Search::DuckDuckGo;

$VERSION  = '0.001';

require Exporter;
@ISA = 'Exporter';
our @EXPORT_OK = qw(ddg);

use strict;
use Carp qw(croak);
use JSON::XS;
use LWP::UserAgent;

my $base_url = 'http://api.duckduckgo.com/?q='; # $query&o=json

sub ddg {
  my $query = shift // 'perl';
  my $u = LWP::UserAgent->new;

  my $response = $u->get( _full_url($query) );

  if($response->is_success) {
    return decode_json( $response->content );
  }
  else {
    croak($response->status_line);
  }
}

sub _full_url {
  my $query = shift;
  return $base_url . $query . '&o=json';
}


=pod

=head1 NAME

WWW::Search::DuckDuckGo - search DuckDuckGo

=head1 SYNOPSIS

  use WWW::Search::DuckDuckGo;

  my $results = ddg('perl');

=head1 DESCRIPTION

B<WWW::Search::DuckDuckGo> provides a simple interface for searching with
DuckDuckGo.

=head1 EXPORTS

None by default.

=head1 FUNCTIONS

=head2 ddg()

Parameters: $query

Returns:    \%results

  my $results = ddg('laleh');

The main search function. Returns a data structure that might look something
like this:

  Abstract => "Laleh Pourkarim is an Iranian-Swedish singer-songwriter and former actress. ",
  AbstractSource => "Wikipedia",
  AbstractText => "Laleh Pourkarim is an Iranian-Swedish singer-songwriter and former actress. ",
  AbstractURL => "http://en.wikipedia.org/wiki/Laleh",
  Answer => "",
  AnswerType => "",
  Definition => "",
  DefinitionSource => "",
  DefinitionURL => "",
  Heading => "Laleh",
  Image => "http://i.duck.co/i/eb3ccaa1.jpg",
  RelatedTopics => [
    {
      FirstURL => "http://duckduckgo.com/c/Swedish_people_of_Iranian_descent",
      Icon => {},
      Text => "Swedish people of Iranian descent Category"
    },
  ],
  Results => [
    {
      FirstURL => "http://www.laleh.se/",
      Icon => {
        Height => 16,
        URL => "http://i.duck.co/i/laleh.se.ico",
        Width => 16
      },
      Result => "<a href=\"http://www.laleh.se/\"><b>Official site</b></a>",
      Text => "Official site"
    }
  ],

=head1 AUTHOR

  Magnus Woldrich
  CPAN ID: WOLDRICH
  magnus@trapd00r.se
  http://japh.se

=head1 COPYRIGHT

Copyright 2011 Magnus Woldrich <magnus@trapd00r.se>. This program is free
software; you may redistribute it and/or modify it under the same terms as
Perl itself.

=cut


1;
