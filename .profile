# .profile is read for all login shells
# all other interactive shells will read .bashrc
# So read .bashrc also from .profile and make all changes to .bashrc.
# Then you should always have your correct setup.

if test -f ~/.bashrc ; then
  if test -z "${BASH_VERSION}" ; then
    if test -n "${SHOW_ERROR}" ; then
      echo "Login standard shell is not bash?!"
      # Could be e.g. "/bin/sh /etc/gdm3/Xsession default" (Debian 6).
      # This Xsession script has shebang /bin/sh and sources ~/.profile,
      #   thus .profile is invoked with wrong shell, which even is not an
      #   interactive shell! IMHO this is really sick, no clue why they did it.
      #   Also there sis /bin/sh -> /bin/dash, but SHELL=/bin/bash in Xsession!
      ps -o command -p $$
      env
    fi
    # Maybe we can at least configure some very important variables
    export PATH=~/bin:$PATH:/home/pub/bin
    export PERL5LIB=~/usr/lib/perl5:~/usr/lib/perl5/site_perl
    export LD_LIBRARY_PATH=~/usr/lib
    export ND_PORT_OFFSET=9
    umask 022
  else
    . ~/.bashrc
  fi
fi

# We cannot set PROFILEREAD before, because then it SuSE
# /etc/profile does not set all options (e.g. no PATH), we cannot
# set PROFILEREAD after sourcing, then on cywgwin /etc/profile
# and endless recursion happens... So we use a second variable
test -z "$PROFILEREAD" && test -z "$PROFILEONCE" &&
    { PROFILEONCE=true ; . /etc/profile ; }

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

export CECCMD=~/work/download/flist

export ILOG_CONSOLE_COLOR=1

# Debian "sudo" passes $DISPLAY and $XAUTHORITY, but sets XAUTHORITY only
# for local X session logins. When logging in via SSH, DISPLAY is set but
# not working, which breaks things.
test -z "$XAUTHORITY" && export XAUTHORITY=~/.Xauthority

# Needed in ND environment with forced UTF-8 on servers (?)
#   I hope I'll get a better idea how to workaround this one day...
#   See also .bashrc
#export LC_ALL=C.UTF-8
#export LC_ALL=de_DE.UTF-8
#export LANG=de_DE.ISO-8859-1
# UTF8 console (how to autodetect?):
export LC_ALL=de_DE.UTF-8
export LANG=de_DE.UTF-8
export LANGUAGE=de_DE.UTF-8

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
