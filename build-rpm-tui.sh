#!/bin/bash
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
#	Builds an rpm package for TUI
#
#
#
#	Variables
#
	app=tui
	ext=tar.gz
	# If this is not found, retrieve code from git
	CHECK_FOR=bin/$app
	HUB_USER=sri-arjuna
	GIT=https://github.com/$HUB_USER/$app.git
	#build_link=/usr/bin/rpm-build-$app
	dir_out="$HOME"
	# Get script & spec homedir
	[[ "." = "$(basename $0)" ]] && \
		home="$(pwd)" || \
		home="$(dirname $0)"
	
#
#	Action
#
	#set -x
	
	# Prepare
	cd "$home"
	[[ -d $HOME/rpmbuild ]] && rpmdev-wipetree
	rpmdev-setuptree
	[[ -f "$CHECK_FOR" ]] || git clone https://github.com/sri-arjuna/tui.git .
	VER=$(grep -i "Version:" "$app.spec"|awk '{print $2}')
	TARBALL=$app-$VER.$ext #$(basename $(grep -i "Source0:" "$app.spec"|grep -v ^"#"|awk '{print $2}'))
	
	cp $app.spec				$HOME/rpmbuild/SPECS
	tar -acf $HOME/rpmbuild/SOURCES/$TARBALL 	../$app
	
	# Build
	rpmbuild -ba $app.spec || exit
	
	# Get packages
	cd "$HOME"/rpmbuild
	raw=$(find | grep $app | grep ".rpm")
	
	for l in $raw;do echo "$l"; [ "\.rpm" = "${l:0:-4}" ] && LIST+=" $l " ; done
	
#	echo $LIST ; exit
	
	
	mv $LIST "$dir_out"
#
#	Clean up
#
	rpmdev-wipetree
	cd "$OLDPWD"
