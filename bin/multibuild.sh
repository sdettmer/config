#!/bin/bash
# This is multibuild search & exec front end.
# If invoked ANYWHERE below tisc-src/vobs or tisc-src/build, it finds multibuild.sh.
# If invoked with any filter option, it passes all options to multibuild.sh.
# If invoked in a multibuild builddir, it invokes multibuild for this builddir.
# If invoked in directory with multiple builddirs directly below, it invokes it for each.

# Cleanup accidentally created builddirs:
# cd build
# rm */multibuild.info.tmp ; rmdir *

set -e

workingdir=$(pwd)
#echo "in $workingdir"

# If invoked with any filter option, do not try any multibuild.info.
tryinfo="1"
declare -a args=($@)
for arg in "${args[@]}" ; do
    case $arg in
        -n|-t|-b|-p) tryinfo="" ;;
    esac
done

# Invoke multibuild.sh with multibuild.info as last parameter.
useinfo()
{
    echo "Using $multibuildinfo"
    . "${multibuildinfo}"
    [ "${multibuild}" ] || multibuild="$topsrc/vobs/tisc_ccu-c/load/bld/multibuild.sh"
    ${multibuild} "$@" "$multibuildinfo"
}



# If invoked in directory with multiple builddirs directly below, it invoke for each.
multimode=""
# Unfortunately, we need absolute path for multibuild.info:
for multibuildinfo in $(pwd)/*/multibuild.info ; do
  if [ -e "$multibuildinfo" -a "$tryinfo" ] ; then
      multimode=1
      useinfo "$@"
  fi
done
[ "$multimode" ] && exit 0



# Maybe we already have "vobs" as sibling (special case for tisc-src itself):
[ -d "${workingdir}/vobs" ] && workingdir="${workingdir}/vobs"

# try to find "vobs" directory in current working directory:
# remove last directory until it ends with 'vobs', e.g.
while [ ${workingdir#*vobs} ] ; do
    # If we have multibuild.info (and no parameters), use its parameters
    if [ -e "${workingdir}/multibuild.info" -a "$tryinfo" ] ; then
        multibuildinfo="${workingdir}/multibuild.info"
        useinfo "$@"
        exit 0
    fi
    workingdir=${workingdir%/*}
    #echo workingdir=$workingdir
    # Maybe we found it as sibling:
    [ -d "${workingdir}/vobs" ] && workingdir="${workingdir}/vobs"
done
multibuild="$workingdir/tisc_ccu-c/load/bld/multibuild.sh"
#echo multibuild=$multibuild

# exec does the error handling here (gives e.g. "No such file or directory")
exec $multibuild "$@"
echo "Failed to execute multibuild" >&2
exit 2

# vim: et ts=4 sw=4
