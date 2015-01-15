### tui-bgjob

Description:
------------

With TUI beeing a line based interface, 'bgjob' is not very accurate, but still true.
It is ment to execute a scriptfile in the background, and show a 'busy' indication while its running.
It even returns wether or not the background job was exited successfull or if it failed.

And if your script which runs in the background changes the size of a file, you can display that file its size, by passing the **-f FILE** option.

Either way, it expects 3 arguments:

0. (Optional:  -f file , which file its size shall be displayed)
1. The file to execute
2. The message that is displayed while running
3. The message that is displayed when done (regardless of exit status)


Examples:
---------

    tui-bgjob /path/to/script "Job running..." "Job done..."
    
    tui-bgjob -f /path/to/file_which_changes_size \
               "/path/to/script with space.sh" \
               "Job running..." \
               "Job done!"