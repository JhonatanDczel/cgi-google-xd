#!/usr/bin/perl

use utf8;
use strict;
use warnings;
use URI::Escape;
use CGI qw(:standard);

my $cgi = CGI->new;
my $search_query = $cgi->param('q');
my $google_search_url = "https://www.google.com/search?q=" . uri_escape($search_query);
print $cgi->redirect($google_search_url);
