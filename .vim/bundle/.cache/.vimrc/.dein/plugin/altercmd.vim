" altercmd - Alter built-in Ex commands by your own ones
" Version: 0.0.0
" Copyright (C) 2009 kana <http://whileimautomaton.net/>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists('g:loaded_altercmd')
  finish
endif




" NOTE: :AlterCommand maps only in mapmode-c for backward compatibility.
" :AlterCommand! maps in mapmode-ic
" :CAlterCommand maps in mapmode-c
" :IAlterCommand maps in mapmode-i
" :NAlterCommand maps in mapmode-n
" :VAlterCommand maps in mapmode-v
" :XAlterCommand maps in mapmode-x
" :SAlterCommand maps in mapmode-s
" :OAlterCommand maps in mapmode-o
" :LAlterCommand maps in mapmode-l

command! -bar -bang -complete=command -nargs=* AlterCommand
\ call altercmd#define(<q-args>, (<bang>0 ? 'ic' : 'c'))
command! -bar       -complete=command -nargs=* CAlterCommand
\ call altercmd#define(<q-args>, 'c')
command! -bar       -complete=command -nargs=* IAlterCommand
\ call altercmd#define(<q-args>, 'i')
command! -bar       -complete=command -nargs=* NAlterCommand
\ call altercmd#define(<q-args>, 'n')
command! -bar       -complete=command -nargs=* VAlterCommand
\ call altercmd#define(<q-args>, 'v')
command! -bar       -complete=command -nargs=* XAlterCommand
\ call altercmd#define(<q-args>, 'x')
command! -bar       -complete=command -nargs=* SAlterCommand
\ call altercmd#define(<q-args>, 's')
command! -bar       -complete=command -nargs=* OAlterCommand
\ call altercmd#define(<q-args>, 'o')
command! -bar       -complete=command -nargs=* LAlterCommand
\ call altercmd#define(<q-args>, 'l')



augroup altercmd
augroup END



let g:loaded_altercmd = 1

" __END__
" vim: foldmethod=marker
