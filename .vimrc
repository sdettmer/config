version 5.3
" This should be "version 5.4" now - but some people source my vimrc
" here and they'd get errors if I upgraded my vimrc to that.  :-/
" Oldest version I currently have to test is 6.1, but I don't see a
" difference when setting the version here
" ==================================================================
" File:         $HOME/.vimrc.forall  (sourced by ~USER/.vimrc)
" Last update from Sven:  Thu Jul 01 20:00:00 MET DST 1999
" master branch
" Linux version

  set noexpandtab

"       autoindent:  "off" as I usually do not write code.
" set noautoindent
  set autoindent
  set smartindent
  set nocindent
"       autoread: When a file has been detected to have been changed
"       outside of Vim and it has not been changed inside of Vim,
"       automatically read it again.
"       *.utf8 is an exception, because I only use this as Its All Text
"       Firefox Plug-In interchange file and here I don't want to
"       lose undo history because of accidentally page reload in other tab
"       Note: Firefox edit-undo history is kept in first tab.
if v:version >= 600
  set autoread
endif
"
"       autowrite: Automatically save modifications to files
"       when you use critical (rxternal) commands.
  set   autowrite
"
"       backup:  backups are for wimps  ;-)
  set nobackup
"
"       backspace:  '2' is much smarter. -> "help backspace"
  set   backspace=2
"
"       background:  Are we using a "light" or "dark" background?
" set   background=dark
"
"       compatible:  Let Vim behave like Vi?  Hell, no!
  set nocompatible
"
"       comments default: sr:/*,mb:*,el:*/,://,b:#,:%,:XCOMM,n:>,fb:-
  " set   comments=sr:/*,mb:*,el:*/,b:#,:%,fb:-,n:>,n:)
  set   comments=sr:/*,mb:*,el:*/,://,b:#,:%,fb:-,n:>,b:--
"
"       cpoptions you should get to know - source of many FAQs!  ;-)
"       cpoptions:  "compatible options" to match Vi behaviour
" set   cpoptions="aABceFs"   "default!
"       FAQ:  Do NOT include the flag '<' if you WANT angle notation!
"
"       dictionary: english words first
  set   dictionary=/usr/dict/words,/local/lib/german.words
"
"       digraph:    required for those umlauts
"  set   digraph
"
"       errorbells: damn this beep!  ;-)
"  set noerrorbells

"       esckeys:    allow usage of cursor keys within insert mode
  set   esckeys


"       foldlevelstart: sets 'foldlevel' when starting to edit another
"       buffer in a window. Useful to always start editing with all folds
"       closed (value zero), some folds closed (one) or no folds closed (99).
if v:version >= 600
    set foldlevelstart=99
endif
"
"       formatoptions:  Options for the "text format" command ("gq")
"                       I need all those options (but 'o')!
" steffen tries "o"
  set   formatoptions=cqrot
"
"       helpheight: zero disables this.
  set   helpheight=0

"       hidden:
  set   hidden
"
"       highlight=8b,db,es,hs,mb,Mn,nu,rs,sr,tb,vr,ws
  set   highlight=8r,db,es,hs,mb,Mr,nu,rs,sr,tb,vr,ws
"
"       hlsearch :  highlight search - show the current search pattern
"       This is a nice feature sometimes - but it sure can get in the
"       way sometimes when you edit.
  set nohlsearch
"
"       icon:       ...
  set noicon
"
" set   iconstring  file of icon (Sven doesn't use an icon)
" set   iconstring
"
  set noignorecase

  set noinsertmode
"
"
"       iskeyword:
"       iskeyword=@,48-57,_,192-255   (default)
" Add the dash ('-'), the dot ('.'), and the '@' as "letters" to "words".
" This makes it possible to expand email addresses, eg
" guckes-www@vim.org
"  set   iskeyword=@,48-57,_,192-255,-,.,@-@
"
"       joinspaces:
"       insert two spaces after a period with every joining of lines.
"       I like this as it makes reading texts easier (for me, at least).
"  set   joinspaces
"
"       keywordprg:  Program to use for the "K" command.
" set   keywordprg=man\ -s
"
"       laststatus:  show status line?  Yes, always!
"       laststatus:  Even for only one buffer.
  set   laststatus=2
" Status line
"set statusline=%t      "tail of the filename
set statusline=%f       "path, rel. or as typed
set statusline+=\ %h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%{Show_Status()} " my status stuff (paste, ",sc")
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%-.2{&ff}] "file format
set statusline+=%-.2{strpart(&ff,0,1)}] "file format first letter
set statusline+=%y      "filetype
" Show in which C function we are
"   http://vim.wikia.com/wiki/VimTip1454
set statusline+=\ %{WhatFunction()}
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ b%n,    "buffer number
set statusline+=\ %P    "percent through file
"
" [VIM5]lazyredraw:  do not update screen while executing macros
  set   lazyredraw
"
"       listchars: Great new feature of vim-5.3 (vim-5.2c actually)!
"       This tells Vim which characters to show for expanded TABs,
"       trailing whitespace, and end-of-lines.  VERY useful!!
" set   list
" set   listchars=tab:>-,trail:·,eol:$
"       The '$' at the end of lines is a bit too much, though.
"       And I quite like the character that shows a dot in the middle:
" set   listchars=tab:>·,trail:·
"       Some people might prefer a double right angle (>>)
"       to show the start of expanded tabs, though:
" set   listchars=tab:»·,trail:·
"       However, this all breaks up when viewing high-bit characters
"       through some brain-dead telnet program (there are many).
"set listchars=eol:$
set list
"set listchars=trail:·,tab:»·
set listchars=trail:·,tab:»·
"
"       magic:  Use 'magic' patterns  (extended regular expressions)
"       in search patterns?  Certainly!  (I just *love* "\s\+"!)
  set   magic
"
"       modeline:    ...
"       Allow the last line to be a modeline - useful when
"       the last line in sig gives the preferred textwidth for replies.
  set   modeline
  set   modelines=10
"
"       number:      ...
  set nonumber
"
"       path:   The list of directories to search when you specify
"               a file with an edit command.
"               Note:  "~/.P" is a symlink to my dir with www pages
"               "$VIM/syntax" is where the syntax files are.
"  set   path=.,,~/.P/vim,~/.P/vim/syntax,~/.P/vim/source,$VIM/syntax/
" set   path=.,,~/.P/vim,~/.P/mutt/,~/.P/elm,~/.P/slrn/,~/.P/nn
"
  set path+=*/src,build/$HOSTNAME/*/src

" Tags (use default)
"   generate with e.g. "ctags -eR --c-kinds=+px .".

"       report: show a report when N lines were changed.
"               report=0 thus means "show all changes"!
  set   report=0
"
"       ruler:       show cursor position?  Yep!
  set   ruler
"
" Setting the "shell" is always tricky - especially when you are
" trying to use the same vimrc on different operatin systems.
"       shell for DOS
" set   shell=command.com
"       shell for UNIX -  math.fu-berlin.de BSD
" set   shell=zsh
"       shell for UNIX -   inf.fu-berlin.de BSD&Solaris
" set   shell=zsh
"       shell for UNIX - zedat.fu-berlin.de BSD&Solaris
" set   shell=/bin/tcsh
" Now that vim-5 has ":if" I am trying to automate the setting:
"
"  if has("dos16") || has("dos32")
"  let shell='command.com'
"  endif
" The zsh is now available at zedat.fu-berlin.de!  :-)
" start the zsh as a login shell:
"  if has("unix")
"  let &shell="zsh\ -l"
"  endif
"
"       shiftwidth:  Number of spaces to use for each
"                    insertion of (auto)indent.
  set   shiftwidth=8
"
"       shortmess:   Kind of messages to show.   Abbreviate them all!
"          New since vim-5.0v: flag 'I' to suppress "intro message".
  set   shortmess=at
"
"       showcmd:     Show current uncompleted command?  Absolutely!
  set   showcmd
"
"       showmatch:   Show the matching bracket for the last ')'?
  set   showmatch
"
"       showmode:    Show the current mode?  YEEEEEEEEESSSSSSSSSSS!
  set   showmode
"
"       suffixes:    Ignore filename with any of these suffixes
"                    when using the ":edit" command.
"                    Most of these are files created by LaTeX.
  set   suffixes=.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar
"
"       startofline:  no:  do not jump to first character with page
"       commands, ie keep the cursor in the current column.
  set nostartofline
"
"       tabstop
  set   tabstop=8

" Set the colors for vim on "xterm"
"  if &term=="xterm"
"  set t_Co=8
"  set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
"  set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
"  endif

" If ALL our xterms have 256 colors, we can enable them.
" This actually is a workaround, because xterms and putty have 256 colors,
"   but do not set "TERM=xterm-256color" (which does not work with mutt)
if &term=="xterm"
  set t_Co=256
endif

" Change color defaults for dark-background xterm
" Search is used in "copen". Default is Brightwhite-on-yellow?!
"   Set black(0) on yellow (3)
highlight Search term=standout ctermfg=0 ctermbg=3
" Spell checking (hint: set spell spelllang=en, correct "z=")
"   See also nmap ,sc
if v:version >= 700
hi SpellBad       term=reverse ctermbg=88 gui=undercurl guisp=Red
hi SpellCap       term=reverse ctermbg=81 gui=undercurl guisp=Blue
hi SpellRare      term=reverse ctermbg=225 gui=undercurl guisp=Magenta
endif

"       textmode:    no - I am using Vim on UNIX!
  set notextmode
"
"       textwidth
"  set   textwidth=65
"  NOW in au BufEnter *
"
"       title:
  set notitle
"
"       ttyfast:     are we using a fast terminal?
"                    seting depends on where I use Vim...
  set nottyfast
"
"       ttybuiltin:
  set nottybuiltin
"
"       ttyscroll:      turn off scrolling -> faster!
"  set   ttyscroll=0
"
"       ttytype:
" set   ttytype=rxvt
"
"       viminfo:  What info to store from an editing session
"                 in the viminfo file;  can be used at next session.
  set   viminfo=%,'50,\"100,:100,n~/.viminfo
"
"       visualbell:
"  set   visualbell
"
"       t_vb:  terminal's visual bell - turned off to make Vim quiet!
"       Please use this as to not annoy cow-orkers in the same room.
"       Thank you  :-)
" set   t_vb=
"
"       whichwrap:
  set   whichwrap=<,>
"
"       wildchar  the char used for "expansion" on the command line
"                 default value is "<C-E>" but I prefer the tab key:
  set   wildchar=<TAB>
"
"       wrapmargin:
  set   wrapmargin=1
"
"       writebackup:
  set nowritebackup

" needing more entries than the default of 20
  set history=2000
"
"     Yruler : A ruler.
  iab Yruler 1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
"
  iab  Ydel  [...]
  vmap ,del c [...] <ESC>

  vmap ,fig !figlet -k -d /usr/lib/figlet22/fonts -f mini
"
" Correcting those typos. [I almost never get these right.  :-(]
" See also:  http://www.igd.fhg.de/~zach/programs/acl/
" Often used filenames - only needed these on the command line:
" see also:  http://www.math.fu-berlin.de/~guckes/setup/
"
  cab Vrc  ~/.vimrc
  cab SIGS ~/Mail/signatures
"
" A list of filenames that are needed to shorten some autocommands:
" cab MAILNEWSFILES .article,.followup,.letter,mutt*[0-9],/postpone/*
" cab MAILNEWSFILES *.article,*.followup,*.letter,*mutt*
  let MAILNEWSFILES = "*.article,*.followup,*.letter,mutt*"

  ab MYADDR "Steffen Dettmer" <steffen@dett.de>
  ab MYADDRI "Steffen Dettmer" <Steffen.DETTMER@ingenico.com>
  ab MYADDRN "Steffen Dettmer" <steffen.dettmer@nomadrail.com>
  ab Yoki   oki,<CR><CR>Steffen
  ab Schönes Wochenende! Schönes Wochenende!

"  ab Ywitzederwoche Bcc: Steffen Dettmer <sdettmer@ingenico.de>, susi, <CR>        Tanja Wehrmann <tanjawehrmann@gmx.de>,<CR>        Daddy <comp-dettmer@t-online.de>, <CR>        Frank Schwemer <face@face-works.de>, <CR>        gordok_t, <CR>        Gordon Lange <gordon_lange@yahoo.de>, <CR>        Elke und Fritz Richter <E.F.Richter@t-online.de>, <CR>        Mark Ruth <MarkRuth@web.de>, <CR>        Rayk Papenbrock <raykpapenbrock@gmx.de>, manfred

  "Witze der Woche
  "Formats the mail completly. "\r" is CR (unix LF)
"  map ,wdw majd/-------<CR>jjd4djd/3. Neue Witze<CR>d5d/Sie können diese Witze bewerten<CR>d/----- End forwarded message<CR>dd:1/^Bcc: <CR>CYwitzederwoche<ESC>?^Bcc:<CR>J/^Subject:<CR>/------<CR>jjjgq/^oki,<CR>kmb'ajCYline2<ESC>jj^CYline1<ESC>jj:,'bs/^$/\r--------------------------------------------------------->8======\r/g<CR>'a

  ab Yline1 ------------------------------------------------------------------->8=======
  ab Yline2 =======8<-------------------------------------------------------------------
"                                                                 O
"                                                              \ /
"---------------------------------------------------------------X-----=======
"                                                              / \
"                                                                 O


" Abbreviations - General Editing - Inserting Dates and Times
" ===================================================================
"
" First, some command to add date stamps (with and without time).
" I use these manually after a substantial change to a webpage.
" [These abbreviations are used with the mapping for ",L".]
"
  iab Ydate <C-R>=strftime("%y%m%d")<CR>
" Example: 971027
"
  iab Ytime <C-R>=strftime("%H:%M")<CR>
" Example: 14:28
"
  iab YDT   <C-R>=strftime("%y%m%d %T")<CR>
" Example: 971027 12:00:00
"
  iab YDATE <C-R>=strftime("%a %b %d %T %Z %Y")<CR>
" Example: Tue Dec 16 12:07:00 CET 1997
"
" On Windows the functions "strftime" seems to have a different
" format.  Therefore the following may be necessary:  [980730]
" if !has("unix")
" iab YDATE <C-R>=strftime("%c %a")<CR>
" else
" iab YDATE <C-R>=strftime("%D %T %a")<CR>
" endif
"
" ===================================================================
" MAPpings
" ===================================================================
" Caveat:  Mapping must be "prefix free", ie no mapping must be the
" prefix of any other mapping.  Example:  "map ,abc foo" and
" "map ,abcd bar" will give you the error message "Ambigous mapping".
"
" The backslash ('\') is the only(?) unmapped key, so this is the best
" key to start mappings with as this does not take away a command key.
" However, the backslash is never in the same position with keyboards.
" Eg on German keyboards it is AltGr-sz - don't ask.
" Anyway, I have decided to start mappings with the comma as this
" character is always on the same position on almost all keyboards
" and I hardly have a need for that command.
"
" The following maps get rid of some basic problems:
"
" When the backspace key sends a "delete" character
" then you simply map the "delete" to a "backspace" (CTRL-H):
"  map <Del> <C-H>
"
" With Vim-4 the format command was just 'Q' and
" I am too used to it.  So I need this back!
  nnoremap Q gq
  vnoremap Q gq
"
" 980527 I often reformat a paragraph to fit some textwidth -
" and I use the following mapping to adjust it to the
" current position of the cursor:
  map #tw :set textwidth=<C-R>=col(".")<C-M>
"
" 981210 Whenever I paste some text into VIM I have to
" toggle from "nopaste" to "paste" and back again:
" map <f4>   :set paste!<c-m>:set paste?<c-m>
"  map <esc>[14~ :set paste!<c-m>:set paste?<c-m>
"
" "tal" is the "trailer alignment" filter program
" Hopefully it will ship with Vim one day.
" vmap #t !tal<CR>
" vmap #t !tal -p 0<CR>
"
" Disable the command 'K' (keyword lookup) by mapping it
" to an "empty command".  (thanks, Lawrence! :-):
" map K :<CR>
" map K :<BS>
" More elegant:  (Hi Aziz! :-)
" map K <NUL>
"
" Disable the suspend for ^Z.
" I use Vim under "screen" where a suspend would lose the
" connection to the " terminal - which is what I want to avoid.
" map <C-Z> :shell
"
" Make CTRL-^ rebound to the *column* in the previous file
  noremap <C-^> <C-^>`"
"
" Make "gf" rebound to last cursor position (line *and* column)
  noremap gf gf`"
"
" When I let Vim write the current buffer I frequently mistype the
" command ":w" as ":W" - so I have to remap it to correct this typo:
  nmap :W :w
" TODO:  Use the following (after some testing):
" command -nargs=? -bang W w<bang> <args>
"
" Are you used to the Unix commands "alias" and "which"?
" I sometimes use these to look up my abbreviations and mappings.
" So I need them available on the command line:
  map :alias map
  map :which map
"
" The command {number}CTRL-G show the current nuffer number, too.
" This is yet another feature that vi does not have.
" As I always want to see the buffer number I map it to CTRL-G.
" Pleae note that here we need to prevent a loop in the mapping by
" using the comamnd "noremap"!
  noremap <C-G> 2<C-G>
"
" 980311  Sourcing syntax files
" My personal syntax files are in ~/.P/vim/syntax/
" and I need a quick way to edit and source them.
  map ,SO :so ~/.P/vim/syntax/
"
" 980706  Sourcing syntax files from the distribution
" A nice and fast way to both source syntax files
" and to take a look at "what's there":
  map ,V  :so $VIM/syntax/
"
" 990614  Quick insertion of an empty line:
" nmap <CR> o<ESC>
" I find this convenient - but as I am also used to proceed to
" next line by pressing CR this often gives me new empty lines
" when I really do not need them.  :-(
"
" ===================================================================
" Customizing the command line
" ===================================================================
" Valid names for keys are:  <Up> <Down> <Left> <Right> <Home> <End>
" <S-Left> <S-Right> <S-Up> <PageUp> <S-Down> <PageDown>  <LeftMouse>
"
" Many shells allow editing in "Emacs Style".
" Although I love Vi, I am quite used to this kind of editing now.
" So here it is - command line editing commands in emacs style:
  cnoremap <C-A> <Home>
  cnoremap <C-F> <Right>
  cnoremap <C-B> <Left>
  cnoremap <C-E> <End>
  cnoremap <ESC>b <S-Left>
  cnoremap <ESC>f <S-Right>
  cnoremap <ESC><C-H> <C-W>
"
" Additional codes for that "English" keyboard at the Xterminal
  cnoremap <ESC>[D <Left>
  cnoremap <ESC>[C <Right>
"
" ===================================================================
" VIM - Editing and updating the vimrc:
" As I often make changes to this file I use these commands
" to start editing it and also update it:
  if has("unix")
    let vimrc='~/.vimrc'
  else
" ie:  if has("dos16") || has("dos32") || has("win32")
    let vimrc='$VIM\_vimrc'
  endif
  nn  ,u :source <C-R>=vimrc<CR><CR>
  nn  ,v :edit   <C-R>=vimrc<CR><CR>
"     ,v = vimrc editing (edit this file)
" map ,v :e ~/.vimrc<CR>
"     ,u = "update" by reading this file
" map ,u :source ~/.vimrc<CR>
" ===================================================================
"
" General Editing
"
" Define "del" char to be the same backspace (saves a LOT of trouble!)
" As the angle notation cannot be use with the LeftHandSide
" with mappings you must type this in *literally*!
" map <C-V>127 <C-H>
"cmap <C-V>127 <C-H>
" the same for Linux Debian which uses
" imap <Esc>[3~ <C-H>
" imap        <C-H>
" cmap        <C-H>
"
"      ;rcm = remove "control-m"s - for those mails sent from DOS:
"  cmap ;rcm %s/<C-M>//g
"
"     Make whitespace visible:
"     Sws = show whitespace
  nmap ,Sws :%s/ /_/g<C-M>
  vmap ,Sws :%s/ /_/g<C-M>
"
"     Sometimes you just want to *see* that trailing whitespace:
"     Stws = show trailing whitespace
  nmap ,Stws :%s/  *$/_/g<C-M>
  vmap ,Stws :%s/  *$/_/g<C-M>
" kill trailing whitespace
fun! KtwsAuto()
  if exists("b:std_nomad") && b:std_nomad
  else
    call Ktws()
  endif
endfun
fun! Ktws()
  let x=line(".")
  let y=col(".")
  "silent %s/ \+$//eg
  %s/ \+$//eg
  call cursor(x,y)
endfun
  nmap ,ktws :call Ktws()<C-M>
  vmap ,ktws :call Ktws()<C-M>
"
" General Editing - Turning umlauts into ascii (for German keyboards)
"
" imap ä ae
" imap ö oe
" imap ü ue
" imap ß ss
"
" &#196; -> Ä  :%s/\&#196;/Ä/gc  -> D
" &#214; -> Ö  :%s/\&#214;/Ö/gc  -> V
" &#220; -> Ü  :%s/\&#220;/Ü/gc  -> \
" &#228; -> ä  :%s/\&#228;/ä/gc  -> d
" &#246; -> ö  :%s/\&#246;/ö/gc  -> v
" &#252; -> ü  :%s/\&#252;/ü/gc  -> |
"
" ===================================================================
" Inserting Dates and Times / Updating Date+Time Stamps
" ===================================================================
"     ,L  = "Last updated" - replace old time stamp with a new one
"        preserving whitespace and using internal "strftime" command:
"       requires the abbreviation  "YDATE"
  map ,L  1G/Last update:\s*/e+1<CR>CYDATE<ESC>
  map ,,L 1G/Last change:\s*/e+1<CR>CYDATE<ESC>
" Example:
" before:  "Last update:   Thu Apr  6 12:07:00 CET 1967"
" after:   "Last update:   Tue Dec 16 12:07:00 CET 1997"
"
"     ,L  = "Last updated" - replace old time stamp with a new one
"        using external "date" command (not good for all systems):
" map ,L 1G/Last update: */e+1<CR>D:r!date<CR>kJ
"
" ===================================================================
" General Editing - link to program "screen"
" ===================================================================
"
"       ,Et = edit temporary file of "screen" program
  map   ,Et :e /tmp/screen-exchange
"       as a user of Unix systems you *must* have this program!
"       see also:  http://www.math.fu-berlin.de/~guckes/screen/
"
" Email/News - Editing replies/followups
"
" Part 1 - prepare for editing
"
" Part 2 - getting rid of empty (quoted) lines and space runs.
"
"      ,cel = "clear empty lines"
"       - delete the *contents* of all lines which contain only whitespace.
"         note:  this does not delete lines!
" map ,cel :g/^[<C-I> ]*$/d
  map ,cel :%s/^\s\+$//
"      ,del = "delete 'empty' lines"
"       - delete all lines which contain only whitespace
"         note:  this does *not* delete empty lines!
"  map ,del :g/^\s\+$/d
"
"      ,cqel = "clear quoted empty lines"
"       Clears (makes empty) all lines which start with '>'
"       and any amount of following spaces.
" nmap ,cqel :%s/^[> ]*$//
" vmap ,cqel  :s/^[> ]*$//
" nmap ,cqel :%s/^[><C-I> ]\+$//
" vmap ,cqel  :s/^[><C-I> ]\+$//
  nmap ,cqel :%s/^[>]\+$//
  vmap ,cqel  :s/^[><C-I> ]\+$//
" NOTE: If the meta sequence "\s"
" The following do not work as "\s" is not a character
" and thus cannot be part of a "character set".
"  map ,cqel  :g/^[>\s]\+$/d

" Figlet playing
  vmap ,fig !figlet -k -d /usr/lib/figlet22/fonts -f mini
"
" Some people have strange habits within their writing.
" But if you cannot educate them - rewrite their text!  ;-)
"
" Jason "triple-dots" King elephant@onaustralia.com.au
" does uses ".." or "..." rather than the usual punctuation
" (comma, semicolon, colon, full stop). So...
"
" Turning dot runs with following spaces into an end-of-sentence,
" ie dot-space-space:
  vmap ,dot :s/\.\+ \+/.  /g
"
" Gary Kline (kline@tera.tera.com) indents his
" own text in replies with TAB or spaces.
" Here's how to get rid of these indentation:
  vmap ,gary :s/^>[ <C-I>]\+\([^>]\)/> \1/
"
"      ,ksr = "kill space runs"
"             substitutes runs of two or more space to a single space:
" nmap ,ksr :%s/  */ /g
" vmap ,ksr  :s/  */ /g
  nmap ,ksr :%s/  \+/ /g
  vmap ,ksr  :s/  \+/ /g
" Why can't the removal of space runs be
" an option of "text formatting"? *hrmpf*
"
"    ,Sel = "squeeze empty lines"
"    Convert blocks of empty lines (not even whitespace included)
"    into *one* empty line (within current visual):
   map ,Sel :g/^$/,/./-j
"
"    ,Sbl = "squeeze blank lines"
"    Convert all blocks of blank lines (containing whitespace only)
"    into *one* empty line (within current visual):
"  map ,Sbl :g/^\s*$/,/[^ <c-i>]/-j
"  map ,Sbl :g/^\s*$/,/[^ \t]/-j
   map ,Sbl :g/^\s*$/,/\S/-j
"
" ===================================================================
" Editing of email replies and Usenet followups - using autocommands
" ===================================================================
"
" Remove ALL auto-commands.  This avoids having the
" autocommands twice when the vimrc file is sourced again.
"   (for search au! )
  autocmd!
"
" au Buf* are executed in order of definition in file, followed
"   by file mode line. So file defaults first:
au BufNewFile,BufRead *           call BufferDefaults()
fun! BufferDefaults()
  setl tw=65 noet ts=8 sts=0
  call Enable_overlen_hi()
endfun
" Let Vim identify itself when editing emails with Mutt:
" au! BufNewFile,BufRead mutt* let @"="X-Editor: Vim-".version." http://www.vim.org/\n"|exe 'norm 1G}""P'
"au! BufNewFile,BufRead mutt* let @"="X-Editor: Vim-".version." http://www.vim.org/\n"|exe 'norm 1G}""P'
"
" reply address setting
map ,rpl :%!~/work/ID-Mail/hashmail/set_reply.pl<CR>
map ,rplc :if confirm("set auto reply?", "&yes\n&no", 2) == 1<CR>:normal ,rpl<CR>:endif<CR>

" set the textwidth to 65 characters for replies (email&usenet)
  au BufNewFile,BufRead .letter,mutt*,nn.*,snd.* setl tw=65
"  au BufNewFile,BufRead .letter,mutt*,nn.*,snd.* :normal ,rplc
  au BufNewFile,BufRead ,bash-fc-*,/tmp/cvs* call Enable_paste()
  au BufNewFile,BufRead *.git/COMMIT_EDITMSG call Enable_paste()
  fun! NadineMod()
    %s/n.woitziske@beratung-sk.de/NadineWoitziske@aol.com/igce
  endfun
  au BufNewFile,BufRead  .letter,mutt*,nn.*,snd.* call NadineMod()
"
" Some more autocommand examples which set the values for
" "autoindent", "expandtab", "shiftwidth", "tabstop", and "textwidth":
au BufNewFile,BufRead *.[ch]      setl ai et sw=3 ts=3
au BufNewFile,BufRead *.cc        setl ai et sw=4 ts=4
au BufNewFile,BufRead *.java      setl ai et sw=4 ts=4
au BufNewFile,BufRead *.idl       setl ai et sw=4 ts=4
au BufNewFile,BufRead *.pl,*.rb,*.hs setl ai et sw=4 ts=4
au BufNewFile,BufRead .vimrc      setl ai et sw=4 ts=4
au BufNewFile,BufRead *.html      setl ai et sw=2 ts=2
au BufNewFile,BufRead *.shtml     setl ai et sw=2 ts=2
au BufNewFile,BufRead *.rb        setl ai et sw=2 ts=2
au BufNewFile,BufRead *.erb       setl ai et sw=2 ts=2
au BufNewFile,BufRead confspec.prepare  setl tw=0 sts=0
au BufNewFile,BufRead configure.{in,ac} setl tw=0 sts=0
" I used .utf8 to communicate with Browser plugin
"   (mozex, ItsAllText or similar) and do not want to lose my
"   changes if browser behaves oddly, so no autoread here
if v:version >= 600
  au BufNewFile,BufRead *.utf8    setlocal noautoread
endif
au BufNewFile,BufRead /nomad*src*     call NomadSrcMode()
au BufNewFile,BufRead /nomad*ini  setf nomadini
au BufNewFile,BufRead /nomad*log  setf nomadlog
au BufNewFile,BufRead Makefile*   setl tw=0 noet nolist ts=8 sts=0
au BufNewFile,BufRead *.utf8      setl fileencoding=utf8
augroup filetypedetect
  au! BufRead,BufNewFile *.sce setfiletype scilab
augroup END

au BufWrite *.[ch]      call KtwsAuto()
au BufWrite *.cc        call KtwsAuto()
au BufWrite *.java      call KtwsAuto()
au BufWrite *.idl       call KtwsAuto()
au BufWrite *.rb        call KtwsAuto()
au BufWrite *.erb       call KtwsAuto()

" au BufEnter *.java      set ai    sw=4 ts=4
" au BufEnter */drafts/*  set tw=72

" Extra syntax - GIT from vim-7.3 (also needs the syntax files)
" Git
autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG setf gitcommit
autocmd BufNewFile,BufRead *.git/config,.gitconfig,.gitmodules setf gitconfig
autocmd BufNewFile,BufRead git-rebase-todo      setf gitrebase
autocmd BufNewFile,BufRead .msg.[0-9]*
      \ if getline(1) =~ '^From.*# This line is ignored.$' |
      \   setf gitsendemail |
      \ endif
autocmd BufNewFile,BufRead *.git/**
      \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
      \   setf git |
      \ endif

" automatically re-source saved vimrc
autocmd BufWritePost ~/.vimrc   so ~/.vimrc

" Examples used by talg@CS.Berkeley.edu - thanks!
"
" Try to use the mapping ",D" when doing a followup.
" autocmd BufNewFile ~/.followup ,D|
"
" Part 3 - Change Quoting Level
"
"      ,dp = de-quote current inner paragraph
"  map ,dp {jma}kmb:'a,'bs/^> //<CR>
   map ,dp vip:s/^> //<CR>
  vmap ,dp    :s/^> //<CR>
"
"      ,qp = quote current paragraph
"            jump to first inner line, mark with 'a';
"            jump to last  inner line, mark with 'b';
"            then do the quoting as a substitution
"            on the line range "'a,'b":
"  map ,qp {jma}kmb:'a,'bs/^/> /<CR>
"      vim-5 now has selection of "inner" and "all"
"      of current text object - mapping commented!
"
"      ,qp = quote current paragraph (old version)
"            jump to first inner line, Visual,
"            jump to last  inner line,
"            then do the quoting as a substitution:
"  map ,qp {jV}k:s/^/> /<CR>
"
"      ,qp = quote current inner paragraph (works since vim-5.0q)
"            select inner paragraph
"            then do the quoting as a substitution:
   map ,qp   vip:s/^/> /<CR>
"
"      ,qp = quote current paragraph
"            just do the quoting as a substitution:
  vmap ,qp    :s/^/> /<CR>
"
"       ## = comment current inner paragraph with '#':
  nmap  ##   vip:s/^/#/<CR>
  vmap  ##      :s/^/#/<CR>
"
" Changing quote style to *the* true quote prefix string "> ":
"
"       Fix Supercite aka PowerQuote (Hi, Andi! :-):
"       before ,kpq:    >   Sven> text
"       after  ,kpq:    > > text
"      ,kpq kill power quote
  vmap ,kpq :s/^> *[a-zA-Z]*>/> >/<C-M>
"
"       Fix various other quote characters:
"      ,fq "fix quoting"
  vmap ,fq :s/^> \([-":}\|][ <C-I>]\)/> > /
"
" Part 4 - Weed Headers of quoted mail/post
"
" These mappings make use of the abbreviation that define a list of
" Email headers (HEMAIL) and News headers (HNEWS):
  nmap ,we vip:v/HEMAIL/d
  vmap ,we    :v/HEMAIL/d
  nmap ,wp vip:v/HNEWS/d
  vmap ,wp    :v/HNEWS/d
"
" Old versions for vim-4.6:
"      ,we = "weed email header"
" nmap ,we !ipegrep "^(Date:\|From \|From:\|Subject:\|To:\|$)"
" vmap ,we   !egrep "^(Date:\|From \|From:\|Subject:\|To:\|$)"
"      ,wp = "weed post header"
" nmap ,wp !ipegrep "^(Date:\|From:\|Subject:\|Newsgroups:\|Followup-To:\|Keywords:\|References:\|Message-ID\|$)"
" vmap ,wp   !egrep "^(Date:\|From:\|Subject:\|Newsgroups:\|Followup-To:\|Keywords:\|References:\|Message-ID\|$)"
"
"      ,ri = "Read in" basic lines from the email header
"            Useful when replying to an email:
" nmap ,ri :r!readmsg\|egrep "^From:\|^Subject:\|^Date:\|^To: \|^Cc:"
"            NOTE: "readmsg" ships with the mailer ELM.
"
"
" Part 5 - Reformatting Text
"
"  NOTE:  The following mapping require formatoptions to include 'r'
"    and "comments" to include "n:>" (ie "nested" comments with '>').
"
" Formatting the current paragraph according to
" the current 'textwidth' with ^J (control-j):
  imap <C-J> <c-o>gqap
   map <C-J> gqap
"
"      ,b = break line in commented text (to be used on a space)
" nmap ,b dwi<CR>> <ESC>
  nmap ,b r<CR>
"      ,j = join line in commented text
"           (can be used anywhere on the line)
" nmap ,j Jxx
"  nmap ,j Vjgq
"
"      ,B = break line at current position *and* join the next line
" nmap ,B i<CR>><ESC>Jxx
  nmap ,B r<CR>Vjgq
"
"      ,,, break current line at current column,
"          inserting ellipsis and "filling space":
" nmap ,,,  ,,1,,2
" nmap ,,1  a...X...<ESC>FXr<CR>lmaky$o<CC-R>"<ESC>
" nmap ,,2  :s/./ /g<C-M>3X0"yy$dd`a"yP
"
"
" ===================================================================
" Edit your reply!  (Or else!)
" ===================================================================
"
" Part 6  - Inserting Special or Standard Text
" Part 6a - The header

"    Add adresses for To: and Cc: lines
"
"     ,ca = check alias (reads in expansion of alias name)
" map ,ca :r!elmalias -f "\%v (\%n)"
"     ,Ca = check alias (reads in expansion of alias name)
" map ,Ca :r!elmalias -f "\%n <\%v>"
"
"   ,cc = "copy notice"
"   Insert a Cc line so that person will receive a "courtesy copy";
"   this tells the addressee that text is a copy of a public article.
"   This assumes that there is exactly one empty line after the first
"   paragraph and the first line of the second paragraph contains the
"   return address with a trailing colon (which is later removed).
  map ,cc 1G}jyykPICc: <ESC>$x
" map ,cc ma1G}jy/ writes<CR>'aoCc: <ESC>$p
"
"     ,mlu = make letter urgent  (by giving the "Priority: urgent")
  map ,mlu 1G}OPriority: urgent<ESC>
"
"               Fixing the From: line
"
"     ,cS = change Sven's address.
"  map ,cS 1G/^From: Sven Guckes/e+2<CR>C<Amailv><ESC>
"     Used when replying as the "guy from vim".
"
"               Fixing the Subject line
"
"    Pet peeve:  Unmeaningful Subject lines.  Change them!
"     ,cs = change Subject: line
  map ,cs 1G/^Subject: <CR>yypIX-Old-<ESC>-W
"    This command keeps the old Subject line in "X-Old-Subject:" -
"    so the recipient can still search for it and
"    you keep a copy for editing.
"
"
"     ,re : Condense multiple "Re:_" to just one "Re:":
  map ,re 1G/^Sub<CR>:s/\(Re: \)\+/Re: /<CR>
"
"     ,Re : Change "Re: Re[n]" to "Re[n+1]" in Subject lines:
  map ,Re 1G/^Subject: <C-M>:s/Re: Re\[\([0-9]\+\)\]/Re[\1]/<C-M><C-A>
"
" Put parentheses around "visual text"
"      Used when commenting out an old subject.
"      Example:
"      Subject: help
"      Subject: vim - using autoindent (Re: help)
"
"      ,) and ,( :
  vmap ,( v`<i(<ESC>`>a)<ESC>
  vmap ,) v`<i(<ESC>`>a)<ESC>
  map ,was li (was: <ESC>A)<ESC>
"
" Part 6  - Inserting Special or Standard Text
" Part 6a - Start of text - saying "hello".
"
"     ,hi = "Hi!"        (indicates first reply)
  map ,hi 1G}oHi!<CR><ESC>
"
"     ,ha = "helloagain"  (indicates reply to reply)
  map ,ha 1G}oHello, again!<CR><ESC>
"
"     ,H = "Hello, Du!"
" map ,H G/Quoting /e+1<CR>ye1G}oHallo, !<ESC>Po<ESC>
  map ,H G/^\* /e+1<CR>ye1G}oHello, !<ESC>Po<ESC>
  map ,hi G/^\* /e+1<CR>ye1G}oHi ,<ESC>Po<ESC>
  map ,Hi G/^\* /e+1<CR>ye1G}oHi !<ESC>Po<ESC>
"
"
" Part 6  - Inserting Special or Standard Text
" Part 6b - End of text - dealing with "signatures".
"
"       remove signatures
"
"     ,kqs = kill quoted sig (to remove those damn sigs for replies)
"          goto end-of-buffer, search-backwards for a quoted sigdashes
"          line, ie "^> -- $", and delete unto end-of-paragraph:
  map ,ksig G?^> -- $<CR>d}
"  map ,kqs G?^> -- $<CR>d}
" map ,kqs G?^> *-- $<CR>dG
"     ,kqs = kill quoted sig unto start of own signature:
 map ,kqs G?^> *-- $<CR>d/^-- $/<C-M>

" k2e: kill to end
  map ,k2e d/^oki,$<CR>

"
"      ,aq = "add quote"
"            Reads in a quote from my favourite quotations:
" nmap ,aq :r!agrep -d "^-- $" ~/.P/quotes/collection<ESC>b
" see http://www.math.fu-berlin.de/~guckes/quotes/collection
"
"      ,s = "sign" -
"           Read in signature file (requires manual completion):
  nmap ,s :r!agrep -d "^-- $" ~/.P/sig/SIGS<S-Left>
"
" available as http://www.math.fu-berlin.de/~guckes/sig/SIGS
"
"      ,S = signature addition of frequently used signatures
  nmap ,SE :r!agrep -d "^-- $" comp.mail.elm ~/.P/sig/SIGS<S-Left>
  nmap ,SM :r!agrep -d "^-- $" WOOF ~/.P/sig/SIGS<S-Left>
  nmap ,SV :r!agrep -d "^-- $" IMproved ~/.P/sig/SIGS<S-Left>
"
"      ,at = "add text" -
"            read in text file (requires manual completion):
"  nmap ,at :r ~/.P/txt/
"
" MUTT: Auto-kill signatures for replies
" map ,kqs G?^> *-- $<C-M>dG
" autocmd BufNewFile,BufRead .followup,.letter,mutt*,nn.*,snd.* :normal ,kqs
" autocmd BufNewFile,BufRead .followup,.letter,mutt*,nn.*,snd.* :normal ,ksig
" autocmd BufNewFile,BufRead .followup,.letter,mutt*,nn.*,snd.* :normal ,kqs
"
" At the end of editing your reply you should check your spelling
" with the spelling checker "ispell".
" These mappings are from Lawrence Clapp lclapp@iname.com:
" spellcheck the document -- skip quoted text
" nmap <F5> :w ! grep -v '^>' \| spell<CR>
" vmap <F5> :w ! grep -v '^>' \| spell<CR>
" At home under Linux it looks something more like this:
" nmap <F5> :w ! grep -v '^>' \| ispell -???<CR>
"
"  Tell the recipient that I was replying to an old email of his:
"  ab SvenR Sven  [finally takeing the time to reply to old emails]
"
" Toggles:  [todo]
"
" toggle autoindent
" toggle hlsearch
" cycle textwidth between values 60, 70, 75, 80
"
" ===================================================================
" LaTeX - LaTeX - LaTeX - LaTeX - LaTeX - LaTeX - LaTeX
" ===================================================================
" This has become quite big - so I moved it out to another file:
" http://www.math.fu-berlin.de/~guckes/vim/source/latex.vim
  let FILE="/home/robinson/emailer/guckes/.P/vim/source/latex.vim"
  if filereadable(FILE)
     let RESULT="file readable"
     exe "source " . FILE
  else
     let RESULT="file not readable"
  endif
"
" ===================================================================
" PGP - encryption and decryption
" ===================================================================
"
" encrypt
"  map ;e :%!/bin/sh -c 'pgp -feast 2>/dev/tty'
" decrypt
"  map ;d :/^-----BEG/,/^-----END/!/bin/sh -c 'pgp -f 2>/dev/tty'
" sign
"  map ;s :,$! /bin/sh -c 'pgp -fast +clear 2>/dev/tty'
"  map ;v :,/^-----END/w !pgp -m
"
" PGP - original mappings
"
"       encrypt and sign (useful for mailing to someone else)
"csh: map #1 :,$! /bin/sh -c 'pgp -feast 2>/dev/tty^V|^V|sleep 4'
" sh: map #1 :,$! pgp -feast 2>/dev/tty^V|^V|sleep 4
"
"       sign (useful for mailing to someone else)
"csh: map #2 :,$! /bin/sh -c 'pgp -fast +clear 2>/dev/tty'
" sh: map #2 :,$! pgp -fast +clear 2>/dev/tty
"
"       decrypt
"csh: map #3 :/^-----BEG/,/^-----END/!\
"             /bin/sh -c 'pgp -f 2>/dev/tty^V|^V|sleep 4'
" sh: map #3 :/^-----BEG/,/^-----END/!\
"             pgp -f 2>/dev/tty^V|^V|sleep 4
"
"       view (pages output, like more)
"csh: map #4 :,/^-----END/w !pgp -m
" sh: map #4 :,/^-----END/w !pgp -m
"
"       encrypt alone (useful for encrypting for oneself)
"csh: map #5 :,$! /bin/sh -c 'pgp -feat 2>/dev/tty^V|^V|sleep 4'
" sh: map #5 :,$! pgp -feat 2>/dev/tty^V|^V|sleep 4
"
" Elijah http://www.mathlab.sunysb.edu/~elijah/pgppub.html says :
" The significant feature is that stderr is redirected independently
" of stdout, and it is redirected to /dev/tty which is a synonym for
" the current terminal on Unix.  I don't know why the ||sleep 4
" stuff is there, but it is harmless so I left it. Since csh is such
" junk, special rules are used if you are using it (tcsh, too).
" ksh and bash should use the sh form. zsh, et al: consult your
" manual.  The #<num> format is used to map function keys. If your
" terminal does not support the requested function key, use a
" literal #<num>.  Not all of the clones correctly support this.
"
" ===================================================================
" Useful stuff.  At least these are nice examples.  :-)
" ===================================================================
"
"     ,t = transpose two characters: from aXb -> bXa
" map ,t XplxhhPl
" This macros shortened by one character by
" Preben Guldberg c928400@student.dtu.dk
" map ,t XpxphXp
" map ,t xphXpxp
"
" make space move the cursor to the right - much better than a *beep*
" nmap \  l
"
"     ,E = execute line
" map ,E 0/\$<CR>w"yy$:<C-R>y<C-A>r!<C-E>
" This command excutes a shell command from the current line and
" reads in its output into the buffer.  It assumes that the command
" starts with the fist word after the first '$' (the shell prompt
" of /bin/sh).  Try ",E" on that line, ie place the cursor on it
" and then press ",E":
" $ ls -la
" Note: The command line commands have been remapped to tcsh style!!
"
"
"      ,dr = decode/encode rot13 text
  vmap ,dr :!tr A-Za-z N-ZA-Mn-za-m

"       Use this with an external "rot13" script:
"       "    ,13 - rot13 the visual text
"       vmap ,13 :!rot13<CR>
"
" Give the URL under the cursor to Netscape
" map ,net yA:!netscape -remote "openurl <C-R>""
"
"
" ===================================================================
" Mapping of special keys - arrow keys and
" ===================================================================
" Buffer commands (split,move,delete) -
" this makes a little more easy to deal with buffers.
" (works for Linux PCs in room 030)
"  map <F4>  :split<C-M>
" toggle pasting
"  map <F3>   :set paste!<c-m>:set paste?<c-m>:set list!<c-m>:set nolist?<c-m>
"  map <F3>   :set list!<c-m>:set nolist?<c-m>:set paste!<c-m>:set paste?<c-m>
  " map <F3>    :call Toggle_overlen_hi()<c-m>:set list!<c-m>:set paste!<c-m>:set paste?<c-m>
  map <F3>    :call Toggle_paste()<CR>
  map <F4>    :cn<C-M>
  map <S-F4>  :cp<C-M>
  map <F5>    :tn<C-M>
  map <S-F5>  :tp<C-M>
  map <F6>    :bn<C-M>
  map <S-F6>  :bp<C-M>
  map <F12>   :bd<C-M>
"
" Buffer commands (split,move,delete) -
" for Mac keyboard (Performa 5200, US keyboard)
"
"  map <ESC>[19~ :split<C-M>
"  map <ESC>[20~ :bp<C-M>
"  map <ESC>[23~ :bn<C-M>
"  map <ESC>[31~ :bd<C-M>
"
" Obvious mappings
"
" map <PageUp>   <C-B>
" map <PageDown> <C-F>
"
" ===================================================================
" FAQ:  Emacs editing"
" Q: How can I stay in insert mode and move around like within Emacs?
" A: Get the following file and source it like it is done here:
" URL:  http://www.math.fu-berlin.de/~guckes/vim/source/emacs.vim
  let FILE="/home/robinson/emailer/guckes/.P/vim/source/emacs.vim"
  if filereadable(FILE)
     let RESULT="file readable"
     exe "source " . FILE
  else
     let RESULT="file not readable"
  endif
"
" Make the up and down movements move by "display/screen lines":
"      map j      gj
"      map <Down> gj
"      map k      gk
"      map <Up>   gk
"
" Normal mode - tcsh style movements [960425]
"
" nmap <C-A>  0
" nmap <C-B>  h
" nmap <C-D>  x
" nmap <C-E>  $
" nmap <C-F>  l
" nmap <ESC>b b
" nmap <ESC>f w
"
" DOS keyboard mapping for cursor keys
"
"  map <ESC>[A <Up>
"  map <ESC>[B <Down>
"  map <ESC>[C <Right>
"  map <ESC>[D <Left>
" imap <ESC>[A <Up>
" imap <ESC>[B <Down>
" imap <ESC>[C <Right>
" imap <ESC>[D <Left>
"
" DOS keyboard
" "insert"
"  map <ESC>[1~ i
"  map <ESC>[1~ <insert>
" "home"
"  map <ESC>[2~ ^
"  map <ESC>[2~ 0
"  map <ESC>[2~ <Home>
" "pgup"
"  map <ESC>[3~ <C-B>
"  map <ESC>[3~ <PageUp>
" "delete"
"  map <ESC>[4~ x
"  map <ESC>[4~ <Del>
" "end"
"  map <ESC>[5~ $
"  map <ESC>[5~ <END>
" "pgdn"
"  map <ESC>[6~ <C-F>
"  map <ESC>[6~ <PageDown>
"
" Keyboard mapping for cursor keys
" [works for SUNs in Solarium (room 030) - 970815]
"
   map <ESC>OA <Up>
   map <ESC>OB <Down>
   map <ESC>OC <Right>
   map <ESC>OD <Left>
  imap <ESC>OA <Up>
  imap <ESC>OB <Down>
  imap <ESC>OC <Right>
  imap <ESC>OD <Left>
"
" Keyboard mapping for cursor keys
" [works for XTerminals - 970818]
   map <ESC>[A <Up>
   map <ESC>[B <Down>
   map <ESC>[C <Right>
   map <ESC>[D <Left>
  imap <ESC>[A <Up>
  imap <ESC>[B <Down>
  imap <ESC>[C <Right>
  imap <ESC>[D <Left>
"
" ===================================================================
" AutoCommands
" ===================================================================
"
" Autocommands are the key to "syntax coloring".
" There's one command in your vimrc that should
" load/source the file $VIM/syntax/syntax.vim
" which contains the definition for colors and
" the autocommands that load other syntax files
" when necessary, ie when the filename matches
" a given pattern, eg "*.c" or *".html".
"
" just load the main syntax file when Vim was compiled with "+syntax"
" Note: I use xterm with black backgrounds (or reverse-video)
"       but gvim.exe with white background (if at all)
" May need set t_Co=256 or TERM=xterm-256color (or vim -T xterm-256color),
"   but mutt doesn't work well with xter-256color
" test of wrong words and rihgt words Germany das
  if has("syntax")
      " The following sources the main syntax file,
      " ie. "$VIM/syntax/syntax.vim", see ":help :syn-on":
      syntax on
      " Redefine the color for "Comment":
      highlight! Comment     term=bold    ctermfg=cyan  guifg=Blue
      " Use a dark red as background for colorcolumn
      hi! ColorColumn term=reverse ctermbg=52    guibg=LightRed
      if v:version < 700
        "No spell check in versions before 7.0, sorry
      else
        hi SpellLocal term=underline ctermbg=14 gui=undercurl guisp=DarkCyan
      endif
  endif
"
" Definition of an alternative syntax file:
" if has("syntax")
"   " Define the filename patterns for mail and news:
"   " MAILNEWSFILES... (missing, damn)
"   " Define the aucommand tow work on special files:
"     let aucommand = "au BufNewFile,BufRead ".MAILNEWSFILES
"   " execute the source command:
"     exe aucommand." source ~guckes/.P/vim/syntax/sven.vim"
"   "
" endif
"
"
" EXAMPLE: Restricting mappings to some files only:
" An autocommand does the macthign on the filenames -
" but abbreviations are not expanded within autocommands.
" Workaround:  Use "exe" for expansion:
" let aucommand = "au BufNewFile,BufRead ".MAILNEWSFILES
" exe aucommand." :map ,hi 1G}oHi!<CR><ESC>"
" exe aucommand." :map ,ha 1G}oHello, again!<CR><ESC>"
" exe aucommand." :map ,H G/Quoting /e+1<CR>ye1G}oHallo, !<ESC>Po<ESC>"
" exe aucommand." :map ,re 1G}oRe!<CR><ESC>"
"
" Automatically place the cursor onto the first line of the mail body:
" autocmd BufNewFile,BufRead MAILNEWSFILES :normal 1G}j
"
" Toggle syntax coloring on/off with "__":
" nn __ mg:if has("syntax_items")<Bar>syn clear<CR>else<Bar>syn on<CR>en<CR>`g
" Note:  It works - but the screen flashes are quite annoying.  :-/
"
"
" ===================================================================
" EXAMPLES
" ===================================================================
"
" Visualizing trailing whitespace:
" :set hls
" /\s\+$
"
" Toggling a numerical variable between two values.
" Example:  Switch the textwidth (tw) between values "70" and "80":
" map \1 :let &tw = 150 - &tw<CR>
"
" Capitalizing the previously typed word,
" returning to the previous position:
" imap CAP <ESC>mzB~`za
"
" Uppercasing the previously typed word,
" returning to the previous position:
" imap CAP <ESC>mzvBU`za
" imap CAP <ESC>mzBvaWU`za
"
" ===================================================================
" TEMPORARY STUFF - TESTING THINGS
" ===================================================================
"
"   View a html document (or part of it) with lynx. You need
"   a system that supports the /def/fd/* file descriptors :-(
"nmap ,ly :w !lynx -force_html /dev/fd/0<CR>
"vmap ,ly :w !lynx -force_html /dev/fd/0<CR>
"
" Fri Jun 19 19:19:19 CEST 1998
" Hi, Vikas! vikasa@att.com
" The <Left> key produces the code "<Esc>OD" and Vikas wants to make
" Vim jump back one word in normal mode, ie using the command 'b':
" nmap <Esc>OD b
" Works for me!  :-)
"
" Some simple example of the "expand modifiers":
" insert the current filename *with* path:
  iab YPATHFILE <C-R>=expand("%:p")<cr>
" insert the current filename *without* path:
  iab YFILE <C-R>=expand("%:t:r")<cr>
" insert the path of current file:
  iab YPATH <C-R>=expand("%:h")<cr>
"
"     #b = "browse" - send selected URL to Netscape
" vmap #b y:!netscape -remote "openurl <C-R>""
"
" Toggle highlight search and report the current value:
" map #1 :set hls!<cr>
" map #2 :echo "HLSearch: " . strpart("OffOn",3*&hlsearch,3)<cr>
" map ## #1#2
"
" Sorting current line containing a list of numbers
" map ## :s/ /<C-M>/g<CR>vip!sort -n
"
" Replying to the mutt mailing list:
" Remove header lines Cc: and Bcc: and insert [mutt] at the beginning
" map ,MM 1G/^Cc:<CR>2dd}o[mutt]<CR>
"
" map ,U %s#<URL:\(.*\)>#<a href="\1"></a>#gc
" map ,F {jma}kmb:'a,'b!sed -e "s/^>//"<C-V><C-V>|\
"        sed -f ~/.P/elm/scripts/weedout.sed
" map ,mb ebi<CR><b><ESC>Ea</b><CR><ESC>dw
"
" stripping netscape bookmarks and making them list items
" vmap ,ns :.,$s/^ *<DT><\(A.*"\) ADD.*">\(.*\)$/<li> <\1><C-M><C-I>\2/
"
" Jump to the last space before the 80th column.
" map ,\| 80\|F<space>
"
" extracting variable names from mutt's init.c
" :%s/^.*"\([a-z0-9_]*\)".*$/\1/
"
"     \<> = change to <> notation by substituting ^M and ^[
" cab \<> s/<C-V><ESC>/<ESC>/gc<C-M>:s/<C-V><C-M>/<C-M>/gc<C-M>
"
" Changing the From_ line in pseudo mail folders to an appropriate
"  value - so you can read them with a mailer.
" %s/^From /From guckes Thu Apr  6 12:07:00 1967/
"
" ===================================================================
" ASCII tables - you may need them some day.  Save them to a file!
" ===================================================================
"
" ASCII Table - | octal value - name/char |
"
" |000 nul|001 soh|002 stx|003 etx|004 eot|005 enq|006 ack|007 bel|
" |010 bs |011 ht |012 nl |013 vt |014 np |015 cr |016 so |017 si |
" |020 dle|021 dc1|022 dc2|023 dc3|024 dc4|025 nak|026 syn|027 etb|
" |030 can|031 em |032 sub|033 esc|034 fs |035 gs |036 rs |037 us |
" |040 sp |041  ! |042  " |043  # |044  $ |045  % |046  & |047  ' |
" |050  ( |051  ) |052  * |053  + |054  , |055  - |056  . |057  / |
" |060  0 |061  1 |062  2 |063  3 |064  4 |065  5 |066  6 |067  7 |
" |070  8 |071  9 |072  : |073  ; |074  < |075  = |076  > |077  ? |
" |100  @ |101  A |102  B |103  C |104  D |105  E |106  F |107  G |
" |110  H |111  I |112  J |113  K |114  L |115  M |116  N |117  O |
" |120  P |121  Q |122  R |123  S |124  T |125  U |126  V |127  W |
" |130  X |131  Y |132  Z |133  [ |134  \ |135  ] |136  ^ |137  _ |
" |140  ` |141  a |142  b |143  c |144  d |145  e |146  f |147  g |
" |150  h |151  i |152  j |153  k |154  l |155  m |156  n |157  o |
" |160  p |161  q |162  r |163  s |164  t |165  u |166  v |167  w |
" |170  x |171  y |172  z |173  { |174  | |175  } |176  ~ |177 del|
"
" ===================================================================
" ASCII Table - | decimal value - name/char |
"
" |000 nul|001 soh|002 stx|003 etx|004 eot|005 enq|006 ack|007 bel|
" |008 bs |009 ht |010 nl |011 vt |012 np |013 cr |014 so |015 si |
" |016 dle|017 dc1|018 dc2|019 dc3|020 dc4|021 nak|022 syn|023 etb|
" |024 can|025 em |026 sub|027 esc|028 fs |029 gs |030 rs |031 us |
" |032 sp |033  ! |034  " |035  # |036  $ |037  % |038  & |039  ' |
" |040  ( |041  ) |042  * |043  + |044  , |045  - |046  . |047  / |
" |048  0 |049  1 |050  2 |051  3 |052  4 |053  5 |054  6 |055  7 |
" |056  8 |057  9 |058  : |059  ; |060  < |061  = |062  > |063  ? |
" |064  @ |065  A |066  B |067  C |068  D |069  E |070  F |071  G |
" |072  H |073  I |074  J |075  K |076  L |077  M |078  N |079  O |
" |080  P |081  Q |082  R |083  S |084  T |085  U |086  V |087  W |
" |088  X |089  Y |090  Z |091  [ |092  \ |093  ] |094  ^ |095  _ |
" |096  ` |097  a |098  b |099  c |100  d |101  e |102  f |103  g |
" |104  h |105  i |106  j |107  k |108  l |109  m |110  n |111  o |
" |112  p |113  q |114  r |115  s |116  t |117  u |118  v |119  w |
" |120  x |121  y |122  z |123  { |124  | |125  } |126  ~ |127 del|
"
" ===================================================================
" ASCII Table - | hex value - name/char |
"
" | 00 nul| 01 soh| 02 stx| 03 etx| 04 eot| 05 enq| 06 ack| 07 bel|
" | 08 bs | 09 ht | 0a nl | 0b vt | 0c np | 0d cr | 0e so | 0f si |
" | 10 dle| 11 dc1| 12 dc2| 13 dc3| 14 dc4| 15 nak| 16 syn| 17 etb|
" | 18 can| 19 em | 1a sub| 1b esc| 1c fs | 1d gs | 1e rs | 1f us |
" | 20 sp | 21  ! | 22  " | 23  # | 24  $ | 25  % | 26  & | 27  ' |
" | 28  ( | 29  ) | 2a  * | 2b  + | 2c  , | 2d  - | 2e  . | 2f  / |
" | 30  0 | 31  1 | 32  2 | 33  3 | 34  4 | 35  5 | 36  6 | 37  7 |
" | 38  8 | 39  9 | 3a  : | 3b  ; | 3c  < | 3d  = | 3e  > | 3f  ? |
" | 40  @ | 41  A | 42  B | 43  C | 44  D | 45  E | 46  F | 47  G |
" | 48  H | 49  I | 4a  J | 4b  K | 4c  L | 4d  M | 4e  N | 4f  O |
" | 50  P | 51  Q | 52  R | 53  S | 54  T | 55  U | 56  V | 57  W |
" | 58  X | 59  Y | 5a  Z | 5b  [ | 5c  \ | 5d  ] | 5e  ^ | 5f  _ |
" | 60  ` | 61  a | 62  b | 63  c | 64  d | 65  e | 66  f | 67  g |
" | 68  h | 69  i | 6a  j | 6b  k | 6c  l | 6d  m | 6e  n | 6f  o |
" | 70  p | 71  q | 72  r | 73  s | 74  t | 75  u | 76  v | 77  w |
" | 78  x | 79  y | 7a  z | 7b  { | 7c  | | 7d  } | 7e  ~ | 7f del|
" ===================================================================
"
" ===================================================================
" If your read this...
" ===================================================================
" ... then please send me an email!  Thanks!  --Sven guckes@vim.org
" I have received some emails so far - thanks, folks!
" Enjoy Vim!  :-)
" ===================================================================
" Yet another example for an autocommand:  [980616]
" au VimLeave * echo "Thanks for using Vim"version". --Sven Guckes@vim.org!"
" ===================================================================
" Last but not least...
" =====================================================
" The last line is allowed to be a "modeline" with my setup.
" It gives vim commands for setting variable values that are
" specific for editing this file.  Used mostly for setting
" the textwidth (tw) and the "shiftwidth" (sw).
" Note that the colon within the value of "comments" needs to
" be escaped with a backslash!  (Thanks, Thomas!)
"       vim:tw=70 et sw=4 comments=\:\"
"
"

" giorgio
"set iskeyword=a-z,A-Z,48-57,_,.,-,>

" Ctrl-Arrow movement
" CTRL-<Right>
:map O5C w
:imap O5C <ESC><Right>wi

" CTRL-<Left>
:map O5D b
:imap O5D <ESC>bi


" flist.vim maps for Vim
"  Author  : Charles E. Campbell, Jr.
" Copyright: Charles E. Campbell, Jr.
" License  : refer to the <Copyright> file for flist

" Make various lists of C/C++ functions
"  \p? prototypes : \[px]g: globals   \pc: comment   \pp: all prototypes
"  \x? externs    : \[px]s: statics                  \xx: all externs
map \pc   :w<CR>:!${CECCMD}/flist -c  % >tmp.vim<CR>:r tmp.vim<CR>:!rm tmp.vim<CR>
map \pg   :w<CR>:!${CECCMD}/flist -pg % >tmp.vim<CR>:r tmp.vim<CR>:!rm tmp.vim<CR>
map \pp   :w<CR>:!${CECCMD}/flist -p  % >tmp.vim<CR>:r tmp.vim<CR>:!rm tmp.vim<CR>
map \ps   :w<CR>:!${CECCMD}/flist -ps % >tmp.vim<CR>:r tmp.vim<CR>:!rm tmp.vim<CR>
map \xg   :w<CR>:!${CECCMD}/flist -xg % >tmp.vim<CR>:r tmp.vim<CR>:!rm tmp.vim<CR>
map \xs   :w<CR>:!${CECCMD}/flist -xs % >tmp.vim<CR>:r tmp.vim<CR>:!rm tmp.vim<CR>
map \xx   :w<CR>:!${CECCMD}/flist -x  % >tmp.vim<CR>:r tmp.vim<CR>:!rm tmp.vim<CR>

if filereadable(expand("hints"))
  au BufNewFile,BufReadPost *.c,*.C,*.cpp,*.CPP,*.cxx  so hints
endif


"Libingede specials
iabbrev Yexp  exp/ingenico/de/exp
cabbrev Yexp  exp/ingenico/de/exp
iabbrev Ybase ingenico/de/base
cabbrev Ybase import/dsp/import/i++/src/ingenico/de/base
cabbrev Ycomm import/dsp/import/i++/src/ingenico/de/comm
iabbrev Ycomm ingenico/de/comm
cabbrev Yutil import/dsp/import/i++/src/ingenico/de/utils
iabbrev Yutil ingenico/de/utils
cabbrev Ydsp  import/dsp/src/ingenico/de/dsp
iabbrev Ydsp  ingenico/de/dsp
cabbrev Yidbc import/dsp/src/ingenico/de/idbc
iabbrev Yidbc ingenico/de/idbc

nmap ,tfu /Submit<CR>wwxxxwwwwwwwwwwhr llllxxxwwhr<CR>whxllx;w<CR>:w<CR>
nmap ,tf2 ddpkdwxxi* <ESC>Jxdwxi wrote on<ESC>A:<ESC>jd3d:,$s/^/> /<CR>:%s/  *$//g<C-M>
nmap ,tf3 2xi*<ESC>$Xjd2dVG,qp,ktwsggjgqG
nmap ,tfc wwxxx/<C-V><C-I><CR>r llllxxxA.<ESC>

nmap ,nofmtall :s/^/{noformat}<C-V><CR>/<CR>kyyGp
nmap ,jir2 madwcw*<ESC>jdwdwdw<ESC>kllPli wrote on <ESC>A:<ESC>jd4d^VG,qp'a,nofmtall,ktws

let templatefile="/home/users/steffen/work/pds_sys/igdevtools/templates/template.vim"
if filereadable( templatefile )
  so/home/users/steffen/work/pds_sys/igdevtools/templates/template.vim
endif


function! Html_maps()
    map! ä &auml;
    map! ö &ouml;
    map! ö &ouml;
    map! ü &uuml;
    map! Ä &Auml;
    map! Ö &Ouml;
    map! Ü &Uuml;
    map! ß &szlig;
    set cindent shiftwidth=4 softtabstop=4
endfunction
"
"if has("autocmd")
"       autocmd BufEnter *.html,*.htm,*.shtml call html_maps()
"endif

"not needed anymore on most systems:
":filetype plugin on

":set makeprg=/home/users/steffen/work/pds_sys/igdevtools/mhmake

" let mysyntaxfile = "~/.vim/mysyntax.vim"
" so "~/.vim/doxyvim.vim"
"so ~/.vim/doxygen.vim
" mszlog now is a syntax file (automatically loaded via setf mszlog)
"so ~/.vim/mszlog.vim
autocmd BufReadPost *.log :setf mszlog
"autocmd BufReadPost *.log :setl nowrap
autocmd BufReadPost *.log :setl wrap

" make clogEnter and clogLeave around the current C function
map ,enter ?^{<CR>?(<CR>byw/^{<CR>ocbaseErrorId_t status = CBASE_ERR_OK;<CR>clogEnter(("<ESC>pA"));<CR><ESC>?^{<CR>%O<CR>clogLeave(("<ESC>pA"));<CR>return status;<ESC>
" add if (status == OK) block and prefix status = current line
map ,ifs ^istatus = <ESC>Oif (status == CBASE_ERR_OK) {<ESC>j==o}<ESC><CR>

" map <F3>    :call Toggle_paste()<CR>
fun! Enable_paste()
  setl paste
  setl nolist
  call Disable_overlen_hi()
  let b:std_pastemode = 1
endfun
fun! Disable_paste()
  setl nopaste
  setl list
  call Enable_overlen_hi()
  let b:std_pastemode = 0
endfun
fun! Toggle_paste()
  if exists("b:std_pastemode") && b:std_pastemode
    call Disable_paste()
  else
    call Enable_paste()
  endif
  setl paste?
endfun

" for statusline, to return e.g. "[PASTE,SPELL]"
fun! Show_Status()
  if v:version < 700
    return "[ver<7]"
  endif
  let l:status = []
  if exists("b:std_nomad") && b:std_nomad
    call add(l:status, "nomad")
  endif
  if exists("b:std_pastemode") && b:std_pastemode
    call add(l:status, "PASTE")
  endif
  if exists("b:std_spell") && b:std_spell
    call add(l:status, "SPELL")
  endif
  if len(l:status) != 0
    "return "[" + l:status + "]";
    return "[" . join(l:status, ",") . "]"
  else
    return ""
  endif
endfun

" Spell checking mode
nmap ,sc :call Toggle_spell()<CR>
fun! Toggle_spell()
  if v:version < 700
    echo "No spell check in versions before 7.0, sorry"
    return
  endif
  if exists("b:std_spell") && b:std_spell
    setl nospell spell?
    let b:std_spell = 0
    nunmap n
    nunmap N
    nunmap <C-P>
  else
    setl spell spelllang?
    let b:std_spell = 1
    nmap n ]s
    nmap N [s
    nmap <C-P> z=
  endif
endfun

" Highlighting matching parens
" You can avoid loading this plugin by setting the loaded_matchparen variable:
:let loaded_matchparen = 1

" highlight long lines (>80 chars)
fun! Enable_overlen_hi()
  if v:version >= 703
    " textwidth + 1 and col 79
    if exists("b:std_nomad") && b:std_nomad
      " :setl colorcolumn=120
      "echo b:std_nomad
      :setl colorcolumn=
    else
      :setl colorcolumn=+1,79
    endif
  elseif v:version >= 600
    "highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    highlight OverLength ctermbg=blue guibg=#592929
    "match OverLength /\%81v.*/
    if exists("b:std_nomad") && b:std_nomad
      " match OverLength /.\%>120/
      "echo b:std_nomad
    else
      match OverLength /.\%>81v/
    endif
  endif
  let b:std_overlen_hi = 1
endfunction
fun! Disable_overlen_hi()
  if v:version >= 703
    :setl colorcolumn=
  elseif v:version >= 600
    highlight clear OverLength
  endif
  let b:std_overlen_hi = 0
endfunction
" Used by F3
fun! Toggle_overlen_hi()
  if exists("b:std_overlen_hi") && b:std_overlen_hi
    call Disable_overlen_hi()
  else
    call Enable_overlen_hi()
  endif
endfunction
" By default, enable
call Enable_overlen_hi()

" To automatically reconfigure buffers
fun! NomadSrcMode()
  "echo "Nomad mode"
  let b:std_nomad = 1
  " We already enabled it, ensure to have it off
  call Disable_overlen_hi()
  au! BufWrite *.[ch]
  au! BufWrite *.rb
  setl ai et sw=2 ts=2 tw=110
  " TODO, LASTER and MAYBE are well-defined (usually followed by colon)
  match Todo /TODO:\?\|LATER:\?\|MAYBE:\?/
  set path=.,,src/*/,wd-src/src/*/
endfun


" Automatically cd into the directory that the file is in
" autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
" doesn't cripple command line:
" autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
" only recent autochdir

" '\e' edit in folder where the current file is in
"  http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
" But I usually like setting "path" and using ":find" more.
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" similar to bash shell completion:
"   first TAB completes to longest unique match, second prints
"   list. Extra goodie: third press iterates all matches (like
"   vim default)
set wildmode=longest,list,list:full

" https://github.com/tpope/vim-pathogen:
" call pathogen#infect()

" Set a nicer foldtext function
" http://vim.wikia.com/wiki/Customize_text_for_closed_folds

if has("folding")
  set foldtext=MyFoldText2()
  function! MyFoldText1()
    let line = getline(v:foldstart)
    if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
      let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
      let linenum = v:foldstart + 1
      while linenum < v:foldend
        let line = getline( linenum )
        let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
        if comment_content != ''
          break
        endif
        let linenum = linenum + 1
      endwhile
      let sub = initial . ' ' . comment_content
    else
      let sub = line
      let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
      if startbrace == '{'
        let line = getline(v:foldend)
        let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
        if endbrace == '}'
          let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
        endif
      endif
    endif
    let n = v:foldend - v:foldstart + 1
    let info = " " . n . " lines"
    let sub = "+ " . sub . "                                                                                                                  "
    let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
    let fold_w = getwinvar( 0, '&foldcolumn' )
    let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
    return sub . info
  endfunction
  function! MyFoldText2()
    " for now, just don't try if version isn't 7 or higher
    if v:version < 701
      return foldtext()
    endif
    " clear fold from fillchars to set it up the way we want later
    let &l:fillchars = substitute(&l:fillchars,',\?fold:.','','gi')
    let l:numwidth = (v:version < 701 ? 8 : &numberwidth)
    if &fdm=='diff'
      let l:linetext=''
      let l:foldtext='---------- '.(v:foldend-v:foldstart+1).' lines the same ----------'
      let l:align = winwidth(0)-&foldcolumn-(&nu ? Max(strlen(line('$'))+1, l:numwidth) : 0)
      let l:align = (l:align / 2) + (strlen(l:foldtext)/2)
      " note trailing space on next line
      setlocal fillchars+=fold:\ 
    elseif !exists('b:foldpat') || b:foldpat==0
      let l:foldtext = ' '.(v:foldend-v:foldstart).' lines folded'.v:folddashes.'|'
      " Steffen wants marker right *after* end of line
      let l:endofline = (&textwidth>0 ? &textwidth : 79) + 1
      let l:linetext = strpart(getline(v:foldstart),0,l:endofline-strlen(l:foldtext))
      let l:align = l:endofline-strlen(l:linetext)
      setlocal fillchars+=fold:-
    elseif b:foldpat==1
      let l:align = winwidth(0)-&foldcolumn-(&nu ? Max(strlen(line('$'))+1, l:numwidth) : 0)
      let l:foldtext = ' '.v:folddashes
      let l:linetext = substitute(getline(v:foldstart),'\s\+$','','')
      let l:linetext .= ' ---'.(v:foldend-v:foldstart-1).' lines--- '
      let l:linetext .= substitute(getline(v:foldend),'^\s\+','','')
      let l:linetext = strpart(l:linetext,0,l:align-strlen(l:foldtext))
      let l:align -= strlen(l:linetext)
      setlocal fillchars+=fold:-
    endif
    return printf('%s%*s', l:linetext, l:align, l:foldtext)
  endfunction
endif

" http://vim.wikia.com/wiki/VimTip1454
function! GetProtoLine()
  let ret       = ""
  let line_save = line(".")
  let col_save  = col(".")
  let window_line = winline()
  let top       = line_save - winline() + 1
  let so_save = &so
  let &so = 0
  let istypedef = 0
  " find closing brace
  let closing_lnum = search('^}','cW')
  if closing_lnum > 0
    if getline(line(".")) =~ '\w\s*;\s*$'
      let istypedef = 1
      let closingline = getline(".")
    endif
    " go to the opening brace
    keepjumps normal! %
    " if the start position is between the two braces
    if line(".") <= line_save
      if istypedef
        let ret = matchstr(closingline, '\w\+\s*;')
      else
        " find a line contains function name
        let lnum = search('^\w','bcnW')
        if lnum > 0
          let ret = getline(lnum)
        endif
      endif
      let lines = closing_lnum - line(".")
      let line_rel = line_save - line(".")
      let ret = ret . ':' . line_rel . '/' . lines
      "let ret .= ":" . line_save - line(".")
    endif
  endif
  exe "keepjumps normal! " . top . "Gz\<CR>"
  " restore position and screen line
  call cursor(line_save, col_save)
  " needed for diff mode (scroll fixing)
  let line_diff = winline() - window_line
  if line_diff > 0
    exe 'normal ' . line_diff . '^E'
  elseif line_diff < 0
    exe 'normal ' . -line_diff . '^Y'
  endif
  let &so = so_save
  return ret
endfunction

" http://vim.wikia.com/wiki/VimTip1454
function! WhatFunction()
  " allow to quickly disable it (:let b:noWhatFunction=1)
  if exists("b:noWhatFunction") && b:noWhatFunction
    return ""
  endif
  if &ft != "c" && &ft != "cpp"
    return ""
  endif
  let proto = GetProtoLine()
  if proto == ""
    return "?"
  endif
  let line_info = matchstr(proto, ':\d\+\/\d\+')
  if stridx(proto, '(') > 0
    let ret = matchstr(proto, '\~\?\w\+(\@=')
  elseif proto =~# '\<struct\>'
    let ret = matchstr(proto, 'struct\s\+\w\+')
  elseif proto =~# '\<class\>'
    let ret = matchstr(proto, 'class\s\+\w\+')
  else
    let ret = strpart(proto, 0, 15) . "..."
  endif
  let ret .= line_info
  return ret
endfunction

" http://vim.wikia.com/wiki/Forcing_UTF-8_Vim_to_read_Latin1_as_Latin1
"   Currency sign: "¤"
" vim: et sw=2 ts=2 tw=2 tw=75 :
