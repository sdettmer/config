#!/bin/bash
# Steffens htop-on-alt-f8-toy

/usr/bin/htop 0<> /dev/tty8 1>&0 2>&0
clear>/dev/tty8
cat <<EOT > /dev/tty8


   ** System load monitor cannot be left **

   Please use ALT-F2, ALT-F3 etc to change
   to a different console to login.

   You can disable this console by editing
   /etc/inittab (use telinit q to reload it)

      (exiting + reincarnating in 5 seconds)
EOT
sleep 5
