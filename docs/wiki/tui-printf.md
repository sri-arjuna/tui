### tui-printf

Description:
------------

This is the very core to display, **tui-echo, tui-header** and **tui-title** are just simply wrappers for easy usablity of **tui-printf**.

The only diffrence between **tui-printf** and **tui-echo** is the linebreak of the 2nd.

tui-header is thought to be used as head-line of a loop'ed script.
Thus its color start at the line beginning and stops at the line end.

tui-title is thought as section title, and its color starts from the inner border, and stops at the inner border.
This one is special, if only one string is passed, it will display it centered.
As soon two arguments are passed, it behaves like tui-printf, tui-echo and tui-header.

When you pass a string too long to be displayed on one line within the borders of tui,
tui will first try to print each string on a separted line, and if it then still wont match,
if starts splitting them up. Each split up, will be right oriented, so a line start will always be on the left side, unless the middle or right one is causing this.

Sadly, it just can happen to produce infinite loops if you try to print too many information on a single line when the terminal window is not wide enough.
Using monospace fonts, a width of around 100 columns or wider is recommended, for my scripts, this preserves infitie loops in 99.9% of all cases, IF they occour.

Examples:
---------
    tui-echo
    tui-echo one
    tui-echo one two
    tui-echo one two three
	     
This will output like this (also for tui-header), and theoreticly for tui-printf - though it would overwrite itself each time):

    # |                                                                      | #
    # | one                                                                  | #
    # | one                                                              two | #
    # | one                             two                            three | #

As already mentioned, for tui-title it would look a little diffrent, but just for the line with one string.

    # |                                                                      | #
    # |                                 one                                  | #
    # | one                                                              two | #
    # | one                             two                            three | #

But you can arrange it yourself either by just passing a space char:

    tui-echo " " center
    tui-echo " " center " "
    
Will look like:

    # |                                                               center | #
    # |                                center                                | #

