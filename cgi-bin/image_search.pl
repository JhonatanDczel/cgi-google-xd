#!/usr/bin/perl

use utf8;
use strict;
use warnings;
use CGI qw(:standard);
use URI::Escape;

my $cgi = CGI->new;
my $search_query = $cgi->param('q');
my $google_image_search_url = "https://www.google.com/search?tbm=isch&q=";

if (defined $search_query && $search_query ne '') {
    $google_image_search_url .= uri_escape($search_query);
}
print $cgi->redirect($google_image_search_url);

