" Vim filetype plugin file
" Language: Envision-Based Software Language (EBSL) a.k.a. Envision Basic
" Author: Jeffrey Crochet <jeffrey02468@gmail.com>
" URL: https://github.com/marzipanzerfaust/vim-ebsl

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

setlocal comments=:*
setlocal commentstring=*%s
setlocal iskeyword=A-Z,.,48-57,_
setlocal tabstop=3 softtabstop=3 shiftwidth=3

" " Folding
" " A lot of the following code was borrowed from Chapter 49 of Learn
" " VimScript the Hard Way:
" " <http://learnvimscriptthehardway.stevelosh.com/chapters/49.html>
" setlocal foldmethod=expr

" function! NextNonBlankLine(lnum)
"   let numlines = line('$')
"   let current = a:lnum + 1

"   while current <= numlines
"     if getline(current) =~? '\v\S'
"       return current
"     endif

"     let current += 1
"   endwhile

"   return -2
" endfunction

" function! IndentLevel(lnum)
"   return indent(a:lnum) / &shiftwidth
" endfunction

" function! GetEBSLFold(lnum)
"   if getline(a:lnum) =~ '\v&\s*$'
"     return '-1'
"   endif

"   let this_indent = IndentLevel(a:lnum)
"   let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

"   if next_indent == this_indent
"     return this_indent
"   elseif next_indent < this_indent
"     return this_indent
"   elseif next_indent > this_indent
"     return '>' . next_indent
"   endif

"   return '0'
" endfunction

" vim-matchit support
if exists('loaded_matchit')
  let b:match_ignorecase = 0
  let b:match_words =
        \ '\%(^\s*\)\@<=\<BEGIN CASE\>:\%(^\s*\)\@<=\<CASE\>:\%(^\s*\)\@<=\<END CASE\>,' .
        \ '\%(^\s*\)\@<=\<\%(IF\|FIND\|FINDSTR\|LOCATE\)\>:\%(^\s*\)\@<=\<END ELSE\>:\%(^\s*\)\@<=\<END\s*$,' .
        \ '\%(^\s*\)\@<=\<\%(FOR\|LOOP\)\>:\%(^\s*\)\@<=\<\%(WHILE\|UNTIL\)\>:\%(^\s*\)\@<=\<\%(NEXT\|REPEAT\)\>,' .
        \ '\%(^\s*\)\@<=\<FOR_\k*\>:\%(^\s*\)\@<=\<END_\k*\>,' .
        \ '(:),[:]'
endif

" vim-endwise support
if exists('loaded_endwise')
  " This is is a list of all qualifiers that can appear in an EBSL macro
  " statement; it is required for matching the actual key element of a
  " macro statement.
  let macro_qualifiers = [
        \ 'ASCENDING', 'ASSOCIATED', 'AT', 'BATCHED', 'BREAKING_ON', 'CANCELLING', 'COMMITTING', 'COMMIT_EVERY', 'COUNTED', 'CREATE_NEW', 'CRITERIA', 'DEFER_COMMIT', 'DELETING', 'DESCENDING', 'EXISTING', 'FIRST', 'FROM', 'GRAPHED', 'INTO', 'INTO_REFERENCED', 'KEY_IN', 'LAST', 'LEFT', 'LIMITING', 'MATCHING', 'NEW', 'NEWLIST', 'ONLY', 'PRE-ASSEMBLED', 'PROTECTED', 'RECURSIVE', 'REFERENCED', 'RELEASING', 'RIGHT', 'SECONDARY', 'SELECTED', 'SINGLE', 'TESTING', 'THIS_APPLICATION', 'THIS_INSTANCE_OF', 'TO', 'UNVALIDATED', 'USING', 'WRITING'
        \ ]

  let b:endwise_addition =
        \ '\=submatch(0) == "THEN" ? "END" : ' .
        \ 'submatch(0) == "ELSE" ? "END" : ' .
        \ 'submatch(0) == "BEGIN CASE" ? "END CASE" : ' .
        \ 'submatch(0) =~ "FOR\\s" ? "NEXT ".submatch(3) : ' .
        \ 'submatch(0) =~ "LOOP" ? "REPEAT" : ' .
        \ 'submatch(0) =~ "FOR_" ? "END_".submatch(1)." ".submatch(2) : ""'
  let b:endwise_words = 'THEN,ELSE,BEGIN CASE,FOR,LOOP'
  let b:endwise_pattern =
        \ '\%(^\s*\)\@<=\<\%(' .
        \ 'BEGIN CASE\|' .
        \ '\%(IF\|FIND\|FINDSTR\|LOCATE\)\|' .
        \ 'FOR_\(\k*\) \%('.join(macro_qualifiers, ' \|').'\)*\(\k\+\)\|' .
        \ 'FOR \(\k\+\)\|' .
        \ 'LOOP' .
        \ '\)\>'
  let b:endwise_syngroups = 'ebslMacro,ebslKeyword'
endif

" Undo the stuff we changed
let b:undo_ftplugin = "setlocal comments< commentstring< iskeyword< ts< sts< sw<" .
      \ " | unlet! b:match_ignorecase b:match_words" .
      \ " | unlet! b:endwise_addition b:endwise_words b:endwise_pattern b:endwise_syngroups"
