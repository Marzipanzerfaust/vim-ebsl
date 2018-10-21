" Vim syntax file
" Language: Envision-Based Software Language (EBSL) a.k.a. Envision Basic
" Author: Jeffrey Crochet <jeffrey02468@gmail.com>
" URL: https://github.com/marzipanzerfaust/vim-ebsl

if exists('b:current_syntax')
  finish
endif

" Syntax definitions {{{
syn match ebslNumber /\<\d\+\>/ display  " Integers
syn match ebslNumber /\<\d\+\.\d\+\>/ display  " Floats with a leading number
syn match ebslNumber /\<\.\d\+\>/ display  " Floats with no leading number

syn match ebslOperator /\*\|\/\|\^\|#\|=\|&\|!\|:\|<\|>\|-\|+\|\[\|\]/ display
syn keyword ebslOperator AND OR EQ NE GT LT GE LE MATCH MATCHES CAT

syn match ebslReservedVariable /\<\k\+\.ADD\.MODE\>/ display
syn match ebslReservedVariable /\<ABORT\.\k\+\.LOOP\>/ display
syn match ebslReservedVariable /\<\%(V\|VL\|R\|KV\|KEY\|SN\|NEXT\)\.\k\+\>/ display

syn region ebslString start=/'/ end=/'/ oneline display
syn region ebslString start=/"/ end=/"/ oneline display
syn region ebslString start=/`/ end=/`/ oneline display

syn keyword ebslFunction nextgroup=ebslFuncArgs
      \ @
      \ ABS acceptConnection ACOS
" A func args region is defined to differentiate between statements and
" functions that have the same name
syn region ebslFuncArgs start='(' end=')' transparent

syn cluster ebslExpression
      \ contains=ebslNumber,ebslOperator,ebslReservedVariable,ebslString,ebslFunction,ebslFuncArgs

syn match ebslPreProcStatement /^\s*\zs\$\%(BASICTYPE\|DEFINE\|F\|FALSE\|IFDEF\|IFNDEF\|INCLUDE\|INSERT\|T\|TRUE\|UNDEFINE\|CHAIN\|COPYRIGHT\|EJECT\|MAP\|OPTIONS\|PAGE\).*$/ display

syn match ebslSubroutineLabel /^\s*\zs\k\+:/ display
" Folding support for subroutine blocks
syn region ebslLabelBlock start=/^\z(\s*\)\k\+:/ end=/^\z1RETURN\>/ transparent fold keepend

syn match ebslComment /\%(^\s*\zs\|;\)\s*\%(\*\|REM\>\).*$/ contains=ebslTodo display
syn keyword ebslTodo TODO FIXME XXX NOTE contained

" This list is for simple statements and commands that do not have any
" special syntax to account for
syn keyword ebslStatement
      \ ABORT ACTIVATEKEY
      \ ERROR
      \ ON
" }}}

" Default highlighting {{{
hi def link ebslFunction Function
hi def link ebslStatement Keyword
hi def link ebslNumber Number
" hi def link ebslOperator Operator
hi def link ebslPreProcStatement PreProc
hi def link ebslReservedVariable Identifier
hi def link ebslString String
hi def link ebslSubroutineLabel Label
hi def link ebslSystemVariable Special
hi def link ebslComment Comment
hi def link ebslTodo Todo
" }}}

let b:current_syntax = 'ebsl'

" vim:fdm=marker fdls=0
