Description:
------------

This command for User interactions : External commands, should help to use File Transfer Protocols (ftp).

Basicly, it tries to summarize one set of available options to be used for either:
1. ftp
2. lftp
3. sftp

Examples:
---------
Upon first call at least, unless you have prepared on your own apriori, you must ([c|sh]ould pass to it.
If no information on your host was found in ~/.netrc, it will ask you to append it. (as of now, it bugs you until you do)

You can leave out the password, but it will ask you for it each time.

	tui-ftp -U "username" -P "password" -c "cd htdocs ; ls" 123.123.123.123

Could look like this

	
