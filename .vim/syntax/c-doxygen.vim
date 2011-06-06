"
" FILE: c-doxygen.vim
"
" ABSTRACT:
"
" AUTHOR: Ralf Schandl <schandl@de.ibm.com>
"   
" $Id: c-doxygen.vim,v 1.1 2000/12/27 12:01:25 rks Exp $
"   
" =============================================================================
"

syn match	cDoxygen    contained /[^\\]\\[^\\ ]\S*/hs=s+1 contains=cTodo

syn match	cTodo		contained /\(TODO\)\|\(FIXME\)\|\(XXX\)\|\(\\todo\)/
highlight link cDoxygen  PreProc

syn cluster	cCommentGroup	contains=cTodo,cDoxygen

"    vim:tw=75 et ts=4 sw=4 sr ai comments=\:\" formatoptions=croq 
"
"---------[ END OF FILE c-doxygen.vim ]----------------------------------------
