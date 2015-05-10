#!/usr/bin/env bash
# ------------------------------------------------------------------------
#
# Copyright (c) 2013-2015 Simon Arjuna Erat (sea)  <erat.simon@gmail.com>
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
# ------------------------------------------------------------------------
#
#	Preparations
#
	[ -f install.sh ] || cd "$(dirname "$0")"
	[ ! -f install.sh ] && \
		echo "You must be in the same directory as the install script resides. ($0)" && \
		exit 1
#
#	Variables
#
	app=tui
	[ -z "$TRC" ] &&  TRC="$HOME/.tui_rc"
	if [ -z "$PREFIX" ]
	then	PREFIX="/usr/local/"
		CHROOT=/
		echo "You have not specified a PREFIX, so $app will install in $PREFIX." >&2
		echo "This is probably not what you want.  Run PREFIX=/usr $0 to install in standard paths." >&2
	fi
	[ "/usr" = "${PREFIX:0:4}" ] && CHROOT=/
	TUI_PREFIX=$PREFIX CHROOT=${CHROOT:-$TUI_PREFIX}  source bin/tui 1>/dev/zero
exit	
	
	# Default paths, hardcoded
	DIR_CFG"${TUI_DIR_CONF:-$CHROOT/etc/$app}"
	DIR_COMPL="${DIR_CFG/tui/bash_completion.d}" #/etc/bash_completion.d"
	
	
	# Default paths, using PREFIX
	DIR_BIN="$PREFIX/bin"
	DIR_DOC="$PREFIX/share/doc/$app"
	DIR_MAN1="${TUI_DIR_USER_MANPAGES:-$PREFIX/share/man/man1}"
	DIR_APP="${TUI_DIR_SYSTEM:-$PREFIX/share/$app}"
	DIR_TPL="$DIR_APP/templates"
#
#	Install to Environment
#
	echo "To UN-install TUI, please execute: $DIR_APP/uninstall.sh"
	printf "\n\n\tPress enter to install $app OR press 'CTRL+c' to abort"
	read buffer
	
	# Prepare paths:
	for tDir in $DIR_APP \
			$DIR_CFG \
			$DIR_DOC \
			$DIR_MAN1 \
			$DIR_TPL \
			$DIR_APP/conf \
			$DIR_APP/conf.etc \
			$DIR_COMPL
	do	if [ ! -d "$tDir" ]
		then	if mkdir -p "$tDir"
			then	printf "*\tCreated missing dir: $tDir\n"
			else	printf "o\tFAILED creating missing dir: $tDir\n"
			fi
		else	printf "*\tFound existing dir: $tDir\n"
		fi
	done
	
	printf "\nCopy files...\n"
	# Copy docs:
	#cp -a README.md $DIR_APP/	# Its just a symlink
	cp -aR docs/* $DIR_DOC/
	cp -a man/*1 $DIR_MAN1/
	
	# Copy binaries
	cp -a bin/* $DIR_BIN/
	
	# Copy configs
	cp -a conf.etc/* $DIR_CFG/
	cp -a conf.etc/* $DIR_APP/conf.etc/
	cp -a conf.home/* $DIR_APP/conf/
	
	# Themes & Templates
	cp -aR themes $DIR_APP/
	cp -aR templates/* $DIR_TPL/
	
	# Copy application
	cp -a tui_compl.bash $DIR_COMPL/
	cp -a uninstall.sh $DIR_APP/
	
	# Final display
	if tui-status $? "Installed $app"
	then	# Neither tui-conf-set nor sed seems to be working properly
		tui-yesno "Remove these tempfiles here \"$PWD/*\" ?" && \
			rm -fr ./* && rm -fr ./.[a-zA-Z]*
		exit 0
	else	echo "There was an error installing \"$app\""
		echo "Please report your system (uname -a), PREFIX=$PREFIX, and a screencopy/screenshot of the install script."
		exit 1
	fi