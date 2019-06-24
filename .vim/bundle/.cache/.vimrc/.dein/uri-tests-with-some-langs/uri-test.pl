#!perl
use common::sense;
use URI;
use Data::Dump qw(dump);


my $uri = URI->new('http://ja.wikipedia.org/wiki/アンパサンド');
say ref $uri;                 # URI::http
say $uri;                     # http://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%B3%E3%83%91%E3%82%B5%E3%83%B3%E3%83%89
say $uri->as_iri;             # http://ja.wikipedia.org/wiki/アンパサンド
say $uri->canonical;          # http://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%B3%E3%83%91%E3%82%B5%E3%83%B3%E3%83%89
say $uri->abs('example.com'); # http://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%B3%E3%83%91%E3%82%B5%E3%83%B3%E3%83%89
say $uri;

say '-------------------------------------';
my $uri = URI->new('http://example.com/hoge?a=1&b=2');
say ref $uri;                  # URI::http
say $uri->path;                # /hoge
say $uri->path_query;          # /hoge?a=1&b=2
say dump $uri->path_segments;  # ("", "hoge")
say $uri->query;               # a=1&b=2
say dump $uri->query_form;     # ("a", 1, "b", 2)
say dump $uri->query_keywords; # ()
say $uri;

say '-------------------------------------';
my $uri = URI->new('http://example.com/search.cgi?some+keywords');
say ref $uri;                  # URI::http
say $uri->path;                # /search.cgi
say $uri->path_query;          # /search.cgi?some+keywords
say dump $uri->path_segments;  # ("", "search.cgi")
say $uri->query;               # some+keywords
say dump $uri->query_form;     # ()
say dump $uri->query_keywords; # ("some", "keywords")
say $uri;

say '-------------------------------------';
my $uri = URI->new('.vimrc');
say ref $uri;              # URI::_generic
say $uri;                  # .vimrc
say $uri->as_iri;          # .vimrc
say $uri->canonical;       # .vimrc
say $uri->abs($ENV{HOME}); # /home/.vimrc
say $uri;
