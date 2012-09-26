# .profile is read for all login shells
# all other interactive shells will read .bashrc
# So read .bashrc also from .profile and make all changes to .bashrc.
# Then you should always have your correct setup.

if test -f ~/.bashrc; then
    . ~/.bashrc
fi

# We cannot set PROFILEREAD before, because then it SuSE
# /etc/profile does not set all options (e.g. no PATH), we cannot
# set PROFILEREAD after sourcing, then on cywgwin /etc/profile
# and endless recursion happens... So we use a second variable
test -z "$PROFILEREAD" && test -z "$PROFILEONCE" &&
    { export PROFILEONCE=true ; . /etc/profile ; }

# PATH and stuff also needed for non-interactive remote shells (when using
#   something over SSH, for example), should go into ~/.bashrc, because
#   ~/.profile won't be read.

# I don't use this anymore, see file to read why.
# . ~/.ssh-autoprompt.sh

# Special variables and setup only for interactive shells
export RANDY=randy
export RANDYUSER=sdettmer
#export CVSROOT=/home/data/repositories/btsabln
export CVSROOT=:ext:${RANDYUSER}@${RANDY}:/home/repositories/systems

#export XCVSSERVER=xcvs
#export XSRCCVSROOT=/home/extcvsrepos/packages/src

export CECCMD=~steffen/work/download/flist

export ILOG_CONSOLE_COLOR=1

# Needed in ND environment with forced UTF-8 on servers (?)
#   I hope I'll get a better idea how to workaround this one day...
#export LC_ALL=C.UTF-8

# breaks mutt, so don't use xterm-256color
#   test "$TERM" = "xterm" && export TERM=xterm-256color

#
# some people don't like fortune.  If you have humor, please enable it by
# uncommenting the following lines.
#

#if [ -x /usr/bin/fortune ] ; then
#    echo
#    /usr/bin/fortune
#    echo
#fi


# http://vim.wikia.com/wiki/Forcing_UTF-8_Vim_to_read_Latin1_as_Latin1
#   Currency sign: "¤"
# vim: et sw=4 ts=4 tw=75:
