" http://vim.wikia.com/wiki/Integrate_gvim_with_Visual_Studio
"
" Vim as an external
" ------------------
" If you like Vim and use MS Visual Studio .NET for debugging and
" want a lightweight way to open the file you're currently
" debugging in VS in Vim, you can add Vim as an external tool. This
" will let you use a single keystroke to open the current VS file
" in vim with the cursor at the same line and even at the same
" column.
" The Tool: In Visual Studio, Tools > External Tools > Add:
"
" * Title: &Vim
" * Command: C:\Vim\vim73\gvim.exe
" * Arguments: --servername VimStudio --remote-silent +"call
"         cursor($(CurLine),$(CurCol))" "$(ItemFileName)$(ItemExt)"
" * Initial directory: $(ItemDir)
"
" If you have other settings you'd like to apply (like normal zz to
" centre the cursor or updating path for :find, then you can put
" them in $HOME/vimfiles/visualstudioinvoke.vim and add +"runtime
" visualstudioinvoke.vim" before $(ItemFileName). $HOME is either
" the %HOME% environment variable if one is defined, or Vim
" determines an appropriate directory which you can see by doing
" :echo $HOME within Vim.
"
" The Shortcut:
" In Visual Studio, Tools -> Options -> Environment -> Keyboard:
"
" * Command: ExternalCommand1 (it's easiest if you move your Vim
"   external tool to be the first, otherwise use the correct index).
" * Shortcut key: F1
"
" This will allow you to use your key combination to open the
" current file at the current line and cursor in a new vim browser.
" The browser will start at the directory of that file, so ':e .'
" will edit the directory of that file.
"
" Remove the --servername VimStudio part if you want it to open a
" new instance of Vim each time.
"
" Preventing Nagging: In order to effectively use the two together
" and make sure .NET does not complain about its files changing,
" goto Tools > Options > Environment > Documents and ensure these
" two options are checked:
"
" * Detect when file is changed outside the environment.
" * Auto-load changes (if not currently modified inside the
"   environment).
"
" In your visualstudioinvoke.vim, enable autoread so vim will
" update files when they're modified in Visual Studio:
" set autoread

" nomad wd-src special:
set lines=50 columns=110
highlight clear OverLength
set tags+=../../TAGS
