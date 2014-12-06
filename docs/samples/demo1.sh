#!/bin/bash
#--This file was created using: tui-new-script -m ./demo1.sh
# ------------------------------------------------------------------------
#
# Copyright (c) 2014 by Simon Arjuna Erat (sea)  <erat.simon@gmail.com>
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
#	Simple menu demonstration
#	. tui -> 
#	
#
#
#	Variables
#
	. tui				# provides $RET_INFO, so you dont have to keep its number in mind.
	TITLE="Menu example:"
	script_version=0.2
#
#	Action
#
	while 
		clear 
		tui-header "$TITLE ($script_version)" "$(date +'%F %T')"
		tui-title "Location:"		"$(pwd) -- prev: $OLDPWD"
		tui-echo "Select Action:"
		tui-echo "q,Q,b or B"		"Quit/Back"
		tui-echo "l or L"		"List"
		tui-echo "u or up"			"Changes to upper dir"
		tui-echo "r or return"		"Goes to previous dir - loop"
		tui-echo "h or home"			"Go home"
		tui-title
		input=$(tui-read "Make your choice:")
	do
		case $input in
		q|Q|b|B)	action=quit	;;
		l|L)		action=list	;;
		u|up)		action=up	;;
		r|return)	action=return	;;
		h|home)		action=home	;;
		*)		action=fail	;;
		esac
		
		
		[[ $action = quit ]] && \
			ret=$RET_CANC || \
			ret=$RET_NEXT
		tui-status $ret "Selected action: $action"
		
		
		case $action in
		fail)	tui-status $RET_INFO "Please make another choice than: $input"
					;;
		quit)	break		;;
		list)	ls		;;
		up)	cd ..		;;
		return)	cd "$OLDPWD"	;;
		home)	cd		;;
		esac
		tui-wait 3s
	done