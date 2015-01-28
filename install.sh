#!/usr/bin/env bash
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
#	Variables
#
	app=tui
	[ -f install.sh ] || cd "$(dirname "$0")"
	[ -d /usr/bin ] && \
		DIR_BIN=/usr/bin || \
		DIR_BIN=/bin
	# Default paths:
	DIR_COMPL="/etc/bash_completion.d"
	DIR_APP=/usr/share/$app
	DIR_CFG=/etc/$app
	DIR_DOC=/usr/share/doc/$app
	DIR_MAN1=/usr/share/man/man1
	DIR_TPL=$DIR_APP/templates
	
	if [ -f /etc/freebsd-update.conf ]
	then	# Its freebsd
		DIR_COMPL="/usr/local/etc/bash_completion.d"
	fi
#
#	Initall to Environment
#
	printf "\n\n\tPress enter to install $app OR press 'CTRL+c' to abort"
	read buffer
	echo "To UN-install TUI, please execute: $DIR_APP/uninstall.sh"
	sleep 2
	
	# Create the missing paths:
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
		fi
	done
	
	printf "\nCopy files..."
	# Copy docs:
	cp -a README.md $DIR_APP/
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
	
	tui-status $? "Installed $app" && \
		tui-yesno "Remove these tempfiles here \"$PWD/*\" ?" && \
		rm -fr ./* && rm -fr ./.[a-zA-Z]*
	