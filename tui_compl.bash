# bash completition for Text User Interface (TUI)
# file: /etc/bash_completion.d/tui_compl.bash
# 2014.12.11 by sea
# ---------------------------------

_tui_module()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		DIR="/usr/share/tui/themes/"
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h"
		ARGS="provides reset reset-yes theme"
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
		tui)	COMPREPLY=( $(compgen -W "${ARGS[*]}" -- $cur) )
			return 0
			;;
		reset*)	return 0;;
		esac
	}
_tui_browser_module()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h -b -C -d -D -f -l -m -p -n -s -t -u"

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
		-b)	COMPREPLY=( $(compgen -W "Word_to_block" -- $cur) )
			return 0
			;;
		-C)	COMPREPLY=( $(compgen -W "CONFIGFILE" -- $cur) )
			return 0
			;;
		-D)	COMPREPLY=( $(compgen -W "default" -- $cur) )
			return 0
			;;
		-f)	COMPREPLY=( $(compgen -W "myFilesLabel" -- $cur) )
			return 0
			;;
		-l)	COMPREPLY=( $(compgen -W "myLocatonLabel" -- $cur) )
			return 0
			;;
		-m)	COMPREPLY=( $(compgen -W "num text" -- $cur) )
			return 0
			;;
		-s)	COMPREPLY=( $(compgen -W "/path_only/to/configurations" -- $cur) )
			return 0
			;;
		-tl)	COMPREPLY=( $(compgen -W "myTitle" -- $cur) )
			return 0
			;;
		-s)	COMPREPLY=( $(compgen -W "Changes_Upper-right_corner" -- $cur) )
			return 0
			;;
		esac
	}
_tui_conf_editor_module()
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
_tui_conf_get_module()
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
_tui_conf_set_module()
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
_tui_install_module()
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
_tui_new_script_module()
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
_tui_printf_module()
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

_tui_progress_module()
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
_tui_psm_module()
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
_tui_status_module()
	{
	#
	#	Variables
	#
		local cur prev OPTS DIR
		COMPREPLY=()
		cur="${COMP_WORDS[COMP_CWORD]}"
		prev="${COMP_WORDS[COMP_CWORD-1]}"
		OPTS="-h"
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
_tui_tar_module()
	{
	COMPREPLY=()
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	[ $prev = tui-tar ]  && \
		COMPREPLY=( $(compgen -W "myFolder" -- $cur) ) && \
		return 0
	}

# Actualy make it available to the shell
complete -F _tui_module tui
complete -F _tui_printf_module tui-printf
complete -F _tui_browser_module tui-browser
complete -F _tui_conf_editor_module tui-conf-editor
complete -F _tui_conf_get_module tui-conf-get
complete -F _tui_conf_set_module tui-conf-set
complete -F _tui_install_module tui-install
complete -F _tui_new_script_module tui-new-script
complete -F _tui_progress_module tui-progress
complete -F _tui_psm_module tui-psm
complete -F _tui_status_module tui-status
complete -F _tui_tar_module tui-tar
