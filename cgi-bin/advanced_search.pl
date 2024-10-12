#!/usr/bin/perl

use utf8;
use strict;
use warnings;
use CGI qw(:standard);
use URI::Escape;

my $cgi = CGI->new;

my $all_words = $cgi->param('q');
my $exact_phrase = $cgi->param('as_epq');
my $no_words = $cgi->param('as_eq');

my $google_search_url = "https://www.google.com/search?";

my @params;

push @params, "q=" . uri_escape($all_words) if defined $all_words && $all_words ne '';
push @params, "as_epq=" . uri_escape($exact_phrase) if defined $exact_phrase && $exact_phrase ne '';
push @params, "as_eq=" . uri_escape($no_words) if defined $no_words && $no_words ne '';

$google_search_url .= join("&", @params);

print $cgi->redirect($google_search_url);
;
