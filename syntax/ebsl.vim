" Vim syntax file
" Language: Envision-Based Software Language (EBSL) a.k.a. Envision Basic
" Author: Jeffrey Crochet <jeffrey02468@gmail.com>
" URL: https://github.com/marzipanzerfaust/vim-ebsl

if exists('b:current_syntax')
  finish
endif

syn match ebslTransaction /^\s*\zs\%(FOR\|END\)_\k*\ze.*$/ contains=ebslTransactionStatement,ebslTransactionQualifier,ebslNumber,ebslString
syn match ebslTransactionStatement /\%(FOR\|END\)_\k*/ contained
syn keyword ebslTransactionQualifier ASCENDING ASSOCIATED AT BATCHED BREAKING_ON CANCELLING COMMITTING COMMIT_EVERY COUNTED CREATE_NEW CRITERIA DEFER_COMMIT DELETING DESCENDING EXISTING FIRST FROM GRAPHED INTO INTO_REFERENCED KEY_IN LAST LEFT LIMITING MATCHING NEW NEWLIST ONLY PRE-ASSEMBLED PROTECTED RECURSIVE REFERENCED RELEASING RIGHT SECONDARY SELECTED SINGLE TESTING THIS_APPLICATION THIS_INSTANCE_OF TO UNVALIDATED USING WRITING contained

syn match ebslFunction /\<\%(ABS\|ACOS\|ALPHA\|ASCII\|ASIN\|ATAN\|BITAND\|BITNOT\|BITOR\|BITXOR\|CALCULATE\|CATS\|CHAR\|CHARLEN\|CHECKSUM\|COL1\|COL2\|COS\|COUNT\|COUNTS\|DATE\|DCOUNT\|DELETE\|DIR\|DOWNCASE\|DQUOTE\|DROUND\|EBCDIC\|ENVIRON\|EQS\|EXP\|EXTRACT\|FIELD\|FIELDSTORE\|FMT\|GES\|GETPTR\|GETUSERNAME\|GROUP\|HASH\|ICONV\|ICONVS\|INDEX\|INDICES\|INMAT\|INSERT\|INT\|ITYPE\|LEN\|LENS\|LES\|LN\|LOWER\|LTS\|MATCHFIELD\|MAXIMUM\|MINIMUM\|MOD\|NEG\|NES\|NOT\|NOTS\|NUM\|NUMS\|OCONV\|OCONVS\|PWR\|QUOTE\|RAISE\|REM\|REMOVE\|REPLACE\|REUSE\|RND\|SADD\|SCMP\|SDIV\|SEQ\|SEQS\|SIN\|SMUL\|SOUNDEX\|SPACE\|SQRT\|SQUOTE\|SSUB\|STATUS\|STR\|SUBSTRINGS\|SUM\|SYSTEM\|TAN\|TIME\|TIMEDATE\|TRIM\|TRIMB\|TRIMF\|TRIMS\|UNASSIGNED\|UPCASE\|XLATE\)\>/

syn keyword ebslStatement BEGIN BY CALL CALL_SCREEN CALL_SUBR CASE CDD CONTINUE CONVAFTER CONVERT CRT DO ELSE END EXIT FIND FINDSTR FOR GOSUB IF IGNORE IN LOCATE LOCKED LOOP NEXT PAGE PRINT PROCEDURE PROGRAM PROMPT PROMPT_IN_PLACE PROMPT_WIDE REPEAT REPROMPT RETURN SETTING STEP SUBROUTINE SWAP THEN TO TRANSLATE UNTIL WHILE

syn match ebslNumber /\<\d\+\>/
syn match ebslNumber /\<\d\.\d*\>/
syn match ebslNumber /\.\d\+\>/

syn match ebslOperator /\*\|\/\|\^\|#\|=\|&\|!\|:\|<\|>\|-\|+/
syn keyword ebslOperator AND OR EQ NE GT LT GE LE MATCH MATCHES

syn region ebslPreProcStatement start=/\$/ end=/$/

syn keyword ebslReservedVariable EDITED.DATA ERROR.OCCURRED INPUT.DATA MSG MSG.ARGUMENTS NEXT.PROC.FLD OUTPUT.DATA WARNING.OCCURRED
syn match ebslReservedVariable /\<VL\=\.\k\+\>/

syn region ebslString start=/'/ end=/'/
syn region ebslString start=/"/ end=/"/
syn region ebslString start=/`/ end=/`/

syn match ebslSubroutineLabel /^\s*\zs\k\+:/

syn match ebslSystemVariable /@\%(ACCOUNT\|COMMAND\|CONV\|CRTHIGH\|CRTWIDE\|DATA\|DATE\|DAY\|DICT\|FORMAT\|GID\|HEADER\|ID\|LASTVERB\|LEVEL\|LOGNAME\|LPTRHIGH\|LPTRWIDE\|MONTH\|NULL\|PARASENTENCE\|PATH\|RECORD\|RECUR0\|RECUR1\|RECUR2\|RECUR3\|RECUR4\|SENTENCE\|SYS\.BELL\|SYSTEM\.RETURN\.CODE\|TIME\|TTY\|TUPLE\|UDTHOME\|UID\|USER\.RETURN\.CODE\|USER\.TYPE\|USER0\|USER1\|USER3\|USER4\|USERNO\|WHO\|YEAR\|IM\|FM\|AM\|VM\|SM\|SVM\|TM\)\>/

syn match ebslDelimiter /(\|)\|\[\|\]\|<\|>/

syn match ebslComment /\%(^\s*\zs\|;\)\%(\*\|REM\s\).*$/ contains=ebslTodo
syn keyword ebslTodo TODO FIXME XXX NOTE contained

" Block regions defined for folding support
" syn region ebslConditionalBlock start=/^\z(\s*\)\%(IF\|FIND\|FINDSTR\|LOCATE\).\+\%(THEN\|ELSE\)\s*$/ end=/^\z1END\s*$/ transparent fold
syn region ebslLabelBlock start=/^\z(\s*\)\k\+:/ end=/^\z1RETURN/ transparent fold

hi def link ebslTransactionStatement Keyword
hi def link ebslTransactionQualifier Type
hi def link ebslFunction Function
hi def link ebslStatement Keyword
hi def link ebslNumber Number
hi def link ebslOperator Operator
hi def link ebslPreProcStatement PreProc
hi def link ebslReservedVariable Identifier
hi def link ebslString String
hi def link ebslSubroutineLabel Special
hi def link ebslSystemVariable Identifier
hi def link ebslDelimiter Delimiter
hi def link ebslComment Comment
hi def link ebslTodo Todo

let b:current_syntax = 'ebsl'
