# Rational ClearCase completion
#
# $Id$

_cleartool()
{
	local cur prev commands options command pname

	COMPREPLY=()

	command=${COMP_WORDS[1]}
	prev=${COMP_WORDS[COMP_CWORD-1]}
	cur=${COMP_WORDS[COMP_CWORD]}

	commands='annotate apropos catcr catcs cd chactivity chbl checkin ci \
		checkout co checkvob chevent chflevel chfolder chmaster \
		chpool chproject chstream chtype chview cptype deliver \
		describe diff diffbl diffcr dospace edcs endview file find \
		findmerge get getcache getlog help hostinfo ln lock ls \
		lsactivity lsbl lscheckout lsco lsclients lscomp lsdo lsfolder \
		lshistory lslock lsmaster lspool lsprivate lsproject lsregion \
		lsreplica lssite lsstgloc lsstream lstype lsview lsvob lsvtree \
		man merge mkactivity mkattr mkattype mkbl mkbranch mkbrtype \
		mkcomp mkdir mkelem mkeltype mkfolder mkhlink mkhltype mklabel \
		mklbtype mkpool mkproject mkregion mkstgloc mkstream mktag \
		mktrigger mktrtype mkview mkvob mount move mv protect \
		protectvob pwd pwv quit rebase recoverview reformatview \
		reformatvob register relocate rename reqmaster reserve \
		rmactivity rmattr rmbl rmbranch rmcomp rmdo rmelem rmfolder \
		rmhlink rmlabel rmmerge rmname rmpool rmproject rmregion \
		rmstgloc rmstream rmtag rmtrigger rmtype rmver rmview rmvob \
		schedule setactivity setcache setcs setplevel setsite setview \
		shell space startview umount uncheckout unco unlock unregister \
		unreserve update winkin'

	if [[ $COMP_CWORD -eq 1 ]] ; then
		COMPREPLY=( $( compgen -W "$commands" -- $cur ) )
	else
		if [[ "$cur" == -* ]]; then
			# Command-specific option flags
			case $command in
				annotate)
					options='-all -rm -nco -out -short \
					-long -fmt -rmfmt -nheader -ndata \
					-force'
					;;
				apropos)
					options='-glossary'
					;;
				catcr)
					options='-recurse -flat -union -check \
					-makefile -select -ci -type \
					-element_only -view_only \
					-critical_only -name -zero -wd -nxname \
					-follow -long -short -scripts_only'
					;;
				catcs)
					options='-tag'
					;;
				chactivity)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -headline -cfset \
					-tcset'
					;;
				chbl)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -incremental -full \
					-nrecurse -level'
					;;
				checkin|ci)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -nwarn -cr -ptime \
					-keep -rm -from -identical -cact \
					-cwork'
					;;
				checkout|co)
					options='-reserved -unreserved \
					-nmaster -out -ndata -ptime -branch \
					-version -nwarn -comment -cfile \
					-cquery -cqeach -ncomment -query \
					-nquery'
					;;
				checkvob)
					options='-view -log -fix -force \
					-ignore -data -protections -debris \
					-setup -pool -source -derived \
					-cleartext -lock -hlinks -to -from \
					-hltype -pname -global -acquire \
					-unlock'
					;;
				chevent)
					options='-comment -cquery -cfile \
					-cqeach -ncomment -append -insert \
					-replace -event -invob -pname'
					;;
				chflevel)
					options='-force -override -family \
					-replica -auto'
					;;
				chfolder)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -to'
					;;
				chmaster)
					options='-comment -comment -cfile \
					-cquery -cqeach -ncomment -pname \
					-stream -override -default -pname -all \
					-obsolete_replica -long -view'
					;;
				chpool)
					options='-force -comment -cfile \
					-cquery -cqeach -ncomment'
					;;
				chproject)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -amodcomp -dmodcomp \
					-to -rebase_level -policy -npolicy \
					-spolicy -crmenable -ncrmenable'
					;;
				chstream)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -target -ntarget \
					-generate -policy -npolicy \
					-recommended -default -nrecommended'
					;;
				chtype)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -pname'
					;;
				chview)
					options='-cachesize -shareable_dos \
					-nshareable_dos -readonly -readwrite'
					;;
				cptype)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -force -replace'
					;;
				deliver)
					options='-graphical -stream -to \
					-target -query -qall -cancel -status \
					-long -preview -activities -baseline \
					-complete -gmerge -ok -abort -serial \
					-force -resume'
					;;
				describe)
					options='-graphical -local -long \
					-short -fmt -alabel -all -aattr -all \
					-ahlink -cview -version -ancestor \
					-ihlink -all -predecessor -pname -type \
					-cact -cwork'
					;;
				diff)
					options='-graphical -tiny -hstack \
					-vstack -redecessor -options -window \
					-serial_format -diff_format -columns'
					;;
				diffbl)
					options='-activities -version \
					-baselines -first_only -nrecurs \
					-predecessor -graphical'
					;;
				diffcr)
					options='-recurse -flat -select -ci \
					-type -element_only -view_only \
					-critical_only -name -wd -nxname \
					-follow -long -short'
					;;
				dospace)
					options='-update -since -before \
					-references -top -all -size -region \
					-pool -dump -scrub'
					;;
				edcs)
					options='-tag'
					;;
				endview)
					options='-server'
					;;
				file)
					options='-invob -all'
					;;
				find)
					options='-all -visible -nvisible \
					-avobs -name -depth -nrecurse \
					-directory -cview -user -group -type \
					-follow -nxname -element -branch \
					-version -print -exec -ok'
					;;
				findmerge)
					options='-graphical -all -avobs -ftags \
					-fversion -flatest -depth -nrecurse \
					-directory -follow -visible -fcsets \
					-user -group -type -name -element \
					-nzero -nback -whynot -log -comment \
					-cfile -cquery -cqeach -ncomment \
					-unreserved -query -abort -qall \
					-serial -btag -fbtag -rpint -long \
					-short -nxname -merge -okmerge -gmerge \
					-okgmerge -exec -ok -co'
					;;
				get)
					options='-to'
					;;
				getcache)
					options='-view -all -short -reset \
					-cview -site -host -mvfs'
					;;
				getlog)
					options='-graphical -host -cview -tag \
					-vob -last -full -since -around \
					-inquire -all'
					;;
				hostinfo)
					options='-long -properties -full'
					;;
				ln)
					options='-slink -comment -cfile \
					-cquery -cqeach -ncomment -nco -force'
					;;
				lock)
					options='-replace -nusers -obsolete \
					-comment -cfile -cquery -cqeach \
					-ncomment -pname'
					;;
				ls)
					options='-recurse -directory -long \
					-short -vob_only -view_only -nxname \
					-visible'
					;;
				lsactivity)
					options='-short -long -fmt -tree \
					-depth -ancestor -obsolete -invob -in \
					-view -cview -contrib'
					;;
				lsbl)
					options='-short -long -fmt -tree \
					-level -ltlevel -gtlevel -component \
					-obsolete -stream -cview'
					;;
				lscheckout|lsco)
					options='-long -short -fmt -cview \
					-brtype -me -user -recurse -directory \
					-all -avobs -areplicas'
					;;
				lsclients)
					options='-host -type -short -long'
					;;
				lscomp)
					options='-short -long -fmt -tree \
					-obsolete -invob'
					;;
				lsdo)
					options='-recurse -me -logn -short \
					-fmt -zero -stime -sname \
					-nshareable_dos'
					;;
				lsfolder)
					options='-short -long -fmt -tree \
					-depth -ancestor -obsolete -invob -in \
					-view -cview'
					;;
				lshistory)
					options='-graphical -nopreferences \
					-minor -nco -user -branch -recurse \
					-directory -all -avobs -pname -long \
					-short -fmt -eventid -last -since -me \
					-local -pname'
					;;
				lslock)
					options='-local -long -short -fmt \
					-obsolete -all -pname'
					;;
				lsmaster)
					options='-kind -fmt -view -inreplicas \
					-all'
					;;
				lspool)
					options='-long -short -fmt -obsolete \
					-invob'
					;;
				lsprivate)
					options='-tag -invob -long -short \
					-size -age -co -do -other'
					;;
				lsproject)
					options='-short -long -fmt -tree \
					-depth -ancestor -obsolete -invob -in \
					-view -cview'
					;;
				lsregion)
					options='-short -long'
					;;
				lsreplica)
					options='-long -short -fmt -siblings \
					-invob'
					;;
				lssite)
					options='-inquire'
					;;
				lsstgloc)
					options='-view -vob -short -long \
					-region -host -storage'
					;;
				lsstream)
					options='-short -long -fmt -tree \
					-depth -ancestor -obsolete -invob -in \
					-view -cview'
					;;
				lstype)
					options='-local -long -short -fmt \
					-obsolete -kind -invob'
					;;
				lsview)
					options='-short -long -host -quick \
					-properties -full -text_mode -age \
					-region -cview -storage -uuid'
					;;
				lsvob)
					options='-graphical -region -short \
					-long -host -quick -region -storage \
					-uuid -family'
					;;
				lsvtree)
					options='-graphical -all -nmerge \
					-ncomment -options -nrecurse -short \
					-all -merge -obsolete -branch'
					;;
				man)
					options='-graphical'
					;;
				merge)
					options='-out -to -graphical -tiny \
					-window -serial_format -diff_format \
					-columns -base -insert -delete -ndata \
					-narrows -replace -query -abort -qall \
					-comment -cfile -cquery -cqeach \
					-ncomment -options -version'
					;;
				mkactivity)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -headline -in -nset \
					-force'
					;;
				mkattr)
					options='-replace -recurse -version \
					-pname -comment -cfile -cquery -cqeach \
					-ncomment -default -select -ci -type \
					-name -config'
					;;
				mkattype)
					options='-replace -global -acquire \
					-ordinary -vpelement -vpbranch \
					-vpversion -shared -vtype -gt -ge -lt \
					-le -enum -default -comment -cfile \
					-cquery -cqeach -ncomment'
					;;
				mkbl)
					options='-comment -cfile -cquery \
					-ncomment -view -component -all \
					-activities -nlabel -incremental -full \
					-dentical -adepends_on -ddepends_on \
					-nact -import'
					;;
				mkbranch)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -nwarn -nco \
					-version'
					;;
				mkbrtype)
					options='-replace -global acquire \
					-ordinary -pbranch -comment -cfile \
					-cquery -cqeach -ncomment'
					;;
				mkcomp)
					options='-comment -cfile -cquery -root \
					-nroot'
					;;
				mkdir)
					options='-nco -comment -cfile -cquery \
					-cqeach -ncomment'
					;;
				mkelem)
					options='-eltype -nco -ci -ptime \
					-master -nwarn -comment -cfile -cquery \
					-cqeach -ncomment'
					;;
				mkeltype)
					options='-replace -global -acquire \
					-ordinary -supertype -manager -ptime \
					-attype -mergetype -comment -cfile \
					-cquery -cqeach -ncomment'
					;;
				mkfolder)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -in'
					;;
				mkhlink)
					options='-unidir -ttext -ftext -tpname \
					-fpname -acquire -comment -cfile \
					-cquery -cqeach -ncomment'
					;;
				mkhltype)
					options='-replace -global -acquire \
					-ordinary -attype -shared -comment \
					-cfile -cquery -cqeach -ncomment'
					;;
				mklabel)
					options='-replace -recurse -follow \
					-version -comment -cfile -cquery \
					-cqeach -ncomment -select -ci -type \
					-name -config'
					;;
				mklbtype)
					options='-replace -global -acquire \
					-rodinary -pbranch -shared -comment \
					-cfile -cquery -cqeach -ncomment'
					;;
				mkpool)
					options='-source -ln -comment -cfile \
					-cquery -cqeach -ncomment -derived \
					-cleartext -size -age -alert -update'
					;;
				mkproject)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -modcomp -policy \
					-npolicy -spolicy -crmenable -in'
					;;
				mkregion)
					options='-tag -tcomment -replace'
					;;
				mkstgloc)
					options='-view -vob -force -comment \
					-region -host -hpath -gpath -ngpath \
					-host -hpath'
					;;
				mkstream)
					options='-integration -in -target \
					-comment -cfile -cquery -cqeach \
					-ncomment -baseline -policy -npolicy'
					;;
				mktag)
					options='-view -tag -tcomment -replace \
					-region -nstart -ncaexported -host \
					-gpath -ngpath -vob -options -public \
					-password'
					;;
				mktrigger)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -recurse -ninherit \
					-nattach -force -nattach'
					;;
				mktrtype)
					options='-replace -element -all -type \
					-ucmobject -all -preop -postop -nusers \
					-exec -execunix -execwin -mklabel \
					-mkattr -mkhlink -attype -brtype \
					-eltype -hltype -lbtype -trtype \
					-project -stream -component -comment \
					-cfile -cquery -cqeach -ncomment'
					;;
				mkview)
					options='-tag -tcommen -tmode -region \
					-ln -ncaexported -cachesize \
					-shareable_dos -nshareable_dos -stream \
					-tgloc -auto -host -hpath -gpath \
					-snapshot'
					;;
				mkvob)
					options='-tag -ucmproject -comment \
					-cfile -cquery -cqeach -ncomment \
					-tcomment -region -options \
					-ncaexported -public -password -host \
					-hpath -gpath -stgloc -auto'
					;;
				mount)
					options='-options -all'
					;;
				move|mv)
					options='-comment -cfile -cquery \
					-cqeach -ncomment'
					;;
				protect)
					options='-chown -chgrp -chmod -comment \
					-cfile -cquery -cqeach -ncomment -file \
					-directory -recurse -pname'
					;;
				protectvob)
					options='-force -chown -chgrp \
					-add_group -delete_group'
					;;
				pwv)
					options='-short -wdview -setview \
					-root'
					;;
				rebase)
					options='-graphical -view -stream \
					-query -qall -cancel -status -long \
					-recommended -baseline -dbaseline \
					-complete -gmerge -ok -abort -serial \
					-force -resume'
					;;
				recoverview)
					options='-synchronize -vob -tag -force \
					-directory'
					;;
				reformatview)
					options='-dump -load -tag'
					;;
				reformatvob)
					options='-dump -load -rm -force -to \
					-host -hpath'
					;;
				register)
					options='-view -replace -host -hpath \
					-vob'
					;;
				relocate)
					options='-force -qall -log -update'
					;;
				rename)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -acquire'
					;;
				reqmaster)
					options='-comment -cquery -ncomment \
					-acl -edit -set -get -enable -disable \
					-deny -allow -instances -list'
					;;
				reserve)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -cact -cwork'
					;;
				rmactivity)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -force'
					;;
				rmattr)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -version -pname'
					;;
				rmbl)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -force'
					;;
				rmbranch)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -force'
					;;
				rmcomp)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -force'
					;;
				rmdo)
					options='-all -zero'
					;;
				rmelem)
					options='-force -comment -cfile \
					-cquery -cqeach -ncomment'
					;;
				rmfolder)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -force'
					;;
				rmhlink)
					options='-comment -cfile -cquery \
					-cqeach -ncomment'
					;;
				rmlabel)
					options='-comment -cfile -cquery \
					-cqeach -ncomment \
					-version'
					;;
				rmmerge)
					options='-comment -cfile -cquery \
					-cqeach -ncomment'
					;;
				rmname)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -nco \
					-force'
					;;
				rmpool)
					options='-comment -cfile -cquery \
					-cqeach -ncomment'
					;;
				rmproject)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -force'
					;;
				rmregion)
					options='-tag -rmall -password'
					;;
				rmstgloc)
					options='-all -region -storage -view \
					-vob -short -long -host'
					;;
				rmstream)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -force'
					;;
				rmtag)
					options='-view -region -all -vob \
					-password'
					;;
				rmtrigger)
					options='-comment -cfile -cquery \
					-cqeach -ncomment \
					-ninherit -nattach -recurse'
					;;
				rmtype)
					options='-ignore -rmall -force \
					-comment -cfile -cquery -cqeach \
					-ncomment'
					;;
				rmver)
					options='-force -xbranch -xlabel \
					-xattr -xhlink -data -version -vrange \
					-comment -cfile -cquery -cqeach \
					-ncomment'
					;;
				rmview)
					options='-force -tag -vob -avobs -all \
					-uuid'
					;;
				rmvob)
					options='-force'
					;;
				schedule)
					options='-host -force -edit -schedule \
					-acl -get -job -tasks -set -delete \
					-run -wait -status'
					;;
				setactivity)
					options='-comment -cfile -cquery \
					-ncomment -view -none'
					;;
				setcache)
					options='-view -default -cachesize \
					-cview -host -site -mvfs -regdnc \
					-noentdnc -dirdnc -vobfree -cvpfree \
					-rpchandles'
					;;
				setcs)
					options='-tag -current -default \
					-stream'
					;;
				setplevel)
					options='-comment -cfile -cquery \
					-ncomment -invob -default'
					;;
				setsite)
					options='-password'
					;;
				setview)
					options='-login -exec'
					;;
				space)
					options='-view -vob -all -update \
					-region -host -directory -generate \
					-scrub'
					;;
				umount)
					options='-all'
					;;
				uncheckout|unco)
					options='-keep -rm -cact -cwork'
					;;
				unlock)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -pname'
					;;
				unregister)
					options='-vob -uuid -view'
					;;
				unreserve)
					options='-view -cact -cwork -comment \
					-cfile -cquery -cqeach -ncomment'
					;;
				update)
					options='-graphical -print -force \
					-overwrite -noverwrite -rename -ctime \
					-ptime -log -add_loadrules'
					;;
				winkin)
					options='-print -noverwrite -siblings \
					-adirs -out -select -ci'
					;;
			esac
			options="$options -h"

			COMPREPLY=( $( compgen -W "$options" -- $cur ) )
		else
			# Command-specific arguments
			case "$command" in
				help|apropos)
					options="$commands"
					;;
				man)
					options="$commands make clearmake \
					clearaudit clearbug cleardiffbl \
					cleargetlog clearhistory clearjoinproj \
					clearvobadmin clearlicense clearmrgman \
					clearprompt clearviewupdate \
					clearfsimport clearexport_rcs \
					clearexport_ccase cleardescribe \
					clearexport_pvcs clearexport_sccs"
					;;
				mount)
					options=$(cleartool lsvob |sed -e "/^\*/d" -e "s/^\s\+\(\S*\).*/\1/")
					;;
				umount)
					options=$(cleartool lsvob |sed -e "/^\s/d" -e "s/^\*\s\+\(\S*\).*/\1/")
					;;
				setview)
					if [[ "$prev" == -exe || "$prev" == -exec ]]; then
						COMPREPLY=( $(compgen -A command -- $cur) )
					else
						options=$(cleartool lsview -short)
					fi
					;;
				lsview)
					if [[ "$prev" == -hos || "$prev" == -host ]]; then
						_known_hosts
					elif [[ "$prev" == -reg || "$prev" == -region ]]; then
						options=$(cleartool lsregion -short)
					elif [[ "$prev" == -sto || "$prev" == -storage ]]; then
						# TODO: Doesn't work OK.
						options=$(cleartool lsview |sed -e "s/.*\s\(\S*\)$/\1/")
					elif [[ "$prev" == -uui || "$prev" == -uuid ]]; then
						options=$(cleartool lsview -long |grep "^View uuid: " |sed -e "s/^View uuid: //" |sort |uniq)
					else
						options=$(cleartool lsview -short)
					fi
					;;
				uncheckout|unco)
					# List of user's checked out elements
					# TODO: Include list of activities for checkin
					options=$(cleartool lscheckout -short -me -cview -avobs)
					;;
				checkin|ci)
					# if [[ "$prev" != @(-fro?(m)|-cfi?(le)) ]]; then
					if [[ "$prev" != -fro && "$prev" != -from && "$prev" != -cfi && "$prev" != -cfile ]]; then
						options=$(cleartool lscheckout -short -me -cview -avobs)
					fi
					;;
				lsregion)
					options=$(cleartool lsregion -short)
					;;
				rmregion)
					if [[ "$prev" != -pas && "$prev" != -password ]]; then
						options=$(cleartool lsregion -short)
					fi
					;;
				lsvob)
					if [[ "$prev" == -reg || "$prev" == -region ]]; then
						options=$(cleartool lsregion -short)
					elif [[ "$prev" == -hos || "$prev" == -host ]]; then
						_known_hosts
					elif [[ "$prev" == -uui || "$prev" == -uuid ]]; then
						options=$(cleartool lsvob -long |grep "^Vob replica uuid: " |sed -e "s/^Vob replica uuid: //" |sort |uniq)
					elif [[ "$prev" == -fam || "$prev" == -family ]]; then
						options=$(cleartool lsvob -long |grep "^Vob family uuid: " |sed -e "s/^Vob family uuid: //" |sort |uniq)
					elif [[ "$prev" == -sto || "$prev" == -storage ]]; then
						# TODO: Doesn't work OK
						options=$(cleartool lsvob |sed -e "s/^\*\?\ \S*\s*\(\S*\).*/\1/")
					fi
					;;
			esac

			if [ -n "$options" -a -z "$COMPREPLY" ]; then
				COMPREPLY=( $(compgen -W "$options" -- $cur ) )
			fi
		fi
	fi

	return 0
}
complete -o default -F _cleartool cleartool ct

_multitool()
{
	local cur prev commands options command pname

	COMPREPLY=()

	command=${COMP_WORDS[1]}
	prev=${COMP_WORDS[COMP_CWORD-1]}
	cur=${COMP_WORDS[COMP_CWORD]}

	commands="help man quit cd pwd shell apropos lstype rmtype mkreplica \
		chreplica syncreplica lsreplica rmreplica rename chmaster \
		lsmaster reqmaster lsepoch chepoch recoverpacket \
		restorereplica describe describe lspacket"

	if [[ $COMP_CWORD -eq 1 ]] ; then
		COMPREPLY=( $( compgen -W "$commands" -- $cur ) )
	else
		if [[ "$cur" == -* ]]; then
			# Command-specific option flags
			case $command in
				man)
					options='-graphical'
					;;
				apropos)
					options='-glossary'
					;;
				lstype)
					options='-local -long -short -fmt \
					-obsolete -kind -invob'
					;;
				rmtype)
					options='-ignore -rmall -force \
					-comment -cfile -cquery -cqeach \
					-ncomment'
					;;
				mkreplica)
					options='-export -workdir -maxsize \
					-comment -cfile -cquery -cqeach \
					-ncomment -ship -fship -sclass \
					-pexpire -notify -tape -out -import \
					-tag -host -hpath -gpath -stgloc \
					-preserve -tcomment -ncaexported \
					-region -options -public -password \
					-ignoreprot -pooltalk -vreplica -tape'
					;;
				chreplica)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -host -preserve \
					-npreserve -isconnected -nconnected'
					;;
				syncreplica)
					options='-export -maxsize -limit \
					-comment -cfile -cquery -cqeach \
					-ncomment -ship -fship -sclass \
					-pexpire -notify -tape -out -import \
					-invob -receive'
					;;
				lsreplica)
					options='-long -short -fmt -siblings \
					-invob'
					;;
				rmreplica)
					options='-comment -cfile -cquery \
					-cqeach -ncomment'
					;;
				rename)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -acquire'
					;;
				chmaster)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -pname -stream \
					-override -default -pname -all \
					-obsolete_replica -long -view'
					;;
				lsmaster)
					options='-kind -fmt -view -inreplicas \
					-all'
					;;
				reqmaster)
					options='-comment -cquery -ncomment \
					-acl -edit -set -get -enable -disable \
					-deny -allow -instances -list'
					;;
				lsepoch)
					options='-invob -actual'
					;;
				chepoch)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -force -actual \
					-raise_only'
					;;
				recoverpacket)
					options='-comment -cfile -cquery \
					-cqeach -ncomment -since'
					;;
				restorereplica)
					options='-comment -cfile -cq -cqe -nc \
					-force -override -invob -replace'
					;;
				describe)
					options='-graphical -local -long -short -fmt \
					-alabel -all -aattr -ahlink -cview \
					-version -ancestor -ihlink \
					-predecessor -pname -type -cact -cwork'
					;;
				lspacket)
					options='-long -short'
					;;
			esac
			options="$options -h"

			COMPREPLY=( $( compgen -W "$options" -- $cur ) )
		else
			case "$command" in
				help|apropos|man)
					options="$commands"
					;;
			esac

			if [ -n "$options" -a -z "$COMPREPLY" ]; then
				COMPREPLY=( $( compgen -W "$options" -- $cur ) )
			fi
		fi
	fi

	return 0
}
complete -o default -F _multitool multitool mt

_clearaudit()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-h" -- $cur ) )
	fi

	return 0
}
complete -o default -A command -F _clearaudit clearaudit

_clearbug()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-short -p -r -l -h" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearbug clearbug

_cleardiffbl()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-ispred" -- $cur ) )
	fi

	return 0
}
complete -o default -F _cleardiffbl cleardiffbl

_cleardiff()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-tiny -window -diff_format \
			-serial_format -columns -headers_only -quiet \
			-status_only -blank_ignore -out -base -q -qall -abort \
			-favor_contrib" -- $cur ) )
	fi

	return 0
}
complete -o default -F _cleardiff cleardiff

_clearexport_ccase()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-r -s -I -t -T -p -o" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearexport_ccase clearexport_ccase

_clearexport_cvs()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-r -A -s -p -I -V -S -t -T -p -o" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearexport_cvs clearexport_cvs

_clearexport_rcs()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-r -s -p -I -V -S -t -T -o" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearexport_rcs clearexport_rcs

_clearexport_sccs()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-r -s -p -I -V -t -T -o" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearexport_sccs clearexport_sccs

_clearexport_ffile()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-r -o -L -s -l -b -v -p -t" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearexport_ffile clearexport_ffile

_clearexport_pvcs()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-r -s -I -G -V -t -T -p -o" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearexport_pvcs clearexport_pvcs

_clearfsimport()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-follow -recurse -rmname -mklabel \
				-nsetevent -identical -master -comment \
				-unco -preview -h" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearfsimport clearfsimport

_cleargetlog()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-host -vob -cview -tag" -- $cur ) )
	fi

	return 0
}
complete -o default -F _cleargetlog cleargetlog

_clearhistory()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-nopreferences -minor -nco -user \
			-branch -recurse -directory -all -avobs -pname" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearhistory clearhistory

_clearimport()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-verbose -identical -nsetevent
			-master -directory -comment -noload -nolabeldir -h" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearimport clearimport

_clearlicense()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-product -hostid -release" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearlicense clearlicense

_clearmrgman()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-deliver -stream -to -target -query \
			-ttag -rebase -view -ftag -fbranch -flabel -fversion \
			-directory -nrecurse -follow -noautomerge -query -avobs \
			-qall -file" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearmrgman clearmrgman

_clearprompt()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-outfile -multi_line -default -dfile \
			        -pattern -directory -items -choices -type \
			        -mask -prompt -prefer_gui -newline -h" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearprompt clearprompt

_clearviewupdate()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-ws -pname" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearviewupdate clearviewupdate

_clearvobadmin()
{
	local cur

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}

	if [[ "$cur" == -* ]]; then
		COMPREPLY=( $( compgen -W "-region" -- $cur ) )
	fi

	return 0
}
complete -o default -F _clearvobadmin clearvobadmin

