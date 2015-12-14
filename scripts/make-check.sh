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
#	Variables
#
	for c in conf.tui/*;do source "$c";done
	something="\163\157\155\145\164\150\151\156\147"
	list_single=one
	list_multi="one two three four five six seven eight nine ten"
	teststring="Test string Test string Test string"
#
#	Functions
#
	
#
#	Action
#
	
#
#	Display
#
	bin/tui-print -H "1: Initial testing / checks" \
			"$something" \
			"$USER @ $HOSTNAME"
	bin/tui-header 	"2: Initial testing / checks" \
			"$something" \
			"$USER @ $HOSTNAME"
	
	bin/tui-print -T "1: $(uname -a)"
	bin/tui-title 	 "2: $(uname -a)"
	
	bin/tui-print -E "1: $something"
	bin/tui-echo	"2: $something"
	(set -x ; bin/tui-echo -e	"\n3: $something\n\n")	## Whats up with tui-echo? no output at all....
	
	bin/tui-print -S 111 "1: Info text"
	bin/tui-status 4 "2: Skip 'icon' text"
	
	for M in header title echo;do
		bin/tui-$M "-example1"
		#bin/tui-$M - "--example2"
		#bin/tui-$M "--example3"
		#bin/tui-$M - "--example4"
	done
	
	bin/tui-list $list_multi
	bin/tui-list -2r $list_multi
	bin/tui-list -a1 $list_multi
	
	
	bin/tui-printfile -t /etc/motd
	bin/tui-typewriter "$teststring"	# "$teststring"
	(set -x ; bin/tui-typewriter -d 0.001 "$(echo -e $something)") ## Whats up with GNU echo? --> something="\163\157\155\145\164\150\151\156\147"
	
