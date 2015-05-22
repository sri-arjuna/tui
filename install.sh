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
#
#	Internals
#
	script_version=0.6
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
#
#	Functions
#
	initializeANSI() { #
	#
	#
		esc=""

		blackf="${esc}[30m";	redf="${esc}[31m";	greenf="${esc}[32m"
		yellowf="${esc}[33m";	bluef="${esc}[34m";	purplef="${esc}[35m"
		cyanf="${esc}[36m";	whitef="${esc}[37m"

		blackb="${esc}[40m";	redb="${esc}[41m";	greenb="${esc}[42m"
		yellowb="${esc}[43m";	blueb="${esc}[44m";	purpleb="${esc}[45m"
		cyanb="${esc}[46m";	whiteb="${esc}[47m"

		reset="${esc}[0m"
	}
	yesno()	{ # "Question"
	#
	#
		while true; do
			read -p "${1} (y/n): " -n1 response ; echo
			case "$response" in
				[yY]) return 0 ;;
				[nN]) return 1 ;;
				*) echo ;
			esac
		done
	}
	showTitle() { # 
	#
	#
		printf "\t    \033[4mInstalling: Text User Interface - Command framework\033[0m\n\n"
	}
	seaLogo() {
	#
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
	tp(){ printf '\r\t\t%s' "${@}" ; }
	tt(){ printf '\t%s\n\n' "${@}" ; }
	te(){ printf '%s\n' "${@}" ; }
	t2(){ printf '%s\t%s\n' "${@}" ; }
	mainmenu() { #
	#
	#
		if [ $UID -eq 0 ]
		then	te "You're root, so a system wide installation is recomended."
		else	te "You're a regular user, so a custom installation is recomended."
			te "Note this makes things complicate if your scripts shall be used as root or with sudo."
		fi
		catched_root=${CHROOT:-$SUGGESTED_ROOT}
		catched_prefix=${PREFIX:-$SUGGESTED_PREFIX}
		te
		t2 "Installation root:" "$catched_root"
		t2 "Installation prefix:" "$catched_prefix"
		te
		t2 "Binary files will be installed to:" "$catched_prefix/bin"
		t2 "Config files will be installed to:" "$catched_root/etc/tui"
		t2 "Application data will be installed to:" "$catched_prefix/share/tui"
		t2 "User configuration defaults to: " "\$XDG_CONFIG_DIR or \$HOME/.config/tui"
		te
		if ! yesno "Do you want to continue?"
		then	te
			te "To change the installation destination, please start as root or start like:"
			te
			te "${bluef}${whiteb}CHROOT=/path/to/chroot PREFIX=/path/to/chroot/usr $0$reset"
			te
			exit 0
		fi
		[ -z "$DIR_COMPL" ] && DIR_COMPL=$catched_prefix/bash_completion/completions
		install_tui
	}
	install_tui() { #
	# Create the user RC file with the set installation paths
	# Then copy the files to their paths
		[ ! -f bin/tui ] && te && te "As of now, you must be in the projects home directory to install TUI!" && exit 1
		CHROOT="$catched_root" PREFIX="$catched_prefix" . bin/tui
		
		te;te;te
		tt "Installing now..."
		te
		te "* Creating system paths..."
		mkdir -p $DIR_COMPL $TUI_DIR_{CONF,DOCS,MANPAGES,LOGS,SYSTEM,TEMPLATES,THEMES,USER,CACHE}
		mkdir -p $TUI_DIR_USER_{LOGS,SCRIPTS,MANPAGES,TEMPLATES,THEMES}
		
		te "* Copying binaries..."
		cp -a bin/tui* "${TUI_DIR_BIN:-/usr/bin}"
		
		te "* Copying configuration (system)..."
		cp -a conf.etc/* "${TUI_DIR_CONF:-/etc/tui}"
		te "* Copying configuration (user)..."
		cp -a conf.home/* "${TUI_DIR_USER:-$HOME/.config/tui}"
		
		te "* Copying documentation..."
		cp -a docs/[LR]* "${TUI_DIR_DOCS:-/usr/share/doc/tui}"
		
		te "* Copying system..."
		cp -aR docs/* "${TUI_DIR_SYSTEM:-/usr/share/tui}"
		cp -aR conf.{etc,home} "${TUI_DIR_SYSTEM:-/usr/share/tui}"
		cp -a tui_compl.bash $DIR_COMPL/
		cp -a uninstall.sh $TUI_DIR_SYSTEM
		
		te "* Copying templates..."
		cp -aR templates/* "${TUI_DIR_TEMPLATES:-/usr/share/tui/templates}"
		
		te "* Copying themes..."
		cp -aR themes/* "${TUI_DIR_THEMES:-/usr/share/tui/themes}"
		
		te "* Copying lists..."
		cp -a lists/* "${TUI_DIR_LIST:-/usr/share/tui/lists}"
		
		tui-status $? "Installation successfull!"
		exit $?
	}
#
#	Action & Display
#
	while true;do
		clear
		sep=173
		tmp_str=$(
			for n in 101 156 157 164 150 145 162 $sep \
				163 143 162 151 160 164 $sep \
				142 162 157 165 147 150 164 $sep \
				164 157 $sep 171 157 165 $sep \
				142 171;do printf "\\$n" ;done
			) 
		te "$tmp_str" | sed s,'{',' ',g
		te
		seaLogo
		showTitle
		mainmenu
		break
	done