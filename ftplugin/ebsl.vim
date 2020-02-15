" Vim filetype plugin file
" Language: Envision-Based Software Language (EBSL) a.k.a. Envision Basic
" Author: Jeffrey Crochet <marzipanzerfaust@protonmail.com>
" URL: https://github.com/marzipanzerfaust/vim-ebsl

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

setlocal comments=:*
setlocal commentstring=*%s
setlocal iskeyword+=.
setlocal tabstop=3 softtabstop=3 shiftwidth=3

if exists("ebsl_fold")
  setlocal foldmethod=syntax
endif

" Helper patterns:
" start of line
let s:sol = '\%(\%(^\|;\)\s*\)'
" end of line, i.e. any amount of whitespace plus an optional inline comment
let s:eol = '\%(\s*\%(;\s*\%(\*\|!\|REM\>\).*\)\=$\)'

" This function produces a pattern that matches a logical line in which
" the given text is the only non-comment text
function! s:Whole(pattern)
  return s:sol.'\@<='.a:pattern.s:eol
endfunction

" This function produces a pattern that matches a logical line beginning
" with the given text that can be proceeded by anything
function! s:Start(pattern)
  return s:sol.'\@<='.a:pattern.'\>.*'
endfunction

" This function produces a pattern that matches a logical line ending
" with the given text that can be preceded by anything
function! s:End(pattern)
  return '.*\<\zs'.a:pattern.s:eol
endfunction

" vim-matchit support
if exists('loaded_matchit')
  " Given a two-dimensional array, where each row is a list of patterns
  " representing an entry in `match_words`, return the full string
  " required for `match_words`
  function! MatchitString(list)
    let strlist = []

    for row in a:list
      call add(strlist, join(row, ':'))
    endfor

    return join(strlist, ',')
  endfunction

  let b:match_ignorecase = 0

  let b:match_skip = synIDattr(synID(line('.'), col('.'), 1), 'name') =~? 'ebslComment\|ebslString'

  let s:match_list = [
        \ [s:Whole('BEGIN CASE'), s:Start('CASE'), s:Whole('END CASE')],
        \ [s:Whole('\%(END\)\@!\%(\<.\+\<\%(THEN\|ELSE\)\)'), s:Start('END ELSE'), s:Whole('END')],
        \ [s:Start('LOOP'), s:Start('WHILE'), s:Start('UNTIL'), s:Start('DO'), s:Whole('REPEAT')],
        \ [s:Start('FOR'), s:Start('NEXT')],
        \ [s:Start('FOR_\k*'), s:Start('END_\k*')],
        \ ['^\k\+\:', '^RETURN\>'],
        \ [s:Start('\$IF'), s:Whole('\$END')],
        \ [s:Start('\$IFDN\=EF'), s:Whole('\$ELSE'), s:Whole('\$ENDIF')]
        \ ]
  let b:match_words = MatchitString(s:match_list)
endif

" vim-endwise support
if exists('loaded_endwise')
  " If vim-capslock is also being used, we need to modify the `capslock`
  " augroup to *only* insert upper case letters when capslock is enabled
  if exists("loaded_capslock")
    augroup capslock
      if exists('##InsertCharPre')
        autocmd InsertCharPre *
              \ if s:enabled('i') |
              \   let v:char = toupper(c:char) |
              \ endif
      endif
    augroup END
  endif

  let b:endwise_addition =
        \ '\=submatch(0) =~ "FOR_" ? "END_" . split(submatch(0))[0][4:] . " " . split(submatch(0))[-1] : ' .
        \ 'submatch(0) =~ "FOR" ? "NEXT ".split(submatch(0))[1] : ' .
        \ 'submatch(0) == "$IF" ? "$END" : ' .
        \ 'submatch(0) == "$IFDEF" || submatch(0) == "$IFNDEF" || submatch(0) == "$ELSE" ? "$ENDIF" : ' .
        \ 'submatch(0) == "THEN" || submatch(0) == "ELSE" ? "END" : ' .
        \ 'submatch(0) == "BEGIN CASE" ? "END CASE" : ' .
        \ 'submatch(0) == "LOOP" ? "REPEAT" : ""'

  let b:endwise_words = ''

  " This is is a list of all qualifiers that can appear in an EBSL
  " database access statement; it is required for matching the actual
  " key element of such a statement.
  let s:database_qualifiers = [
        \ 'ASCENDING', 'ASSOCIATED', 'AT', 'BATCHED', 'BREAKING_ON', 'CANCELLING', 'COMMITTING', 'COMMIT_EVERY', 'COUNTED', 'CREATE_NEW', 'CRITERIA', 'DEFER_COMMIT', 'DELETING', 'DESCENDING', 'EXISTING', 'FIRST', 'FROM', 'GRAPHED', 'INTO', 'INTO_REFERENCED', 'KEY_IN', 'LAST', 'LEFT', 'LIMITING', 'MATCHING', 'NEW', 'NEWLIST', 'ONLY', 'PRE-ASSEMBLED', 'PROTECTED', 'RECURSIVE', 'REFERENCED', 'RELEASING', 'RIGHT', 'SECONDARY', 'SELECTED', 'SINGLE', 'TESTING', 'THIS_APPLICATION', 'THIS_INSTANCE_OF', 'TO', 'UNVALIDATED', 'USING', 'WRITING'
        \ ]
  let s:match_patterns = [
        \ '\zsFOR \k\+\ze\>.*',
        \ '\zs\$\%(IF\%(N\=DEF\)\=\|ELSE\)\ze\>.*',
        \ '.\+\<\zs\%(THEN\|ELSE\)\ze',
        \ '\zsBEGIN CASE\ze',
        \ '\zsLOOP\ze\>.*',
        \ '\zsFOR_\k* \%(\%('.join(s:database_qualifiers, '\|').'\)\s*\)*\k\+\ze.*'
        \ ]
  let b:endwise_pattern = s:sol . '\%(' . join(s:match_patterns, '\|') . '\)' . s:eol

  let b:endwise_syngroups = 'ebslKeyword,ebslPreProc,ebslDatabaseAccess'
endif

" Undo the stuff we changed
let b:undo_ftplugin = "setlocal comments< commentstring< iskeyword< ts< sts< sw<" .
      \ " | unlet! b:match_ignorecase b:match_words" .
      \ " | unlet! b:endwise_addition b:endwise_words b:endwise_pattern b:endwise_syngroups"
