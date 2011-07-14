# .profile is read for all login shells
# all other interactive shells will read .bashrc
# So read .bashrc also from .profile and make all changes to .bashrc.
# Then you should always have your correct setup.

# We cannot set PROFILEREAD before, because then it SuSE
# /etc/profile does not set all options (e.g. no PATH), we cannot
# set PROFILEREAD after sourcing, then on cywgwin /etc/profile
# and endless recursion happens... So we use a second variable
test -z "$PROFILEREAD" && test -z "$PROFILEONCE" &&
    { export PROFILEONCE=true ; . /etc/profile ; }

#export PATH=$PATH:/home/pub/bin:/home/pub/sbin

if test -f ~/.bashrc; then
	. ~/.bashrc
fi

#alias print2="a2ps -s 2 -E -M Executive -r -2 -A virtual"
#alias print="a2ps -s 1 -E -M Executive -r -2 -A virtual"
#in .alias

export CVS_RSH=`which ssh`
export RSYNC_RSH=`which ssh`
export RANDY=randy
export EDITOR=vim
export RANDYUSER=sdettmer
#export CVSROOT=/home/data/repositories/btsabln
export CVSROOT=:ext:${RANDYUSER}@${RANDY}:/home/repositories/systems

#export XCVSSERVER=xcvs
#export XSRCCVSROOT=/home/extcvsrepos/packages/src

export CECCMD=~steffen/work/download/flist
export PATH=$PATH:/home/pub/bin

export ILOG_CONSOLE_COLOR=1

#
# some people don't like fortune.  If you have humor, please enable it by
# uncommenting the following lines.
#

#if [ -x /usr/bin/fortune ] ; then
#    echo
#    /usr/bin/fortune
#    echo
#fi
