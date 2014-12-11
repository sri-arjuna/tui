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
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	OPTS="-h -v"
	ARGS="reset reset-yes theme"
	DIR="/usr/share/tui/themes/"
	
#
#	Fill codec lists
#
	raw_audio=$(ffmpeg -v quiet -encoders|grep ^\ A|awk '{print $2}'|grep -v =)
	raw_video=$(ffmpeg -v quiet -encoders|grep ^\ V|awk '{print $2}'|grep -v =)
	raw_sub=$(ffmpeg -v quiet -encoders|grep ^\ S|awk '{print $2}'|grep -v =)
	for a in $raw_audio;do audio_codecs+=" a$a";done
	for v in $raw_video;do video_codecs+=" v$v";done
	for s in $raw_sub;do sub_codecs+=" s$s";done
#
#	Action
#
	# This completes the custom entries from $DIR
	# But only use this, if 'prev' was one using entries from $DIR
	# This list is dynamicly (automaticly) updated
	case $prev in
	theme)
		case $cur in
		[a-zA-Z]*)	COMPREPLY=( $( compgen -W "$(cd $DIR 2>/dev/null && echo $cur*)" -- "$cur" ) ) 
				return 0
				;;
		*)		COMPREPLY=( $( compgen -W "$(cd $DIR 2>/dev/null && echo $cur*)" -- "$cur" ) ) 
				return 0
				;;
		esac
		;;
	tui)	COMPREPLY=( $( compgen -W "reset reset-yes theme" -- "$cur" ) ) 
		return 0
		;;
	esac
	
	# This completes the word you are currently writing
	# These need manual maintainance
	case $cur in
		-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
			return 0
			;;
		r*)	
	esac
	
	# This shows a list of words applying to your last argument
	# These need manual maintainance
	case $prev in
		-a|-i|tui)
			COMPREPLY=( $(compgen -f -- $cur) )
			return 0
			;;
		-h)	return 0
			;;
	esac
}
# Actualy make it available to the shell
complete -F _tui_module tui