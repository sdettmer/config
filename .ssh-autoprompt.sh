#!/bin/bash
# This is prompt and xterm title for SSH configurator.
#
# I don't use it anymore, because it is not reliable, for example
# surely fails if ssh to users without that functionality (root).
# Also, nowadays I usually only have one single agent on the
# local machine running (via .xinitrc or Putty-Agent on Win), so
# this information isn't needed on each shell prompt.
#
# It's mostly handy when administrating multiple networks to
# show agent status (when not trusting agent forwarding and using
# different keys in and for different networks), but then it
# fails unless in /etc/profile...

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

# http://vim.wikia.com/wiki/Forcing_UTF-8_Vim_to_read_Latin1_as_Latin1
#   Currency sign: "¤"
# vim: et sw=4 ts=4 tw=75:
