" Vim syntax file
" Language:	helog file
" Maintainer:	Patrick Lorenz <patrick.lorenz@de.transport.bombardier.com>
" Remark: Simply highlight lines depending on the log-level

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match debugLine	/.*Deb p5.*/
syn match warnLine	/.*Wrn p1.*/
syn match errLine	/.*Err p0.*/
syn match infoLine	/.*Inf p0.*/
syn match info2Line	/.*Inf p2.*/
syn match info4Line	/.*Inf p4.*/
syn match icdLine	/.*Icd p.*/
syn match header	/^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d \S\+/ nextgroup=debugLine,warnLine,errLine,infoLine,info2Line,info4Line,icdLine

if !exists("did_helog_syntax_inits")
  let did_helog_syntax_inits = 1
  hi debugLine	ctermfg=darkblue	guifg=darkblue
  hi warnLine	ctermfg=yellow		guifg=yellow
  hi errLine	ctermfg=red		guifg=red
  hi infoLine	ctermfg=green		guifg=green
  hi info2Line	ctermfg=darkgreen	guifg=darkgreen
  hi info4Line	ctermfg=darkgray	guifg=darkgray
  hi icdLine	ctermfg=blue		guifg=blue
  hi header	ctermfg=darkblue	guifg=darkblue
endif

let b:current_syntax="helog"
