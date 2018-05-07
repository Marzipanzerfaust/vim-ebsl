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
setlocal indentkeys&
setlocal indentkeys+==~end,=~next,=~repeat,=~while,=~until,=~end_

let s:keepcpo=&cpo
set cpo&vim

" Only define the function once
if exists("*GetEBSLIndent")
  finish
endif

" This function borrows parts from indent/lua.vim
function! GetEBSLIndent(...)
  " Use the first argument as the current line number, or use v:lnum as
  " default
  let clnum = a:0 ? a:1 : v:lnum

  " Find a non-blank line above the current line
  let prevlnum = prevnonblank(clnum-1)

  " At the start of the file, user zero indent
  if prevlnum == 0
    return 0
  endif

  " Add a 'shiftwidth' after lines that start a block
  let ind = indent(prevlnum)
  let prevline = getline(prevlnum)
  let midx = match(prevline, '^\s*\%(IF\>\|FOR\>\|END\s\+ELSE\>\|UNTIL\>\|WHILE\>\|FIND\>\|FINDSTR\>\|LOCATE\>\|FOR_\%(\w\|\.\)*\)')

  if midx != -1
    " Add 'shiftwidth' if what we found previously is not in a comment
    if synIDattr(synID(prevlnum, midx + 1, 1), "name") != 'ebslComment'
      let ind += &shiftwidth
    endif
  endif

  " Subtract a 'shiftwidth' on END, REPEAT, NEXT, and END_*
  " This is the part that requires 'indentkeys'
  let midx = match(getline(clnum), '^\s*\%(END\>\|REPEAT\>\|NEXT\>\|END_\%(\w\|\.\)*\)')
  if midx != -1 && synIDattr(synID(clnum, midx + 1, 1), "name") != 'ebslComment'
    let ind -= &shiftwidth
  endif

  return ind
endfunction

let b:undo_indent = 'setl si<'

let &cpo = s:keepcpo
unlet s:keepcpo
