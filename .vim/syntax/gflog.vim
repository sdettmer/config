" Vim syntax file
" Glassfish server.log uses a strange multi-line logfile format:
" [2015-10-15T06:12:24.249+0200] [glassfish 4.1] [INFO] [NCLS-LOGGING-00009] [javax.enterprise.logging] [tid: _ThreadID=16 _ThreadName=RunLevelControllerThread-1444882343882] [timeMillis: 1444882344249] [levelValue: 800] [[
"   Running GlassFish Version: GlassFish Server Open Source Edition  4.1  (build 13)]]


" Setup
if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif


" For glassfish
"syntax region log_error    start="^\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[ERROR\].*\[\[$" end="\]\]$" contains=gf,logger
"syntax region log_warn     start="^\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[WARNING\].*\[\[$" end="\]\]$" contains=gf,logger
"syntax region log_info     matchgroup=log_meta transparent contains=gf,logger start="^\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[INFO\].*\[\[$" end="\]\]$" contains=gf,logger
"syntax match gf "\[glassfish 4.1\]"ms=s+1,he=e-1 containedin=log_info
syntax match log_gf "\[glassfish 4.1\]"

syntax region log_rest_trick start="\[[^]]\+\] " matchgroup=log_rest end=".*$" contained transparent
syntax match log_time "\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[[^]]\+\]" contained containedin=log_meta transparent
syntax region log_meta       start="^\[" end="\[\[$" contained oneline contains=log_time,log_gf,log_level,log_level_rest transparent
syntax match  log_level    "\[\(ERROR\|WARNING\|INFO\|CONFIG\|FINE\|FINER\|FINEST\)\]" contained transparent contains=log_rest_trick nextgroup=log_rest_trick

syntax region log_error      start="^\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[ERROR\].*\[\[$" end="\]\]$" contains=log_meta
syntax region log_warn       start="^\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[WARNING\].*\[\[$" end="\]\]$" contains=log_meta
syntax region log_info       start="^\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[INFO\].*\[\[$" end="\]\]$" contains=log_meta
syntax region log_config     start="^\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[CONFIG\].*\[\[$" end="\]\]$" contains=log_meta
syntax region log_fine       start="^\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[FINE\].*\[\[$" end="\]\]$" contains=log_meta
syntax region log_finer      start="^\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[FINER\].*\[\[$" end="\]\]$" contains=log_meta
syntax region log_finest     start="^\[\d\d\d\d-\d\d-\d\dT\d\d[:.]\d\d[:.]\d\d[.]\d\d\d[+-]\d\d\d\d\] \[[^]]\+\] \[FINEST\].*\[\[$" end="\]\]$" contains=log_meta

" highlight log_error         ctermfg=DarkRed
" highlight log_warn          ctermfg=Brown
" highlight log_progress      ctermfg=Yellow
" highlight log_info          ctermfg=Yellow
" highlight log_config        ctermfg=DarkGreen
" highlight log_fine          ctermfg=Gray
" highlight log_finer         ctermfg=Blue
" highlight log_finest        ctermfg=DarkBlue

highlight log_error         ctermfg=Red
highlight log_warn          ctermfg=DarkRed
highlight log_progress      ctermfg=Yellow
highlight log_info          ctermfg=White
highlight log_config        ctermfg=DarkGreen
highlight log_fine          ctermfg=Gray
highlight log_finer         ctermfg=Blue
highlight log_finest        ctermfg=DarkBlue

highlight log_meta          ctermfg=DarkGray
highlight log_level_rest    ctermfg=DarkGray
highlight log_level         ctermfg=White
highlight log_time          ctermfg=Blue
highlight log_rest          ctermfg=DarkGray
highlight log_gf            ctermfg=DarkGray

let b:current_syntax = "gflog"
