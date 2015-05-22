#!/bin/bash
# This diffs the view contents of two Clear Case config specs.
# Based on my old coloring diff wrapper, just added the view
# cleartool view support. By this, changed argument usage
# (now gets three normal parameters: 2 x cs and path)

function warn() { echo "$@" >&2 ; }
function die() { warn "FATAL: $@" ; exit 2 ; }
ME=$(basename -- $0)

function usage()
{
  echo "Diffs the view contents as defined by two config specs."
  echo "Usage: $ME [opts] <config_spec_a.cs> <config_spec_b.cs> [path]"
  echo "Path default to \"/vobs\"."
  echo "Options:"
  echo "  -h               Show this help text and exit"
  echo "  -k               keep views"
  echo "  -C               Do not use colordiff.pl, even if found in PATH"
  echo "  -p <executable>  Pipe diff output to executable"
}

function usage_err()
{
    warn "$@"
    warn "Try $ME -h for help."
    exit 1
}

if [ -x "`type -p colordiff.pl`" ] ; then
    pipe=`type -p colordiff.pl`
fi

while getopts ":khp:C" opt; do
  case $opt in
    C) pipe=;;
    p) pipe=$OPTARG;;
    k)
      warn "Argument -k passed, will keep views."
      keep=1
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      usage_err "Invalid option: -$OPTARG."
      ;;
    :)
      usage_err "Option -$OPTARG requires an argument."
      ;;
  esac
done
shift $((OPTIND-1))

CS_A=$1
shift
CS_B=$1
shift
DIFFPATH=${1:-/vobs}
shift

if [ -z "$CS_B" ] ; then
    usage_err "Two config specs required as parameters."
fi

if [ "$1" ] ; then
    usage_err "Unknown trailing command line arguments remaining: $@."
fi

if [ ! -r "$CS_A" ] ; then
    usage_err "Cannot read config spec $CS_A."
fi
if [ ! -r "$CS_B" ] ; then
    usage_err "Cannot read config spec $CS_B."
fi
if [ "$pipe" -a ! -x "`type -p $pipe`" ] ; then
    usage_err "Cannot execute pipe executable $pipe."
fi

test -d /view/. || die "no /view directory"

function at_exit()
{
    if [ "$keep" ] ; then
        warn "keeping state"
    else
        warn "Cleaning up..."
        test "$VIEW_A" && cleartool rmview -f -tag "${VIEW_A}"
        test "$VIEW_B" && cleartool rmview -f -tag "${VIEW_B}"
    fi
}
trap at_exit EXIT

function viewname()
{
    name=$1
    test "$name" || die "viewname: manadatory parameter missing"
    test "$USER" || die "viewname: \$USER not set"
    shift
    name=$(basename "${name%.cs}")
    name=$(echo -n "$name" | tr -c '[:alnum:]' '_')
    echo ${USER}_tmp_${name} # return
}

function viewsetup()
{
    view=$1
    cs=$2
    test "$cs" || die "viewsetup: manadatory parameter(s) missing"
    if [ -e "/view/${view}" ] ; then
        warn "View $view seems to exist, shall I try to remove it first (y/N)?"
        read a
        if [ "$a" = "y" ] ; then
            cleartool rmview -f -tag ${view}
        fi
    fi
    cleartool mkview -tag "$view" -stgloc nasviewstore || die "csdiff.sh: failed to mkview $view (status $?)"
    cleartool setcs -tag "$view" "$cs" || die "csdiff.sh: failed to setcs -tag $view $cs (status $?)"
    test -d "/view/${view}" || die "no /view/${view} directory"
}

VIEW_A=$(viewname $CS_A)
VIEW_B_=$(viewname $CS_B)
if [ "$VIEW_A" = "$VIEW_B_" ] ; then
    warn "Both view names are the same: $VIEW_A"
    usage
    exit 1
fi

echo $VIEW_A
viewsetup "$VIEW_A" "$CS_A"

VIEW_B=$VIEW_B_
echo $VIEW_B
viewsetup "$VIEW_B" "$CS_B"

DIFFPATH=${DIFFPATH#/} # cut leading slash

if [ "$pipe" ] ; then
  diff -Nur "/view/$VIEW_A/$DIFFPATH" "/view/$VIEW_B/$DIFFPATH" | $pipe
else
  diff -Nur "/view/$VIEW_A/$DIFFPATH" "/view/$VIEW_B/$DIFFPATH"
fi

if [ "$keep" ] ; then
  VIEW_A=
  VIEW_B=
fi

# vim: set et ts=4 sw=4:
