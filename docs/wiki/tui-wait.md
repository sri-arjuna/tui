### tui-wait

Description:
------------

This little user interaction helper could be used to display a delay when required.

For example, but not limited to: before a screenshot - say cheese :D

Examples:
---------
One could be crazy and wait several hours:

	tui-wait 5h "I need to clean up my desktop icons!"

Start counting:

	# | I need to clean up my desktop icons!                         4:59:58 | #
	
Other usages might be:

	tui-wait 5m "Could not reach host, trying again in:"
	
Retrying soon:

	# | Could not reach host, trying again in:                        0:4:58 | #