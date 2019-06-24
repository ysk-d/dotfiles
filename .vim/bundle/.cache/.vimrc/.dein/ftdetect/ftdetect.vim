" use `set filetype` to override default filetype=xml for *.ts files
autocmd BufNewFile,BufRead *.ts  set filetype=typescript
" use `setfiletype` to not override any other plugins like ianks/vim-tsx
autocmd BufNewFile,BufRead *.tsx setfiletype typescript
autocmd BufReadPost *.fugitiveblame setfiletype fugitiveblame
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim ftdetect file
"
" Language: JSX (JavaScript)
" Maintainer: Max Wang <mxawng@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Whether the .jsx extension is required.
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 0
endif

" Whether the @jsx pragma is required.
if !exists('g:jsx_pragma_required')
  let g:jsx_pragma_required = 0
endif

let s:jsx_pragma_pattern = '\%^\_s*\/\*\*\%(\_.\%(\*\/\)\@!\)*@jsx\_.\{-}\*\/'

" Whether to set the JSX filetype on *.js files.
fu! <SID>EnableJSX()
  if g:jsx_pragma_required && !exists('b:jsx_ext_found')
    " Look for the @jsx pragma.  It must be included in a docblock comment
    " before anything else in the file (except whitespace).
    let b:jsx_pragma_found = search(s:jsx_pragma_pattern, 'npw')
  endif

  if g:jsx_pragma_required && !b:jsx_pragma_found | return 0 | endif
  if g:jsx_ext_required && !exists('b:jsx_ext_found') | return 0 | endif
  return 1
endfu

autocmd BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.js
  \ if <SID>EnableJSX() | set filetype=javascript.jsx | endif
" Detect syntax file.
autocmd BufNewFile,BufRead *.snip,*.snippets set filetype=neosnippet
" vint: -ProhibitAutocmdWithNoGroup

autocmd BufRead,BufNewFile *.rs call s:set_rust_filetype()
autocmd BufRead,BufNewFile Cargo.toml setf FALLBACK cfg

function! s:set_rust_filetype() abort
    if &filetype !=# 'rust'
        set filetype=rust
    endif
endfunction

" vim: set et sw=4 sts=4 ts=8:
fun! s:SelectJavascript()
  if getline(1) =~# '^#!.*/bin/\%(env\s\+\)\?node\>'
    set ft=javascript
  endif
endfun

augroup javascript_syntax_detection
  autocmd!
  autocmd BufNewFile,BufRead *.{js,mjs,jsm,es,es6},Jakefile setfiletype javascript
  autocmd BufNewFile,BufRead * call s:SelectJavascript()
augroup END
autocmd BufNewFile,BufRead *.json setlocal filetype=json
autocmd BufNewFile,BufRead *.jsonl setlocal filetype=json
autocmd BufNewFile,BufRead *.jsonp setlocal filetype=json
autocmd BufNewFile,BufRead *.geojson setlocal filetype=json
autocmd BufNewFile,BufRead *.template setlocal filetype=json
au BufNewFile,BufRead *.clj set filetype=clojure

au BufRead,BufNewFile *.scala set filetype=scala
" vint: -ProhibitAutocmdWithNoGroup

" don't spam the user when Vim is started in Vi compatibility mode
let s:cpo_save = &cpo
set cpo&vim

" Note: should not use augroup in ftdetect (see :help ftdetect)
au BufRead,BufNewFile *.go setfiletype go
au BufRead,BufNewFile *.s setfiletype asm
au BufRead,BufNewFile *.tmpl setfiletype gohtmltmpl

" remove the autocommands for modsim3, and lprolog files so that their
" highlight groups, syntax, etc. will not be loaded. *.MOD is included, so
" that on case insensitive file systems the module2 autocmds will not be
" executed.
au! BufRead,BufNewFile *.mod,*.MOD
" Set the filetype if the first non-comment and non-blank line starts with
" 'module <path>'.
au BufRead,BufNewFile go.mod call s:gomod()

fun! s:gomod()
  for l:i in range(1, line('$'))
    let l:l = getline(l:i)
    if l:l ==# '' || l:l[:1] ==# '//'
      continue
    endif

    if l:l =~# '^module .\+'
      setfiletype gomod
    endif

    break
  endfor
endfun

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2 ts=2 et
autocmd BufNewFile,BufRead *.slim setfiletype slim
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn,*.mdwn
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \   set ft=markdown |
      \ else |
      \   setf markdown |
      \ endif
" Officially distributed filetypes

" Support functions {{{
function! s:setf(filetype) abort
  if &filetype !~# '\<'.a:filetype.'\>'
    let &filetype = a:filetype
  endif
endfunction

func! s:StarSetf(ft)
  if expand("<amatch>") !~ g:ft_ignore_pat
    exe 'setf ' . a:ft
  endif
endfunc
" }}}

" HTML with Ruby - eRuby
au BufNewFile,BufRead *.erb,*.rhtml				call s:setf('eruby')

" Interactive Ruby shell
au BufNewFile,BufRead .irbrc,irbrc				call s:setf('ruby')

" Ruby
au BufNewFile,BufRead *.rb,*.rbw,*.gemspec			call s:setf('ruby')

" Rackup
au BufNewFile,BufRead *.ru					call s:setf('ruby')

" Bundler
au BufNewFile,BufRead Gemfile					call s:setf('ruby')

" Ruby on Rails
au BufNewFile,BufRead *.builder,*.rxml,*.rjs,*.ruby		call s:setf('ruby')

" Rakefile
au BufNewFile,BufRead [rR]akefile,*.rake			call s:setf('ruby')
au BufNewFile,BufRead [rR]akefile*				call s:StarSetf('ruby')

" Rantfile
au BufNewFile,BufRead [rR]antfile,*.rant			call s:setf('ruby')

" vim: nowrap sw=2 sts=2 ts=8 noet fdm=marker:
" All other filetypes

" Support functions {{{
function! s:setf(filetype) abort
  if &filetype !=# a:filetype
    let &filetype = a:filetype
  endif
endfunction
" }}}

" Appraisal
au BufNewFile,BufRead Appraisals		call s:setf('ruby')

" Autotest
au BufNewFile,BufRead .autotest			call s:setf('ruby')

" Axlsx
au BufNewFile,BufRead *.axlsx			call s:setf('ruby')

" Buildr Buildfile
au BufNewFile,BufRead [Bb]uildfile		call s:setf('ruby')

" Capistrano
au BufNewFile,BufRead Capfile,*.cap		call s:setf('ruby')

" Chef
au BufNewFile,BufRead Cheffile			call s:setf('ruby')
au BufNewFile,BufRead Berksfile			call s:setf('ruby')

" CocoaPods
au BufNewFile,BufRead Podfile,*.podspec		call s:setf('ruby')

" Guard
au BufNewFile,BufRead Guardfile,.Guardfile	call s:setf('ruby')

" Jbuilder
au BufNewFile,BufRead *.jbuilder		call s:setf('ruby')

" Kitchen Sink
au BufNewFile,BufRead KitchenSink		call s:setf('ruby')

" Opal
au BufNewFile,BufRead *.opal			call s:setf('ruby')

" Pry config
au BufNewFile,BufRead .pryrc			call s:setf('ruby')

" Puppet librarian
au BufNewFile,BufRead Puppetfile		call s:setf('ruby')

" Rabl
au BufNewFile,BufRead *.rabl			call s:setf('ruby')

" Routefile
au BufNewFile,BufRead [rR]outefile		call s:setf('ruby')

" SimpleCov
au BufNewFile,BufRead .simplecov		call s:setf('ruby')

" Thor
au BufNewFile,BufRead [tT]horfile,*.thor	call s:setf('ruby')

" Vagrant
au BufNewFile,BufRead [vV]agrantfile		call s:setf('ruby')

" vim: nowrap sw=2 sts=2 ts=8 noet fdm=marker:
" Language:    CoffeeScript
" Maintainer:  Mick Koch <mick@kochm.co>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *Cakefile set filetype=coffee
autocmd BufNewFile,BufRead *.coffeekup,*.ck set filetype=coffee
autocmd BufNewFile,BufRead *._coffee set filetype=coffee

function! s:DetectCoffee()
    if getline(1) =~ '^#!.*\<coffee\>'
        set filetype=coffee
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectCoffee()
" Language:   Literate CoffeeScript
" Maintainer: Michael Smith <michael@diglumi.com>
" URL:        https://github.com/mintplant/vim-literate-coffeescript
" License:    MIT

autocmd BufNewFile,BufRead *.litcoffee set filetype=litcoffee
autocmd BufNewFile,BufRead *.coffee.md set filetype=litcoffee

au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex,*.leex set filetype=eelixir
au BufRead,BufNewFile * call s:DetectElixir()

function! s:DetectElixir()
  if (!did_filetype() || &filetype !=# 'elixir') && getline(1) =~# '^#!.*\<elixir\>'
    set filetype=elixir
  endif
endfunction
