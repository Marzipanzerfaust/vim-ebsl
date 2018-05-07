" Vim indent file
" Language: Envision-Based Software Language (EBSL) a.k.a. Envision Basic
" Author: Jeffrey Crochet <jeffrey02468@gmail.com>
" URL: https://github.com/marzipanzerfaust/vim-ebsl

" Only load this indent file when no other was loaded
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetEBSLIndent(v:lnum)
setlocal indentkeys=0=~end,0=~next,=~repeat,=~while,=~until,0=~end_

let s:keepcpo=&cpo
set cpo&vim

" Only define the function once
if exists("*GetEBSLIndent")
  finish
endif

" I copied most of this from indent/vb.vim
function! GetEBSLIndent(lnum)
  " Labels and pre-processor statements get zero indent
  let this_line = getline(a:lnum)
  let labels_or_preproc = '^\s*\%(\)'
endfunction

let b:undo_indent = 'setl si<'

let &cpo = s:keepcpo
unlet s:keepcpo
