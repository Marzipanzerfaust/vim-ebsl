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
setlocal indentkeys=o,O,0=END,0=NEXT,0=REPEAT,=CASE,=WHILE,=UNTIL

" If available, use shiftwidth() instead of &shiftwidth
if exists('*shiftwidth')
  function! s:sw()
    return shiftwidth()
  endfunc
else
  function! s:sw()
    return &sw
  endfunc
endif

" Only define the function once
if exists("*GetEBSLIndent")
  finish
endif

" Some of this is copied from indent/vb.vim
function! GetEBSLIndent(lnum)
  " Labels and pre-processor statements get zero indent
  let this_line = getline(a:lnum)
  let labels_or_preproc = '^\s*\<\k\+\>:'
  if this_line =~? labels_or_preproc
    return 0
  endif

  " Find a non-blank line above the current line;
  " skip over comments, labels, and pre-processor directives
  let lnum = a:lnum
  let comment = '^\s*\%(\*\|REM\>\).*'
  while lnum > 0
    let lnum = prevnonblank(lnum - 1)
    let previous_line = getline(lnum)
    if previous_line !~ labels_or_preproc && previous_line !~ comment
      break
    endif
  endwhile

  " Hit the start of the file, use zero indent
  if lnum == 0
    return 0
  endif

  let ind = indent(lnum)

  " Pattern for anything that constitutes the end of a line, i.e. any
  " amount of whitespace followed by an optional inline comment
  let line_ending = '\s*\%(;\%(\*\|REM\>\).*\)\=$'

  " Add
  if previous_line =~ '^\s*BEGIN CASE'.line_ending ||
        \ previous_line =~ '\<\%(THEN\|ELSE\)'.line_ending ||
        \ previous_line =~ '^\s*\%(FOR\|LOOP\|WHILE\|UNTIL\)\>' && previous_line !~ '\<REPEAT'.line_ending ||
        \ previous_line =~ '^\s*FOR_\k*'
    let ind += s:sw()
  endif

  " Subtract
  if this_line =~ '^\s*END\>' ||
        \ this_line =~ '^\s*\%(WHILE\|UNTIL\|NEXT\|REPEAT\)\>' ||
        \ this_line =~ '^\s*END_\k*\>'
    let ind -= s:sw()
  endif

  if this_line =~ '^\s*END CASE\>' && previous_line !~ '^\s*BEGIN CASE\>'
    let ind -= s:sw()
  endif

  " There's a few edge cases for the CASE statement that we have to
  " handle separately
  if previous_line =~ '^\s*CASE\>' && this_line !~ '^\s*CASE\>'
    let ind += s:sw()
  endif

  if previous_line !~ '^\s*\%(CASE\|BEGIN CASE\)\>' && this_line =~ '^\s*CASE\>'
    let ind -= s:sw()
  endif

  return ind
endfunction

let b:undo_indent = 'set ai< indentexpr< indentkeys<'
