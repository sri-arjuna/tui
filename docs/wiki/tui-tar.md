Description:
------------

This command for User interactions : External commands, should help to compress folders.

Basicly, it compresses the folder given as argument and saves it in $HOME.
Its using the configuration from apps.conf of the user configuration.

Examples:
---------

	tui-tar /path/to/dir

Could look like this (the output is just 1 line, its just the 3 steps):

	# | Initializing ./prjs/grub2-circled-nasa-themes/...           [  ∞   ] | #
	# | Compressing...       grub2-circled-nasa-themes (2.9M)       [  |   ] | #
	# | Compressed: /home/sea/grub2-circled-nasa-themes.tar.gz      [  √   ] | #
