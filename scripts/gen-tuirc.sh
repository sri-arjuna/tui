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

for tc in /usr/var/tmp /var/tmp /tmp $HOME/.cache;do [ -w $tc ] && break;done
for tl in /usr/var/log /var/log $HOME/.config/tui/logs;do [ -w $tc ] && break;done

cat << EOS
#!/usr/bin/env bash
# ------------------------------------------------------------------------
# Copyright (c) 1996-2015 Simon Arjuna Erat (sea)  <erat.simon@gmail.com>
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
#	This file provides the core of the heart
#
	# This project
	TUI_VERSION=$(gawk -F= '/APP_VER/ {print $2}' ./configure.yassi|head -n1)
	# This script
	TRC_VERSION=3.0			
#
#	This file is NOT meant to be changed.
#
	[ -z "\$TUI_DIR_CONF" ]		&& readonly TUI_DIR_CONF="$SYSCONFDIR/tui"
	[ -z "\$TUI_DIR_SYSTEM" ] 	&& readonly TUI_DIR_SYSTEM="$DATADIR"
#
#	Paths	:	Used to run TUI
#
	TUI_DIR_TEMP="$tc"
	TUI_DIR_LOG="$tl"
	TUI_DIR_THEMES="\$TUI_DIR_SYSTEM/themes"
	[ -z "\$TUI_DIR_TEMPLATES" ] 	&& readonly TUI_DIR_TEMPLATES="\$TUI_DIR_SYSTEM/templates"
	[ -z "\$TUI_DIR_FUNCTIONS" ] 	&& readonly TUI_DIR_FUNCTIONS="\$TUI_DIR_SYSTEM/functions"
	[ -z "\$TUI_DIR_LOCALE" ]	&& readonly TUI_DIR_LOCALE="\$TUI_DIR_SYSTEM/locale"
	[ -z "\$TUI_DIR_LIST" ]		&& readonly TUI_DIR_LIST="\$TUI_DIR_SYSTEM/lists"
#
#	Files
#	Direct access to the most important configuration files for the System
#
	[ -z "\$TUI_FILE_CONF_APPS" ] 	&& readonly TUI_FILE_CONF_APPS="\$TUI_DIR_CONF/apps.conf"
	[ -z "\$TUI_FILE_CONF_COLORS" ]	&& readonly TUI_FILE_CONF_COLORS="\$TUI_DIR_CONF/colors.conf"
	[ -z "\$TUI_FILE_CONF_COMMANDS" ] && readonly TUI_FILE_CONF_COMMANDS="\$TUI_DIR_CONF/commands.conf"
	[ -z "\$TUI_FILE_CONF_SETTINGS" ] && readonly TUI_FILE_CONF_SETTINGS="\$TUI_DIR_CONF/settings.conf"
	[ -z "\$TUI_FILE_CONF_SYSTEM" ]	&& readonly TUI_FILE_CONF_SYSTEM="\$TUI_DIR_CONF/tui.conf"
	[ -z "\$TUI_FILE_CONF_STATUS" ]	&& readonly TUI_FILE_CONF_STATUS="\$TUI_DIR_CONF/status.conf"
	[ -z "\$TUI_FILE_CONF_SHORTS" ]	&& readonly TUI_FILE_CONF_SHORTS="\$TUI_DIR_CONF/shorts.conf"
	[ -z "\$TUI_FILE_CONF_ALIAS" ]	&& readonly TUI_FILE_CONF_ALIAS="\$TUI_DIR_CONF/shorts-alias.conf"
#
#	Low level workarounds and 'make sures'
#
	HOMEBASE="$HOMEBASE"
	HOME="\${HOME:-\$(eval echo ~\$USER)"
	TERM="\${TERM:-GNU\057Linux}"
	WIDTH="\${COLUMNS:-\$(tput cols)}"
	HEIGHT="\${LINES:-\$(tput lines)}"
	TUI_THEME="default"
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
EOS
