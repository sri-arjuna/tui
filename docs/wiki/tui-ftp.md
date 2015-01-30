Description:
------------


ALPHA
=====


This command for User interactions : External commands, should help to use File Transfer Protocols (ftp).

Basicly, it tries to summarize one set of available options to be used for either:
1. ftp
2. lftp
3. sftp

Understand that i just started with this tool, using diffrent ftp commands, parsing logs according to work mode and generate a readable and informative text and present it nicely is quite a challenge.

Examples:
---------
Upon first call at least, unless you have prepared on your own apriori, you must ([c|sh]ould pass to it.
If no information on your host was found in ~/.netrc, it will ask you to append it. (as of now, it bugs you until you do)

You can leave out the password, but it will ask you for it each time.

	tui-ftp -U "username" -P "password" -c "cd htdocs ; ls" 123.123.123.123

So on the first time call, it could look like this:

	# | Please select which ftp command you want to use:                     | #
	# | 1) ftp                        2) lftp                        3) sftp | #
	# | > 1
	# | Saved ftp as FTP                                            [  ✔   ] | #
	# | Add 123.123.123.123 to /home/sea/.netrc for automatic login? (y/n) y | #
	# |                           /home/sea/.netrc                           | #
	# | machine 123.123.123.123 login username password password             | #
	# |                                                                      | #
	# | Change any loginame / password? (y/n)                              n | #
	# | Done job with ftp                                           [  ✔   ] | #

Then, to see what happend, you could call:

	tui-ftp -L
	
Which will present the logfile, each ftp call will look similar to this:

	10:11:19 	 Process ID: 23428
	10:11:19 	 FTP Command: ftp
	10:11:19 	 Set commands to parse: 
	10:11:19 	 Set host to: <hostname>
	Connected to <hostname> (<hostip>).
	220---------- Welcome Message of the host ----------
	220-Host info
	331 User <username> OK. Password required
	230-This server supports FXP transfers
	230 OK. Current restricted directory is /
	Remote system type is UNIX.
	Using binary mode to transfer files.
	221-Goodbye. You uploaded 0 and downloaded 0 kbytes.
	221 Logout.
	
However, once you have automatic login, your calls could be simple as: (to download a single file)

	tui-ftp -d /remote/path-to/file -l /local/dest/path

Which then would look like:

	# | Downloaded file/s                                           [  √   ] | #


The same command, but beeing 'verbose':

	tui-ftp -vd /remote/path-to/file -l /local/dest/path 123.123.123.123
	
Will look like:

	# | Enabled verbosity                                                    | #
	# | Added file to download: /remote/path-to/file                         | #
	# | Added path to download: /local/dest/path                             | #
	# | Set host to: 123.123.123.123                                         | #
	# | Generated download list.                                    [  √   ] | #
	# | Downloaded file/s                                           [  √   ] | #
	
	
Or download multiple files to the same location:

	tui-ftp -v \
		-d /remote/path-to/file1 \
		-d /remote/path-to/file2 \
		-d /remote/path-to/file3 \
		-l /local/dest/path \
		123.123.123.123
	
Will look like:

	# | Enabled verbosity                                                    | #
	# | Added file to download: /remote/path-to/file1                        | #
	# | Added file to download: /remote/path-to/file2                        | #
	# | Added file to download: /remote/path-to/file3                        | #
	# | Added path to download: /local/dest/path                             | #
	# | Set host to: 123.123.123.123                                         | #
	# | Generated download list.                                    [  √   ] | #
	# | Downloaded file/s                                           [  √   ] | #

Or upload multiple files to diffrent locations:

	tui-ftp -v \
		-f /path/to/lcl/file1 \
		-f /path/of/loc/file2 \
		-f /path/fr/locl/file3 \
		-r /remote/dest/path1 \
		-r /remote/dust/path2 \
		-r /remote/desk/path3 \
		123.123.123.123
	
This will upload the local file file<N> to remote path</N>.
And it will look like:

	# | Enabled verbosity                                                    | #
	# | Added file to upload: /path/to/lcl/file1                             | #
	# | Added file to upload: /path/of/loc/file2                             | #
	# | Added file to upload: /path/fr/locl/file3                            | #
	# | Added path to upload: /remote/dest/path1                             | #
	# | Added path to upload: /remote/dust/path2                             | #
	# | Added path to upload: /remote/desk/path3                             | #
	# | Set host to: 123.123.123.123                                         | #
	# | Generated upload list.                                      [  √   ] | #
	# | Uploaded file                                               [  √   ] | #