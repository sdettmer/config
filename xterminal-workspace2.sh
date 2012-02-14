#!/bin/bash

#used: xwinfo

#COLOR="-bg #000020 -fg white"
COLOR=""
OPTS="-sb"

#eval `ssh-agent`
#ssh-add ~/.ssh/id_dsa

#xterm $COLOR -geometry 82x59+2+4 -fn 9x15 &

if [ -x `which Eterm` ] ; then
	#the sleeps are to force the correct stack order
	FNT="8x9"
	FNT="misc-fixed-medium-r-semicondensed-*-*-120-*-*-c-*-iso8859-15"
	OPTS="--trans --cmod=48 --scrollbar=0"
	xmessage -center "Please wait ..." &
	xmpid=$!
	Eterm $OPTS --geometry 80x24-7-0 --font $FNT &
	sleep 1;
	Eterm $OPTS --geometry 80x24-7+346 --font $FNT &
	sleep 1;
	Eterm $OPTS --geometry 80x24-7+18 --font $FNT &
	sleep 1;
	Eterm $OPTS --geometry 83x56+2+20 --font 9x15 &
	#remove wait message:
	kill $xmpid
	sleep 1;
	xmessage -timeout 3 -center "*** Workspace ready. ***" &
elif [ -x `which gnome-terminal` ] ; then
	FNT="8x9"
	FNT="misc-fixed-medium-r-semicondensed-*-*-120-*-*-c-*-iso8859-15"
	OPTS="--transparent --shaded"
	gnome-terminal $OPTS --geometry 82x59+2+4 --font 9x15 &
	gnome-terminal $OPTS --geometry 80x24-510+15 --font $FNT &
	gnome-terminal $OPTS --geometry 80x24-510+342 --font $FNT &
	gnome-terminal $OPTS --geometry 80x24-510-340 --font $FNT &
else
	xterm $COLOR -geometry 82x59+2+4 -fn 9x15 &
	xterm $COLOR -geometry 80x24-7+2 &
	xterm $COLOR -geometry 80x24-7+342 &
	xterm $COLOR -geometry 80x24-7-6 &
fi

