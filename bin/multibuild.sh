#!/bin/sh
# This is multibuild search & exec.
# If invoked ANYWHERE below tisc-src/vobs or tisc-src/build, it finds multibuild.sh.

workingdir=$(pwd)
#echo "in $workingdir"

# Maybe we already have it as sibling (special case for tisc-src itself):
[ -d "${workingdir}/vobs" ] && workingdir="${workingdir}/vobs"

# try to find "vobs" directory in current working directory:
# remove last directory until it ends with 'vobs', e.g.
while [ ${workingdir#*vobs} ] ; do
    workingdir=${workingdir%/*}
    #echo workingdir=$workingdir
    # Maybe we found it as sibling:
    [ -d "${workingdir}/vobs" ] && workingdir="${workingdir}/vobs"
    # If we have multibuild.info (and no parameters), use its parameters
    if [ -e "${workingdir}/multibuild.info" -a -z "$1" ] ; then
        echo "Using ${workingdir}/multibuild.info"
        . "${workingdir}/multibuild.info"
        # multibuild="$topsrc/vobs/tisc_ccu-c/load/bld/multibuild.sh"
        multibuild="$cmakesrcdir/multibuild.sh"
        exec $multibuild -n "$name" -p "$project" -t "$platformname" -b "$build_type"
        echo "Failed to execute multibuild.sh (via multibuild.info)" >&2
        exit 2
    fi
done
multibuild="$workingdir/tisc_ccu-c/load/bld/multibuild.sh"
#echo multibuild=$multibuild

# exec does the error handling here (gives e.g. "No such file or directory")
exec $multibuild "$@"
echo "Failed to execute multibuild" >&2
exit 2
