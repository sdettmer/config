#!/usr/bin/perl -np
# This is config spec patcher hack.
# This is an untested hack that may kill your pet.
# It will use the output of "clearcase ci" to patch a config spec.

our $checkinlog;
our $startlineregex;
our $replacements;
our $patch;

sub usage()
{
  # ~/tmp/out.txt could be generated by:
  # cp message ~/tmp/out.txt
  # ct ci -c `cat message` | tee -a ~/tmp/out.txt
  die "usage: cspatch <checkin_log_file> <start_tag_regex>\n"
    . " e.g.: cspatch ~/tmp/out.txt \"BEGIN wcg-load ASV\"\n"
    . " e.g.: perl -npi ./cspatch.pl ~/tmp/sync_out.txt \"BEGIN wcg-load ASV\" /vobs/path/my.cs\n";
}

BEGIN
{
  $checkinlog = shift @ARGV || usage;
  $startlineregex = shift @ARGV || usage;
  {
    open LOG, "$checkinlog" or die "Failed to open log $checkinlog: $!\n";
    my @loglines = (<LOG>);
    close LOG, "$checkinlog" or die "Failed to close log $checkinlog: $!\n";
    my $maxlen = -1;
    # find length of longest log line. Be quick include everything, we just need an idea for tab size.
    map { if (length > $maxlen) { $maxlen = length; } } @loglines;
    $maxlen += -length('Checked in "" version "/main/1".') + 2;
    $maxlen += -$maxlen % 4; # For Micha, who wants dividable by 4.

    my @patchlines = ();
    push @patchlines, ""; # start with a blank line.
    foreach my $logline (@loglines) {
      chomp $logline;
      if ($logline =~ m/^Checked in "(\S*)" version "(\S*)"\.$/) {
         my ($element, $version) = ($1, $2);
         $element =~ s|/view/[^/]+/|/|; # cut optional "/view/sdettmer_latest/" prefix
         # Whitespace-free without quoting.
         $logline = sprintf "    element %*s %s", -$maxlen, "$element", $version;
      } elsif ($logline =~ m/^Checked in (".*") version (".*")\.$/) {
         my ($element, $version) = ($1, $2);
         $element =~ s|/view/[^/]+/|/|; # cut optional "/view/sdettmer_latest/" prefix
         # whitespace in path -> quoting.
         $logline = sprintf "    element %*s %s", -$maxlen+1, "$element", $version;
      } elsif ($logline =~ m/^cleartool: Warning: Version checked in is not selected by view\.$/) {
          # ignore
          $logline = undef;
      } else {
         # comment
         $logline = "    # $logline";
      }
      push @patchlines, $logline unless (!defined($logline));
    }
    $patch = join("\n", @patchlines);
  }
  warn "log \"$checkinlog\", regex \"$startlineregex\", ARGV: @ARGV\n";
}

if (s/($startlineregex)/\1\n$patch/) {
  $replacements++;
  # warn "xxx $replacements replacements\n";
}

END
{
  # warn "log \"$checkinlog\", regex \"$startlineregex\", ARGV: @ARGV\n";
  warn "$replacements replacements\n";
  if ($replacements == 0) {
      die "No replacements performed!\n";
  }
}
