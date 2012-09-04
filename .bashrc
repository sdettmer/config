# Bash knows 3 diferent shells: normal shell, interactive shell, login shell.
# ~/.bashrc is read for interactive shells and ~/.profile is read for login
# shells. We just let ~/.profile also read ~/.bashrc and put everything in
# ~/.bashrc.

test -z "${LESS/*-R*/}" || export LESS="$LESS -R"
test -z "${LS_OPTIONS}" && export LS_OPTIONS='--color=auto'

# We cannot set PROFILEREAD before, because then it SuSE
# /etc/profile does not set all options (e.g. no PATH), we cannot
# set PROFILEREAD after sourcing, then on cywgwin /etc/profile
# and endless recursion happens... So we use a second variable
test -z "$PROFILEREAD" && test -z "$PROFILEONCE" &&
    { export PROFILEONCE=true ; . /etc/profile ; }

# git-unlock-pack wasn't found
# test -z "${PATH/*local*/}" || PATH="$PATH:/usr/local/bin/"
# export PATH

function xterm_title()
{
    echo -n "]2;$@]1;$*"
}

#SSH_AUTOPROMPT flags if already set
function ssh_autoprompt()
{
    additional_string=$1
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ "$?" = "0" ] ; then
        #no identities:
        echo "The agent has no identities."
        sshstate="ssh${additional_string}"
    else
        #list and print all identities:
        ssh-add -l|perl -ne \
            'm/\d+ (\d+ \d+|[\w:]+) (.*)$/ && print "SSH-ID: $2\n"'
        sshstate="SSH${additional_string}"
    fi
    xterm_title "${sshstate}`whoami`@`hostname -f`";
    PS1="${sshstate}\u@\h:\w # "
    export SSH_AUTOPROMPT=$PS1
}

#CVS+SSH hack:
SSH_AUTOPROMPT="\u@\h:\w # "

if [ "$SSH_AUTOPROMPT" = "" ] ; then
    #default prompt:
    PS1="\u@\h:\w # "

    if [ ! -z "$SSH_AGENT_PID" ] ; then
        #agent pid set: check it
        if kill -0 "$SSH_AGENT_PID" 2>/dev/null ; then
            ssh_autoprompt " "
        else
            echo "FATAL: Agent [$SSH_AGENT_PID] died!"
        fi
    else
        #no agent PID, but maybe SSH_AUTH_SOCK
        if [ ! -z "$SSH_AUTH_SOCK" -a -S "$SSH_AUTH_SOCK" ] ; then
            ssh_autoprompt "|"
        fi

    fi
else
    #echo "autoprompt set"
    PS1=$SSH_AUTOPROMPT
fi
export PS1 PS2

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
# vim: et sw=4 ts=4 tw=4 tw=0:
