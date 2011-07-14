# Bash knows 3 diferent shells: normal shell, interactive shell, login shell.
# ~/.bashrc is read for interactive shells and ~/.profile is read for login
# shells. We just let ~/.profile also read ~/.bashrc and put everything in
# ~/.bashrc.

test -z "$PROFILEREAD" && . /etc/profile

test -z "${LESS/*-R*/}" || LESS="$LESS -R"
export LESS
test -z "$PROFILEREAD" && { PROFILEREAD=1 ; . /etc/profile ; }

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
if test -z "$DISPLAY" -a "$TERM" = "xterm" -a -x /usr/bin/who ; then
    WHOAMI="`/usr/bin/who am i`"
    _DISPLAY="`expr "$WHOAMI" : '.*(\([^\.][^\.]*\).*)'`:0.0"
    if [ "${_DISPLAY}" != ":0:0.0" -a "${_DISPLAY}" != " :0.0" \
         -a "${_DISPLAY}" != ":0.0" ]; then
        export DISPLAY="${_DISPLAY}";
    fi
    unset WHOAMI _DISPLAY
fi


test -e ~/.alias && . ~/.alias


export DISPLAY PS1 PS2
umask 022
