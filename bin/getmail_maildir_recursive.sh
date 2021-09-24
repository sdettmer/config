#!/bin/bash
# This gets a recursive structure of Windows-style *.eml files
# and imports them via getmail_maildir preserving the paths as
# Maildir structure.
# Needs on Debian: sudo apt install getmail
# In dovecot:
#   mail_location = maildir:~/Maildir:LAYOUT=fs
# BUGS:
#   This is very very slow, it boots python for each message.

# Needs maildirmake from package maildrop
# OR    maildirmake.dovecot from dovecot-core
maildirmake=maildirmake.dovecot

indir="$1"
outdir="$2"
if [ ! -d "$outdir/cur" ] ; then
   echo "No directory: $outdir/cur" >&2
   echo -e "Usage:\n  $0 $indir $outdir"
   echo -e "Example:\n  $0 Winmail ./Maildir/"
   exit 2
fi
if ! getmail_maildir -h >/dev/null ; then
   echo "Error executing getmail_maildir."
   exit 2
fi

process()
{
    files=0
    total="$(find "$indir" -iname '*.eml' -print | wc -l)"
    echo "Will import $total files."
    find "$indir" -iname '*.eml' -print0 |
        while IFS= read -r -d '' emlfile ; do
            files=$((files+1))
            path=${emlfile%/*}
            file=${emlfile##*/}
            if [ $((files % 37)) = 0 ] ; then
                printf "%3d%% in %s:%s to %s\n" \
                  "$((100*$files/$total))" "$path" "$file" "$outdir/$path"
            fi
            #echo "   $emlfile"
            if [ ! -d "$outdir/$path/cur" ] ; then
                echo "Creating new Maildir folder $outdir/$path"
                maildirmake.dovecot "$outdir/$path/"
            fi
            getmail_maildir "$outdir/$path/" < "$emlfile"
        done

    got="$(find "$outdir" -type f -print | wc -l)"
    echo "Having $got from $total files."
}

time process
