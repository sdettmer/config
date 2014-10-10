#!/usr/bin/perl -w
# Diffs given file against predecessor. If no files given, all
# checked out files are diff'd.
use strict;

my @files = ();
my $color = 1;

# Based on http://stackoverflow.com/questions/375398/any-way-to-use-a-custom-diff-tool-with-cleartool-clearcase
my ($arg_file, $switches) = @ARGV;
$switches ||= '-u';

my $me = "ctdiff.pl";

if ($arg_file) {
    # use given file only
    push @files, $arg_file;
} else {
    # use all checked out files
    @files = `cleartool lsco -avobs -me -cview -s`;
    if($? != 0) { dodie("$me: failed to determine checked out files."); }
    map { chomp } @files;
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
        my $predtemp = "c:\\temp\\pred.txt";
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
    print exec "diff $switches $predfile $file $colordiff | less";
}
