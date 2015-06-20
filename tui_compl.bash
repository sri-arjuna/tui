# bash completition for Text User Interface (TUI)
# file: /etc/bash_completion.d/tui_compl.bash
# Created: 2014.12.11 by sea
# Changed: 2015.06.20 by sea
# ---------------------------------
if ! source ~/.tuirc
then	source /etc/tuirc #|| return 1
fi
_tui()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		DIR="$TUI_DIR_THEMES"
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h --help"
		ARGS="provides reset reset-yes theme"
		#echo "prev:$prev :: cur:$cur"
	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		[prt]*)	COMPREPLY=( $(compgen -W "${ARGS[*]}" -- $cur) )
			return 0
			;;
		#*)	COMPREPLY=( $(compgen -W "${OPTS[*]} ${ARGS[*]}" -- $cur) )
		#	return 0
		#	;;
		esac

		# This completes the custom entries from $DIR
		# But only use this, if 'prev' was one using entries from $DIR
		# This list is dynamicly (automaticly) updated
		case $prev in
		theme)
			case "$cur" in
			[a-zA-Z]*)	COMPREPLY=( $( compgen -W "$(cd $DIR 2>/dev/null && echo $cur*)" -- "$cur" ) ) 
					return 0
					;;
			*)		COMPREPLY=( $( compgen -W "$(cd $DIR 2>/dev/null && echo *)" -- "$cur" ) ) 
					return 0
					;;
			esac
			;;
		tuirc)	COMPREPLY=( $(compgen -W "${ARGS[*]}" -- $cur) )
			return 0
			;;
		reset*)	return 0;;
		esac
	}
_tui_browser()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h -T -U -L -P -p -n -s -D -F -b -c -d -q -S -X"

	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
		case $prev in
		# Basic options
		-T)	COMPREPLY=( $(compgen -W "myTitle" -- $cur) )
			return 0
			;;
		-U)	COMPREPLY=( $(compgen -W "Changes_Upper-right_corner" -- $cur) )
			return 0
			;;
		-L)	COMPREPLY=( $(compgen -W "myLocatonLabel" -- $cur) )
			return 0
			;;
		-P)	COMPREPLY=( $(compgen -W "myPositionLabel" -- $cur) )
			return 0
			;;
		-p)	COMPREPLY=( $(compgen -W "/path/to/menu" -- $cur) )
			return 0
			;;
		-s)	COMPREPLY=( $(compgen -W "/path_only/to/files/to/source/" -- $cur) )
			return 0
			;;
		-[qSnm])
			reutrn 0
			;;
		# Text mode
		-D)	COMPREPLY=( $(compgen -W "myDirLabel" -- $cur) )
			return 0
			;;
		-F)	COMPREPLY=( $(compgen -W "myFilesLabel" -- $cur) )
			return 0
			;;
		# Advanced mode
		-b)	COMPREPLY=( $(compgen -W "Word_to_block,more_words" -- $cur) )
			return 0
			;;
		-c)	COMPREPLY=( $(compgen -W "CONFIGFILE" -- $cur) )
			return 0
			;;
		-d)	COMPREPLY=( $(compgen -W "default" -- $cur) )
			return 0
			;;
		-X)	COMPREPLY=( $(compgen -W "ash bash csh perl python tcsh zsh" -- $cur) )
			return 0
			;;
		esac
	}
_tui_conf_editor()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h -l -L -t"

	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
		case $prev in
		-l)	COMPREPLY=( $(compgen -W "change_LOGFILE_used" -- $cur) )
			return 0
			;;
		-t)	COMPREPLY=( $(compgen -W "myTitle" -- $cur) )
			return 0
			;;
		tui-conf-editor)	COMPREPLY=( $(compgen -W "$(echo *conf)" -- $cur) )
			return 0
			;;
		esac
	}
_tui_conf_get()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h -i -l"

	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
		case $prev in
		-i|-l|tui-conf-get)
			COMPREPLY=( $(compgen -W "$(echo *conf)" -- $cur) )
			return 0
			;;
		esac
	}
_tui_conf_set()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h -i -c -s -l"

	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
		case $prev in
		-c|-s|-i|-l|tui-conf-set)
			COMPREPLY=( $(compgen -W "$(echo *conf)" -- $cur) )
			return 0
			;;
		esac
	}
_tui_install()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h -b -d -l -v"

	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
		case $prev in
		-l)	COMPREPLY=( $(compgen -W "Logfile_to_write_to" -- $cur) )
			return 0
			;;
		tui-install)
			COMPREPLY=( $(compgen -W "packages" -- $cur) )
			return 0
			;;
		esac
	}
_tui_new_script()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h -a -r -m"

	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
		case $prev in
		tui-new-script)
			COMPREPLY=( $(compgen -W "myScript.sh" -- $cur) )
			return 0
			;;
		esac
	}
_tui_printf()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h -E -H -S -T"
		ARGS=""
	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
#
# =====================================================================================
#

_tui_progress()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h -m -i -r"
		ARGS=""
	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		-m)	COMPREPLY=( $(compgen -W "my_MAX_VALUE" -- $cur) )
			return 0
			;;
		-i)	COMPREPLY=( $(compgen -W "my_ID" -- $cur) )
			return 0
			;;
		esac
	}
_tui_psm()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h -L -c -l -d -q -w"
		ARGS=""
	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		-l)	COMPREPLY=( $(compgen -W "my_LIMIT_VALUE" -- $cur) )
			return 0
			;;
		-w)	COMPREPLY=( $(compgen -W "SECS" -- $cur) )
			return 0
			;;
		esac
		[ "$2" = tui-psm ]  && \
			COMPREPLY=( $(compgen -W "myScript_s.sh" -- $cur) ) && \
			return 0
	}
_tui_status()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h --help"
		ARGS="0 1 2 3 4 5 6 7  10 11 99 111"
	#
	#	Action
	#
		# This completes the word you are currently writing
		# These need manual maintainance
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		-l)	COMPREPLY=( $(compgen -W "my_LIMIT_VALUE" -- $cur) )
			return 0
			;;
		tui-status)
		COMPREPLY=( $(compgen -W "$(echo ${ARGS[@]})" -- $cur) )
			return 0
			;;
		esac
		[ $2 = tui-status ]  && \
			COMPREPLY=( $(compgen -W "\"MSG1\" \"MSG2\"" -- $cur) ) && \
			return 0
	}
_tui_tar()
	{
	COMPREPLY=()
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	[ $prev = tui-tar ]  && \
		COMPREPLY=( $(compgen -W "myFolder" -- $cur) ) && \
		return 0
	}
####									####
####	###########################################################
####									####
_tui_justhelp()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "-h --help" -- $cur) )
			return 0
			
		esac
		case "$prev" in
		*)	return 0	;;
		esac
	}
_tui_asroot()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h --help -m"
		ARGS=""
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[@]}" -- $cur) )
			return 0
			
		esac
		case "$prev" in
		*)	return 0	;;
		-m)	COMPREPLY=( $(compgen -W "MSG" -- $cur) )
			return 0
			;;
		esac
	}
_tui_bgjob()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -f -s -e"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		*)	COMPREPLY=( $(compgen -W "$cur*" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		*)	COMPREPLY=( $(compgen -W "${OPTS[*]} ${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_bol_dir()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -v"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		*)	COMPREPLY=( $(compgen -W "${OPTS[*]} *" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		tui-bol-dir)	COMPREPLY=( $(compgen -W "$prev*" -- $cur) )
			return 0
			;;
		*)	return 0;;
		esac
	}
_tui_cat()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -d -t -T"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		-d)	COMPREPLY=( $(compgen -W "0.05" -- $cur) )
			return 0
			
			;;
		*)	COMPREPLY=( $(compgen -W "$cur*" -- $cur) )
			return 0
			;;
		esac
	}
_tui_cp()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -d -f -l -q"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		*)	COMPREPLY=( $(compgen -W "${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_ftp()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -L -q -v -H -U -P -B -c -a -p -f -r -d -l"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		-H)	COMPREPLY=( $(compgen -W "myDomain:port" -- $cur) )
			return 0
			;;
		-U)	COMPREPLY=( $(compgen -W "remote_UserName" -- $cur) )
			return 0
			;;
		-P)	COMPREPLY=( $(compgen -W "remote_PassWord" -- $cur) )
			return 0
			;;
		-B)	COMPREPLY=( $(compgen -W "BATCHFILE" -- $cur) )
			return 0
			;;
		-c)	COMPREPLY=( $(compgen -W "'cmd1','cmd2'..." -- $cur) )
			return 0
			;;
		-f)	COMPREPLY=( $(compgen -W "[/path/to/]local_file" -- $cur) )
			return 0
			;;
		-r)	COMPREPLY=( $(compgen -W "remote_target_path" -- $cur) )
			return 0
			;;
		-d)	COMPREPLY=( $(compgen -W "remote-source-file" -- $cur) )
			return 0
			;;
		-l)	COMPREPLY=( $(compgen -W "local_target_path" -- $cur) )
			return 0
			;;
		*)	#COMPREPLY=( $(compgen -W "myDomain:port" -- $cur) )
			return 0
			;;
		esac
	}
_tui_list()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -a -r -n -v"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_log()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -e -d -t -p -u -s -v"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		-s)	COMPREPLY=( $(compgen -W "\\\t" -- $cur) )
			return 0
			;;
		*)	COMPREPLY=( $(compgen -W "${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac
	}	
_tui_math()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -v"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		*)	return 0
			;;
		esac
	}	
_tui_new_manpage()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -a -m"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_new_script()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -e -s -r -t -m -M"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_read()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		*)	COMPREPLY=( $(compgen -W "${OPTS[*]} ${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		*)	COMPREPLY=( $(compgen -W "${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_select()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -1 -2 -a -v"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_str_usb()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -a"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_str_bol_conv()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -C -d -t -y"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_str_encrypt()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help -t"
		ARGS="md5 224 256 384 512 sha224 sha256 sha384 sha512 sha1sum shasum "
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		-t)	COMPREPLY=( $(compgen -W "${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_terminal()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		*)	COMPREPLY=( $(compgen -W "${OPTS[*]} ${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		*)	COMPREPLY=( $(compgen -W "${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_wait()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		*)	COMPREPLY=( $(compgen -W "${OPTS[*]} ${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		*)	COMPREPLY=( $(compgen -W "${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac
	}
_tui_web()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		DIR=""
		OPTS="-h --help"
		ARGS=""
	#
	#	Action
	#
		# Is user currently typing?
		case "$cur" in
		*)	COMPREPLY=( $(compgen -W "${OPTS[*]} ${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac

		# Check previous word
		case $prev in
		*)	COMPREPLY=( $(compgen -W "${ARGS[*]}" -- $cur) )
			return 0
			;;
		esac
	}

# Actualy make it available to the shell
# RC
complete -F _tui tuirc

# Core Display
complete -F _tui_printf tui-printf
complete -F _tui_justhelp tui-echo
complete -F _tui_justhelp tui-title
complete -F _tui_justhelp tui-header
complete -F _tui_status tui-status
complete -F _tui_progress tui-progress

complete -F _tui_browser tui

# Core Interaction
complete -F _tui_select tui-select
complete -F _tui_justhelp tui-yesno

# Code Helpers
complete -F _tui_asroot tui-asroot
complete -F _tui_justhelp tui-bol-root
complete -F _tui_bol_dir tui-bol-dir
complete -F _tui_bol_dir tui-bol-gui
complete -F _tui_math tui-math-add
complete -F _tui_math tui-math-div
complete -F _tui_math tui-math-mlt
complete -F _tui_math tui-math-pwer
complete -F _tui_math tui-math-sub
complete -F _tui_justhelp tui-math-sqr
complete -F _tui_conf_editor tui-conf-editor
complete -F _tui_conf_get tui-conf-get
complete -F _tui_conf_set tui-conf-set
complete -F _tui_new_script tui-new-script
complete -F _tui_new_manpage tui-new-manpage
complete -F _tui_justhelp tui-new-browser
complete -F _tui_justhelp tui-press
complete -F _tui_justhelp tui-rnd
complete -F _tui_str_bol_conv tui-str-bol-conv
complete -F _tui_str_encrypt tui-str-encrypt
complete -F _tui_justhelp tui-str-extension
complete -F _tui_justhelp tui-str-genfilename
complete -F _tui_str_usb tui-str-usb

# Code Wrappers
complete -F _tui_tar tui-tar
complete -F _tui_cat tui-cat
complete -F _tui_cp tui-cp
complete -F _tui_cp tui-dd
complete -F _tui_cp tui-mv
complete -F _tui_list tui-list
complete -F _tui_log tui-log
complete -F _tui_justhelp tui-download
complete -F _tui_justhelp tui-edit
complete -F _tui_justhelp tui-terminal
complete -F _tui_justhelp tui-filemgr
complete -F _tui_math tui-wait

# Advanced
complete -F _tui_install tui-install
complete -F _tui_psm tui-bgjob-mgr
complete -F _tui_bgjob tui-bgjob
complete -F _tui_ftp tui-ftp