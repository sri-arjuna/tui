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
	. $HOME/.config/fas/fas.conf
	app=tui
	[[ -z $1 ]] && \
		dir_out="$FAS_REVIEW/$app" || \
		dir_out="$1"
	ext=tar.gz
	# If this is not found, retrieve code from git
	CHECK_FOR=bin/$app
	HUB_USER=sri-arjuna
	GIT=https://github.com/$HUB_USER/$app.git
	#build_link=/usr/bin/rpm-build-$app
	# Get script & spec homedir
	[[ "." = "$(basename $0)" ]] && \
		home="$(pwd)" || \
		home="$(dirname $0)"
	oPWD=$(pwd)
#
#	Prepare
#
	cd "$home"
	[[ -d $HOME/rpmbuild ]] && rpmdev-wipetree
	rpmdev-setuptree
	[[ -f "$CHECK_FOR" ]] || git clone $GIT ../$app
#
#	Version & tarball name
#
	VER=$(grep -i "Version:" "$app.spec"|awk '{print $2}')
	TARBALL=$app-$VER.$ext #$(basename $(grep -i "Source0:" "$app.spec"|grep -v ^"#"|awk '{print $2}'))
#
#	Place file in rpmbuild and $dir_out
#	
	cp $app.spec			$HOME/rpmbuild/SPECS
	cp $app.spec			"$dir_out"
	[[ -d ../$app ]] || (mkdir ../$app;cp -r * ../$app )
	tar -acf $dir_out/$TARBALL 	../$app
	ln -sf $dir_out/$TARBALL 	$HOME/rpmbuild/SOURCES/$TARBALL
#	
# 	Build
#
	rpmbuild -ba $app.spec || exit
#	
# 	Get packages
#
	cd "$HOME"/rpmbuild
	raw=$(find | grep $app | grep rpm)
	mv $raw "$dir_out"
	
	cd "$dir_out"
	pwd
	ls $dir_out/ | grep $app
#
#	Clean up
#
	rpmdev-wipetree
	rm -fr $HOME/rpmbuild
	cd "$oPWD"
