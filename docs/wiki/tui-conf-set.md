Description:
------------

This command for advanced scripting is thought to simply change or set a variable within a file.

It can also be used to create a new configuration file, or to set a variable to an empty string.


Examples:
---------
Syntax is simple:

	tui-conf-set /path/to/file.conf VARIABLE VALUE
	
An example with grub its default config:

	sudo tui-conf-set /etc/default/grub GRUB_THEME /path/to/new-theme/theme.txt
	
Or to create a new config

	tmp_file=$$
	touch $tmp_file
	tui-conf-set $tmp_file var1 value1
	tui-conf-set $tmp_file var2 "second value"
	tui-conf-set $tmp_file var3 third
	tui-conf-set $tmp_file empty_var ""
   
  	cat $tmp_file
	rm $tmp_file
	
Will output as this:

	var1=value1
	var2="second value"
	var3=third
	empty_var=

