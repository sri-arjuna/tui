#
#	Injection protection
#
	break_on_injections() { # ARGS
	# Searches for injection subjects
	# Returns true if it finds some
		typeset arg ac=0
		for arg do
		ac="$((ac+=1))"
		case "$arg" in
		#(*[';`|<&>:']*|*'$('*|)	# Orginal
		#(*[';`|<&>':-'':('']*|*'$('*)
		#(*[';`|<&>:']*|*'$('*|'*:(*'|'*:-*')
		(*[';´|<&>']*|*':('*|*':-'*)
			printf "%s\n" "Aborting, injection detected! arg${ac}='$arg'"
			return 0
		;;
		esac
		done
		return 1
	}