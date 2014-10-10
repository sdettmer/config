#!/usr/bin/perl -w
# See http://www.colordiff.org/
#
# $Id: colordiff.pl,v 1.4.2.2 2003/03/06 13:41:12 daveewart Exp $

########################################################################
#                                                                      #
# ColorDiff - a wrapper/replacment for 'diff' producing                #
#             colourful output                                         #
#                                                                      #
# Copyright (C)2002-2003 Dave Ewart (davee@sungate.co.uk)              #
#                                                                      #
########################################################################
#                                                                      #
# This program is free software; you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation; either version 2 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# This program is distributed in the hope that it will be useful,      #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with this program; if not, write to the Free Software          #
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.            #
#                                                                      #
########################################################################

use strict;

my $app_name     = 'colordiff';
my $version      = '1.0.1';
my $author       = 'Dave Ewart';
my $author_email = 'davee@sungate.co.uk';
my $app_www      = 'http://colordiff.sourceforge.net/';
my $copyright    = '(C)2002-2003';
my $show_banner  = 1;

# ANSI sequences for colours
my %colour;
$colour{white}    = "\033[1;37m";
$colour{yellow}   = "\033[1;33m";
$colour{green}    = "\033[1;32m";
$colour{blue}     = "\033[1;34m";
$colour{cyan}     = "\033[1;36m";
$colour{red}      = "\033[1;31m";
$colour{magenta}  = "\033[1;35m";
$colour{OFF}      = "\033[0;0m";

# Default colours if /etc/colordiffrc or ~/.colordiffrc do not exist
my $plain_text = $colour{white};
my $file_old   = $colour{red};
my $file_new   = $colour{blue};
my $diff_start = $colour{magenta};

# Locations for personal and system-wide colour configurations
my $HOME   = $ENV{HOME};
my $etcdir = '/etc';

my ($setting, $value);
my @config_files = ("$etcdir/colordiffrc", "$HOME/.colordiffrc");
my $config_file;

foreach $config_file (@config_files) {
    if (open(COLORDIFFRC, "<$config_file")) {
        while (<COLORDIFFRC>) {
            chop;
            next if (/^#/);
            ($setting, $value) = split ('=');
            if ($setting eq 'banner') {
                if ($value eq 'no') {
                    $show_banner = 0;
                }
                next;
            }
            if (!defined $colour{$value}) {
                print "Invalid colour specification ($value) in $config_file\n";
                next;
            }
            if ($setting eq 'plain') {
                $plain_text = $colour{$value};
            }
            elsif ($setting eq 'oldtext') {
                $file_old = $colour{$value};
            }
            elsif ($setting eq 'newtext') {
                $file_new = $colour{$value};
            }
            elsif ($setting eq 'diffstuff') {
                $diff_start = $colour{$value};
            }
            else {
                print "Unknown option in $etcdir/colordiffrc: $setting\n";
            }
        }
        close(COLORDIFFRC);
    }
}
if ($show_banner == 1) {
    print STDERR "$app_name $version ($app_www)\n";
    print STDERR "$copyright $author, $author_email\n\n";
}

my $diff_type = 'unknown';

my $nrecs = 0;
my $inside_file_old = 1;
if (defined $ARGV[0]) {
    open(INPUTSTREAM, "diff @ARGV|");
    while(<INPUTSTREAM>) {
        &process_record;
    }
    close(INPUTSTREAM);
}
else {
    while (<STDIN>) {
        &process_record;
    }
}

sub process_record() {
    $nrecs++;
    if ($nrecs == 1) {
        if (/^[1-9]/) {
            $diff_type = 'basic';
        }
        elsif (/^---/) {
            $diff_type = 'u';
        }
        elsif (/^\*\*\* /) {
            $diff_type = 'c';
        }
    }
    if ($diff_type eq 'unknown') {
        if (/^diff -u/) {
            $diff_type = 'u';
        }
        elsif (/^diff -c/) {
            $diff_type = 'c';
        }
        elsif (/^diff /) {
            $diff_type = 'basic';
        }
    }
    elsif ($diff_type eq 'c') {
        if ($nrecs == 1) {
            print "$file_old";
        }
        elsif ($nrecs == 2) {
                print "$file_new";
        }
        elsif (/^- /) {
            print "$file_old";
        }
        elsif (/^\+ /) {
            print "$file_new";
        }
        elsif (/^\*{4,}/) {
            print "$diff_start";
        }
        elsif (/^\*\*\* /) {
            print "$diff_start";
            $inside_file_old = 1;
        }
        elsif (/^--- /) {
            print "$diff_start";
            $inside_file_old = 0;
        }
        elsif (/^!/) {
            if ($inside_file_old == 1) {
                print "$file_old";
            }
            else {
                print "$file_new";
            }
        }
        else {
            print "$plain_text";
        }
    }
    elsif ($diff_type eq 'u') {
        if (/^-/) {
            print "$file_old";
        }
        elsif (/^\+/) {
            print "$file_new";
        }
        elsif (/^\@/) {
            print "$diff_start";
        }
        else {
            print "$plain_text";
        }
    }
    elsif ($diff_type eq 'basic') {
        if (/^</) {
            print "$file_old";
        }
        elsif (/^>/) {
            print "$file_new";
        }
        elsif (/^[1-9]/) {
            print "$diff_start";
        }
        else {
            print "$plain_text";
        }
    }
    s/$/$colour{OFF}/;
    print "$_";
}
