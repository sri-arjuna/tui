#!/usr/bin/env bash
# 2014.12.08 by sea
#
#	Variables
#
	app=tui
	[ ! -f install.sh ] && cd "$(dirname '$0')"
	[ -d /usr/bin ] && \
		DIR_BIN=/usr/bin || \
		DIR_BIN=/bin
	# Default paths:
	DIR_COMPL="/etc/bash_completion.d"
	DIR_APP=/usr/share/$app
	DIR_CFG=/etc/$app
	DIR_DOC=/usr/share/doc/$app
	DIR_MAN1=/usr/share/man/man1
	DIR_TPL=$DIR_APP/templates
	
	if [ -f /etc/freebsd-update.conf ]
	then	# Its freebsd
		DIR_COMPL="/usr/local/etc/bash_completion.d"
	fi
	
	
	# Create the missing paths:
	for tDir in $DIR_APP \
			$DIR_CFG \
			$DIR_DOC \
			$DIR_MAN1 \
			$DIR_TPL \
			$DIR_APP/conf \
			$DIR_APP/conf.etc \
			$DIR_COMPL
	do	[ ! -d $tDir ] && \
			mkdir -p $tDir && printf "*\tCreated missing dir: $tDir\n"
	done
#
#	Initall to Environment
#
	printf "\n\n\tPress enter to install $app OR press 'CTRL+c' to abort"
	read buffer
	mkdir -p $DIR_APP $DIR_CFG $DIR_MAN1 $DIR_TPL #$DIR_MAN8
	cp -a README.md $DIR_APP
	cp -a tui_compl.bash $DIR_COMPL
	cp -a bin/* $DIR_BIN
	cp -a conf.etc/* $DIR_CFG
	cp -a conf.etc/* $DIR_APP/conf.etc
	cp -a conf.home/* $DIR_APP/conf
	cp -aR docs/* $DIR_DOC
	#cp -R docs/[a-z]* $DIR_APP
	cp -a man/*1 $DIR_MAN1
	cp -a themes $DIR_APP/
	cp -a uninstall.sh $DIR_APP
	cp -aR templates/* $DIR_TPL
	
#	[ -f /etc/freebsd-update.conf ] && \
#		ln -sf `which bash` /bin/bash
	
	#cp profile.d/* /etc/profile.d
	RET=$?
	tui-status $? "Installed $app" && \
		tui-yesno "Remove these tempfiles here \"$PWD/*\" ?" && \
		rm -fr ./*
