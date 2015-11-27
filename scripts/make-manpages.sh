#!/bin/bash
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
# MERCHANT ABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>
#
#	Usage:
#	./scripts/make-po-files.sh
#
#	Variables
#
	source ./configure.cfg
	MAN_DEST=manpages
#
#	Action & Display
#
	[ -d "$MAN_DEST" ] || mkdir "$MAN_DEST"
	for f in bin/*;do
		$f -h 2>/dev/zero| \
			txt2man -v "TUI Manual" \
			-t "${f##*/}" -s 1 \
			-r "TUI $APP_VER" > "$MAN_DEST/${f##*/}.1" 2>/dev/zero
	done
