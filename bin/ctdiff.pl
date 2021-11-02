#!/usr/bin/perl -w
# Diffs given file against predecessor. If no files given, all
# checked out files are diff'd. If no files are checked out,
# all 
use strict;

my @files = ();
my $color = 1;
if (defined $ENV{'color'}) {
    $color = $ENV{'color'};
}

# Based on http://stackoverflow.com/questions/375398/any-way-to-use-a-custom-diff-tool-with-cleartool-clearcase
my ($arg_file, $switches) = @ARGV;
$switches ||= '-u';

my $me = "ctdiff.pl";

my $predtemp;
{
  use File::Temp qw/tempfile/;
  use File::Spec;
  my ($fh, $filename) = tempfile("ctdiff.tmp.pred.XXXXXXXXX",
      DIR=>File::Spec->tmpdir(), UNLINK => 1);
  $predtemp=$filename;
}

if ($arg_file) {
    # use given file only
    push @files, $arg_file;
} else {
    # use all checked out files
    # @files = `cleartool lsco -avobs -me -cview -s`;
    my $CLEARCASE_AVOBS=`cleartool catcs | grep -o "/vobs/[[:alpha:]|_|0-9-]*"| sort -u | tr "\\n" ":" | sed -e "s/:\$//"`;
    if (!$CLEARCASE_AVOBS) { $CLEARCASE_AVOBS = "/vobs/TcmsGenSw:/vobs/tisc_ccu-c"; }
    @files = `CLEARCASE_AVOBS=$CLEARCASE_AVOBS; cleartool lsco -avobs -me -cview -s`;
    if($? != 0) { dodie("$me: failed to determine checked out files."); }
    if (@files) {
        print "Diffing all checked out files ($CLEARCASE_AVOBS).\n";
        map { chomp } @files;
    }
}

# Neither argument given nor checked out files present - try branch.
if (!@files) {
    my $mkbranch = `cleartool catcs | grep -e ^\\s*mkbranch`;
    my $branch;
    if ($mkbranch =~ m/^\s*mkbranch\s+(\w+)$/) {
        print "Branch $1\n";
        $branch=$1;
    }
    if ($branch) {
        #@files = `ct find -avobs -type f -version "brtype($branch)" -print | grep -v '/0$'`
        @files = `cleartool find -avobs -type f -version "brtype($branch)" -print | grep -v '/0\$'`
        # Note: we keep the @@/version part. This ensures that we
        # do not see changes that have not been checked in, which
        # could not be desired in all cases. Here it is, because
        # we use this diff mode only if there are not checked out files.
        # TODO it makes not much sense to diff against last
        # version if a file was checked in multiple times in the
        # branch. This should be addressed in future versions.
    }
    if (@files) {
        print "Diffing all files with branch \"$branch\" against their last revision (NOT first).\n";
        map { chomp } @files;
        # print join ("\n", @files), "\n";
    }
}

# Check if we can use ctdiff.pl
if ($color) {
   my $have_ctdiff = `which ctdiff.pl`;
   if ($? != 0) {
       warn "Color mode requested, but ctdiff.pl not found.\n";
       $color = 0;
   }
}

foreach my $file (@files) {
    my ($element, $version, $pred)
    = split(/;/,`cleartool describe -fmt '%En;%Vn;%PVn' $file`);

    unless ($pred) { die "$me: $file has no predecessor\n"; }

    # figure out if view is dynamic or snapshot
    my $is_snapshot = 0;
    my $str1 = `cleartool lsview -long -cview`;
    if($? != 0) { dodie("$me must be executed within a clearcase view"); }
    my @ary1 = grep(/Global path:/, split(/\n/, $str1));
    if($str1 =~ /View attributes: snapshot/sm) { $is_snapshot = 1; }

    my $predfile = "$element\@\@$pred";
    $predfile =~ s/\'//g;#'
    # printf("$predfile\n");
    if ($is_snapshot) {
        #my $predtemp = "c:\\temp\\pred.txt";
        unlink($predtemp);
        my $cmd = "cleartool get -to $predtemp $predfile"; printf("$cmd\n");
        my $str2 = `$cmd`;
        $predfile = $predtemp;
    }
    sub dodie {
        my $message = $_[0];
        print($message . "\n");
        exit 1;
    }

    my $colordiff = "";
    if ($color) { $colordiff = "| colordiff.pl"; }
    open (DIFF, "diff $switches $predfile $file $colordiff | less |")
        or dodie("$me: failed to create diff pipe: $!.");
    while (my $line = <DIFF>) {
        $line =~ tr|\r\n||d;
        print "$line\n";
    }
}
