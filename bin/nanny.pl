#!/usr/bin/perl -w
#This is Steffen's universal nanny <steffen@dett.de>
#GPL applies, no warranty - as always :)

#I love setsid.

my $procname = "snort";
my $log="/var/log/rcscanlogd.log";
my $restart_command = "/usr/sbin/rcscanlogd restart";
my $timeout=10;

use strict;
use POSIX 'setsid';

sub my_log(@)
{
	my $parm = shift;
	my $pri = shift || "debug";
	`/usr/bin/logger -t nanny.pl[$$] -p $pri -- $parm`;
	print STDERR $parm;
}

sub my_die(@)
{
	my $parm = join("", @_);
	my_log($parm, "error");
	die "$parm\n";
}

sub my_wait_pid($)
{
	my $pid = shift;
	for (my $n=1; $n<$timeout; $n++) {
		sleep 1;
		print("after $n secs for $pid\n");
		if (!kill (0,$pid)) {
			print("$pid died after $n secs\n");
			return 0;
		}
	}
	return 1;
}

sub safe_system(@)
{
        my @command = @_;
        print "shell: @command\n";
        if (join("", @command) eq "") {
                return "";
        }


	my @res;
        my $pid = fork();

	if ($pid) {   # parent
		if (my_wait_pid($pid) == 0) {
			close(KID_TO_READ) || warn "kid exited $?";
			return;
		}

		print "TIMED OUT. PID $pid still alive - sending TERM\n";
		kill 15, $pid;
		if (my_wait_pid($pid) == 0) {
			close(KID_TO_READ) || warn "kid exited $?";
			return;
		}

		print "TIMED OUT. PID $pid still alive - sending KILL\n";
		kill 9, $pid;
		if (my_wait_pid($pid) == 0) {
			close(KID_TO_READ) || warn "kid exited $?";
			return;
		}

		print "TIMED OUT. PID $pid still alive(!)\n";

	} else {      # child
		#important for some rc scripts!!
		#otherwise they would block...
		close(STDIN);
		close(STDOUT);
		close(STDERR);
		open(STDOUT, ">>$log");
		open(STDERR, ">>$log");
		exec(@command)
		  || die "can't exec program: $!";
		# NOTREACHED
	}

}

sub REAPER {
	my $waitedpid = wait;
	$SIG{CHLD} = \&REAPER; #go for sure...
}

sub exit_sig {
   	my_die("exit_sig: caught signal.\n");
}


sub daemonize {
	chdir '/'               or die "Can't chdir to /: $!";
	defined(my $pid = fork) or die "Can't fork: $!";
	if ($pid) {
		print "Session $pid started.\n";
		exit 0;
	}
	open STDIN, '/dev/null' or die "Can't read /dev/null: $!";
	open STDOUT, ">>$log"   or die "Can't write to $log: $!";

	#Did I already told that I love setsid?
	setsid                  or die "Can't start a new session: $!";
	open STDERR, '>&STDOUT' or die "Can't dup stdout: $!";
	my_log "Nanny daemon session started.\n";
	$SIG{CHLD} = \&REAPER;
	$SIG{INT} = 'IGNORE';
	$SIG{TERM} = \&exit_sig;
	$SIG{PIPE} = \&exit_sig;
	$SIG{ABRT} = \&exit_sig;
	$SIG{HUP} = 'IGNORE'; #not supported
}


sub get_pids_by_ps()
{
	my $count = 0;
	my %pids;
	open(PIPE, "/bin/ps ax|")
		or my_die("cannot open PIPE: $!");
	my @ps = <PIPE>;

	if ($#ps == -1) {
		my_die("empty PIPE: $!");
	}

	foreach my $line (@ps) {
		chomp $line;
		$line =~ s/^(\s+)//;
		my ($pid, $tty, $state, $cpu, $proc, $param) 
			= split(/\s+/, $line);
		$param ||= "";
		#print "$line\n";
		#print "$pid, $tty, $state, $cpu, $proc, $param\n";

		if ($proc =~ m/$procname/) {
			#print "$proc [$pid] found\n";
			$pids{$pid} = "$proc $param";
			$count++;
		}

	}

	my_log("found $count processes.\n");
	return \%pids;
}

sub check_proc($)
{
	my $pids_ref = shift;

	my $found = 0;
	my $error = 0;

	foreach my $pid (keys %$pids_ref) {
		$found++;
		if (! kill 0, $pid) {
			my_log "PID: $pid: DIED!\n", "info";
			print "    was: " . $pids_ref->{$pid} . "\n";
			$error++;
		#} else {
		#	print "PID: $pid: alive!\n";
		}

	}

	if ($found == 0) {
		print "process not known\n";
		return 1;
	} elsif ($error != 0) {
		print "$error process(s) DIED!\n";
		return 2;
	} else {
		return 0;
	}
}

daemonize;

#get pids:
my $pids_ref = get_pids_by_ps;

my $ret;

while("true") {
	$ret=check_proc($pids_ref);

	if ($ret == 1) {
		#if unknown, rebuild list
		$pids_ref = get_pids_by_ps;
		$ret=check_proc($pids_ref);
	}

	if ($ret != 0) {
		my_log "trying restart, ret == $ret ...\n";
		print safe_system($restart_command);
		print "waiting a moment.\n";
		sleep 3;
		$pids_ref = get_pids_by_ps;
	}
	sleep 1;
}


