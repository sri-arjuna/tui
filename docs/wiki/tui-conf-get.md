Description:
------------

This command for advanced scripting simplifies the task of retrieving a single variable value from a file.



Examples:
---------
The syntax is simple

	tui-conf-get /path/to/FILE VARIABLE
	
So a practical use will be:

	value=$(tui-conf-get /path/to/FILE VARIABLE)
	
To make an example with GRUB

	value=$(tui-conf-get /etc/default/grub GRUB_THEME)
	echo "$value"

Could output like:

	/boot/grub2/themes/circled-nasa-horizon/theme.txt

	
You can also get a list of available variables within a file:

	list=$(tui-conf-get -l /etc/default/grub )
	echo "$list"

Could output like:

	GRUB_TIMEOUT
	GRUB_DISTRIBUTOR
	GRUB_DEFAULT
	GRUB_DISABLE_SUBMENU
	GRUB_TERMINAL_OUTPUT
	GRUB_CMDLINE_LINUX
	GRUB_DISABLE_RECOVERY
	GRUB_GFXMODE
	GRUB_THEME
