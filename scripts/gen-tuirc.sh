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

for tc in /usr/var/tmp /var/tmp /tmp $HOME/.cache;do [ -w "$tc" ] && break;done
for tl in /usr/var/log /var/log $HOME/.config/tui/logs;do [ -w "$tl" ] && break;done
source ./tui_dirs.conf

cat << EOS
#!/usr/bin/env bash
# ------------------------------------------------------------------------
# Copyright (C) 1996-2015 Simon Arjuna Erat (sea) <erat.simon@gmail.com>
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
	TUI_VERSION=$(gawk -F= '/APP_VER/ {print $2}' ./configure.yassi|head -n1)	# 0.9.4
	# This script
	TRC_VERSION=3.0
	#TUI_AUTHOR="Simon Arjuna Erat (sea), Switzerland"
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
#	Low level workarounds, fallbacks and 'make sures' before the system config is read
#
	HOMEBASE="$HOMEBASE"	# This should provide OS independant base for regular users.
	HOME="\${HOME:-\$(eval echo ~\${SUDO_USER:-\$USER})}"
	TERM="\${TERM:-GNU\057Linux}"
	WIDTH="\${COLUMNS:-\$(tput cols)}"
	HEIGHT="\${LINES:-\$(tput lines)}"
	TUI_THEME="default"
	AWK=\gawk
	GREP=\grep
	SED=\sed
	LS=\ls
#
#	Color and other formatting
#	Since this is also for 'endusers', this is all small letters
#
	reset="\033[0m" 	;	invert="\033[7m"
	bold="\033[1m"  	; 	stroke="\033[9m" 	;	underline="\033[4m"
	
	# --- Colors : foreground ----- Colors : background ------------
	
	black="\033[30m"	;	bg_black="\033[40m"
	red="\033[31m"  	;	bg_red="\033[41m"
	green="\033[32m"	;	bg_green="\033[42m"
	yellow="\033[33m"	;	bg_yellow="\033[43m"
	blue="\033[34m" 	;	bg_blue="\033[44m"
	purple="\033[35m"	;	bg_purple="\033[45m"
	cyan="\033[36m" 	;	bg_cyan="\033[46m"
	white="\033[37m"	;	bg_white="\033[47m"
#
#	Protection and Error handling
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
	msg_error() { # CALLER SCRIPT FUNCNAME LINENO [CONTENT]
	# Prints an error message and exits
	#
		caller="\$1" script="\$2" #fname="\$3" lineno="\$4" 
		shift 2 #4
		
		content=($(echo "\${@}"))
		printf "\n"
		printf '\t%s:\t%s\n' \\
			"$(gettext 'Callerscript')" "\$caller" \\
			"$(gettext 'Scriptname')" "\$script" \\
			"$(gettext 'Functionname')" "\$fname" \\
			"$(gettext 'Linenumber')" "\$lineno"
		for cont in "\${content[@]}";do
			printf '\t* %s\n' "\$cont"
		done
		trap - HUP INT QUIT ABRT ALRM TERM EXIT
		exit 1
	}
#
#	Traps & Error messages
#
	traps_save(){ saved_traps=\$(trap) ; export saved_traps ; }
	traps_restore() { eval \$saved_traps;}
	export -f msg_error traps_save traps_restore
	# Set and save basic error message traping, 
	#trap "msg_error \${CALLER:-\$0} \$0 \${FUNCNAME:-NON-FUNCTION} \$LINENO '\$(echo -E \${@})'" ABRT ALRM HUP QUIT TERM # INT  #2>/dev/null
	trap "msg_error \${CALLER:-\$0} \$0 '\$(echo -E \${@})'" ABRT ALRM HUP QUIT TERM
	## HUP INT QUIT ABRT KILL ALRM TERM ## 1 2 3 6 9 14 15
	[ $(trap | wc -l) -ge 4 ] &&  traps_save	# Save initial traps
EOS
#cat scripts/tuirc.tpl

