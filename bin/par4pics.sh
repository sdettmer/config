#!/bin/bash
# This is PAR2 file creator for JPEG pics.
# I'd better used Perl.

set -e

check=yes
shopt -s nullglob
par2=~/work/par2cmdline/par2
warn() { echo "WARNING: $@" >&2 ; }
die()  { warn "$@" ; exit 1 ; }
[ -x $par2 ] || { die "Cannot execute $par2"; }

echo "started at $(date)"
for dir in "$@" ; do
    IFS=$'\n' pars=( $(find $dir -maxdepth 1 -type f -iname '*.par*') )
    if [ "$pars" -a "$check" ] ; then
        # FIXME This does not work when there are multiple different
        #   sets of PAR files: par2 seems simply to use the first!
        echo "Check   $dir (${#pars[*]} PAR files)"
        ret=0
        IFS=$'\n' parout=( $($par2 v -q -B "$dir" $pars) ) || ret=$? || true
        if [ "$ret" -ne 0 ] ; then
            echo "ERROR in PAR2 verification ($ret) in $dir";
            warn "PAR2 verification error $ret in $dir";
            printf "%s\n" "${parout[@]}"
            # echo "DEBUG: continue?" ; read
        else
            echo "OK:     $dir";
        fi
    elif [ "$pars" -a "$check" != "yes" ] ; then
        echo "Skip   $dir (${#pars[*]})"
    else
        # TODO handle CR2 in own PAR files
        files=( $dir/*.JPG $dir/*.jpg $dir/*.jpeg $dir/*.JPEG $dir/*.CR $dir/*.cr $dir/*.CR2 $dir/*.cr2 )
        allfiles=( $dir/* )
        echo "Create  $dir (for ${#files[*]} of ${#allfiles[*]} files)"
        if [ ${#files[*]} -eq 0 ] ; then
            warn "No files in $dir!"
        else
            basename=$(basename $dir)
            arcname="$dir/$basename"
            size=$(du -csm "${files[@]}" | tail -1 | cut -f 1)
            # Calculate desired reundancy and use as -rm argument
            # Redundancy in MB: 4%
            rm=$((size/(100/4)))
            # min 10 MB
            if [ "$rm" -lt 10 ] ; then rm=10 ; fi
            # Check for largest files in MB, calculate * 2.5 and
            largest=$(du -sm "${files[@]}" | sort -n | tail -1 | cut -f 1)
            largestrm=$((largest*2+(largest/2)))
            if [ "$rm" -lt "$largestrm" ] ; then rm="$largestrm"; fi
            # value for the "n" argument
            n=2
            # lograrithmically grow when > 39 (39-19=20 --> log=2.99)
            # rounded down. 40+: 3 files, 74+: 4 files, 168+: 5 files...
            nmin=$(echo "scale=0;l($rm-19)"|bc -l)
            if [ "$n" -lt "$nmin" ] ; then n="$nmin"; fi
            echo "- Total $size MB, largest $largest MB -->" \
                 "Redundancy $rm MB in $n files."
            echo $par2 c -B"$dir" -v -a "$arcname" -s128000 -rm"$rm" -n"$n" --
            # "${files[@]}"
            # echo "DEBUG: continue?" ; read
            $par2 c -B"$dir" -v -a "$arcname" -s128000 -rm"$rm" -n"$n" -- \
               "${files[@]}"
            parsize=$(du -csm *par2|tail -1 |cut -f 1)
            echo "Created $dir ($parsize MB for ${#files[*]} files)"
            echo "(done   at $(date))"
       fi
    fi
done
echo "done    at $(date)"


# ~/work/par2cmdline/par2 c -v -a "$(basename $(pwd))" -s128000 -rm20 -n2 -- *.JPG
# vim: et ts=4 sw=4
