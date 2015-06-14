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
#	Last Update:	2015.06.09
#
#	Internals
#
	script_version=0.8.6
	TRC=$HOME/.tui_rc
#
#	Variables
#
	if [ $UID -eq 0 ]
	then	SUGGESTED_ROOT=/
		SUGGESTED_PREFIX=/usr
	else	SUGGESTED_ROOT=$HOME/.local
		SUGGESTED_PREFIX=$HOME/.local
	fi
	SUGGESTED_PROJECT=$HOME/Projects
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
		printf "\t    \033[4mInstalling: Text User Interface - Command framework\033[0m\n\n"
	}
	seaLogo() {
	# Shows the logo
	#
		initializeANSI  
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
		 
		 		     ${greenf}${blackb}# Joined Linux @ 2011 June 1st${reset}
		
		EOF
	}
	# Some basic display tools
	tp(){ printf '\r\t\t%s' "${@}" ; }
	tt(){ printf '\t%s\n\n' "${@}" ; }
	te(){ printf '%s\n' "${@}" ; }
	t2(){ printf '%s\t%s\n' "${@}" ; }
	mainmenu() { #
	# Start the actual installation from here
	# Inform the user about 'tweaks'
		if [ $UID -eq 0 ]
		then	te "You're root, so a system wide installation is recomended."
		else	te "You're a regular user, so a custom installation is recomended."
			te "Note this makes things complicate if your scripts shall be used as root or with sudo."
		fi
		if [ -f "$TRC" ]
		then	[ -z "$TUI_DIR_INSTALL_ROOT" ] && \
				catched_root=${CHROOT:-$SUGGESTED_ROOT} ||\
				catched_root="$TUI_DIR_INSTALL_ROOT"
			[ -z "$TUI_PREFIX" ] && \
				catched_prefix=${PREFIX:-$SUGGESTED_PREFIX} ||\
				catched_prefix="$TUI_PREFIX"
		else	catched_root="${CHROOT:-$SUGGESTED_ROOT}"
			catched_prefix="${PREFIX:-$SUGGESTED_PREFIX}"
		fi
		te
		t2 "Installation root:" "$catched_root"
		t2 "Installation prefix:" "$catched_prefix"
		te
		t2 "Binary files will be installed to:" "$catched_prefix/bin"
		t2 "Config files will be installed to:" "$catched_root/etc/tui"
		t2 "Application data will be installed to:" "$catched_prefix/share/tui"
		t2 "User configuration defaults to: " "\$XDG_CONFIG_DIR[/tui] or \$HOME/.config[/tui]"
		te
		te "To change the installation destination, please start as root or start like:"
		te "${bluef}${whiteb}CHROOT=/path/to/chroot PREFIX=/path/to/chroot/usr $0$reset"
		te
		if ! yesno "Do you want to continue?"
		then	exit 0
		fi
		# Bash completion is quit annoying to catch
		if [ -z "$DIR_COMPL" ] 
		then	for TASK in bash_completion bash-completion
			do	[ -d "$catched_prefix/share/$TASK/completions" ] && \
					DIR_COMPL="$catched_prefix/share/$TASK/completions" && \
					break
			done
			[ -z "$DIR_COMPL" ] && DIR_COMPL="$catched_prefix/share/bash-completion/completions"
		fi
		install_tui
	}
	install_tui() { #
	# Create the user RC file with the set installation paths
	# Then copy the files to their paths
		[ ! -f bin/tui ] && te && te "As of now, you must be in the projects home directory to install TUI!" && exit 1
		printf '%s' "Writing RC file ($TRC)"
		CHROOT="$catched_root" PREFIX="$catched_prefix" . bin/tui
		
		te;te
		tt "Installing now..."
		te "* Creating system paths..."
		mkdir -p $DIR_COMPL $TUI_DIR_{CONF,DOCS,MANPAGES,LOGS,LIST,SYSTEM,TEMPLATES,THEMES,USER,CACHE}
		mkdir -p $TUI_DIR_USER_{LOGS,SCRIPTS,MANPAGES,TEMPLATES,THEMES}
		
		te "* Copying binaries..."
		cp -a bin/tui* "${TUI_DIR_BIN:-/usr/bin}"/
		
		te "* Copying configuration (system)..."
		cp -a conf.etc/* "${TUI_DIR_CONF:-/etc/tui}"
		te "* Copying configuration (user)..."
		cp -a conf.home/* "${TUI_DIR_USER:-$HOME/.config/tui}"
		
		te "* Copying themes..."
		cp -aR themes/* "${TUI_DIR_THEMES:-/usr/share/tui/themes}"
		
		te "Copying documentation"
		cp -aR docs/* "${TUI_DIR_DOCS:-/usr/share/doc/tui}"
		
		te "Copying system"
		cp -aR conf.{etc,home} "${TUI_DIR_SYSTEM:-/usr/share/tui}"
		cp -af uninstall.sh "$TUI_DIR_SYSTEM"
		cp -af tui_compl.bash "$DIR_COMPL"
		
		te "Copying templates"
		cp -aRf templates/* "${TUI_DIR_TEMPLATES:-/usr/share/tui/templates}"
		
		te "Copying lists"
		cp -aRf lists/* "${TUI_DIR_LIST:-/usr/share/tui/lists}"
		RET=$?
		
		if [ ${RET:-1} -eq 0 ]
		then	bin/tui-printf -T "" "Status Report" ""
			bin/tui-printf -S $RET "Installation successfull" && \
				bin/tui-printf -E "If you install TUI as dependency, you may skip this step." && \
				bin/tui-yesno "Do you want to configure TUI now?" && \
				bin/tui config || exit $RET
		else	te "Installation failed...  ;("
			t2 "CHROOT was:" "$CHROOT"
			t2 "PREFIX was:" "$PREFIX"
			t2 "USER was:"   "$USER"
			t2 "Probably an expected path was not found."
		fi
		exit $RET
	}
#
#	Action & Display
#
	case "$1" in
	"-h"|"--help")
		cat <<-EOF
		${0##*/} ($script_version) for TUI by Arjuna
		This script will install Text User Interface (TUI)
		
		Set these variables before you execute ${0##*/} for custom installation.
		CHROOT	Set this variable as prefix for <CHROOT>/etc/tui
		PREFIX	Set this variable as prefix for <CHROOT>/<PREFIX>/share/tui
		PROJECT Set this variable as \$HOME\<PROJECT>
		
		EOF
		exit 99
		;;
	esac
	while true;do
		clear
		tmp_str=$(
			for n in 101 156 157 164 150 145 162 173 163 143 162 151 160 164 173 142 \
				162 157 165 147 150 164 173 164 157 173 171 157 165 173  142 171
			do printf "\\$n" ;done
			) 
		te "$tmp_str" | sed s,'{',' ',g
		te
		seaLogo
		showTitle
		mainmenu
		break
	done
