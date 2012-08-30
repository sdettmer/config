" Vim syntax file

" Setup
if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif

" echo "nomadlog apply"

" "DBG", "ERR", "WRN", "NTC", "INF", "VRB", "CRZ"
syntax match nomadlogError    "^\d\{4\}-\d\{2\}-\d\{2\}-\d\{6\}-\d\{3\} ERR .*"
syntax match nomadlogWarn     "^\d\{4\}-\d\{2\}-\d\{2\}-\d\{6\}-\d\{3\} WRN .*"
syntax match nomadlogProgress "^\d\{4\}-\d\{2\}-\d\{2\}-\d\{6\}-\d\{3\} NTC .*"
syntax match nomadlogInfo     "^\d\{4\}-\d\{2\}-\d\{2\}-\d\{6\}-\d\{3\} INF .*"
syntax match nomadlogConfig   "^\d\{4\}-\d\{2\}-\d\{2\}-\d\{6\}-\d\{3\} VRB .*"
syntax match nomadlogFine     "^\d\{4\}-\d\{2\}-\d\{2\}-\d\{6\}-\d\{3\} CRZ .*"
syntax match nomadlogFiner    "^\d\{4\}-\d\{2\}-\d\{2\}-\d\{6\}-\d\{3\} DBG .*"
syn keyword nomadlogLevel DBG ERR WRN NTC INF VRB CRZ

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_nomadlog_syntax_inits")
  if version < 508
    let did_nomadlog_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink nomadlogLevel          Type
  highlight nomadlogError         ctermfg=DarkRed
  highlight nomadlogWarn          ctermfg=Brown
  highlight nomadlogProgress      ctermfg=Yellow
  highlight nomadlogInfo          ctermfg=Green
  highlight nomadlogConfig        ctermfg=LightGrey
  highlight nomadlogFine          ctermfg=Blue
  highlight nomadlogFiner         ctermfg=DarkGray
  " highlight nomadlogFinest        ctermfg=Blue

  delcommand HiLink
endif

let b:current_syntax = "nomadlog"

