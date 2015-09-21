#!/usr/bin/env bash
#
#	Prepare the RC file
#
	source ./configure.cfg
	source ./tui_dirs.conf
#
#	Write it
#
	cat > "./tuirc" <<EOF
#	This file provides the default directories,
#	required to created the user his own tuirc file.
#
	prefix=$prefix
	[ -z "\$TUI_DIR_CONF" ] && readonly \\
		TUI_DIR_CONF=$SYSCONFDIR/tui
	[ -z "\$TUI_DIR_SYSTEM" ] && readonly \\
		TUI_DIR_SYSTEM="$DATADIR"
#
#	Paths	:	Used to run TUI
#
	TUI_DIR_LOG=\${prefix}/var/log
	[ -z "\$TUI_DIR_TEMPLATES" ] && readonly \\
		TUI_DIR_TEMPLATES="\$TUI_DIR_SYSTEM/templates"
	[ -z "\$TUI_DIR_THEMES" ] && readonly \\
		TUI_DIR_THEMES="\$TUI_DIR_SYSTEM/themes"
	[ -z "\$TUI_DIR_LIST" ] && readonly \\
		TUI_DIR_LIST="\${TUI_DIR_SYSTEM}/lists"
	[ -z "\$TUI_DIR_LOCALE" ] && readonly \\
		TUI_DIR_LOCALE="\${TUI_DIR_SYSTEM}/locale"
	TUI_DIR_TEMP="\${TUI_DIR_TEMP:-$HOME/.cache}"
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
EOF
cat "scripts/injection_protection.sh" >> ./tuirc
sed s,"$SYSCONFDIR/conf.tui","$SYSCONFDIR/tui",g -i "make-uninstall"
