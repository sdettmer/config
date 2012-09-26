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
test -z "$PROFILEREAD" && test -z "$PROFILEONCE" &&
    { export PROFILEONCE=true ; . /etc/profile ; }

# standard environment
test -z "${LESS/*-R*/}" || export LESS="$LESS -R"
test -z "${LS_OPTIONS}" && export LS_OPTIONS='--color=auto'

export EDITOR=vim
export CVS_RSH=`which ssh`
export RSYNC_RSH=`which ssh`
export PATH=~/bin:$PATH:/home/pub/bin

# git-unlock-pack wasn't found
# test -z "${PATH/*local*/}" || PATH="$PATH:/usr/local/bin/"
# export PATH

# Nomad Digital test port offset value for Steffen:
export ND_PORT_OFFSET=7

# I don't use this anymore, see file to read why.
# . ~/.ssh-autoprompt.sh
PS1="\u@\h:\w $ "

# color version:
if test "$TERM" = "xterm" ; then
    PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\] $ '
fi

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

#export LANG=de_DE.ISO-8859-1


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

test -e ~/.alias_all && . ~/.alias_all
test -e ~/.alias && . ~/.alias

test -e ~/.git-completion.bash && . ~/.git-completion.bash

umask 022
# http://vim.wikia.com/wiki/Forcing_UTF-8_Vim_to_read_Latin1_as_Latin1
#   Currency sign: "¤"
# vim: et sw=4 ts=4 tw=75:
