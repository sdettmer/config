# Bash knows 3 diferent shells: normal shell, interactive shell, login shell.
# ~/.bashrc is read for interactive shells and ~/.profile is read for login
# shells. We just let ~/.profile also read ~/.bashrc and put everything in
# ~/.bashrc.
# Note: Bash attempts to determine when it is being run with its standard
#   input connected to a a network connection, as if by the remote shell
#   daemon, usually rshd, or the secure shell daemon sshd. If bash
#   determines it is being run in this fashion, it reads and executes
#   commands from ~/.bashrc, if that file exists and is readable. It will
#   not do this if invoked as sh.

# We also need /etc/profile. It seems on some systems we have to source it
# explicitely (older SuSE), but on others it seems to be sourced
# automatically (MSYS Git Shell), so we have to spend some effort to ensure
# it is ready once (and only once). SuSE sets PROFILEREAD=1 in /etc/profile.
# We cannot set PROFILEREAD before sourcing, because then SuSE's
# /etc/profile does not set all options (e.g. no PATH; has this been done
# to avoid creating long PATH when profile is executed several times?)
# Also, we cannot set PROFILEREAD after sourcing, because MSYS Git
# /etc/profile sources ~/.bashrc (!) and thus and endless recursion
# would happen...
# So we use two variables to guard sourcing.
# Note: if only MSYS has /etc/profile source ~/.bashrc, maybe a MSYS
# specific exception could be better.
# Idea:
# # If we have a prompt, we have an interactive shell, and bash read profile already.
# [ "$PS1" ] && export PROFILEONCE=true
test -z "$PROFILEREAD" && test -z "$PROFILEONCE" &&
    { PROFILEONCE=true ; . /etc/profile ; }

# Source helpers
test -e ~/.alias_all && . ~/.alias_all
test -e ~/.alias && . ~/.alias
test -e ~/.git-completion.bash && . ~/.git-completion.bash
test -e ~/.ct-completion.bash && . ~/.ct-completion.bash

test -e ~/.multibuild-completion.bash && . ~/.multibuild-completion.bash
test -e ~/.bashrc.local && . ~/.bashrc.local

# standard environment
test -z "${LESS/*-R*/}" || export LESS="$LESS -R"
test -z "${LS_OPTIONS}" && export LS_OPTIONS='--color=auto'

export EDITOR="vim -X"
export CVS_RSH="`type -p ssh`"
export RSYNC_RSH="`type -p ssh`"
export PATH=~/bin:$PATH:/home/pub/bin
export PERL5LIB=~/usr/lib/perl5:~/usr/lib/perl5/site_perl
export LD_LIBRARY_PATH=~/usr/lib
export MANPATH=~/usr/share/man:$MANPATH

if [ -d ~/opt/jdk1.8.0_171/ ] ; then
    export JAVA_HOME=~/opt/jdk1.8.0_171
    export PATH=~/bin:~/opt/jdk1.8.0_171/bin:$PATH:/home/pub/bin
elif [ -d ~/opt/jdk1.7.0_71 ] ; then
    export JAVA_HOME=~/opt/jdk1.7.0_71
    export PATH=~/bin:~/opt/jdk1.7.0_71/bin:$PATH:/home/pub/bin
fi

# git-unlock-pack wasn't found
# test -z "${PATH/*local*/}" || PATH="$PATH:/usr/local/bin/"
# export PATH

# GIT hacking (just left as comment, but not needed with MSYS or cygwin)
#export GIT_SSH='c:\bin32\plink.exe'

#export MSVCROOT="/cygdrive/c/Programme/Microsoft Visual Studio//VC98/Bin/"
#"$MSVCROOT"/VCVARS32.BAT
#export PATH=$PATH:"$MSVCROOT":"/cygdrive/c/Programme/Microsoft Visual Studio/Common/MSDev98/Bin"
#evaluates to:
export INCLUDE="C:\PROGRA~1\MICROS~3\VC98\ATL\INCLUDE;C:\PROGRA~1\MICROS~3\VC98\INCLUDE;C:\PROGRA~1\MICROS~3\VC98\MFC\INCLUDE;"
export LIB="C:\PROGRA~1\MICROS~3\VC98\LIB;C:\PROGRA~1\MICROS~3\VC98\MFC\LIB;"
export PATH="$PATH:/cygdrive/c/Programme/Microsoft Visual Studio/VC98/Bin/:/cygdrive/c/Programme/Microsoft Visual Studio/Common/MSDev98/Bin"

export A32DE_DFS_DIR="/cygdrive/c/Programme/Ingedev503/CommonFiles/~d~e0200_a32de/"
export PATH=~/bin:$PATH:/home/pub/bin:/c/MinGW/bin:/c/cygwin/bin
export KEYFILEPATH="c:/Programme/INGEDEV408/Key/"
#export JAVA_HOME=/cygdrive/c/Programme/Java/jre1.5.0_06/

# fslint is a toolset to find various problems with filesystems,
# including duplicate files and problematic filenames etc.
[ -d /usr/share/fslint/fslint/ ] && export PATH=$PATH:/usr/share/fslint/fslint/

# Nomad Digital test port offset value for Steffen:
export ND_PORT_OFFSET=9


# http://stackoverflow.com/questions/12568658/java-lang-outofmemoryerror-permgen-space-error
MAVEN_OPTS="-Xmx512m"
if [ -d /vobs/TWCS_HEN/3p/Maven ] ; then
    export M2_HOME=/vobs/TWCS_HEN/3p/Maven
elif [ -d ~/ccviews/sdettmer_dt5_wcg_dev_snap/vobs/TWCS_HEN/3p/Maven ] ; then
    export M2_HOME=~/ccviews/sdettmer_dt5_wcg_dev_snap/vobs/TWCS_HEN/3p/Maven
fi

# ClearCase Tool "-avobs" speed-up:
#    "Specify CLEARCASE_AVOBS as a list of VOB tags separated by commas,
#    white space, or colons (UNIX and Linux) or by semicolons (Windows)."
export CLEARCASE_AVOBS='\TWCS_HEN \twcs_tools \twcs_wcac'
#export CLEARCASE_CMNT_PN=~/cs/.last_ct_comment.txt

# see ~/.git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=1            # "*" when dirty
GIT_PS1_SHOWSTASHSTATE=1            # "$" when stashed
#GIT_PS1_SHOWUNTRACKEDFILES=1       # "%" untracked files
GIT_PS1_SHOWUPSTREAM="auto verbose" # also: legacy, git, svn

# I don't use this anymore, see file to read why.
# . ~/.ssh-autoprompt.sh

# standard Prompt
test -z "$PS1_org" && export PS1_org="$PS1"
PS1_mono='\u@\h:\w$(__git_ps1 " (%s)") $ '
PS1=$PS1_mono

# color version. On older bash versions (3.x?) this fails with multi-line
# editing, so either should have \n after last escape sequence or simply
# don't use it. bash-4.1.5(1) works (bash-3.2.33(1) doesn't).
PS1_color='\[\e]0;\w\a\]\[\e[32m\]\u@\h:\[\e[33m\]\w\[\e[32m\]$(__git_ps1 " (%s)")\[\e[0m\] $ '
PS1_color_n='\[\e]0;\w\a\]\[\e[32m\]\u@\h:\[\e[33m\]\w\[\e[32m\]$(__git_ps1 " (%s)")\[\e[0m\]\n$ '
# =~ is regex and excepts xterm-256color etc.
if [[ "$TERM" =~ "xterm" || "$TERM" = "rxvt-cygwin-native" ]] ; then
    [ "${BASH_VERSINFO[0]}" -ge "4" ] && PS1=$PS1_color
    # comment out next line to get monochrome propmt on bash-3.
    [ "${BASH_VERSINFO[0]}" -le "3" ] && PS1=$PS1_color_n
fi

# https://github.com/cuviper/ssh-pageant
#   ssh-pageant is an SSH authentication agent for Cygwin that
#   links OpenSSH to PuTTY's Pageant.  It acts very much like
#   ssh-agent, except it leaves the key storage to Pageant.
#   TODO we might need to kill agent somewhen and maybe just use
#   one for all
# Warn as workaround for uninstalled cygwin file still present
if [ -e /usr/bin/gnome-keyring-daemon.exe ] ; then
  echo "Warning, gnome-keyring-daemon.exe exists and will break SSH" >&2
fi
if [ -z "$SSH_AUTH_SOCK" ] && type ssh-pageant >/dev/null 2>&1 ; then
  eval $(ssh-pageant -q)
fi
#trap logout HUP

#alias hilbert='finger @hilbert.suse.de'
#export EDITOR=/usr/bin/pico
#export NNTPSERVER=news.suse.de

# commands common to all logins

if ! [ $TERM ] ; then
    eval `tset -s -Q`
    case $TERM in
      con*|vt100) tset -Q -e ^?
        ;;
    esac
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Make multi-line commandsline in history
shopt -q -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="[%F %T] "

# auto pager (avoid plain "history" kills $HISTSIZE lines of terminal history)
function history()
{
  if [ "$@" ] ; then
    command history "$@"
  else
    command history | less
  fi
}

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Turn on the extended pattern matching features
# shopt -q -s extglob


#
# try to set DISPLAY smart (from Hans) :)
#
# Update: really bad idea when not having open DISPLAY
#    (e.g. when using putty)
#if test -z "$DISPLAY" -a "$TERM" = "xterm" -a -x /usr/bin/who ; then
#    WHOAMI="`/usr/bin/who am i`"
#    _DISPLAY="`expr "$WHOAMI" : '.*(\([^\.][^\.]*\).*)'`:0.0"
#    if [ "${_DISPLAY}" != ":0:0.0" -a "${_DISPLAY}" != " :0.0" \
#         -a "${_DISPLAY}" != ":0.0" ]; then
#        export DISPLAY="${_DISPLAY}";
#    fi
#    unset WHOAMI _DISPLAY
#fi

# Unfortunately I forgot what this was for:
# [[ -f "/home/steffen/.config/autopackage/paths-bash" ]] && . "/home/steffen/.config/autopackage/paths-bash"

# Safety: when there is no GIT, don't use it in prompt
if [ ! -x "`type -p git`" ] ; then
    __git_ps1() { fmt=$1 || "%s" ; printf $fmt "no git"; }
fi
# in MSYS, shell moans about non-implemented pipe subst or so
if [ "$MSYSTEM" = "MINGW32" ] ; then
    __git_ps1() { fmt=$1 || "%s" ; printf $fmt "[MSYS]"; }
    test -n "$PS1_org" && export PS1=$PS1_org
fi

# Old GIT versions (<=1.7.x?) do not support rev-list --count, set legacy mode.
if ! git rev-list --count HEAD >/dev/null 2>&1 ; then
    GIT_PS1_SHOWUPSTREAM="$GIT_PS1_SHOWUPSTREAM legacy"
fi

# export NVM_DIR="/net/dehecnas1/Homes/sdettmer/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

umask 002
# http://vim.wikia.com/wiki/Forcing_UTF-8_Vim_to_read_Latin1_as_Latin1
#   Currency sign: "¤"
# vim: et sw=4 ts=4 tw=75:
