" Vim syntax file
" Language: Envision-Based Software Language (EBSL) a.k.a. Envision Basic
" Author: Jeffrey Crochet <jlcrochet@pm.me>
" URL: https://github.com/jlcrochet/vim-ebsl

if exists('b:current_syntax')
  finish
endif

syn iskeyword @,48-57,_,.,@-@

" Group definitions
syn match ebslOperator /[*/^#=&!:<>\-+]/ display
syn keyword ebslKeywordOperator CAT EQ NE LT GT GE LE MATCH MATCHES AND OR

syn match ebslInteger /\%(\%(\%(\k\|)\|]\|>\)\s*\)\@<![+-]\)\=\<\d\+\>/ display
syn match ebslFloat /\%(\%(\%(\k\|)\|]\|>\)\s*\)\@<![+-]\)\=\<\%(\d\+\)\=\.\d\+\>/ display

syn match ebslComment /\%(^\s*\zs\|;\s*\)\%(\*\|!\|REM\>\).*/ contains=ebslTodo display
syn keyword ebslTodo TODO FIXME XXX NOTE

syn region ebslString matchgroup=ebslStringDelimiter start=/'/ end=/'/ oneline display
syn region ebslString matchgroup=ebslStringDelimiter start=/"/ end=/"/ oneline display
syn region ebslString matchgroup=ebslStringDelimiter start=/`/ end=/`/ oneline display

syn keyword ebslFunction
      \ @
      \ ABS ACOS ALPHA ASCII ASIN ATAN
      \ BITAND BITNOT BITOR BITXOR BYTELEN
      \ CALCULATE CATS CHANGE CHAR CHARLEN CHARS CHECKSUM COL1 COL2 COS COUNT COUNTS CloseXMLData
      \ DATE DBTOXML DCOUNT DIGEST DIR DISPLAYWIDTH DOWNCASE DQUOTE DROUND
      \ EBCDIC EDADRV_Cleanup EDADRV_CloseStmt EDADRV_Connect EDADRV_Disconnect EDADRV_DropStmt EDADRV_EndTransaction EDADRV_ExecuteStmt EDADRV_FetchStmt EDADRV_FreeResult EDADRV_GetDBInfo EDADRV_GetEDAAttr EDADRV_GetErrmsg EDADRV_GetSpecialInfo EDADRV_LoadSymbols EDADRV_Perform EDADRV_PrepareStmt ENCODE ENCRYPT EQS EREPLACE EXP EXTRACT
      \ FIELDSTORE FILEINFO FMT
      \ GES GETENV GETPTR GETPU GETQUEUE GETREADU GETUSERGROUP GETUSERID GETUSERNAME GROUP GTS
      \ HASH
      \ ICONV ICONVS INDEX INDICES INMAT INSERT INT ISMB ISNV ISNVS ITYPE
      \ LEN LENS LES LISTUSER LN LOWER LTS
      \ MATCHFIELD MAXIMUM MBLEN MINIMUM MOD
      \ NEG NES NFAUSER NOTS NUM NUMS
      \ OCONV OCONVS OpenXMLData
      \ PWR PrepareXML
      \ QUOTE
      \ RAISE RECORDLOCKED REM REPLACE REUSE RND ReadXMLData ReleaseXML
      \ SADD SCMP SDIV SELECTINFO SEQ SEQS SETENV SIGNATURE SIN SMUL SOAPCreateRequest SOAPCreateSecureRequest SOAPGetDefault SOAPGetFault SOAPGetResponseHeader SOAPRequestWrite SOAPSetDefault SOAPSetParameters SOAPSetRequestBody SOAPSetRequestContent SOAPSetRequestHeader SOAPSubmitRequest SORT SOUNDEX SPACE SPACES SPLICE SQLAllocConnect SQLAllocEnv SQLAllocStmt SQLBindCol SQLBindParameter SQLCancel SQLColAttributes SQLColumns SQLConnect SQLDescribeCol SQLDisconnect SQLError SQLExecDirect SQLExecute SQLFetch SQLFreeConnect SQLFreeEnv SQLFreeStmt SQLGetInfo SQLGetTypeInfo SQLNumParams SQLNumResultCols SQLParamOptions SQLPrepare SQLRowCount SQLSetConnectOption SQLSetParam SQLSpecialColumns SQLStatistics SQLTables SQLTransact SQRT SQUOTE SSUB STATUS STR STRS SUBSTRINGS SUM SYSTEM
      \ TAN TIME TIMEDATE TRIM TRIMB TRIMF TRIMS
      \ UNASSIGNED UPCASE
      \ XDOMAddChild XDOMAppend XDOMClone XDOMClose XDOMCreateNode XDOMCreateRoot XDOMEvaluate XDOMGetAttribute XDOMGetNodeName XDOMGetNodeType XDOMGetNodeValue XDOMGetOwnerDocument XDOMGetUserData XDOMImportNode XDOMInsert XDOMLocate XDOMLocateNode XDOMOpen XDOMRemove XDOMReplace XDOMSetNodeValue XDOMSetUserData XDOMTransform XDOMValidate XDOMValidateDom XDOMWrite XLATE XMAPAppendRec XMAPClose XMAPCreate XMAPOpen XMAPReadNext XMAPToXMLDoc XMLError XMLExecute XMLGetError XMLGetOptionValue XMLGetOptions XMLSetOptions XMLTODB
      \ acceptConnection addAuthenticationRule addCertificate addRequestParameter amInitialize amReceiveMsg amReceiveRequest amSendMsg amSendRequst amSendResponse amTerminate analyzeCertificate
      \ closeSocket createCertRequest createCertificate createRequest createSecureRequest createSecurityContext
      \ generateKey getCipherSuite getHTTPDefault getResponseHeader getSocketInformation getSocketOptions
      \ initSecureServerSocket initServerSocket
      \ loadSecurityContext
      \ openSecureSocket openSocket
      \ protocolLogging
      \ readSocket
      \ saveSecurityContext setAuthenticationDepth setCipherSuite setClientAuthentication setHTTPDefault setPrivateKey setRandomSeed setRequestHeader setSocketOptions showSecurityContext submitRequest
      \ writeSocket

syn keyword ebslKeyword
      \ ABORT ACTIVATEKEY ADD ADD_ONLY ALL ALLOW_CANCEL ALL_OF AND_EV AND_FROM APPEND ASCENDING ASSIGN ASSOCIATED ASYNC AT AUX
      \ BATCHED BEFORE BEGIN BOTH BPIOCP BPIOCPN BREAK BREAKING_ON BROWSE BUFFER.KEYS BUT_NOT_FROM BY
      \ CALL CALLC CALLING CALL_PROCESS CALL_SCREEN CALL_SUBR CANCEL CANCELLING CAPTURE CAPTURING CASE CDD CHAIN CHAIN_SCREEN CLEAR CLEARCOM CLEARCOMMON CLEARDATA CLEARFILE CLEARINPUT CLEARSELECT CLEARSQL CLOSE CLOSESEQ COM COMMIT COMMITTING COMMIT_EVERY COMMON COMO CONCAT CONDITIONALLY CONFIRM CONSOLIDATING CONTINUE CONVAFTER CONV_AFTER COPY_LOGICAL COUNTED CREATE_NEW CRITERIA CRT
      \ DATA DEACTIVATEKEY DEBUG DEFAULT_RECORD DEFER_COMMIT DEFFUN DEL DELETELIST DELETEU DELETE_RECORD DELETE_RECORDS DELETING DESCENDING DIM DIMENSION DISABLEDEC DISPLAY DO
      \ ECHO ELSE EMAIL ENABLEDEC END ENTER EQU EQUATE ERROR ERROR_IF EXECUTE EXECUTESQL EXISTING EXIT
      \ FIELDS FILELOCK FILEUNLOCK FIND FINDSTR FIRST FLUSH FOOTING FOR FORCE FORMLIST FROM FULL_ACCESS FUNCTION
      \ GARBAGECOLLECT GET GETLIST GETTING_ACTION_CODES GETX GO GOSUB GOTO GRAPHED GROUPSTORE
      \ HEADING HOLD HUSH
      \ IF IGNORE INPUT INPUTCLEAR INPUTERR INPUTIF INPUTNULL INPUTTRAP INQUIRY INS INSTANCE_OF INTO INTO_REFERENCED ITEMIZING
      \ KEY KEY_IN
      \ LAST LEFT LENGTH LIMITING LINE LIT LITERALLY LOCATE LOCK LOCKED LOOKUP LOOP
      \ MAT MATBUILD MATCHING MATPARSE MATREAD MATREADL MATREADU MATWRITE MATWRITEU MDPERFORM MOVE_CONTROLLER
      \ NEW NEWLIST NEXT NOADD NOBROWSE NOCONV NOCONVERT NODELAY NOFMT NO_ACCESS NO_ADD NO_CONV NO_DELETE NULL
      \ OFF ON ONLY OPEN OPENSEQ OSBREAD OSBWRITE OSCLOSE OSDELETE OSOPEN OSREAD OSWRITE OUTPUT
      \ PAGE PASSCOM PASSLIST PAUSE PCPERFORM PDF PERFORM PHANTOM PRECISION PRE_ASSEMBLED PRINT PRINTER PRINTERR PRINT_DETAIL PRINT_TOTAL PROCEDURE PROCREAD PROCWRITE PROGRAM PROMPT PROMPT_IN_PLACE PROMPT_WIDE PROTECTED
      \ READ READBCK READBCKL READBCKU READFWD READFWDL READFWDU READL READLIST READNEXT READNEXTTUPLE READONLY READSELECT READSEQ READT READU READV READVL READVU READXBCK READXFWD RECORDLOCKL RECORDLOCKU RECORD_CACHING RECURSIVE REFERENCED RELEASE RELEASING REPEAT REPROMPT RESET RESIZET RETCODE RETURN RETURNING REWIND RIGHT RNDSEED RQM RTNLIST RUN
      \ SCREEN SECONDARY SELECT SELECTED SELECTINDEX SEND SENDX SETINDEX SETPTR SETTING SET_SECURITY SHOWA SHOWC SINGLE SLEEP SORTING START STEP STMT STOP SUBROUTINE SUSPEND SWAP SYNC
      \ TEMPLATE TESTING THEN THIS_APPLICATION_ONLY THIS_INSTANCE_OF THROW_ERROR TO TRANSACTION TRANSLATE TRANSLATING TYPE
      \ UNFILTERED UNIT UNLOCK UNTIL UNVALIDATED UPDATE USING UTDEXECUTE
      \ VALIDATE VALIDATE.KEY VALIDATION
      \ WAITING WAKE WARNING WEOF WEOFSEQ WHILE WINDOW WINDOWS WITH WRITE WRITELIST WRITEONLY WRITESEQ WRITESEQF WRITET WRITEU WRITEV WRITEVU WRITING

" The following keywords can also be used as functions, so we need to
" match them as ebslFunction if they are proceeded by a parenthesis,
" otherwise ebslKeyword
let s:ambiguous_words = join(["CONVERT", "DELETE", "FIELD", "IN", "NOT", "REMOVE"], '\|')
exe 'syn match ebslFunction /\<\%('.s:ambiguous_words.'\)\>\ze\s*(/ display'
exe 'syn match ebslKeyword  /\<\%('.s:ambiguous_words.'\)\>\ze\%(\s*(\)\@!/ display'
unlet s:ambiguous_words

" The below function and keyword names strip out any [.-_] before being
" matched
let s:strip_func_names = ['MODIFYSELECT', 'MODIFYSORT']
let s:strip_word_names = ['NOEXECUTE', 'NOSEC', 'NOMODIFY', 'FOREGROUND', 'BACKGROUND']

function! s:AddIgnoreChars(key, word)
  let new_word = a:word[0]

  for i in range(1, strchars(a:word)-1)
    let new_word .= '[.\-_]*'.a:word[i]
  endfor

  return new_word
endfunction

let s:strip_func_pattern = join(map(s:strip_func_names, function('s:AddIgnoreChars')), '\|')

exec 'syn match ebslFunction /\<\%('.s:strip_func_pattern.'\)\>/ display'

let s:strip_word_pattern = join(map(s:strip_word_names, function('s:AddIgnoreChars')), '\|')

exec 'syn match ebslKeyword /\<\%('.s:strip_word_pattern.'\)\>/ display'

unlet s:strip_func_pattern
unlet s:strip_func_names
unlet s:strip_word_pattern
unlet s:strip_word_names

syn match ebslDatabaseAccess /^\s*\zs\%(FOR\|END\)_\k*/ display
syn match ebslDatabaseElement /\<\%(VL\=\|R\)\.\k\+\>/ display

syn match ebslLabel /^\zs\k\+:/ display
syn region ebslLabelBlock start=/^\zs\k\+:/ end=/^RETURN\>/ transparent fold keepend

syn match ebslPreProc /^\s*\zs\$.\+/ display
syn region ebslPreProc matchgroup=ebslPreProcDelimiter start=/^\s*\zs:/ end=/:/ oneline display

syn match ebslMacro /\%(^\s*\)\@<!\$\k\+/

syn keyword ebslReservedVariable
      \ @ACCOUNT @AM
      \ @COMMAND @CONV @CRTHIGH @CRTWIDE
      \ @DATA @DATE @DAY @DICT
      \ @FM @FORMAT
      \ @GID
      \ @HEADER
      \ @ID
      \ @LASTVERB @LEVEL @LOGNAME @LPTRHIGH @LPTRWIDE
      \ @MONTH
      \ @PARASENTENCE @PATH
      \ @RECORD @RECUR0 @RECUR1 @RECUR2 @RECUR3 @RECUR4 @RM
      \ @SENTENCE @SM @SVM @SYS.BELL @SYSTEM.RETURN.CODE
      \ @TIME @TM @TRANSACTION @TTY
      \ @UDTNO @UID @USER.RETURN.CODE @USER.TYPE @USER0 @USER1 @USER2 @USER3 @USER4 @USERNO
      \ @VM
      \ @WHO
      \ @YEAR

syn match ebslReservedVariable /\<\k\+\.ADD\.MODE\>/ display
syn match ebslReservedVariable /\<ABORT\.\k\+\.LOOP\>/ display
syn match ebslReservedVariable /\<\%(KEY\|SN\|NEXT\)\.\k\+\>/ display
syn match ebslReservedVariable /\<\k\+\.TRANSLATION\>/ display
syn match ebslReservedVariable /\<\k\+\.ACTION[12]\>/ display

syn keyword ebslReservedVariable
      \ CONFIRM.LVL CONFIRMED CRNT.KEY
      \ EDITED.DATA ERROR.OCCURRED
      \ INPUT.DATA
      \ MSG MSG.ARGUMENTS
      \ NEXT.PROC.FLD NUM.ERRORS.THROWN
      \ OUTPUT.DATA
      \ PROCESS.END
      \ RECORD.CANCEL
      \ TEC.ERROR.IDS
      \ WARNING.OCCURRED

" Default highlighting
hi def link ebslComment          Comment
hi def link ebslString           String
hi def link ebslStringDelimiter  Delimiter
hi def link ebslInteger          Number
hi def link ebslFloat            Float
hi def link ebslDatabaseElement  Identifier
hi def link ebslReservedVariable Identifier
hi def link ebslFunction         Function
hi def link ebslKeyword          Keyword
hi def link ebslPreProc          PreProc
hi def link ebslPreProcDelimiter Delimiter
hi def link ebslLabel            Label
hi def link ebslOperator         Operator
hi def link ebslKeywordOperator  Keyword
hi def link ebslDatabaseAccess   Statement
hi def link ebslMacro            PreProc
hi def link ebslTodo             Todo

let b:current_syntax = 'ebsl'
