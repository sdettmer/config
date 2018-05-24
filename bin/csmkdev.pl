#!/usr/bin/perl -w
# This is Clear Tool config spec branch adder.
# It gets a branchname as first argument and patches it into
#   config spec at the positions with the "DEV:" marker.
# These markers have to be in the following format:
#   #DEV: element /vobs/TWCS_HEN/wcg/...                 .../dev_<user>_<feature_or_scr>/LATEST
#   #DEV: mkbranch dev_<user>_<feature_or_scr>
#   #DEV: end mkbranch dev_<user>_<feature_or_scr>
# Please note, that "dev_<user>_<feature_or_scr>" is a fixed
#   token (template name) and cannot be changed.
# Command line option "-m" creates an appropriate branch type in
#   all VOBS from CLEARCASE_AVOBS.
# TODO support a -c "comment" option

use strict;

my $vobmnt="/vobs";

my $mkbrtype=0;
my $comment="";
if ($ARGV[0] eq  "-c") {
    shift;
    warn "Will use branch comment.\n";
    $comment=shift;
}
if ($ARGV[0] eq  "-m") {
    warn "Will create branch type on CLEARCASE_AVOBS=$ENV{'CLEARCASE_AVOBS'}\n";
    $mkbrtype=1;
    shift;
}
my $branchname=shift;
$comment=$branchname unless ($comment);

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
if ($branchname !~ m/^[a-zA-Z]\w+$/) {
    die "First argument must be valid branchname (not \`$branchname').\n"
      . "Hint: invoke without arguments to get usage help.\n"
} elsif (!$branchname) {
    die "First argument must be branchname.\n"
      . "Hint: invoke without arguments to get usage help.\n"
}

while (my $line = <>) {
    #chop $line;
    $line =~ s/[\r\n]*$//g; # like chmop, but works also for DOS LFs.

    # "Enable" the following rules with "filled" out values:
    #  #DEV: element /vobs/TWCS_HEN/wcg/...                 .../dev_<user>_<feature_or_scr>/LATEST
    #  #DEV: mkbranch dev_<user>_<feature_or_scr>
    #  #DEV: end mkbranch dev_<user>_<feature_or_scr>
    if ($line =~ m/^\s*#\s*DEV:/) {
        $line =~ s/^\s*#\s*DEV:\s*(.*)dev_<user>_<feature_or_scr>/$line\n$1${branchname}/;
    }
    print $line, "\n";
}

if ($mkbrtype) {
    # "Specify CLEARCASE_AVOBS as a list of VOB tags separated by commas,
    # white space, or colons (UNIX and Linux) or by semicolons (Windows)."
    for my $vob (split(/[\s,:;]+/, $ENV{'CLEARCASE_AVOBS'})) {
       print STDERR `cleartool mkbrtype -c "$comment" $branchname\@$vob`
    }
}

