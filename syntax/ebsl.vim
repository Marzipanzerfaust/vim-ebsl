" Vim syntax file
" Language: Envision-Based Software Language (EBSL) a.k.a. Envision Basic
" Author: Jeffrey Crochet <jeffrey02468@gmail.com>
" URL: https://github.com/marzipanzerfaust/vim-ebsl

if exists('b:current_syntax')
  finish
endif

syn match ebslTransaction /^\s*\zs\%(FOR\|END\)_\k*.*$/ contains=ebslTransactionStatement,ebslTransactionQualifier,ebslNumber,ebslString,ebslComment
syn match ebslTransactionStatement /\%(FOR\|END\)_\k*/ contained
syn keyword ebslTransactionQualifier ASCENDING ASSOCIATED AT BATCHED BREAKING_ON CANCELLING COMMITTING COMMIT_EVERY COUNTED CREATE_NEW CRITERIA DEFER_COMMIT DELETING DESCENDING EXISTING FIRST FROM GRAPHED INSTANCE_OF INTO INTO_REFERENCED KEY_IN LAST LEFT LIMITING MATCHING NEW NEWLIST ONLY PRE-ASSEMBLED PROTECTED RECURSIVE REFERENCED RELEASING RIGHT SECONDARY SELECTED SINGLE TESTING THIS_APPLICATION THIS_INSTANCE_OF TO UNVALIDATED USING WRITING contained

syn match ebslFunction /\<\%(ABS\|ACOS\|ALPHA\|ASCII\|ASIN\|ATAN\|BITAND\|BITNOT\|BITOR\|BITXOR\|CALCULATE\|CATS\|CHAR\|CHARLEN\|CHECKSUM\|COL1\|COL2\|COS\|COUNT\|COUNTS\|DATE\|DCOUNT\|DELETE\|DIR\|DOWNCASE\|DQUOTE\|DROUND\|EBCDIC\|ENVIRON\|EQS\|EXP\|EXTRACT\|FIELD\|FIELDSTORE\|FMT\|GES\|GETPTR\|GETUSERNAME\|GROUP\|HASH\|ICONV\|ICONVS\|INDEX\|INDICES\|INMAT\|INSERT\|INT\|ITYPE\|LEN\|LENS\|LES\|LN\|LOWER\|LTS\|MATCHFIELD\|MAXIMUM\|MINIMUM\|MOD\|NEG\|NES\|NOT\|NOTS\|NUM\|NUMS\|OCONV\|OCONVS\|PWR\|QUOTE\|RAISE\|REM\|REMOVE\|REPLACE\|REUSE\|RND\|SADD\|SCMP\|SDIV\|SEQ\|SEQS\|SHOWA\|SHOWC\|SIN\|SMUL\|SOUNDEX\|SPACE\|SQRT\|SQUOTE\|SSUB\|STATUS\|STR\|SUBSTRINGS\|SUM\|SYSTEM\|TAN\|TIME\|TIMEDATE\|TRIM\|TRIMB\|TRIMF\|TRIMS\|UNASSIGNED\|UPCASE\|XLATE\)\>/

syn keyword ebslStatement BEFORE BEGIN BY CALL CALL_SCREEN CALL_SUBR CASE CDD CONTINUE CONVAFTER CONVERT CRT DEL DIM DO ELSE END EXIT FIND FINDSTR FOR GOSUB IF IGNORE IN INS LINE LOCATE LOCKED LOOP MAT NEXT NULL PAGE PRINT PRINT_DETAIL PROCEDURE PROGRAM PROMPT PROMPT_IN_PLACE PROMPT_WIDE REPEAT REPROMPT RETURN SETTING SLEEP STEP SUBROUTINE SWAP THEN TO TRANSLATE UNTIL WHILE

syn match ebslNumber /\<\d\+\>/  " Integers
syn match ebslNumber /\<\d\+\.\d\+\>/  " Floats with a leading number
syn match ebslNumber /\<\.\d\+\>/  " Floats with no leading number

syn match ebslOperator /\*\|\/\|\^\|#\|=\|&\|!\|:\|<\|>\|-\|+/
syn keyword ebslOperator AND OR EQ NE GT LT GE LE MATCH MATCHES

syn region ebslPreProcStatement start=/^\s*\$/ end=/$/ oneline
syn region ebslPreProcStatement start=/^\s*:/ end=/$/ oneline

syn keyword ebslReservedVariable EDITED.DATA ERROR.OCCURRED INPUT.DATA MSG MSG.ARGUMENTS NEXT.PROC.FLD OUTPUT.DATA WARNING.OCCURRED
syn match ebslReservedVariable /\<VL\=\.\k\+\>/
syn match ebslReservedVariable /\<\k\+\.ADD\.MODE\>/
syn match ebslReservedVariable /\<R\.\k\+\>/
syn match ebslReservedVariable /\<ABORT\.\k\+\.LOOP\>/

syn region ebslString start=/'/ end=/'/ oneline
syn region ebslString start=/"/ end=/"/ oneline
syn region ebslString start=/`/ end=/`/ oneline

syn match ebslSubroutineLabel /^\s*\zs\k\+:/

syn match ebslSystemVariable /@\%(ACCOUNT\|COMMAND\|CONV\|CRTHIGH\|CRTWIDE\|DATA\|DATE\|DAY\|DICT\|FORMAT\|GID\|HEADER\|ID\|LASTVERB\|LEVEL\|LOGNAME\|LPTRHIGH\|LPTRWIDE\|MONTH\|NULL\|PARASENTENCE\|PATH\|RECORD\|RECUR0\|RECUR1\|RECUR2\|RECUR3\|RECUR4\|SENTENCE\|SYS\.BELL\|SYSTEM\.RETURN\.CODE\|TIME\|TTY\|TUPLE\|UDTHOME\|UID\|USER\.RETURN\.CODE\|USER\.TYPE\|USER0\|USER1\|USER3\|USER4\|USERNO\|WHO\|YEAR\|IM\|FM\|AM\|VM\|SM\|SVM\|TM\)\>/

syn match ebslDelimiter /(\|)\|\[\|\]\|,\|;/

syn match ebslComment /\%(^\s*\zs\|;\)\s*\%(\*\|REM\>\).*$/ contains=ebslTodo
syn keyword ebslTodo TODO FIXME XXX NOTE contained

" Block regions defined for folding support
syn region ebslLabelBlock start=/^\z(\s*\)\k\+:/ end=/^\z1RETURN\>/ transparent fold keepend

hi def link ebslTransactionStatement Keyword
hi def link ebslTransactionQualifier Type
hi def link ebslFunction Function
hi def link ebslStatement Keyword
hi def link ebslNumber Number
" hi def link ebslOperator Operator
hi def link ebslPreProcStatement PreProc
hi def link ebslReservedVariable Identifier
hi def link ebslString String
hi def link ebslSubroutineLabel Underlined
hi def link ebslSystemVariable Identifier
" hi def link ebslDelimiter Operator
hi def link ebslComment Comment
hi def link ebslTodo Todo

let b:current_syntax = 'ebsl'
