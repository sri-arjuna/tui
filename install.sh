#!/usr/bin/env bash
# ------------------------------------------------------------------------
#
# Copyright (c) 2015 by Simon Arjuna Erat (sea)  <erat.simon@gmail.com>
# All rights reserved.
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>
#
# ------------------------------------------------------------------------
#
#	This script will help you to install TUI on your system
#	Last Update:	2015.06.14
#
#	Internals
#
	script_version=0.8.8
	TRC=$HOME/.tuirc	# This exists for all users, incl root
	TRC_SYS="/etc/tuirc"	# This contains the installation paths, only created if installed as root!
	isUpdate=false
#
#	Variables
#
	# Presets / Defaults
	if [ $UID -eq 0 ]
	then	SUGGESTED_ROOT=/usr/local
		SUGGESTED_PREFIX=/usr/local
	else	SUGGESTED_ROOT=$HOME/.local
		SUGGESTED_PREFIX=$HOME/.local
	fi
	SUGGESTED_PROJECT=$HOME/Projects
	# As this is user specific, leave empty so it will look for $HOME/.local/bin or $HOME/bin,
	# if neither is found, it will create $HOME/bin and place tui-new-scripts and tui-new-manpage files there
	SUGGESTED_SCRIPTS=""
	
	# Update if possible, otherwise catch user definitions
	if [ -f "$TRC_SYS" ] || [ -f "$TRC" ]
	then	# Its an update
		isUpdate=true
		# Get only the system paths if available:
		[ -f "$TRC_SYS" ] && source "$TRC_SYS" || source "$TRC"
		catched_root="$TUI_ROOT" ## "${TUI_ROOT%/}"
		catched_prefix="$TUI_PREFIX"
		catched_project="$TUI_DIR_PROJECTS"
		catched_scripts="$TUI_DIR_USER_SCRIPTS"
	else	# Its a fresh installation
		isUpdate=false
		catched_root="${CHROOT:-$SUGGESTED_ROOT}"
		[ -z "$CHROOT" ] && catched_root="$SUGGESTED_ROOT" || catched_root="$CHROOT"
		[ -z "$PREFIX" ] && catched_prefix="$SUGGESTED_PREFIX" || catched_prefix="$PREFIX"
		catched_project="${PROJECT:-$SUGGESTED_PROJECT}"
		catched_scripts="$SCRIPTS"
	fi
	# Bash completion is quit annoying to catch on some systems
	if [ -z "$DIR_COMPL" ] 
	then	compl_default=bash-completion
		for TASK in bash_completion $compl_default
		do	[ -d "$catched_prefix/share/$TASK/completions" ] && \
				DIR_COMPL="$catched_prefix/share/$TASK/completions" && \
				break
		done
		[ -z "$DIR_COMPL" ] && DIR_COMPL="$catched_prefix/share/$compl_default/completions"
	fi
#
#	Functions
#
	initializeANSI() { #
	# Get the ANSI codes
	#
		esc="";		blackf="${esc}[30m";	redf="${esc}[31m"
		greenf="${esc}[32m";	yellowf="${esc}[33m";	bluef="${esc}[34m"
		purplef="${esc}[35m";	cyanf="${esc}[36m";	whitef="${esc}[37m"
		blackb="${esc}[40m";	redb="${esc}[41m";	greenb="${esc}[42m"
		yellowb="${esc}[43m";	blueb="${esc}[44m";	purpleb="${esc}[45m"
		cyanb="${esc}[46m";	whiteb="${esc}[47m";	reset="${esc}[0m"
	}
	yesno()	{ # "Question"
	# Returns 0 for yes and 1 for no
	#
		while true; do
			echo "${1} (y/n): "
			read response ; echo
			case "${response:0:1}" in
				[yYjJsSOo]) return 0 ;;
				[nN]) return 1 ;;
				*) echo ;
			esac
		done
	}
	showTitle() { # 
	# Shows the title
	#
		printf "\n\t    \033[4mInstalling: Text User Interface - Command framework\033[0m\n\n"
	}
	seaLogo() {
	# Shows the logo
	#
		tmp_str=$(
			for n in 101 156 157 164 150 145 162 173 163 143 162 151 160 164 173 142 \
				162 157 165 147 150 164 173 164 157 173 171 157 165 173  142 171
			do printf "\\$n" ;done
			) 
		te "$tmp_str" | sed s,'{',' ',g
		te
		cat <<-EOF
		 			${bluef}${whiteb}╔══════════════════════╗${reset}
		 			${bluef}${whiteb}║                      ║${reset}
		 			${bluef}${whiteb}║  ╔══╗  ╔═══╗  ╔═══╗  ║${reset}
		 			${bluef}${whiteb}║  ║     ║   ║      ║  ║${reset}
		 			${bluef}${whiteb}║  ╚══╗  ╠═══╝  ╔═══╣  ║${reset}
		 			${bluef}${whiteb}║     ║  ║      ║   ║  ║${reset}
		 			${bluef}${whiteb}║  ╚══╝  ╚═══╝  ╚═══╝  ║${reset}
		 			${bluef}${whiteb}║                      ║${reset}
		 			${bluef}${whiteb}╚══════════════════════╝${reset}
		 
		 		     ${greenf}${blackb}# Joined GNU/Linux @ 2011 June 1st${reset}
		
		EOF
	}
	# Some basic display tools
	tp(){ printf '\r\t\t%s' "${@}" ; }
	tt(){ printf '\t%s\n\n' "${@}" ; }
	te(){ printf '%s\n' 	"${@}" ; }
	t2(){ printf '%s\t%s\n' "${@}" ; }
	mainmenu() { #
	# Start the actual installation from here
	# Inform the user about 'tweaks'
		if [ $UID -eq 0 ]
		then	te "You're root, so a system wide installation is recomended."
			te "Recomended Installation as root:"
			te "${bluef}${whiteb}CHROOT=/ PREFIX=/usr $0$reset"
			te
		else	te "You're a regular user, so a custom installation is recomended."
			te "Note this makes things complicate if your scripts shall be used as root, with sudo, or by other users!"
			te "Recomended Installation as user:"
			te "${bluef}${whiteb}CHROOT=\$HOME/.local PREFIX=\$HOME/.local [PROJECT=\$HOME/prjs] [SCRIPTS=\$HOME/path/to/scripts] $0$reset"
			te
		fi
		t2 "Installation root:" 	"$catched_root"
		t2 "Installation prefix:" 	"$catched_root/${catched_prefix/$catched_root/}"
		[ 0 -ne $UID ] && t2 "User projects:"	"$catched_project"
		[ 0 -ne $UID ] && t2 "User scripts:"	"$catched_scripts"
		te
		t2 "User config will be installed to:" "${TUI_DIR_USER:-$HOME/.config/tui}/"
		t2 "Binary files will be installed to:" "$catched_prefix/bin/"
		t2 "Default config will be installed to:" "$catched_root/etc/tui/"
		t2 "Application data will be installed to:" "$catched_prefix/share/tui/"
		t2 "Bash-completion will be installed to:" "$DIR_COMPL"
		te
		[ 0 -eq $UID ] && t2 "Systemwide configuration presets are set in:" "$catched_root/etc/tui/"
		t2 "Personal configuration defaults to: " "\$XDG_CONFIG_DIR[/tui] or \$HOME/.config[/tui]"
		t2 "New scripts will be saved to:" "$catched_scripts"
		te
		# If it is NOT an update, and user doesnt want to contiue, to change paths perhaps, exit with success.
		#! $isUpdate &&
		! yesno "Do you want to continue?" && exit 0
		
		install_tui
	}
	install_tui() { #
	# Create the user RC file with the set installation paths
	# Then copy the files to their paths
		[ ! -f bin/tui ] && te && te "You must be in the directory of $0" && exit 1
		te
		if $isUpdate
		then	tt "Updating now..."
			source "$TRC" 1>/dev/zero
		else	tt "Installing now..."
			te "* Creating system paths..."
			# Make sure initial variables contain data:
			TUI_DIR_BIN="${TUI_DIR_BIN:-$catched_root/${catched_prefix/$catched_root}/bin}"/
			TUI_DIR_THEMES="${TUI_DIR_THEMES:-$catched_root/${catched_prefix/$catched_root}/share/tui/themes}/"
			TUI_DIR_DOCS="${TUI_DIR_DOCS:-$catched_root/${catched_prefix/$catched_root}/share/doc/tui}/"
			TUI_DIR_MANPAGES="${TUI_DIR_MANPAGES:-$catched_root/${catched_prefix/$catched_root}/share/man/man1}"
			TUI_DIR_SYSTEM="${TUI_DIR_SYSTEM:-$catched_root/${catched_prefix/$catched_root}/share/tui}"
			TUI_DIR_TEMPLATES="${TUI_DIR_TEMPLATES:-$catched_root/${catched_prefix/$catched_root}/share/tui/templates}"
			TUI_DIR_USER="${TUI_DIR_USER:-$HOME/.config/tui}/"
			
			for t_dir in 	"$catched_root" "$catched_prefix" \
					$DIR_COMPL $TUI_DIR_{BIN,CONF,DOCS,MANPAGES,LOGS,LIST,SYSTEM,TEMPLATES,THEMES,USER,TEMP} \
					$TUI_DIR_USER_{LOGS,SCRIPTS,MANPAGES,TEMPLATES,THEMES}
			do	if [ ! -d "$t_dir" ] 
				then	printf "%s" "Creating: $t_dir :: "
					mkdir -p "$t_dir" 
					printf "%s\n" "$?"
				else	echo "Skipped: $t_dir"
				fi
			done
			
			
			printf '%s\n' "* Writing RC file ($TRC)"
			CHROOT="$catched_root" PREFIX="$catched_prefix" PROJECT="$catched_project" SCRIPT="$catched_scripts" . bin/tuirc >/dev/zero
			
		fi
		
		# Ok, me load the variables now 3 times...
		#[ -f /etc/tuirc ] && source /etc/tuirc
		source ~/.tuirc 2>/dev/zero
		#source bin/tuirc
		#echo $TUI_DIR_BIN
		#echo but still empty?
		
		te
		te "* Copying binaries..."
	#	cd bin
	#	set -x
	#	cp -aurf -t "${TUI_DIR_BIN:-/usr/bin}"/ *
	#	ls /usr/bin/tui*
		
		cp -aurf bin/* "$TUI_DIR_BIN"/
	#	ls /usr/bin/tui*
		
	#	cp -aurf  * -t "$TUI_DIR_BIN"
	#	ls /usr/bin/tui*
	#	cd ..
	#	set +x
		
		te "* Copying configuration (system)..."
		cp -au conf.etc/* "$TUI_DIR_CONF"/
		te "* Copying configuration (user)..."
		cp -au conf.home/* "$TUI_DIR_USER"/
		
		te "* Copying themes..."
		cp -aRu themes/* "$TUI_DIR_THEMES"/
		
		te "* Copying documentation"
		cp -aRfu docs/* "$TUI_DIR_DOCS"/
		
		te "* Copying manpages"
		cp -aRf docs/* "$TUI_DIR_MANPAGES"/
		
		te "* Copying system"
		cp -aR conf.{etc,home} "$TUI_DIR_SYSTEM"
		cp -af uninstall.sh "$TUI_DIR_SYSTEM"
		cp -af tui_compl.bash "$DIR_COMPL"
		
		te "* Copying templates"
		cp -aRf templates/* "$TUI_DIR_TEMPLATES"/
		
		te "* Copying lists"
		cp -aRf lists/* "$TUI_DIR_LIST"
		RET=$?
		
		if [ ${RET:-1} -eq 0 ]
		then	bin/tui-printf -T "" "Status Report" ""
			bin/tui-printf -S $RET "Installation successfull" && \
				bin/tui-printf -E "If you install TUI as dependency, you may skip this step." && \
				bin/tui-yesno "Do you want to configure TUI now?" && \
				bin/tui config || exit $RET
		else	te "Installation failed...  ;("
			t2 "CHROOT was:" "<$CHROOT>"
			t2 "PREFIX was:" "\$CHROOT/<$PREFIX>"
			t2 "USER was:"   "<$USER>"
			t2 "Probably an expected path was not found."
		fi
		exit $RET
	}
#
#	Action & Display
#
	beQuiet=false 
	case "$1" in
	"-q"|"--quiet")
		beQuiet=true # && shift || 
		;;
	"-h"|"--help")
		cat <<-EOF
		${0##*/} ($script_version) for TUI by Arjuna
		This script will install Text User Interface (TUI)
		
		Set these variables before you execute ${0##*/} for custom installation.
		CHROOT	Set this variable as prefix for <CHROOT>/etc/tui
		PREFIX	Set this variable as prefix for <CHROOT>/<PREFIX>/share/tui
		PROJECT Set this variable as \$HOME\<PROJECT>
		SCRIPTS	Set this variable ONLY if you use neither \$HOME/bin nor \$HOME/.local/bin
		
		EOF
		exit 99
		;;
	esac
	initializeANSI
	$beQuiet || seaLogo
	showTitle
	mainmenu
