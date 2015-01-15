### tui-edit

Description:
------------
Open's passed files in your favorite text editor.

This will work in graphical and shell environments.

The use of this command has two benefits:

1. The writer of scripts has not to care about which editor and in which environment is, **tui-edit** does this handling for you.

2. The user can set his prefered editor in **$HOME/.config/tui/apps.conf**

Either way, upon first call, tui-edit checks wether or not the default editor is available or not, and if it is not found, it parses a list of known editors that work in current mode, CLI or GUI.

If you ever should experience that no editor is opened, please raise an issue and let me know of your system its editor for the cLI and for the GUI.

Usage:
------

    tui-edit [/path/to/]FILE1 FILE2 ...


Configuration:
--------------

* /etc/tui/apps.conf

* $HOME/.config/tui/apps.conf