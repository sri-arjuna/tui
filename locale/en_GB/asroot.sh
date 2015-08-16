# BASH - Language File
# --------------------
# Translator:	Simon Arjuna Erat
# 
#
# --------------------
# For project TUI, the version string may stay untouched
TR_MSG_TEXT_VERSION="
GNU $ME, Version $script_version
Copyright (C) 2011-2015 Simon Arjuna Erat
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
"

# ----------------------

TR_MSG_TEXT_HELP_SHORT="Usage: 		$ME \"command\""
TR_MSG_TEXT_HELP_LONG="
Examples:	$ME \"cat /etc/cryptab\"
		$ME -m \"Provide password to show crypttab\" \"cat /etc/cryptab\"
Where options are:
	-h(elp) 		This screen
	-m(essage)	MSG	Prints \"MSG\" before asking for a password
"
TR_MSG_TEXT_HELP="$TR_MSG_TEXT_HELP_SHORT$TR_MSG_TEXT_HELP_LONG"
#------------------------------------------
TR_MSG_TEXT_PASSWORD="Please provide the password for $USER"