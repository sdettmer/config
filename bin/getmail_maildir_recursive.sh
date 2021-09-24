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
    echo "Deleting todo files..."
    find "$outdir/" -iname '.todo-std-import' -print0 | \
        xargs --null --no-run-if-empty rm
    echo "Creating todo files..."
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
            #getmail_maildir "$outdir/$path/" < "$emlfile"
            echo "$emlfile" >> "$outdir/$path/.todo-std-import"
        done

    files="$(find "$outdir/" -iname '.todo-std-import' -print | xargs cat | wc -l)"
    total="$(find "$outdir/" -iname '.todo-std-import' -print | wc -l)"
    echo "Procssing $files from $total todo files..."
    files=0
    find "$outdir/" -iname '.todo-std-import' -print0 |
        while IFS= read -r -d '' todofile ; do
            echo "todofile = $todofile"
            files=$((files+1))
            path=${todofile%/*}
            file=${todofile##*/}
            if [ $((files % 1)) = 0 ] ; then
                printf "%3d%% in %s:%s to %s\n" \
                  "$((100*$files/$total))" "$path" "$file" "$path"
            fi
            echo "cat $todofile | xargs cat | getmail_maildir $path/"
            cat "$todofile" | xargs cat | getmail_maildir "$path/"
        done

    echo "Deleting todo files..."
    find "$outdir/" -iname '.todo-std-import' -print0 | \
        xargs --null --no-run-if-empty rm

    got="$(find "$outdir" -type f -print | wc -l)"
    echo "Having $got from $total files."
}

time process
