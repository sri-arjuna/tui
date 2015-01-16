Description:
------------

This command for User interactions : External commands, simply shows how much data has been transfered.

Its main purpose is to write an image towards a device.
I have not had an opportunity to test it vice-versa.


Examples:
---------
Recomended usage:

	IMAGE=file.iso
	TARGET=/dev/sdX
	tui-bol-sudo && \
		sudo tui-dd $IMAGE $TARGET || \
		su -c "tui-dd $IMAGE $TARGET"

Of course, if already loged as root, and not knowing which device your USB is, this is already enough:

	tui-dd file.img
	
	# | Use USB as target? (y/n)                                           y | #
	# | 1) usb-Multiple_Card_Reader_058F63666485-0:0                         | #
	# |                           2) usb-SWISSBIT_Twist_99999999F900011d-0:0 | #
	# | > 2
	# | Writing AwesomeWM_3.17.8... to /dev/sdc...      (38MB)      [  /   ] | #