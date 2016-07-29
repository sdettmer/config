#!/usr/bin/perl

use Date::Parse;
#use POSIX;
#use MIME::QuotedPrint;

$max_days = 30;        #move elder by Date:
$never_touch_days = 3; #mtime; ignore them even if elder by Date:
$ignore_parse_errors = 1; #bool

$now = time;

#Path to work behind:
$path = "/home/steffen";

$src  = "Mail-In";
$dest = "Mail/!__Archive__!";

$logfile= "$path/Mail/logs/move-mail.log";
open(LOG, ">>$logfile")
    or die "Cannot open logfile $logfile: $?\n";

sub print_err(@)
{
    $mv+=0;
    $err+=0;
    $hits+=0;
    $n_mv+=0;
    print(LOG @_);
    print(@_);
}

$findmaildirs="find $path/Mail-In -type d -maxdepth 2"
            . " -not -path '*/new' -not -path '*/cur'"
            . " -not -path '*/tmp' -print0";

$findmail_param="-print0 -type f -mtime $never_touch_days";

print("Collecting maildirs...\n");
@MAILDIRS=split("\0", `$findmaildirs`);
print("Done: ", $#MAILDIRS + 1, " found.\n");

#print join("\nxxx:", @MAILDIRS), "\n";

$dir_count=0;

DIR:
foreach $dir (@MAILDIRS) {
    $dir_count++;
    $now_dir = time;
    $hits=0;
    $mv=0;
    $err=0;
    print("* Collecting mails in [", $dir_count, "/",
        $#MAILDIRS + 1, "] $dir...\n");
    if (! -d "$dir/cur") {
        print_err("  --> Directory $dir does not look like a maildir!\n");
        next DIR;
    }
    @mails=split("\0", `find $dir/cur $findmail_param`);
    print("  Done: ", $#mails, " found.\n");
    #print join("\nxxx:", @mails), "\n";

    MAIL:
    foreach $mail (@mails) {
        open(MAIL, "<$mail")
            or die "Cannot open Mail $mail: $?\n";
        while(<MAIL>) {
            if ( m/^Date:\s+(.*)$/ ) {
                $hits++;
                $file = $mail;
                $date = $1;
                $time = str2time($date);
                $age = ($now - $time)/3600/24 ;
                if (!$ignore_parse_errors and $time == 0) {
                    $filep = $file;
                    $filep =~ s|^$path/($src/.*)$|~/$1|;
                    print_err "+----[ FATAL: cannot parse Date: field here! ]---\n";
                    print_err "| File : $filep (#", $hits,")\n";
                    print_err "| Sting: $_";
                    print_err "| Date : $date (", $time/3600/24," epoch days)\n";
                    $err++;
                    next MAIL;
                }
                $new = $file;
                if ( !($new =~ s|^$path/$src/ 
                                |$path/$dest/|x )) {
                    $filep = $file;
                    $filep =~ s|^$path/($src/.*)$|~/$1|;
                    print_err "+----[ FATAL: cannot get new path here! ]---\n";
                    print_err "| File : $filep (", $hits,")\n";
                    $err++;
                    next MAIL;
                }
                $file =~ m|^$path/$src/(.*)$|;
                $filep = $1;
                $new =~ m|^$path/$dest/(.*)$|;
                $newp = $1;
                $new =~ m|^($path/$dest/.*/)cur/|;
                $newd = $1;
                if ($newp ne $filep) {
                    $filep = $file;
                    $filep =~ s|^$path/($src/.*)$|~/$1|;
                    print_err "+----[ FATAL: paranoia path check failed here! ]---\n";
                    print_err "| File : $filep (", $hits,")\n";
                    $err++;
                    next MAIL;
                }
                if ($age > $max_days) {
                    if ( (! -d "$newd") || (! -d "$newd/cur")) {
                        $filep = $file;
                        $filep =~ s|^$path/($src/.*)$|~/$1|;
                        $newd =~ s|^$path/($src/.*)$|~/$1|;
                        print_err "+----[ FATAL: archive directory does not exist! ]---\n";
                        print_err "| File : $filep (", $#mails+1,")\n";
                        print_err "| Path : $newd\n";
                        print_err `/var/qmail/bin/maildirmake $newd\n`;
                    }
                    print LOG "COMMAND: mv '$file' '$new'\n";
                    print LOG "    AGE: ", int($age), " days\n";
                    print LOG "   UNDO: mv '$new' '$file'\n";
                    print_err `mv '$file' '$new'`;
                    $mv++;
                } else {
                    $n_mv++;
                    #print "to young $file\n";
                    #print "   (AGE: ", int($age), ")\n";
                }
                next MAIL;
            }
        }
    } continue {
        close MAIL;
    }
    print("  (Moved: $mv of $hits with $err errors)\n");
    $dura = time - $now_dir;
    if ( ($dura != 0) and ($hits != 0) ) {
        $string = sprintf("  (Time: %d secs, %.2f mails/sec, %.6f sec/mail)\n", 
            $dura, $hits/($dura+0.001), $dura/($hits+0.001));
        print_err($string);
    }
    $mv_total += $mv;
    $hits_total += $hits;
    $err_total += $err;
}

$dura = time - $now;
print_err("Done. Moved: $mv_total of $hits_total with $err_total errors\n");
if ( ($dura != 0) and ($hits_total != 0) ) {
    $string = sprintf("Time: %d secs, %.2f mails/sec, %.6f sec/mail\n", 
        $dura, $hits_total/($dura+0.001), $dura/($hits_total+0.001));
    print_err($string);
}

