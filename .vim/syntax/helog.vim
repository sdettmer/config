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
syn match info4Line	/.*Inf p4.*/ contains=eevknown1,eevknown0,eevunknown,eevvarknown,eevvarknown0,eevvarunknown,eevvarknownx,eevvarunknownx
syn match sta3Line	/.*Sta p3.*/ contains=eevknown1,eevknown0,eevunknown,eevvarknown,eevvarknown0,eevvarunknown,eevvarknownx,eevvarunknownx
syn match icdLine	/.*Icd p.*/
syn match passLine	/^PASS.*/
syn match xpassLine	/^XPASS.*/
syn match failLine	/^FAIL.*/
syn match xfailLine	/^XFAIL.*/
syn match simInfo	/.*SIM Inf p4.*/
syn match header	/^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d /
syn match header	/^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d \S\+/
syn match eevknown1	/ \S\+ now KNOWN\/1/ contained
syn match eevvarknownx	/ \S\+ now KNOWN\/.*/ contained
syn match eevknown0	/ \S\+ now KNOWN\/0/ contained
syn match eevunknown	/ \S\+ now UNKNOWN\/\d/ contained
syn match eevvarknown	/ \S\+:New Value KNOWN\/.*/ contained
syn match eevvarknown0	/ \S\+:New Value KNOWN\/0/ contained
syn match eevvarunknown	/ \S\+:New Value UNKNOWN\/.*/ contained
syn match eevvarunknownx	/ \S\+ now UNKNOWN\/.*/ contained

if !exists("did_helog_syntax_inits")
  let did_helog_syntax_inits = 1
  hi debugLine	ctermfg=darkblue	guifg=darkblue
  hi warnLine	ctermfg=yellow		guifg=yellow
  hi errLine	ctermfg=red		guifg=red
  hi infoLine	ctermfg=green		guifg=green
  hi info2Line	ctermfg=darkgreen	guifg=darkgreen
  hi info4Line	ctermfg=darkgray	guifg=darkgray
  hi sta3Line	ctermfg=darkmagenta	guifg=darkmagenta
  hi icdLine	ctermfg=blue		guifg=blue
  hi header	ctermfg=darkblue	guifg=darkblue
  hi passLine	ctermfg=green		guifg=green
  hi xpassLine	ctermfg=red		guifg=red
  hi failLine	ctermfg=red		guifg=red
  hi xfailLine	ctermfg=yellow		guifg=yellow
  hi simInfo	ctermfg=cyan		guifg=cyan
  hi eevknown1	ctermfg=darkgreen	guifg=darkgreen
  hi eevknown0	ctermfg=darkyellow	guifg=darkyellow
  hi eevunknown	ctermfg=darkred		guifg=darkred
  hi link eevvarknown eevknown1
  hi link eevvarknown0 eevknown0
  hi link eevvarunknown eevunknown
  hi link eevvarknownx eevknown1
  hi link eevvarunknownx eevunknown
endif

let b:current_syntax="helog"
