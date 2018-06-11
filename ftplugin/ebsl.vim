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
setlocal iskeyword=a-z,A-Z,.,48-57,_
setlocal tabstop=3 softtabstop=3 shiftwidth=3
setlocal foldmethod=syntax

" vim-matchit support
if exists('loaded_matchit')
  let b:match_ignorecase = 0
  let b:match_words =
        \ '\%(^\s*\)\@<=\<BEGIN CASE\>:\%(^\s*\)\@<=\<CASE\>:\%(^\s*\)\@<=\<END CASE\>,' .
        \ '\%(^\s*\)\@<=\<\%(IF\|FIND\|FINDSTR\|LOCATE\)\>:\%(^\s*\)\@<=\<END ELSE\>:\%(^\s*\)\@<=\<END\s*$,' .
        \ '\%(^\s*\)\@<=\<\%(FOR\|LOOP\)\>:\%(^\s*\)\@<=\<\%(WHILE\|UNTIL\)\>:\%(^\s*\)\@<=\<\%(NEXT\|REPEAT\)\>,' .
        \ '\%(^\s*\)\@<=\<FOR_\k*\>:\%(^\s*\)\@<=\<END_\k*\>,' .
        \ '^\s*\k\+\:\s*$:\<RETURN\s*$,' .
        \ '(:),[:]'
endif

" vim-endwise support
if exists('loaded_endwise')
  " This is is a list of all qualifiers that can appear in an EBSL
  " transaction statement; it is required for matching the actual key
  " element of a transaction statement.
  let s:transaction_qualifiers = [
        \ 'ASCENDING', 'ASSOCIATED', 'AT', 'BATCHED', 'BREAKING_ON', 'CANCELLING', 'COMMITTING', 'COMMIT_EVERY', 'COUNTED', 'CREATE_NEW', 'CRITERIA', 'DEFER_COMMIT', 'DELETING', 'DESCENDING', 'EXISTING', 'FIRST', 'FROM', 'GRAPHED', 'INTO', 'INTO_REFERENCED', 'KEY_IN', 'LAST', 'LEFT', 'LIMITING', 'MATCHING', 'NEW', 'NEWLIST', 'ONLY', 'PRE-ASSEMBLED', 'PROTECTED', 'RECURSIVE', 'REFERENCED', 'RELEASING', 'RIGHT', 'SECONDARY', 'SELECTED', 'SINGLE', 'TESTING', 'THIS_APPLICATION', 'THIS_INSTANCE_OF', 'TO', 'UNVALIDATED', 'USING', 'WRITING'
        \ ]

  let b:endwise_addition =
        \ '\=submatch(0) =~ "FOR_" ? "END_" . split(submatch(0))[0][4:] . " " . split(submatch(0))[-1] : ' .
        \ 'submatch(0) =~ "FOR" ? "NEXT ".split(submatch(0))[1] : ' .
        \ 'submatch(0) == "THEN" || submatch(0) == "ELSE" ? "END" : ' .
        \ 'submatch(0) == "BEGIN CASE" ? "END CASE" : ' .
        \ 'submatch(0) == "LOOP" ? "REPEAT" : ""'
  let b:endwise_words = ''
  let b:endwise_pattern =
        \ '^\s*\%(' .
        \ '\zsFOR \k\+\ze\>.*\|' .
        \ '\%(IF\|FIND\|FINDSTR\|LOCATE\).\+\zs\%(THEN\|ELSE\)\ze\|' .
        \ '\zsBEGIN CASE\ze\|' .
        \ '\zsLOOP\ze\>.*\|' .
        \ '\zsFOR_\k* \%('.join(s:transaction_qualifiers, ' \|').'\)*\k\+\ze.*' .
        \ '\)\s*$'
  let b:endwise_syngroups = 'ebslStatement,ebslTransactionStatement'
endif

" Undo the stuff we changed
let b:undo_ftplugin = "setlocal comments< commentstring< iskeyword< ts< sts< sw<" .
      \ " | unlet! b:match_ignorecase b:match_words" .
      \ " | unlet! b:endwise_addition b:endwise_words b:endwise_pattern b:endwise_syngroups"
