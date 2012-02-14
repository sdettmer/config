#!/bin/bash

COLOR="-bg #000020 -fg white"
COLOR=""
#OPTS="-sb"

#eval `ssh-agent`

unset SSH_PS1
#if kill -0 "$SSH_AGENT_PID" ; then
#	if ssh-add ; then 
#		SSH_PS1="SSH"
#		TITLE="SSH XTerm"
#	else
#		SSH_PS1="ssh"
#		TITLE="ssh XTerm"
#	fi
#else
#	SSH_PS1=""
#fi
#
export SSH_PS1

xterm -title "$TITLE" $OPTS -geometry 81x58+0+15    -fn 9x15 &
xterm -title "$TITLE" $OPTS -geometry 80x24-23+15   -fn fixed &
xterm -title "$TITLE" $OPTS -geometry 80x24-23+352  -fn fixed &
xterm -title "$TITLE" $OPTS -geometry 80x24-22-0    -fn fixed &

