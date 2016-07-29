#!/bin/bash
#This is mail archiver <steffen@dett.de>

echo "this version is not finished!"

#at least target directory name is wrong, not more tested!
#  the archives will be renamed on each run (since they're still to large)
#  i.e. to: openssl-users-02-Apr-2000-02-Dec-2000 and so on
#  perl -ne 'if (/-\d{2}-\w{3}-\d{4}/) {print}'
#exit 1

#WORKS LIKE:
# My saved mails are in ~/Mail. Those folders may become really
# great (i.e. sent-mail). If they become to large, they are moved
# into Mail/!__Archive__! and renamed to "folder-date", i.e.
# "inbox-01-Jan-2000". This is done by this script.
# 
# I have my "inbox" in ~/Mail-In/ in different folders in maildir
# format. I move the Mails that are older that 30 days from
# that dir to ~/Mail/!__Archive__!/. If a folder becomes to
# large, it becomes renamed to "folder-date", i.e.
# "inbox-01-Jan-2000". This is done by this script.

#in short: incomming mail
#Mail/ --> Mail/!__Archive__!/
#saved mail:
#Mail/!__Archive__!/ --> Mail/!__Archive__!/*-date

#Files, that include -date are called "eternal archives" and will
#  not be changed anymore (usually :))

#trigger in KB:
trigger="10000"
# trigger for ONE special directory (HACK)
largename="/home/steffen/Mail/!__Archive__!/large"
largetripper="50000"

export LC_ALL="C"
DATE=`date +%d-%b-%Y` # i.e. Nov-1998
#here are the actual files
SRC='/home/steffen/Mail/'
#here are the archives
DEST='/home/steffen/Mail/!__Archive__!'

FILES=`find $SRC/* -maxdepth 0 -size +${trigger}k` #no recurse, no small
#echo $FILES

DIRS=`find $SRC/* -maxdepth 0 -type d -not -path "*/!__Archive__!*" -not -path "*/!__Conserved__!*" -not -path "*/!__Gmail__!*" -not -path "*/logs*"` 

ARCHIVE_DIRS=`find $DEST/* -maxdepth 0 -type d` 
#ARCHIVE_DIRS='/disk3/steffen/Mail/!__Archive__!/open*'

if [ "$1" != "doit" ] ; then
	echo "(displaying only - I will take NO actions!)"
	echo "   use \"$0 doit\" to move the folders!"
fi

if [ -x /var/qmail/bin/maildirmake ] ; then
	MAILDIRMAKE=/var/qmail/bin/maildirmake
elif [ -x /usr/bin/maildirmake ] ; then
	MAILDIRMAKE=/usr/bin/maildirmake
else
	echo "no /var/qmail/bin/maildirmake or /usr/bin/maildirmake - aborting."
	exit 1
fi

echo ""
echo "###################################################"
echo "# Mail folders run"
echo "##########################################"
echo ""
echo "*** Checking if we need to archive folders"
echo ""
#this section moves mail from Mail to Archive dir (wit
#renaming to *-date --> creates eternal archives
#it's for my saved messages.

#get sizes of files/dirs:
for dir in $DIRS
do
	size=`du -ks "$dir"|awk '{print $1}'`
	curtrigger=$trigger
	if [ "$dir" = "$largename" ] ; then
		curtrigger=$largetripper
	fi
	if [ $size -gt $curtrigger ] ; then
		echo "large Maildir $dir : $size > $curtrigger"
		#store if to large
		FILES="$FILES $dir"
	fi
done

#rename to large files and create new (empty) folder
for file in $FILES ; do
	newname=$DEST/`basename "$file-$DATE"`
	if [ -e $newname ] ; then
		echo ""
		echo "------------[ WARNING !! ]-----------------"
		echo "   Already exists: $newname"
		echo ""
		echo -e '\a';sleep 1;
	else
		echo "incoming Folder File: $file"
		echo "       --> $newname" 
		if [ "$1" = "doit" ] ; then
			#echo "mv \"$file\" \"$newname\""
			mv "$file" "$newname"
			$MAILDIRMAKE $file
			chmod 700 $file
		else 
			echo "ACTION: mv \"$file\" \"$newname\""
		fi
	fi
done

#reset vars:
FILES=""
DIRS=""
ARCHIVE_FILES=""

echo ""
echo "###################################################"
echo "# Mail ARCHIVES run"
echo "##########################################"
echo ""
echo "*** Checking if we have very large archive folders to move away"
echo ""
#this section renames folder in the Archive dir (with
#renaming to *-date --> creates eternal archives.
#it's for auto-moved Mail-In folders (that is done by a different
#script)

#get sizes of the directories or files:
for dir in $ARCHIVE_DIRS
do
	echo "$dir" | perl -ne 'if (/-\d{2}-\w{3}-\d{4}/) {exit 1}'
	ret=$?
	if [ "$ret" = "0" ]; then
		size=`du -ks "$dir"|awk '{print $1}'`
		curtrigger=$trigger
		if [ "$dir" = "$largename" ] ; then
			curtrigger=$largetripper
		fi
		if [ $size -gt $curtrigger ] ; then
			echo "large Maildir Archive $dir : $size > $curtrigger"
			#remember if it's to large
			ARCHIVE_FILES="$ARCHIVE_FILES $dir"
		fi
	#else
	#	echo "$dir already an eternal archive."
	fi
done

#rename to large folders and create a new emtpy one
for file in $ARCHIVE_FILES ; do
	#newname=$DEST_OLDS/`basename "$file"`
	newname="$file-$DATE"
	#wrong?
	if [ -e $newname ] ; then
		echo ""
		echo "------------[ WARNING !! ]-----------------"
		echo "   Already exists: $newname"
		echo ""
		echo -e '\a';sleep 1;
	else
		echo "Archive File: $file"
		echo "       --> $newname" 
		if [ "$1" = "doit" ] ; then
			#echo "mv \"$file\" \"$newname\""
			mv "$file" "$newname"
			#create new file or maildir
			if [ -f "$newname" ] ; then
				touch $file
			else
				$MAILDIRMAKE $file
			fi
			chmod 700 $file
		else
			echo "ACTION: mv \"$file\" \"$newname\""
		fi
	fi
done

