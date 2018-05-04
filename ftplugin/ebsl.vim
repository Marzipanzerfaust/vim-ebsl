" Vim filetype plugin file
" Language:   Envision-Based Software Language (EBSL) a.k.a. Envision Basic
" Maintainer: Jeffrey Crochet <jeffrey02468@gmail.com>
" URL:        https://github.com/marzipanzerfaust/vim-ebsl

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal comments=:*
setlocal commentstring=*\ %s
setlocal iskeyword+=.

" " vim-matchit support
" if exists('loaded_matchit') && !exists('b:match_words')
"   let b:match_ignorecase = 0

"   let s:word = '[\w\._]'

"   let b:match_words =
"         \ '\<FOR_\('.s:word.'*\)\s\+.*\>:\<END_\1\>,' .
"         \ '\<IF\>:\<END\s\+ELSE\>:\<END\>,' .
"         \ '\<FIND\>:\<END\s\+ELSE\>:\<END\>,' .
"         \ '\<FINDSTR\>:\<END\s\+ELSE\>:\<END\>,' .
"         \ '\<LOCATE\>:\<END\s\+ELSE\>:\<END\>,' .
"         \ '\<BEGIN\s\+CASE\>:\<CASE\>:\<END\s\+CASE\>,' .
"         \ '\<LOOP\>:\<WHILE\>:\<UNTIL\>:\<REPEAT\>,' .
"         \ '\<FOR\>:\<WHILE\>:\<UNTIL\>:\<NEXT\>,' .
"         \ '\[:\],(:)'
" endif

" " vim-endwise support
" if exists('loaded_endwise')
"   let b:endwise_pattern =
"         \ '\%(^\s*\zsFOR_\)'
"   let b:endwise_addition = '\=submatch(0)=='
" endif

" Undo the stuff we changed
let b:undo_ftplugin = "setlocal comments< commentstring< iskeyword<" .
      \ " | unlet! b:match_ignorecase b:match_words"

let &cpo = s:cpo_save
unlet s:cpo_save
