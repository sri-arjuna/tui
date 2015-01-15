### tui-str-usb

Description:
------------

This coding helper is ment to ease the selection of an usb device.
It will return its 'oldschool' device path.

Examples:
---------

	DEVICE=$(tui-str-usb)

Could look like this:

	# | 1) usb-Multiple_Card_Reader_058F63666485-0:0                         | #
	# |                           2) usb-SWISSBIT_Twist_99999999F900011d-0:0 | #
	# | > 2

So later in your code, it could look like this:

	echo "USB=$DEVICE" >> /path/to/config