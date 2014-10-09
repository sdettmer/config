#!/usr/bin/perl -w
# This is Clear Tool DOS -> Unix config spec converter

use strict;

my $vobmnt="/vobs";

while (my $line = <>) {
    #chop $line;
    $line =~ s/[\r\n]*$//g; # like chmop, but works also for DOS LFs.

    # Prepent the VOBs mountpoint "/vobs":
    #   element -dir /twcs_tools/3p                    /main/LATEST
    #   load /vobs/TcmsGenSw/tools
    $line =~ s/^(\s*(#\s*|#\s*DEV:\s*)?(element|load)(\s+-\w+)*\s+)(\/)/$1$vobmnt$5/;
    print $line, "\n";
}
