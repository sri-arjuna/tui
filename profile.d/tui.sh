#!/bin/sh
#
#	As of now, this script loads only interface variables
#	That is for your privacy!
#
#	Load default interface
#
	source /etc/tui/{colors,tui}.conf
#
#	Load user interface config
#
	[ ! 0 -eq $UID ] && \
		[ -f $HOME/.config/tui/user.conf ] && \
		source $HOME/.config/tui/user.conf
#
#	Export so it remains available for TUI
#
	export HEAD_BG HEAD_FG
	export TITLE_BG TITLE_FG 
	export BORDER_LEFT BORDER_RIGHT
