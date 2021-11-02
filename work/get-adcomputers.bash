#!/bin/bash
# This gets all computers from a Active Directory domain.
# Based on https://stackoverflow.com/a/26215568
#   Get-ADComputer -Filter * | ForEach-Object {$_.Name}

locdomain="dcsd"

warn() { echo "$@" >&2 ; }
die()  { warn "FATAL: $@" ; exit 1 ; }

# Show AD controllerr name:
# nslookup -type=any "_ldap._tcp.$locdomain.local"
# Non-authoritative answer:
# _ldap._tcp.$locdomain.local   service = 0 100 389 w2kcsd.dcsd.local.
dcrr=$(dig  "_ldap._tcp.$locdomain.local" SRV|grep "$locdomain.local.$")
echo -e "Domain Controller Resource Record:\n  $dcrr"
dc="${dcrr##* }"
echo "Pinging Domain Controller \"$dc\":"
set pipefail
#ping -q -l3 -c1 -w3 $dc|grep ms || die "Cannot reach $dc"
ping -q -l3 -c1 -w3 $dc \
  | perl -ne '/ms/ && print "  $_" ' \
  || die "Cannot reach $dc"

server="$dc"
test -e  "$USER-pass.bin" || die "FATAL: No $USER-pass.bin found."
user="$locdomain\\$USER"
#-w 'thepassword' would be visible in ps!
ldapsearch -LLL -H "ldap://$server" -x -D "$user" -y "$USER-pass.bin" \
  -b "dc=$locdomain,dc=local" \
  'objectClass=computer' name \
  | grep "^name:"

