Description:
------------

This command for User interactions : External commands, should help getting the user to a certain path within GUI.

If the user is in VT/console mode, it looks for mc, fd, fdclone and vifm, if none is found, it fails.
If the user is in GUI mode, it is looking for: pcmanfm, thunar, nautilus, dolphin, konquerer, krusader, xfe, 4pane, gentoo or filerunner, if none of these were found, it fails.


Examples:
---------
Recomended usage:

	tui-yesno "Do you want to open the project path?" && \
		tui-filemgr "$PRJ_PATH"
	
