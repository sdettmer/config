echo ~/.gdbinit...\n
set pagination off
set history save
set history size 20000

define show_clog
  if $is_show_clog && clogStaticLogBuffer_ != 0 && clogStaticLogBuffer_[0] != 0
    printf "%s", clogStaticLogBuffer_
    set clogStaticLogBuffer_[0] = 0
  end
end
set var $have_show_clog = 1
set var $is_show_clog = 1
# TODO add to tr command if avail. Make it adding just once
#   by using some var
# now some magic sets this:
#echo after `trc' or `l40', FIRST time type:\n
#echo break clogStaticBufferPublisherBreak if $show_clog_py()\n

# must be last statement, because gdb-6.8 (w/o Python)
#   stops execution because of the error in the file.
# echo ~steffen/.gdbinit explicitely sourcing ~steffen/.gdbinit.py:\n
# source ~steffen/.gdbinit.py
echo ~steffen/.gdbinit explicitely sourcing gdb-commands.txt:\n
source gdb-commands.txt

# Automatic remote logging
# ------------------------
# needs in some ~/.gdbinit.py:
#   class ShowClogPy (gdb.Function):
#       """Shows clog static log buffer"""
#
#       def __init__ (self):
#       super (ShowClogPy, self).__init__ ("show_clog_py")
#
#       def invoke (self):
#       gdb.execute("show_clog")
#       return False
#
#   ShowClogPy()
#
# and then can be automated via:
#   $ cd tsabsa_exp.all/build/arm-ingenico-elf_telium/tsade
#   $ /usr/local/build/gdb-7.1/build-python2/gdb/gdb
#   (gdb) so gdb-commands.txt
#   (gdb) so ~/.gdbinit.py
#   (gdb) trc
#   (gdb) break clogStaticBufferPublisherBreak if $show_clog_py()
#   # optionally, other breakpoints etc
#   (gdb) c

echo ~/.gdbinit DONE\n
