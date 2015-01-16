Description:
------------

This command for User interactions : External commands, should help downloading a file while preserving the TUI.

It is thought to download either a single file, a list of files, or several files from remote to local.

It looks on the users system wether curl was found, if not, its looking for wget.
If neither of which is found, it fails.

Examples:
---------
Recomended usage:

	URL="https://sea.fedorapeople.org/review/tui/tui-0.6.5-8.fc21.src.rpm"
	tui-download "$URL"

The 3 lines below are just one line:

	# | Initializing new download...                                [  ∞   ] | #
	# | Downloading...          tui-0.6.5-8.fc21.src.rpm ()         [  \   ] | #
	# | Downloading...        tui-0.6.5-8.fc21.src.rpm (1.2M)       [  /   ] | #
