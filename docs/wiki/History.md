About me
--------

As i grew up using taperecorders for a C64, i always was familiar to the console.

Sometime later, on a _Compaq i386 SX2 66mhz and 4mb ram_ using MSDos 5 and _that GUI thing from **Ensemble Studios**_ (before it got bought by MS), i first met the command **net**.

Oh, how i loved the command **net**...
It used words as arguments which when the command was complete, gave something like a proper sentence.
To me, this was a great experience, as i figured one could write something that takes _words_ as arguments, 
and when provided with a proper directory and file structure it should become quite natural to use.

The idea and desire to write something like that was born.
That was around 1993.

In 1996 i had a quick meeting with slackware 3.0 from the book and some distro with a redhat, got confused by the package manager and Enlightment and returned back to Dos6 to play games on an island :D

About TUI
---------

In 2011 the confusion and annoyance of the way to create one owns custom automated OS installation... oh, how i missed the _unattend.txt_.
And during the first year of distro hopping and trying diffrent flavors of linux, i started writing bash scripts.

Obviously caused due to the massive often repeated reinstallation of Linux distro $WHATEVER_YOUNAMEIT, the first scripts were regarding getting all the required packages
installed and tweaks done.
After the first few successfull attempts, i wanted to have them look better, and started to write functions.
Pretty soon i've had quite a bunch of functions, i had to copy from script to script, remove unrequired functions to keep the scripts as small as possible.
Oh deer, having like 15 scripts, and having to update 3 functions in all of them is quite annoying, specialy if you constantly (have to) change them.

It then started that i exported the functions to files, like one does with php.
That was, because i wanted the share the script as a single text file, heck its just a script.
But i also wanted to have the functions easier 'updateable', so 'exporting' them to an external file was logic.

I recalled **net** and thought i would try to write this now.

A principle of linux is:

	Everything is a file.

This means, one can access a blockdevice, such as your harddisc, basicly the same way like the familiy pictures.

Applying this method of thinking down to 'executeables', configurations, logs and data storage:

	Every file is text.

So i wanted to be able to maintain this framework not only from cli, but also to de required changes 'on the fly'.

The very first approach of the framework was with **Sea's Script Collection**, a rewrite later named it simply **Script Collection**, another rewrite it became **Script-Tools**.

It provided commands like:

        ssc tweak grub 1 change-bg
        ssc tweak grub 2 rebuild
        ssc system cron add


Where each of the first and last word was a file, and the others directory names.

Imagine to replace 'ssc'(st) with the _menu path_ where 'tweak' and 'system' (and their subfolders: grub/1 grub/2 system/cron) are located in.


I then started to include scripts which make it easier for me to build packages and live isos.

When i finaly figured out that the interface was too much interweaved with the scripts using them,
eventualy i decided to extract the interface functions.
After having all the basic display functions, figured, the core function of script-tools was missing.
It took _words_ as argument and checked wether their order match the path/file structure inside a pre-defined location.
If it was a file it would execute it and if it was a folder it would list the files/folders contained.

tui-browser is all about let the user use arguments as in the code block shown above, but also browse through that virtual home/root direcotry either by 'select' (default, tui-select actualy) or text (-m).

tui-browser is TUI and my very own masterpiece of showning how powerfull the shell (bash) is, eventhough its limitations.
