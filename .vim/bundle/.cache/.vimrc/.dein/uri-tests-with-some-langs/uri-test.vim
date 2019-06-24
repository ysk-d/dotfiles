

let uri = urilib#new('http://ja.wikipedia.org/wiki/アンパサンド')
" http://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%B3%E3%83%91%E3%82%B5%E3%83%B3%E3%83%89
echo uri.to_string()
" http://ja.wikipedia.org/wiki/アンパサンド
echo uri.as_iri()
" http://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%B3%E3%83%91%E3%82%B5%E3%83%B3%E3%83%89
echo uri.canonical()
" http://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%B3%E3%83%91%E3%82%B5%E3%83%B3%E3%83%89
echo uri.abs('example.com')

echo '-------------------------------------'
let uri = urilib#new('http://example.com/hoge?a=1&b=2')
" /hoge?a=1&b=2
echo uri.path_query()
" ("", "hoge")
echo uri.path_segments()
" a=1&b=2
echo uri.query()
" ("a", 1, "b", 2)
echo uri.query_form()
" ()
echo uri.query_keywords()

echo '-------------------------------------'
let uri = URI.new('http://example.com/search.cgi?some+keywords')
" /search.cgi?some+keywords
echo uri.path_query()
" ("", "search.cgi")
echo uri.path_segments()
" some+keywords
echo uri.query()
" ()
echo uri.query_form()
" ("some", "keywords")
echo uri.query_keywords()
