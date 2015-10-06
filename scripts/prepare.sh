#!/usr/bin/env bash
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
# ------------------------------------------------------------------------
#
#	Prepare the RC file
#
	source ./configure.cfg
	source ./tui_dirs.conf
#
#	Write it
#
	cat > "./tuirc" <<EOF
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
# ------------------------------------------------------------------------
#
#	This file provides the default directories,
#	required to created the user his own tuirc file.
#
#	This file is NOT meant to be changed.
#
	# The 'prefix', SYSCONFDIR and DATADIR variables are read from /etc/tui.conf
	[ -z "\$TUI_DIR_CONF" ] && readonly \\
		TUI_DIR_CONF=\$SYSCONFDIR/tui
	[ -z "\$TUI_DIR_SYSTEM" ] && readonly \\
		TUI_DIR_SYSTEM="\$DATADIR"
#
#	Paths	:	Used to run TUI
#
	TUI_DIR_LOG=\${prefix}/var/log
	[ -z "\$TUI_DIR_TEMPLATES" ] && readonly \\
		TUI_DIR_TEMPLATES="\$TUI_DIR_SYSTEM/templates"
	[ -z "\$TUI_DIR_THEMES" ] && \\
		TUI_DIR_THEMES="\$TUI_DIR_SYSTEM/themes"
	[ -z "\$TUI_DIR_LIST" ] && readonly \\
		TUI_DIR_LIST="\${TUI_DIR_SYSTEM}/lists"
	[ -z "\$TUI_DIR_LOCALE" ] && readonly \\
		TUI_DIR_LOCALE="\${TUI_DIR_SYSTEM}/locale"
	TUI_DIR_TEMP="\${TUI_DIR_TEMP:-\$HOME/.cache}"
#
#	Files
#	Direct access to the most important configuration files for the System
#
	[ -z "\$TUI_FILE_CONF_APPS" ] && readonly \\
		TUI_FILE_CONF_APPS="\$TUI_DIR_CONF/apps.conf"
	[ -z "\$TUI_FILE_CONF_COLORS" ] && readonly \\
		TUI_FILE_CONF_COLORS="\$TUI_DIR_CONF/colors.conf"
	[ -z "\$TUI_FILE_CONF_COMMANDS" ] && readonly \\
		TUI_FILE_CONF_COMMANDS="\$TUI_DIR_CONF/commands.conf"
	[ -z "\$TUI_FILE_CONF_SETTINGS" ] && readonly \\
		TUI_FILE_CONF_SETTINGS="\$TUI_DIR_CONF/settings.conf"
	[ -z "\$TUI_FILE_CONF_SYSTEM" ] && readonly \\
		TUI_FILE_CONF_SYSTEM="\$TUI_DIR_CONF/tui.conf"
	[ -z "\$TUI_FILE_CONF_STATUS" ] && readonly \\
		TUI_FILE_CONF_STATUS="\$TUI_DIR_CONF/status.conf"
	[ -z "\$TUI_FILE_CONF_SHORTS" ] && readonly \\
		TUI_FILE_CONF_SHORTS="\$TUI_DIR_CONF/shorts.conf"
	[ -z "\$TUI_FILE_CONF_ALIAS" ] && readonly \\
		TUI_FILE_CONF_ALIAS="\$TUI_DIR_CONF/shorts-alias.conf"
#
#	Low level workaround
#	As in: When called by a script during boot process
#
	TERM="\${TERM:-GNU Linux}"
#
#	Injection protection
#
	break_on_injections() { # ARGS
	# Searches for injection subjects
	# Returns true if it finds some
		typeset arg ac=0
		for arg do
		ac="$((ac+=1))"
		case "$arg" in
		(*[';´|<&>']*|*':('*|*':-'*)
			printf "%s\n" "Aborting, injection detected! arg\${ac}='\$arg'"
			return 0
		;;
		esac
		done
		return 1
	}

EOF
#cat "scripts/injection_protection.sh" >> ./tuirc
sed s,"\$SYSCONFDIR/conf.tui","\$SYSCONFDIR/tui",g -i "make-uninstall"
