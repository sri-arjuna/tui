### tui-status

Description
------------

This is a very nice tool to display diffrent kind of a status. it can also help to code, or make tasks easier.
Like all other display commands, it accepts up to 3 commands, however, the first one is always required and must be numeric.

The numeric value is a must, so diffrent exit status can be catched by simply passing **$?** as the numeric value.


Examples
-----------

A very simple demonstration:

    [[ -f filename ]]
    tui-status $? "File exists"

This could output like this:

    # | File exists                                                 [  ✔   ] | #


This will print an init-style message, with "File exists" on the left side, and either a DONE or a FAIL.
tui-status has another neat trick, it passes the numeric value as exit status.
That way, you can simply catch it, or, use it with an if-then-codeblock.

    [[ -f filename ]]
    if tui-status $? "File exists"
    then    tui-echo do_something
    else    tui-echo something-else
    fi

This could output like this:

    # | File exists                                                 [  ✘   ] | #
    # | something-else                                                       | #

Obviously you could customize the message, by a diffrent approach:

    if [[ -f filename ]]
    then    tui-status $? "File exists"
    else    tui-status $? "File does not exists"
    fi

This could look like either one line:

    # | File does not exists                                        [  ✘   ] | #
    # | File exists                                                 [  √   ] | #

But here is more, if you are going to 'start' something, which takes a while, you can inform the user about it.

    tui-status 2 "Starting something"


If you had sourced tui previously in your script, you could use the $RET_XY values instead.
See a list of options with:

    tui-status -h

If you have started something, but do not want to have that longer visible than required, pass **-r**, so the cursors returns to the line, and your next output will overwrite this message.
Combined, this could look like:

    tui-status -r $RET_WORK "Message"
    
This will output as:

    # | Starting something                                          [  ∞   ] | #

And do not forget, for reporting purposes, you can also display a centered value like this:

    tui-status 0 "Copied to $PWD:" "filename"

Which will look like:

    # | Copied to /home/user:                filename               [  √   ] | #
