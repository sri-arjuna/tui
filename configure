#!/usr/bin/env bash
#	Yet Another Simple Script Installer
# ------------------------------------------------------------------------
# Copyright (c) 2015 Simon Arjuna Erat (sea)  <erat.simon@gmail.com>
# All rights reserved.
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>
#
#
#	Created:	2015.07.27
#	Changed:	2015.11.27
	script_name=configure
	script_version=1.2.3
#
#	Description:
#		This script automaticly, according to passed options, 
#		generates the following files, named to go along with GNU Automake terminology.
#		* make
#		* make-install
#		* make-uninstall
#		* make-distclean
#
#		It can also create a REFERENCE file ($APP_dirs.conf) and if 'doRef=true',
#		it will copy that file to $SYSCONFDIR automaticly, as well as remove it when uninstalling
#		
#		The options were applied from the output of GNU Automake's './configure --help'
#		and the calculation of the paths is done according to: http://www.pathname.com/fhs/
#
#		This is not about auto magic compiling,
#		this is about simply placing files - with some required extras.
#
#
#	To report bugs or suggestions about YASSI (configure), please raise an issue on:
#		* https://github.com/sri-arjuna/yassi/issues
#	or send me an email with the subject YASSI.
#
# ------------------------------------------------------------------------
#
#	Configfile / Option defaults
#
	APP="<APPNAME>"		# Non-space-name of the application
	APP_VER=""		# Version of the APP
	APP_TITLE=""		# Full name with spaces
	APP_DIR="/usr/local"	# Default if no --prefix=DIR is passed
	
	# External requirements
	APP_REQUIRES=""		# Commands required by APP
	CFG_REQUIRES=""		# Commands required for MAKE
	
	# Author
	APP_AUTHOR=""		# Author of the script project
	APP_EMAIL=""		# Email of the author
	APP_HOMEPAGE=""		# Homepage of the author
	
	# App/Code retrieving
	APP_URL=""		# Homepage of $APP
	APP_GIT=""		# Giturl to clone from
	APP_URL=""		# Url to download the package
	DOWNLOAD=""		# Url to download the package
	
	APP_LIC="GPLv3+"	# Default license for scripted projects
	
	BUGS=""			# Email adress to disply for bug repots
	ISSUE=""		# Web adress to display for bug reports
	
	# Bools
	doRef=false		# Copy the REFERENCE file to SYSCONFDIR?
	doMakefile=false	# Do not write a makefile by default
	doTarball=false		# Create a redist tarball?
	is_at_home=false	# Is it a system (false) or user (true) installation?
#
#	Internal Variables
#
	unset FHS MAKE PRIOR POST REMOVE	# Basic/Core arrays
	unset HTML DVI PDF PS			# Documention arrays
	declare -A FHS		# This contains the directory strucutre by name
	declare -a MAKE	# This will be ran during ./configure --prefix=/usr
	declare -a PRIOR	# This will be ran first during ./make-install
	declare -a POST		# This will be ran last during ./make-install
	declare -a REMOVE	# This will be ran during ./make-uninstall
	declare -a CLEAN	# This will be ran during ./make-distclean
	declare -a IGNORE	# These files will be ignored when running './configure --tarball --prefix=/usr'
	declare -a HTML DVI PDF PS # Use for creating make-* scripts
	AWK=\awk		# Bypass aliases
	GREP=\grep		# Bypass aliases
	SED=\sed		# Bypass aliases
	# Accept shell preset, but get overwritten by option --config CONFIG
	CONFIG="${CONFIG:-./$script_name.cfg}"
	which sudo 1>/dev/zero 2>/dev/zero && \
		install_prefix="sudo " || \
		install_prefix="su -c "
	mandirs="mandir $(echo man{1..9}dir)"
	index_list="prefix bindir sbindir  sysconfdir datarootdir appdir icondir datadir docdir htmldir infodir $mandirs dvidir pdfdir psdir compldir sharedstatedir localstatedir"
	variable_list="";for i in $index_list;do variable_list+=" ${i^^}";done
	TMP="$PWD/tmp.$$"
	CHROOT=""
	source "$CONFIG"
#
#	Functions
#
	make_info() { # INFILE OUTDIR
	#
	#
		INFILE="$1"
		OUTDIR="${2:-./docs}"
		OUTFILE="${1##*/}"
		OUTFILE="${OUTFILE/\.*}.info"
		
		[ -f "$INFILE" ] || return 1
		[ -d "$OUTDIR" ] || mkdir -p "$OUTDIR"
		
		echo "texi2any -o $OUTDIR/$OUTFILE --no-split $INFILE"
		#echo "texi2any -o docs/info/$APP.info --no-split docs/info/$APP.texi"
	}
	make_doc() { # TYPE INFILE OUTDIR
	#
	#
		EXT="$1"
		INFILE="$2"
		OUTDIR="${3:-./docs}"
		OUTFILE="${INFILE##*/}"
		OUTFILE="${OUTFILE/\.*}.$EXT"
		
		[ -f "$INFILE" ] || return 1
		[ -d "$OUTDIR" ] || mkdir -p "$OUTDIR"
		
		echo "texi2any  --$EXT -o $OUTDIR/$OUTFILE --no-split $INFILE"
	}
	write_makefile() { 
	# Checks for existing scripts and adds them to the makefile
	#
		# Clear / Init makefile
		local M="./Makefile"
		>$M
		#printf '%s\n' \
		#	"SHELL = /bin/sh" > "$M"
		#echo "PHONY: options make $(echo make-*|sed s,make\-,,g|sed s,doc\-,,g)" > "$M"
		
		for task in ./make ./make-*
		do 	case "$task" in
			./make)	# Was PNONY ??
				printf '%s\n' "options:"  \
					"	./make"  >> "$M"
				[ -f ./make-doc-info ] && \
					printf '%s\n' \
						"	./make-doc-info" >> "$M"
				;;
			# *-doc-*)
			#	[ -f "$task" ] && \
			#		printf '%s\n' \
			#		"install: ${task/*-}"  \
			#		"	${task}"  >> "$M" 
			#	;;
			make-install)
				[ -f "$task" ] && \
					printf '%s\n' \
					"${task/*-}:"  \
					"	DESTDIR=\$DESTDIR ${task}"  >> "$M" 
				;;
			*)	[ -f "$task" ] && \
					printf '%s\n' \
					"${task/*-}:"  \
					"	${task}"  >> "$M" 
				;;
			esac
		done
		
	}
	show_sample() {
	# Prints a sample configure.cfg
	# and exits
		cat <<-EOF
		#!/usr/bin/env bash
		#
		#	Project Info
		#
		 	APP=prjname
		 	APP_TITLE="<Project Name>"
		 	APP_REQUIRES="gawk bash grep sed"
		#
		#	Targets
		#
		 	BINDIR=bin
		 	DOCDIR=docs/[CRL]*
		 	MAN1DIR=docs/man/\*.1
		 	INFODIR=docs/info/\*.info
		 	DATADIR="./templates ./extra"
		#
		#	Contact
		#
		 	BUGS="${USER_EMAIL:-your@email.com}"
		EOF
		exit 0
	}
	show_sample_full() {
	# Prints an advanced sample configure.cfg
	# and exits
		cat <<-EOF
		#!/usr/bin/env bash
		#
		#	Project Info
		#
		 	# Used for /usr/share/\$APP & /usr/share/doc/\$APP
		 	APP=prjname
		 	# Used to show full name of the project
		 	APP_TITLE=""
		 	# This is required to run the script properly
		 	APP_REQUIRES="gawk bash grep sed"
		 	# This is required only until it is installed
		 	CFG_REQUIRES="git texi2any txt2man"
			
		 	# Used for helpscreen & tarball
		 	APP_VER=0.1
			
		 	# Contact
		 	APP_AUTHOR="${USER_NAME:-$USER}"
		 	APP_EMAIL="${USER_EMAIL:-your@email.com}"
		 	# The authors homepage, not related to the project
		 	APP_HOMEPAGE="${USER_HOMEPAGE:-http://your-homepage.com}"
		 
		 	# Visit & Download package locate
		 	APP_URL="https://github.com/\$APP_AUTHOR/\$APP/"
		 	APP_GIT="\$APP_URL.git"
		 	DOWNLOAD="\$APP_URL/archive/v\${APP_VER}.tar.gz"
			DOWNLOAD_DIR="\$APP-\$APP_VER"
		 	
		 	# If set, overwrites the default PREFIX (/usr/local) to assigned value.
		 	#APP_DIR=~/.local
		 	
		 	# Set true to install the reference file to $PREFIX/$SYSCONFDIR/\$APP.conf
		 	# This will automaticly be uninstalled if set to true, no extra work.
		 	#doRef=false
		#
		#	Prepare, before making a tarball
		#	So the CFG_REQUIRES are only needed on one machine, and the tarball then can be shared 
		#
		 	MAKE[0]="texi2any -o docs/info/\$APP.info --no-split docs/info/\$APP.texi"
		 	MAKE[1]="texi2any --html -o docs/info/\$APP.html --no-split docs/info/\$APP.texi"
		 	MAKE[2]="which tuirc 1>/dev/zero 2>/dev/zero || git clone https://github.com/sri-arjuna/tui tui"
		 	MAKE[3]="bin/\$APP --help | txt2man -T \${APP^^} -r \$APP_VER > docs/man/\$APP.1"
		#
		#	Tasks prior to installation, but after tarball
		#
		 	# Only install if the current system does not provide TUI, simply remove this if you dont need it
		 	PRIOR[0]="! which tuirc 1>/dev/zero 2>/dev/zero && cd tui && ./configure --prefix=\${prefix} && ./make-install && cd .. "
		 	PRIOR[1]="echo 'Some variable examples:'"
		 	PRIOR[2]="printf '* %s\n' \"CHROOT=\\\$CHROOT\" \"prefix=\\\$prefix\" \"SYSCONFDIR=\\\$SYSCONFDIR\" \"DATADIR=\\\$DATADIR\";read -p 'press enter to continue' buffer"
		#
		#	Targets, where is what installed
		#
		 	BINDIR=bin
		 	# Do not use [A-Z], that might include a-z as well
		 	DOCDIR=docs/[CIRU]*
		 	MAN1DIR=docs/man/*.1
		 	INFODIR=docs/info/\$APP.info
		 	HTMLDIR=docs/info/\$APP.html
		 	DATADIR="./menu ./includes"
		#
		#	Tasks post of installation
		#
		 	POST[0]=scripts/post_script1.sh
		 	POST[1]="echo \"Thank you for installing '\$APP' to \\\${prefix}! :)\""
		#
		#	Clean up what has been prepared 
		#
		 	CLEAN[0]="docs/info/\$APP.html"
		 	CLEAN[0]="docs/info/\$APP.info"
		#
		#	Additional tasks for the uninstallation process
		#
		 	# In this example, TUI was installed, therefor the command 'tui-yesno' is available
		 	REMOVE[0]="tui-yesno 'Remove TUI as well?' && cd tui && ./make-uninstall && ./make-distclean && cd .."
		#
		#	Contact
		#
		 	BUGS="\$APP_EMAIL"
		 	ISSUE="\$APP_SITE/\$APP_AUTHOR/\$APP/issues"
		EOF
		exit 0
	}
	show_help() {
	# Prints the helpscreen
	# and exits
		FINAL_NOTE=$(printf '\n%s\n' "YASSI $script_version (Yet Another Simple Script Installer), Copyright (c) 2015 GPLv3+ by Simon Arjuna Erat (sea)")
		CONTACT_INFO="$( [ ! -z "$BUGS" ] && echo -e "\nReport bugs of \"$APP\" to <$BUGS>")$( [ ! -z "$ISSUE" ] && printf "\nReport bugs of \"$APP\" on <$ISSUE>\n\n")$(printf '\n')"
		
		if [ -n "$APP_AUTHOR$APP_EMAIL$APP_HOMEPAGE" ]
		then 	COPYRIGHTLINE="
$APP"
			[ -n "$APP_VER" ] && COPYRIGHTLINE+=" $APP_VER"
			[ -n "$APP_TITLE" ] && COPYRIGHTLINE+=" ($APP_TITLE)"
			COPYRIGHTLINE+=", Copyright (c) - $APP_LIC"
			[ -n "$APP_AUTHOR" ] && COPYRIGHTLINE+=" - by $APP_AUTHOR"
			[ -n "$APP_EMAIL" ] && \
				COPYRIGHTLINE+=", (<${APP_EMAIL}>" && \
				[ -n "$APP_HOMEPAGE" ] && \
				COPYRIGHTLINE+=", <" || \
				COPYRIGHTLINE+=", <"
			[ -n "$APP_HOMEPAGE" ] && COPYRIGHTLINE+="${APP_HOMEPAGE}>"
			[ -n "$APP_EMAIL" ] && COPYRIGHTLINE+=")
"
		fi
			
		MSG_TR_HELP="SYNOPSIS
  	./$script_name [options]

DESCRIPTION
	Routine to configure the installation of ${APP_TITLE:-${APP:-APPNAME}} ${APP_VER}

OPTIONS
	-h|--help		Shows this screen and exits
	--version		Shows the version and exits
	
	--sample		Prints a sample '$CONFIG' required by projects and exits
	--sample-full		Prints an advanced sample '$CONFIG' required by projects and exits
	--tarball		Configures ${APP:-APPNAME}, runs PRIOR tasks and saves the folder as tarball, then exits
	
	--prefix DIR		Sets the prefix to DIR		(default: ${APP_DIR})
	--chroot DIR		Sets the CHROOT to DIR		(for 'builddirs' or before chrooting into a partition)
	
	--bindir DIR		user executeables 		(\$prefix/bin)
	--sbindir DIR		admin executeables		(\$prefix/sbin)
	--sysconfdir DIR	read-only single-machine data 	(\$prefix/etc)
	--datarootdir DIR	read-only arch.-independent data root 	(\$prefix/share)
	
	--datadir DIR		read-only architecture-independent data (\$DATAROOTDIR/${APP:-APPNAME})
	--docdir DIR		project documentation root	(\$DATAROOTDIR/doc/${APP:-APPNAME})
	--htmldir DIR		project documentation root	(\$DOCDIR)
	--infodir DIR		info documentation		(\$DATAROOTDIR/info)
	dvidir|pdfdir|psdir
	
	--appdir DIR		.desktop files			(\$DATAROOTDIR/applications)
	--icondir DIR		Icons for the desktop files	(\$DATAROOTDIR/icons)
	--compldir DIR		bash completion			(\$DATAROOTDIR/bash-completion/completions)
	--localedir		locale-dependent data		(\$DATAROOTDIR/locale)
	--localstatedir		modifiable single-machine data	(\$prefix/var)
	
	--mandir DIR		Basedir for manpages		(\$DATAROOTDIR/man)
	--man[1-9]dir DIR	Specific manpage dirs		(\$MANDIR/man/man[1-9])
	
	--sharedstatedir	modifiable architecture-independent	(\$prefix/com)

NOTES
  Common Prefix Locations
  	Common places that are used as --prefix=DIR:
  	* / or /usr
	* /usr/local or /opt
	* \$HOME
	* \$HOME/local or \$HOME/.local
  ${CONTACT_INFO}
  ${COPYRIGHTLINE}${FINAL_NOTE}"
		printf "%s\n" "$MSG_TR_HELP"
		exit 99
	}
	show_version() {
	# Prints the version of the script
	# and exits
		MSG_TR_VERSION="(sea) $script_name, Version $script_version
Copyright (C) 2015 Simon Arjuna Erat
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Report bugs of $script_name to: https://github.com/sri-arjuna/yassi/issues
"
		echo "$MSG_TR_VERSION"
		exit 111
	}
	write_files() { 
	# Write the different types of make-{clean,install,uninstall} scripts
	# An run pre-'make-install'-tasks
		# Abort with failure if not all required apllication are present
		APP_REQUIRES=""
		source "$CONFIG";missing=""
		for req in $CFG_REQUIRES;do
			which $req 2>/dev/zero 1>&2 || missing+=" $req"
		done
		[ ! -z "$missing" ] && \
			printf '%s\n' "Please provide these commands before configuring $APP!" "Sadly, you must figure out the package name yourself." && \
			printf '::-->> %s\n' ${missing} && \
			exit 1
		write_install() { # INDEX CONTENT
		# Prints the copy commands
		#
			fullPath="${2/$CHROOT}"
			target="${CHROOT}${FHS[${1,,}]}"
		#	tui-header " --> $1 -- $target" >&2 #; exit 100
			case "$1" in
			INFODIR|HTML*)
				if [ -d "$2" ] && [ ! "./" = "${fullPath:0:2}" ]
				then	# Its a directory, go recursive
					tui-header "$2 DIR" >&2
					echo "cp -ar \"${PWD:-$(pwd)}/$2/\"* \"$target\" || exit 1" | sed s,"//","/",g
				else	# It is a single entry but not a directory
			#		tui-header "$1 $2 FILE" >&2
					tmp_check="${2##*/}"
					check_char="${tmp_check:0:1}"
					isAsterix=$(printf '%s' "$check_char" | grep -q '*' && echo true || echo false )
				
					case "$isAsterix" in
					true|false)	isAsterix=$isAsterix	;;
					*)		isAsterix=false		;;
					esac
			#	tui-header "$(dirname $2)/$tmp_check" >&2
					if $isAsterix
					then 	echo "[ -f \"$(dirname $2)/$tmp_check\" ] && cp -ar \"${PWD:-$(pwd)}/$(dirname ${2})/\"$tmp_check \"$target\" || exit 1" | sed s,"//","/",g
					else	echo "[ -f \"$2\" ] && cp -a \"${PWD:-$(pwd)}/$2\" \"$target\" || exit 1" | sed s,"//","/",g
					fi
				
					case "${1,,}" in
					compldir)	echo "[ \${UID:-0} -eq 0 ] && chown 0:nobody \"$target/${2##*/}\""
					esac
				fi 
				;;
			*)
				if [ -d "$2" ] && [ ! "./" = "${fullPath:0:2}" ]
				then	# Its a directory, go recursive
					echo "cp -ar \"${PWD:-$(pwd)}/$2/\"* \"$target\" || exit 1" | sed s,"//","/",g
				else	tmp_check="${2##*/}"
					check_char="${tmp_check:0:1}"
					isAsterix=$(printf '%s' "$check_char" | grep -q '*' && echo true || echo false )
				
					case "$isAsterix" in
					true|false)	isAsterix=$isAsterix	;;
					*)		isAsterix=false		;;
					esac
				
					if $isAsterix
					then 	echo "cp -ar \"${PWD:-$(pwd)}/$(dirname ${2})/\"$tmp_check \"$target\" || exit 1" | sed s,"//","/",g
					else	echo "cp -a \"${PWD:-$(pwd)}/$2\" \"$target\" || exit 1" | sed s,"//","/",g
					fi
				
					case "${1,,}" in
					compldir)	echo "[ \${UID:-0} -eq 0 ] && chown 0:nobody \"$target/${2##*/}\""
					esac
				fi
				;;
			esac
		}
		write_reference() { # INDEX
		# Prints the index reference used
		#
			ref_val="${FHS[${1,,}]}"
			echo "${1}=$ref_val"  | \sed s,"//","/",g
		}
		write_uninstall() { # INDEX CONTENT
		# Prints the remove commands
		#
			INDEX="$1" ; shift
			DEST="${CHROOT}${FHS[${INDEX,,}]}"
			
			for tr in ${@}
			do	case "$INDEX" in
				SBINDIR|BINDIR|MANDIR|MAN[1-9]DIR)
					if [ -d "${tr}" ]
					then	for e in "./$tr/"*
						do 	[ -d "$e" ] && \
								echo "rm -fr $DEST/${e##*/}" || \
								echo "rm -f $DEST/${e##*/}"
						done
					else	echo "rm -f $DEST/${tr##*/}"
					fi
					;;
				COMPLDIR)
					# Check if it is a single file or a dir with possible multiple files
					if [ -d "$tr" ]
					then	for this_compl in "$tr/"*
						do 	tmp_compl="${this_compl/\$\{APP\}/$APP}"
							echo "rm -f $DEST/${tmp_compl##*/}"
						done
					else	tr="${tr/\$\{APP\}/$APP}"
						echo "rm -f $DEST/${tr##*/}"
					fi
					;;
				APPDIR|ICONDIR)
					(
						. ./$CONFIG
						for F in $(cd ${!INDEX}/ ; find -type f )
						do
							[ ! -d "$F" ] && echo "rm -f $DEST/${F##/*}"
						done
					)
					;;
				*)	[ -d "$tr" ] && \
						echo "rm -fr $DEST/${tr##*/}" || \
						echo "rm -f $DEST/${tr##*/}"
					;;
				esac
			done
			return 0
		}
		write_remover() { # ENTRY
		# Catches ENTRY and prints 'rm -f ENTRY' if it is a file/dir
		# Print the line as-is otherwise
			if [ -f "$1" ]
			then 	echo "rm -f \"$1\""
			elif [ -d "$1" ]
			then 	echo "rm -fr \"$1\""
			else	echo "$1"
			fi
		}
		write_executer() { # ENTRY
		# Catches ENTRY and prints 'sh ./ENTRY'
		# Executes it, or fails if it is a dir.
			if [ -d "$1" ]
			then 	echo "DIR: $1, cannot execute!" >&2
				exit 1
			elif [ -f "$1" ]
			then	[ "/" = "${1:0:1}" ] && \
					echo "bash \"$1\"" || \
					echo "bash \"./$1\""
			else	echo "$1"
			fi
		}
		write_clean() { 
		# Remove the files that where created
		# from 'make' or make 'html'
			if [ -n "$(echo ${TEXI[@]})" ]
			then	#tui-header "DEBUG:: TODO It has info files"
				for T in "${TEXI[@]}";do
					first="$(echo ${T}|$AWK '{print $1}')"
					tt="${first/\.texi}.info"
					echo $T | awk -vtt="$tt" '{print "rm -fr ",tt}'
				done
			fi
			if [ -n "$(echo ${HTML[@]})" ]
			then	#tui-header "DEBUG:: TODO It has html files"
				for T in "${TEXI[@]}";do
					first="$(echo ${T}|$AWK '{print $1}')"
					tt="${first/\.texi}.html"
					echo $T | awk -vtt="$tt" '{print "rm -fr ",tt}'
				done
			fi
		}
		write_distclean() { 
		# Remove all the files that where created
		#
			echo "rm -f Makefile"
			for task in make* make-* $REFERENCE
			do	write_remover "$task"
			done
			
		}
		
		# Prepare script headers
		if [ -n "$(echo ${MAKE[@]})" ] 
		then	echo "#!/usr/bin/env bash" > "./make"
			echo "set -x" >> "./make"
			chmod +x "./make"
		fi
		for m in install uninstall distclean clean
		do	echo "#!/usr/bin/env bash" > "make-$m"
			if [ ! "$m" = "distclean" ] &&  [ ! "$m" = "clean" ] && !  $is_at_home 
			then	echo "$CHROOT/$prefix"| grep -q -ve /home -ve /Users && \
					printf '%s\n' \
					"[ -z \$UID ] && UID=0" \
					"[ \$UID -ne 0 ] && \\" \
					"	echo \"To $m '$APP', root access is required.\" && \\" \
					"	exit 99" >> "make-$m"
			fi
			echo "set -x" >> "make-$m"
			chmod +x "make-$m"
		done
		
		$is_at_home && FHS[prefix]="$prefix_home"
		echo "prefix=${FHS[prefix]}">"$REFERENCE"
		echo "CHROOT=\${DESTDIR:-$CHROOT}" >> "make-install"
		echo "CHROOT=\${DESTDIR:-$CHROOT}" >> "make-uninstall"
		
		# Create the basic ./make content
		if [ -n "$(echo ${PREPARE[@]} ${MAKE[@]})" ]
		then 	C=0
			touch ./make
			chmod +x ./make
			#echo "#!/usr/bin/env bash" > "./make"
			while 	item="${MAKE[$C]}"
				[ -n "$item" ]
			do 	write_executer "$item" >> "./make"
				echo >> "./make"
				((C++))
			done
		else 	echo "echo 'Nothing todo.'" > "./make"
		fi
		
		# Write content of PRIOR tasks, if any
		if [ -n "$(echo ${PRIOR[@]})" ]
		then	source "./$REFERENCE"	# Just prefix yet
			C=0
			echo >> "make-install"
			while 	item="${PRIOR[$C]}"
			[ -n "$item" ]
			do 	write_executer "$item" >> "make-install"
				((C++))
			done
		fi
		
		# Actualy write the make-{un,}install scripts
		for index in $variable_list
		do	# Expand index
			tmp="${!index}"
			# Count words
			num=$(echo "$tmp" | wc -w)
			
			# Only do something if index has content count higher than 0
			if [ "$num" -gt 0 ]
			then	# 'Group' different tasks 
				echo >> "make-install"
				echo >> "make-uninstall"
				
				# It has content
				write_reference "$index" >> "$REFERENCE"
				set $index
				# This usualy is the most important fix, sadly
				cat >> "make-install" <<-EOF
				tmp_str="${FHS[${1,,}]}"
				if [ ! -d "\${CHROOT}\${tmp_str%/*}" ]
				then 	cd "\${CHROOT}/usr/.."
				 	[ -d "\${CHROOT}/usr\${tmp_str%/*}" ] && [ -n "\${tmp_str%/*}" ] && \\
				 		ln -sf "usr\${tmp_str%/*}" "./\${tmp_str%/*}"
				 	cd "\$OLDPWD"
				fi
				[ -d "\${CHROOT}\$tmp_str" ] || mkdir -p "\${CHROOT}\$tmp_str"
				EOF
				case "$num" in
				1)	write_install "$index" "$tmp" >> "make-install"
					write_uninstall "$index" "$tmp" >> "make-uninstall"
					;;
				*)	for s in $(echo "$tmp"|sed s,\"," ",g)
					do 	write_install "$index" "$s" >> "make-install"
						write_uninstall "$index" "$s" >> "make-uninstall"
					done
					;;
				esac
			fi
		done
		source "$PWD/$REFERENCE"
	#
	# 	Finalize
	#
		# Uninstall
		if [ -n "$(echo ${REMOVE[@]})" ]
		then 	C=0
			echo >> "make-uninstall"
			
			while 	item="${REMOVE[$C]}"
				[ -n "$item" ]
			do 	[ -f "$item" ] && \
					echo "rm -f $item" >> "make-uninstall" || \
					echo "$item" >> "make-uninstall"
				((C++))
			done
		fi
		# Now remove hardcoded folders that were used
		for D in data doc
		do 	d="${FHS[${D}dir]}"
			[ -n "$d" ] && \
				echo "[ -d \"\${CHROOT}$d\" ] && rm -fr \${CHROOT}$d" >> "make-uninstall"
		done
		
		# Check for DISTCLEAN operations
		if [ -n "$(echo ${CLEAN[@]})" ]
		then 	C=0
			echo >> "make-distclean"
			
			while 	item="${CLEAN[$C]}"
				[ -n "$item" ]
			do 	write_executer "$item" >> "make-distclean"
				((C++))
			done
		fi
		
		if [ "true" = "${doRef:-false}" ]
		then	echo >> "make-install"
			echo "mkdir -p ${CHROOT}${FHS[sysconfdir]} ; cp \"$REFERENCE\" \"${CHROOT}${FHS[sysconfdir]}/$APP.conf\"" >> "make-install"
			echo "rm -f ${CHROOT}${FHS[sysconfdir]}/$APP.conf" >> "make-uninstall"
		fi
		
		# Check for TEXI operations
		if [ -n "$(echo ${TEXI[@]})" ]
		then 	this_target=make-doc-info
			C=0
			touch "$this_target"
			echo "#!/usr/bin/env bash" > "$this_target"
			chmod +x "$this_target"
			
			while 	[ -n "${TEXI[$C]}" ]
			do 	while read infile outdir
				do 	make_info "$infile" "$outdir" >> "$this_target"
					write_install "infodir" "$outdir/$(echo ${infile##*/}info|sed s,'texi','',)" >> "make-install"
					write_uninstall "infodir" "$outdir/$(echo ${infile##*/}info|sed s,'texi','',)" >> "make-uninstall"
					break
				done<<<"${TEXI[$C]}"
				C=$(( $C + 1 ))
			done
		fi
		# Check for HTML operations
		if [ -n "$(echo ${HTML[@]})" ]
		then 	this_target=make-doc-html
			C=0
			touch "$this_target"
			echo "#!/usr/bin/env bash" > "$this_target"
			chmod +x "$this_target"
			
			while 	[ -n "${HTML[$C]}" ]
			do 	while read infile outdir
				do 	make_doc html "$infile" "$outdir" >> "$this_target"
					write_install "infodir" "$outdir/$(echo ${infile##*/}html|sed s,'texi','',)" >> "make-install"
					write_uninstall "infodir" "$outdir/$(echo ${infile##*/}html|sed s,'texi','',)" >> "make-uninstall"
					break
				done<<<"${HTML[$C]}"
				C=$(( $C + 1 ))
			done
		fi
		# Check for PDF operations
		if [ -n "$(echo ${PDF[@]})" ]
		then 	this_target=make-doc-pdf
			C=0
			touch "$this_target"
			echo "#!/usr/bin/env bash" > "$this_target"
			chmod +x "$this_target"
			
			while 	[ -n "${PDF[$C]}" ]
			do 	while read infile outdir
				do 	make_doc pdf "$infile" "$outdir" >> "$this_target"
					write_install "infodir" "$outdir/$(echo ${infile##*/}pdf|sed s,'texi','',)" >> "make-install"
					write_uninstall "infodir" "$outdir/$(echo ${infile##*/}pdf|sed s,'texi','',)" >> "make-uninstall"
					break
				done<<<"${PDF[$C]}"
				C=$(( $C + 1 ))
			done
		fi
		# Check for DVI operations
		if [ -n "$(echo ${DVI[@]})" ]
		then 	this_target=make-doc-dvi
			C=0
			touch "$this_target"
			echo "#!/usr/bin/env bash" > "$this_target"
			chmod +x "$this_target"
			
			while 	[ -n "${DVI[$C]}" ]
			do 	while read infile outdir
				do 	make_doc dvi "$infile" "$outdir" >> "$this_target"
					write_install "infodir" "$outdir/$(echo ${infile##*/}dvi|sed s,'texi','',)" >> "make-install"
					write_uninstall "infodir" "$outdir/$(echo ${infile##*/}dvi|sed s,'texi','',)" >> "make-uninstall"
					break
				done<<<"${DVI[$C]}"
				C=$(( $C + 1 ))
			done
		fi
		# Check for PS operations
		if [ -n "$(echo ${PS[@]})" ]
		then 	this_target=make-doc-ps
			C=0
			touch "$this_target"
			echo "#!/usr/bin/env bash" > "$this_target"
			chmod +x "$this_target"
			
			while 	[ -n "${PS[$C]}" ]
			do 	while read infile outdir
				do 	make_doc ps "$infile" "$outdir" >> "$this_target"
					write_install "infodir" "$outdir/$(echo ${infile##*/}ps|sed s,'texi','',)" >> "make-install"
					write_uninstall "infodir" "$outdir/$(echo ${infile##*/}ps|sed s,'texi','',)" >> "make-uninstall"
					break
				done<<<"${PS[$C]}"
				C=$(( $C + 1 ))
			done
		fi
		
		
		# Use the REFERENCE file?
		if [ "true" = "${doRef:-false}" ]
		then	echo >> "make-install"
			echo "mkdir -p ${CHROOT}${FHS[sysconfdir]} ; cp \"$REFERENCE\" \"${CHROOT}${FHS[sysconfdir]}/$APP.conf\"" >> "make-install"
			echo "rm -f ${CHROOT}${FHS[sysconfdir]}/$APP.conf" >> "make-uninstall"
		fi
		
		# Check for post operations, letter better here, than with 'set -s'
		if [ -n "$(echo ${POST[@]})" ]
		then 	C=0
			echo >> "make-install"
			while 	item="${POST[$C]}"
				[ ! -z "$item" ]
			do 	[ -f "$item" ] && \
					echo "bash ./$item" >> "make-install" || \
					echo "$item" >> "make-install"
				((C++))
			done
		fi
		write_distclean >> "make-distclean"
		write_clean >> "make-clean"
		for m in install uninstall clean distclean doc-{info,html,dvi,ps,pdf}
		do	if [ -f "./make-$m" ]
			then 	echo >> "make-$m"
				printf '%s\n' \
					"RET=\$?" \
					"set +x" >> "make-$m"
			fi
		done
		printf '%s\n' "RET=\$?" "set +x" >> "./make"
		
		# Let the script exit with their proper exit code.
		echo "echo;echo \"Finished installation of ${APP_TITLE:-$APP} with \$? (0=success)\";exit \$RET" >> "make-install"
		[ -f "./make" ] && echo "exit \$RET" >> "make" && chmod +x "./make"
		echo "exit \$RET" >> "make-uninstall"
		echo "exit \$RET" >> "make-distclean"
		
		sed s,'set -x',"set -x\nSYSCONFDIR=$SYSCONFDIR",g -i make-{uni,i}nstall
		sed s,'~',"$HOME",g -i make-{uni,i}nstall
		
		
	}
#
#	Get options
#
	GETOPT=$(getopt \
		--options	"h" \
		--longoptions	"help,version,config,write-makefile,sample,sample-full,chroot:,tarball,bindir:,sbindir:,prefix:,datarootdir:,datadir:,infodir:,mandir,man[1-9]dir:,localedir:,docdir:,compldir:,sharedstatedir:,localstatedir:,localedir:" \
		--name 		"${0##*/}" -- "${@}"
	)
	eval set -- "$GETOPT"
	while true
	do 	case "$1" in
		-h|--help)	show_help	;;
		--version)	show_version	;;
		--sample)	show_sample	;;
		--sample-full)	show_sample_full;;
		--prefix|--bindir|--sbindir|--datarootdir|--datadir|\
		--infodir|--sysconfdir|--mandir,--man[1-9]dir|--docdir|--htmldir|--dvidir|--pdfdir|--psdir|\
		--compldir|--sharedstatedir|--localstatedir|--localedir)
				FHS["${1/--}"]="$2"
				shift 2		;;
		--tarball)	doTarball=true
				shift 		;;
		--config)	CONFIG="$2"
				shift 2		;;
		--chroot)	CHROOT="$2"
				shift 2		;;
		--write-makefile)
				doMakefile=true
				shift		;;
		--)		shift ; break	;;
		esac
	done
	[ -z "$APP" ] && echo "Missing APP name..." && exit 1
	REFERENCE="${APP}_dirs.conf"
#
#	Prepare paths
#
	for index in $index_list
	do
		tmp="${FHS[$index]}"
		etc_done=false
		if [ -z "$tmp" ]
		then	case "$index" in
			prefix)		tmp="${APP_DIR}"	;;
			"bindir")	tmp="${FHS[prefix]}/bin"	;;
			"sbindir")	tmp="${FHS[prefix]}/sbin"	;;
			sysconfdir)	tmp_prefix="${FHS[prefix]}"
					case "$tmp_prefix" in
					"/"|"/usr")
						tmp="/etc"		;;
					*)	if $is_at_home
						then	tmp="$HOME/.local/etc"
						else	tmp="${FHS[prefix]}/etc"
						fi
						;;
					esac ; etc_done=true				;;
			datarootdir)	tmp="${FHS[prefix]}/share"	;;
			appdir)		tmp="${FHS[datarootdir]}/applications"	;;
			icondir)	tmp="${FHS[datarootdir]}/icons"	;;
			datadir)	tmp="${FHS[datarootdir]}/$APP"	;;
			infodir)	tmp="${FHS[datarootdir]}/info"	;;
			mandir)		tmp="${FHS[datarootdir]}/man" ;;
			man[0-9]dir)	tmp="${FHS[mandir]}/${index:0:4}" ;;
			localedir)	tmp="${FHS[datarootdir]}/locale" ;;
			docdir)		tmp="${FHS[datarootdir]}/doc/$APP" ;;
			htmldir|dvidir|pdfdir|psdir)	tmp="${FHS[docdir]}" ;;
			compldir)	# Some systems have bash completion within the SYSCONFDIR
					if [ -d "${FHS[datarootdir]}/bash_completion/completions" ]
					then 	tmp="${FHS[datarootdir]}/bash_completion/completions"
					elif [ -d "${FHS[sysconfdir]}/bash_completion.d" ]
					then	tmp="${FHS[sysconfdir]}/bash_completion.d"
					else # Use default as fallback
						tmp="${FHS[datarootdir]}/bash-completion/completions"
					fi ;;
			sharedstatedir)	tmp="${FHS[prefix]}/com"	;;
			localstatedir)	tmp="${FHS[prefix]}/var"	;;
			esac
			if [ "$index" = "prefix" ] && ! $etc_done
			then	# Do special handling
				[ "~" = "${tmp:0:1}" ] && tmp="${tmp/~/$HOME}"
				if [ "${tmp:0:${#HOME}}" = "$HOME" ]
				then	is_at_home=true
					install_prefix=""
					prefix_home="${{tmp/~/$HOME}/$HOME}"
					tmp="$prefix_home"
				fi
			fi
			FHS["$index"]="$tmp"
		fi
	done
	export FHS
	prefix="${FHS[prefix]}"
	# Updated again - For the Arrays
	source "$CONFIG"
#
#	Before we start, are there any other files beside configure?
#
	tmp=$(\ls -l|\grep -v configure)
	if [ -z "$tmp" ]
	then	# It is empty, so no other files available, get them now

		if [ -n "$DOWNLOAD" ]
		then 	# Tarball is available
			curl -o "$APP.tar.gz" "$DOWNLOAD"
			tar axf "$APP.tar.gz"
			cd "$DOWNLOAD_DIR"
			mv * ..
			cd ..
		elif [ -n "$APP_GIT" ]
		then	# Git url is passed, lets check if it is required
			# There are 'code' or '.git' urls
			last_word="${APP_GIT##*/}"
			check_word="${last_word/\.git}"
			if [ "$last_word" = "$check_word" ]
			then	# it is 'code'
				git clone "$APP_GIT" "$APP"
			else	# its *.git
				git clone "$APP_GIT"
			fi
			mv "$APP" "$APP.$$"
			cd "$APP.$$"
			mv * ..
			cd ..
		else	printf '%s\n' \
				"Fatal error, could not retrieve source code" \
				"Please check if either DOWNLOAD ($DOWNLOAD + $DOWNLOAD_DIR) are set," \
				"or if $APP_GIT provides a valid URL."
			exit 1
		fi
	fi
#
#	Prepare installation script
#
	write_files
	APP_REQUIRES=""
	source "$CONFIG";missing=""
	for req in $CFG_REQUIRES $APP_REQUIRES;do
		which $req 2>/dev/zero 1>&2 || missing+=" $req"
	done
	[ ! -z "$missing" ] && \
		printf '%s\n' "Please provide these commands before installing $APP!"  && \
		printf '::-->> %s\n' ${missing} && \
		exit 1
#
#	Output
#
	if $doTarball
	then	exclude_list="make-distclean"
		for ex in "${IGNORE[@]}";do exclude_list+=" $ex";done
		# Since we prepare the make-<files>, configure is no longer required
		opt_exclude="--exclude-ignore=configure"
		for item in $exclude_list;do opt_exclude+=" --exclude-ignore=$item";done
		
		tmp_p="${PWD:-$(pwd)}"
		tmp_dir="$(dirname $tmp_p)"
		[ -z "$APP_VER" ] && \
			VERSION="" || \
			VERSION="_${APP_VER}"
		for t in "${PRIOR[@]}"
		do 	(set -x ; $t )
		done
		tarball="../${APP}$VERSION.tar.gz"
		set -x
		tar 	-acf "$tarball" \
			--hard-dereference \
			$opt_exclude * && \
			echo "Successfully created tarball ${tarball}!"
		set +x
	else	[ "$HOME" = "${prefix:0:${#HOME}}" ] && install_prefix=""
		${doMakefile} && write_makefile
		echo
		echo "The installation script has been configured to ${CHROOT}${FHS[prefix]} (${FHS[prefix]})."
		if [ -n "$(echo ./make-doc-*)" ] 
		then
			if [ -f Makefile ]
			then 	for mm in ./make-doc-*
				do
					[ ! -f make-doc-info ] && \
						echo "You might want to run:" && \
						grep ":" Makefile | awk '{print $1}' | \
							grep -ve tall -ve opt -ve clea -ve PH|\
							while read var;do echo "* make ${var/\:}";done
				done
			fi
		#	 && \
		#		echo "You might to run $(echo ./make-doc-*)."
		fi
		[ -f Makefile ] && \
			echo "To install \"${APP_TITLE:-$APP} ($APP_VER)\" now, please execute: make && ${install_prefix}'make install'" || \
			echo "To install \"${APP_TITLE:-$APP} ($APP_VER)\" now, please execute: ./make && ${install_prefix}'./make-install'"
		echo
	fi
	exit
