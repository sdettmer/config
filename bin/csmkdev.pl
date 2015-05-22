#!/usr/bin/perl -w
# This is Clear Tool config spec branch adder.
# It gets a branchname as first argument and patches it into
# config spec at the positions with the "DEV:" marker.
# These markers have to be in the following format:
#   #DEV: element /vobs/TWCS_HEN/wcg/...                 .../dev_<user>_<feature_or_scr>/LATEST
#   #DEV: mkbranch dev_<user>_<feature_or_scr>
#   #DEV: end mkbranch dev_<user>_<feature_or_scr>
# Please note, that "dev_<user>_<feature_or_scr>" is a fixed
# token (template name) and cannot be changed.

use strict;

my $vobmnt="/vobs";

my $prefix;
my $user;
my $name;

my $branchname=shift;

# poor mans basename:
my $scriptname=$0;
$scriptname =~ s/^.+?([^\/]+)$/$1/;

if (!$branchname) {
    die "This is Clear Tool config spec branch adder.\n"
      . "Usage:\n"
      . "  $scriptname <branchname>\n"
      . "Example:\n"
      . "  $scriptname dev_sde_wcg_scr_b2pis00003408 < wcg_dt5_latest_unx.cs \\\n"
      . "        > dev_sde_wcg_scr_b2pis00003408.cs\n";
}
if ($branchname =~ m/^((dev)_([a-zA-Z]+))_((\w+))$/) {
    $prefix=$1;
    $user=$3;
    $name=$4;
} else {
    die "First argument must be branchname.\n"
      . "Hint: invoke without arguments to get usage help.\n"
}
#die "p=$prefix\nuser=$user\nname=$name\n";

while (my $line = <>) {
    #chop $line;
    $line =~ s/[\r\n]*$//g; # like chmop, but works also for DOS LFs.

    # "Enable" the following rules with "filled" out values:
    #  #DEV: element /vobs/TWCS_HEN/wcg/...                 .../dev_<user>_<feature_or_scr>/LATEST
    #  #DEV: mkbranch dev_<user>_<feature_or_scr>
    #  #DEV: end mkbranch dev_<user>_<feature_or_scr>
    if ($line =~ m/^\s*#\s*DEV:/) {
        $line =~
        s/^\s*#\s*DEV:\s*(.*)dev_<user>_<feature_or_scr>/$line\n$1dev_${user}_${name}/;
    }
    print $line, "\n";
}
