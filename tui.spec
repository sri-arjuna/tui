Name:        tui
Version:     0.8.1
Release:     1%{?dist}
Summary:     Shell wrapper and I/O toolset

License:     GPLv3
URL:         https://github.com/sri-arjuna/tui
#Source0:     https://github.com/sri-arjuna/tui/archive/master.zip
Source0:     http://sea.fedorapeople.org/review/%{name}/%{name}-%{version}.tar.gz

BuildArch:   noarch

Requires:    bash
Requires:    coreutils


%description
Advanced command based framework for scripts
Each command represents a known counterpart from a regular command,
or describes its task with its name.


%prep
%setup -q -c %{name}-%{version}

%build
# nothing to do

%install
# Clean buildroot
rm -rf       %{buildroot}
# Remove non-used files to reduce package size
rm -fr  %{name}/build-rpm-%{name}.sh \
        %{name}/install.sh \
        %{name}/uninstall.sh
# Prepare directories
mkdir -p     %{buildroot}%{_bindir}/ \
                     %{buildroot}%{_mandir}/man1 \
                     %{buildroot}%{_sysconfdir}/%{name}/ \
                     %{buildroot}%{_sysconfdir}/profile.d/ \
                     %{buildroot}%{_datarootdir}/%{name}/themes \
                     %{buildroot}%{_docdir}/%{name} \
                     %{buildroot}%{_datadir}/bash-completion/completions
# Move the executeables
rm -fr %{name}/screenshots
mv %{name}/bin/*     %{buildroot}%{_bindir}/
mv %{name}/%{name}_compl.bash %{buildroot}%{_datadir}/bash-completion/completions
# Copy system defaults to system
echo "PREFIX=/usr" >> %{name}/conf.etc/tui.conf
cp %{name}/conf.etc/*    %{buildroot}%{_sysconfdir}/%{name}/
# Move system defaults to app dir
mv %{name}/conf.etc    %{buildroot}%{_datarootdir}/%{name}/
cp %{name}/conf.home/*  %{buildroot}%{_datarootdir}/%{name}/
mv %{name}/templates    %{buildroot}%{_datarootdir}/%{name}/
mv %{name}/themes       %{buildroot}%{_datarootdir}/%{name}/
mv %{name}/docs/*       %{buildroot}%{_docdir}/%{name}
mv %{name}/man/*.1      %{buildroot}%{_mandir}/man1


%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)   
%doc %{_docdir}/%{name}/
%{_mandir}/man1/%{name}*.1.gz
%{_datarootdir}/%{name}/
%{_bindir}/%{name}
%{_bindir}/%{name}-*

%config
%{_sysconfdir}/%{name}/
%{_datadir}/bash-completion/completions/%{name}_compl.bash

%changelog
* Sun May 24 2015 - Simon A. Erat - erat.simon@gmail.com - 0.8.1-1
- Updated:   tui-bgjob, added option -e BYTES, which may obsolete
-            option -s FILE on some occasions. Either of which is 
-            required to use a progress bar as indicator.
- Updated:   tui-cp, showed wrong name in helpscreen
- Updated:   install.sh, bash-completion path was missing 'share'
- Updated:   tui-status/conf.etc/status.conf, didnt recognize console
- Changed:   Screenshot strucuture

* Sun May 24 2015 - Simon A. Erat - erat.simon@gmail.com - 0.8.1-0
- Fixed:     tui, checked for user configurations without the path
- Updated:   tui-select, didnt have -1|2 in the getopts parselist
-            if passed, instead of 3, it shows this many columns
-            Its output (selected-item) was unstable at some conditions

* Sat May 23 2015 - Simon A. Erat - erat.simon@gmail.com - 0.8.0-3
- Fixed:     tui-wait, had a local reference left from devel branch

* Thu May 21 2015 - Simon A. Erat - erat.simon@gmail.com - 0.8.0-2
- Changed:   install-new.sh had a typo and copied the folder to destination
- Changed:   tui, if a loadlist is missing it rewrites a default one now
- Changed:   bash-completion should be installed properly again with rpm
- Changed:   Replaced old install script with the new one.

* Thu May 21 2015 - Simon A. Erat - erat.simon@gmail.com - 0.8.0-1
- Updated:   tui-new-script, had an additional /templates string
- Added:     install-new.sh, simplified and 'guided' installation script

* Thu May 21 2015 - Simon A. Erat - erat.simon@gmail.com - 0.8.0-0
- Changed:   tui, now using an RC file to provide internal paths
-                required for manual install and some exotic bsd, linux, unix distros
- Changed:   Preparing themes to 'not' calculate BORDER_RIGHT, if its set in the theme
- Changed:   Conffiles for both, system and user
- Split:     Settings.conf, previously part of apps.conf
- Touched:   tui, tui-bgjob, tui-browser, tui-cat, tui-cp, tui-dd, tui-download, tui-ftp, 
-            tui-header, tui-indi, tui-mv, tui-printf, tui-progress, tui-select, 
-            tui-str-extension, tui-tar, tui-new-*
- Updated:   Paths in tui-{echo,edit,install,list,log,press,rnd,status,title,wait}
-            tui-bol-gui  and tui-str-{encrypt,genfilename}
- Added:     tui-bol-root, tui-str-bol-conv
- Added:     tui-asroot, executes command as root, uses sudo if useSudo is true.
- Changed:   tui-progress, new arrangements alignments
- Changed:   tui-str-usb, optimized first usage, autoselection, and cardread ignore
- Updated:   tui-{edit,terminal,web}, updated to paths and now read list files.
- Changed:   tui-wait, updated timecode display
- Changed:   tui-printf, fixed clean line(ty chubbler) and other small things

* Sun May 10 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.6-5
- Updated:   tui-progress, procent is now only shown in long bar mode.
- Fixed:     tui-str-extension, fixed typo

* Fri May 08 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.6-4
- Fixed:     tui-{edit,filemgr,web,terminal}, stdout was muted
- Updated:   tui-psm, added verbose mode which executes each script
-                     in its own terminal, verbose is gui only.

* Fri May 08 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.6-3
- Fixed:     tui-str-genfilename, by exporting functionality to tui-str-extension
- Added:     tui-str-extension, to provide a tool for this task
- Updated:   tui-select, now can also show only 1 or only 2 columns
- Added:     tui-bol-gui, to simple check if one is in gui or cli mode.

* Fri May 01 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.6-2
- Updated:   tui-install, now prefers dnf over yum if available
- Changed:   tui-conf-set, leading space handling improvement?
-            added verbose mode
- Updated:   tui-conf-editor, now uses the verbose mode of tui-conf-set

* Thu Apr 30 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.6-1
- Changed:   Specfile for reviewing

* Wed Apr 29 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.6-0
- Fixed:     tui-printf, no longer adds tailing backslash to strings with escaped variables
- Changed:   tui-conf-set, now prints status message if verbose
- Changed:   tui-status, added a comment line to code
- Changed:   templates/scripts/modul, changed helpscreen from string to function
- Changed:   manpages for tui and tui-progress
- Added:     conf.etc/commands.conf, added LS, so it doesnt take an alias'

* Mon Apr 20 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.5-0
- Updated:   tui-progress, bar now has a border and optimizied alignment
- Fixed:     tui-select, empty selection should no longer raise an error message.
- Fixed:     tui-str-genfilename, no longer cuts of filenames after first dot, only last dot.

* Thu Mar 26 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.4-1
- Removed:   Old and no longer used templates
- Added:     Create fun stats for project
- Added:     tui-str-encrypt, encrypt strings

* Wed Mar 25 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.4-0
- Added:     tui-cp, tui-mv
- Updated:   tui-progress, a few code optimizations
- Updated:   tui-bgjob uses now a progress bar if both options 
-                   'source' and 'file'  file are provided.

* Thu Mar 19 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.3-0
- Updated:   man tui-printf, 0.9.7 -> 1.4.8
- Changed:   $TUI_FONT_INVERT became corrected to $TUI_COLOR_INVERT
- Added:     New README - project info
- Added:     tui-str-genfilename
- Updated:   tui-progress, bar mode is working now.
- Updated:   man tui-tar|progress

* Wed Mar 18 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.2-0
- Updated:   tui-list, now accepts -1 or -2 to define output rows
- Updated:   tui, no longer shows config screen when passing
-            'config' to certain tui-<command>'s
- Updated:   tui-browser can be silent now (no header,title,footer)
- Updated:   tui-select, output optimized

* Sun Mar 08 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.1-0
- Updated:   tui-edit, now saves the full application path.
- Updated:   tui-conf-set, there was an issue if vars were indented.
- Updated:   tui-select, actualy fixed empty line if user pressed enter

* Wed Feb 25 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.0-32
- Updated:   tui-browser now uses tui-select in numeric (default) mode
- Updated:   tui-{edit,filemgr,web,terminal} no longer show the binary executed

* Wed Feb 18 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.0-28
- Updated:   tui-log, better handling on creating initial logfile
- Updated:   install.sh, using PREFIX to custom target installations
-            Some commands, so they now also use PREFIX when installed
- Updated:   tui-new-script, modified templates a bit
- Updated:   tui-psm, needed to set a variable earlier

* Wed Feb 11 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.0-25
- Fixed:     tui-list, items with space are properly shown now
- Updated:   tui-conf-set, removed debug output
- Added:     some wiki pages

* Tue Feb 10 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.0-23
- Updated:   tui-select, new attempt to keep the input line minimal
- Updated:   tui-conf-[gs]et, decreased overhead, fixed space issue
- Updated:   tui-list, fixed seperator space issue

* Thu Feb 05 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.0-7
- Updated:   tui-browser, appends now a newline to avoid sourcing error

* Mon Feb 02 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.0-4
- Changed:  tui-yesno, no longer makes an empty line
- Changed:  tui-download, message display should be handled better now
- Updated:  README.md, "Also, a big **thank you** goes 
-                    to the forummembers of unix.com."
- Updated:  tui-ftp, added basic logfile parsing for display

* Tue Jan 27 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.0-2
- Added:    tui-ftp, log parsing to generate output

* Tue Jan 27 2015 - Simon A. Erat - erat.simon@gmail.com - 0.7.0-1
- Added:    tui-ftp, handler for [ls]ftp, incl wiki & manpage
- Updated:  tui-conf-set, improved check if variable exists or not
- Changed:  templates/scripts/*, changed shebang to "#!/usr/bin/env bash"
- Changed:  templates/scripts/*, changed the way it sources tui
- Changed:  tui-install, was missing -y to continue installation on *bsd

* Tue Jan 27 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.9-8
- Updated:  Installation wiki page, added wget installation, ty glenn
- Updated:  install.sh, had a quoting issue, ty glenn
- Updated:  tui-conf-set had to check for required quotes in case of space

* Fri Jan 23 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.9-4
- Updated:  install.sh, final optimization for freebsd

* Fri Jan 23 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.9-2
- Updated:  install.sh, changed DIR_COMPL for freebsd
- Updated:  tui-status, changed how it defines wether it a VT or GUI
- Changed:  All commands, replaced [[expr]] by [expr]
- Updated:  install.sh should work on freeBSD now
- Updated:  tui-browser, uses now tui-cat rather than its own code
- Updated:  tui-{broser,conf-set,printf} had a wrong grep space cmd
- Changed:  Many grep commands were missing a bracket, because of the
-           massive brack removal of if-block
- Updated:  tui-new-manpage, no longer prints its own name (*.1) when
-           refering to the application name

* Thu Jan 22 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.8-40
- Updated:  tui-cat, pass -- to tui-echo so it prints leading dashes
- Updated:  tui-printf, removed sed s,\ -,-*\ ,
- Updated:  tui-printf, added information on -- option to helptext
- Updated:  tui-{echo,header,title}, added automatic handling
-           if strings with a leading dash are submited.

* Thu Jan 22 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.8-37
- Updated:  tui-printf, prints %% properly now
- Fixed:    tui-cat, now prints leading dashes (if reading from file only)

* Wed Jan 21 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.8-4
- Added:   tui-cat, prints a file, also offers typewriter mode
- Updated: tui-new-script, renamed medium to default, added 'tool'

* Tue Jan 20 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.8-3
- Fixed:   tui-download still had debug mode on.

* Sat Jan 17 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.8-2
- Added:   wikipages for tui-new-{browser,manpage,script} and tui-browser
- Updated: tui-browser, now prints the default.help file if one
-                    typed 'help' in textmode and the file exists.
- Fixed:   tui-browser, can start again without arguments required.

* Fri Jan 16 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.8-1
- Updated: tui-download, now asks to install curl, if missing both
- Updated: tui-filemgr, had a typo
- Updated: tui-terminanl, added (automatic)options for 
-           gnome-terminal (-e CMD) and
-           lxterminal (-e CMD)
- Updated: tui-web, fixed a typo
- Updated: tui-log, muted touch if user has no write access to path
- Fixed:   tui-psm, called tui-log without the logfile.
- Added:   Another 10 wiki pages

* Thu Jan 15 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.8-0
- Added:   Wikipages 'Basic Display' to 'User interaction - scripts'
- Updated: tui-list, roman numbers use now a dot as seperator
- Udpated: tui-progress, now shows bar in terminals
-          smaller than 80 colums, the math was in wrong order

* Tue Jan 13 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.7-23
- Updated: tui-browser, 
-          '-b WORD' is now counterchecked if it is a bash command
-          Removed XDG_MIME checks -> KISS, expecting executables only
-          Its manpages
-          Config & Source loading, functions
- Fixed:   tui-browser, Position display was missing leading /

* Tue Jan 13 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.7-15
- Updated: tui-list, can now also print a list without numbering at all
- Updated: tui-download, now checks wether curl or wget is available
- Updated: tui-browser, accepting "-P lbl_position" which overwrites
-          the display of the current subdir of the projects menu dir.
-          "-S" will force the location/position line to be shown,
-          when calling scripts directly.
-          "-X SHELL" will start the scripts with given SHELL
-          Using now: tui-list
- Fixed:   tui-browser, textmode input display

* Mon Jan 12 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.7-11
- Added: tui-rnd, to easy get random numbers within range
- Updated: tui-browser, changed options and the way it loads files

* Sun Jan 11 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.7-5
- Fixed the -tr- quoting causing the issue with the string splitting
- Fixed tui-conf-set, should be the final fix for this, ty Don

* Fri Jan 09 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.7-0
- Hopefully fixed the splitting issue of tui-printf
-  This was roadmap + hotfix at the same time.

* Thu Jan 08 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.6-9
- Hotfix for: tui-read, too many empty lines
- Added another sample script in /usr/share/docs/samples

* Thu Jan 08 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.6-6
- Hotfix for: tui-conf-{g|s}et
- Hotfix for: tui-bol-sudo
- Hotfix for: tui-str-usb

* Wed Jan 07 2015 - Simon A. Erat - erat.simon@gmail.com - 0.6.6-0
- Added tui-bol-sudo
- Optimized tui-dd, if not TARGET is provided, to use USB devices
- Changed all files to it should become Solaris compatible
-     when commands.conf is changed properly, see commands.conf
- Optimized tui-str-usb, to autoselect if only 1 entry was found

* Tue Dec 30 2014 - Simon A. Erat - erat.simon@gmail.com - 0.6.5-8
- tui-status can now 'stay on line' with '-r'
- removed unrequired calls of printf in status.conf

* Fri Dec 26 2014 - Simon A. Erat - erat.simon@gmail.com - 0.6.5-1
- Update for tui-read, accidently prints newline char to output, 
-      rather than screen.
- Updated tui-yesno
- Added commands.conf to prepare compatiblity for solaris users

* Sat Dec 20 2014 - Simon A. Erat - erat.simon@gmail.com - 0.6.5-0
- Updated version number
- Fixed 'endless loop' issue with tui-status with 3 arguments,
-    in terminals smaller than 80 columns, still needs optimal finetuning.
- Fixed tui-list, didnt display items properly, 
-    therefor tui-select couldnt select right.

* Thu Dec 18 2014 - Simon A. Erat - erat.simon@gmail.com - 0.6.4-0
- tui-read: Works on more systems now, and hopefully fixed display issue
- tui-install: Supports (hopefully) more systems now, thx 'drl'
- tui-progress: Now also has a bar (#)
- Added several screenshots

* Fri Dec 12 2014 - Simon A. Erat - erat.simon@gmail.com - 0.6.3-6
- Added: tui-new-manpage
- Fixed: tui-read
- Fixed: emptyline of tui-list/tui-select

* Thu Dec 11 2014 - Simon A. Erat - erat.simon@gmail.com - 0.6.3-0
- Updated: tui-list, roman numbering now uses CI) rather than M.
- Updated: tui-status, status.conf, uses now colors
- Added:   tui-filemgr
- Updated: tui-{edit,web}
- Updated: manpages of tui-{edit, filemgr, web, terminal}
- Added:   Bash completion

* Mon Dec 08 2014 - Simon A. Erat - erat.simon@gmail.com - 0.6.2-1
- Fixed:   tui-select now uses tui-list to print its options
- Updated: tui-list now supports roman numbers
- Updated: tui-select seems stable now, wrong input fills the line though...
- Updated: tui-conf-editor uses now tui-select
- Fixed:   tui-conf-editor applies supplied title
- Added:   demo & sample scripts, screenshots
- Performance update for tui-list

* Sun Dec 07 2014 - Simon A. Erat - erat.simon@gmail.com - 0.6.1-0
- Fixed: tui-conf-set, automaticly shell escapes when writing values
- Updated: tui-new-script, handling & templates
- Introducing: tui-select

* Mon Dec 01 2014 - Simon A. Erat - erat.simon@gmail.com - 0.6.0-0
- Helptext update in tui-bgjob, tui-log, tui-wait
- Added verbose: (-v) in: tui-{log, wait}
- Fixes in: tui, tui-{browser, conf-editor}

* Fri Nov 28 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.9-2
- Updated website in the manpages & prepared spec for 'tui reset'

* Fri Nov 28 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.9-1
- General manpage update and unifiquation.

* Thu Nov 27 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.9-0
- tui-browser 'fix' argument passing to sub scripts
- tui-read, properly uses theme now
- tui-download, requires less variables.

* Tue Nov 18 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.8-21
- Fixed: tui-edit, was very slow loading
- Fixed: tui-browser passes now arguments to scripts it executes

* Thu Nov 13 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.8-1
- Fixed: Showed $USER instead of whoami ($USER_NAME)

* Thu Nov 13 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.8-0
- Added: Colors and Borders are now changeable by a theme
- Renamed: tui-value-* to tui-conf-*
- Renamed: tui-config-editor to tui-conf-editor

* Thu Nov 13 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.7-0
- Fixed: tui-tar, compress 'indicator' was not properly shown
- Fixed: tui-read, now shows the border
- Fixed: tui-config-editor, had a check wrong formated
- Fixed: tui-printf, less split up aligments
- Fixed: tui-value-set, didnt change value but reported so
- Removed: tui-printf-optimized, no more things to apply

* Wed Nov 12 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.6-0
- 'tui' should be fixed again for first call
- changed manpage for 'tui'

* Wed Oct 29 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.5-1
- Changed: tui-psm, attempt to hide default output of scripts working on
- Readded: Some reqs for the spec - leafpad, nano, w3m, xterm

* Mon Oct 27 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.5-0
- Fixed: tui-browser, location display & passed path/file recognition

* Sun Oct 19 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.4-0
- Fixed: tui-browser, now passes passed arguments
- Updated %%description

* Sat Oct 18 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.3-0
- Added tui-psm (Paralell Script Manager)

* Thu Sep 04 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.1-0
- Changed: colors.conf
- Changed: status.conf
- Fixing ATM: colors spread over lines

* Sun Aug 31 2014 - Simon A. Erat - erat.simon@gmail.com - 0.5.0-0
- Rewrote for performance
- Added tui-browser, tui-new-browser
- Added tui-install, tui-wait

* Thu Mar 20 2014 - Simon A. Erat - erat.simon@gmail.com - 0.4.1-0
- Introducing $USER_SHELL, used for tui-newscript as shell definition

* Sun Feb 02 2014 - Simon A. Erat - erat.simon@gmail.com - 0.4.0-7
- Added:     tui.spec to package location
- Changed:   install.sh
- Changed:   tui-newscript.sh

* Sat Oct 26 2013 - Simon A. Erat - erat.simon@gmail.com - 0.4.0-6
- Added:     tui-bgjob

* Sun Oct 13 2013 - Simon A. Erat - erat.simon@gmail.com - 0.4.0-5
- Changed:   Optimized dd, download, tar

* Thu Oct 03 2013 - Simon A. Erat - erat.simon@gmail.com - 0.4.0-4
- Added:     tui-dd
- Changed:   Tarball now more structured

* Thu Oct 03 2013 - Simon A. Erat - erat.simon@gmail.com - 0.4.0-3
- Changed:   Renamed tui-str-ask -> tui-read
- Long line fix : attemp 1

* Mon Sep 30 2013 - Simon A. Erat - erat.simon@gmail.com - 0.4.0-2
- Changed:   Renamed 'global' variable DEFAULT_USER -> USER_NAME
- Changed:   Renamed 'global' variable DEFAULT_EMAIL -> USER_EMAIL
- Changed:   Renamed 'global' variable USER_HOMEPAGE -> USER_HOMEPAGE

* Sun Sep 29 2013 - Simon A. Erat - erat.simon@gmail.com - 0.4.0-1
- Added:     tui-tar
- Changed:   tui-download - Now displays amount of data downloaded

* Sat Sep 28 2013 - Simon A. Erat - erat.simon@gmail.com - 0.4.0-0
- Fixed:     Alignments & stable
- Spec:      Clean up

* Thu Sep 26 2013 - Simon A. Erat - erat.simon@gmail.com - 0.3.8-2
- Added:     tui-download, tui-str-ask, tui-str-usb
- Changed:   tui-newscript 
-            Rearanged argument handling after sourcing 'tui'
- Fixed:     ?tui-indi, missed variable check for proper tempdir
- Fixed:     tui-printf: Contained accidently \n instead or \r
- Spec:      Updated descripton

* Tue Sep 24 2013 - Simon A. Erat - erat.simon@gmail.com - 0.3.8-1
- Fixed:     Alignments - header/title (GUI still needs care)

* Tue Sep 24 2013 - Simon A. Erat - erat.simon@gmail.com - 0.3.8-0
- Updated:   Manpages
- Fixed:     Several files

* Sat Sep 21 2013 - Simon A. Erat - erat.simon@gmail.com - 0.3.7-2
- Added:     tui-status, tui-edit, tui-yesno, tui-press

* Sat Sep 21 2013 - Simon A. Erat - erat.simon@gmail.com - 0.3.7-1
- Fixed:     Display issues

* Sat Sep 21 2013 - Simon A. Erat - erat.simon@gmail.com - 0.3.7-0
- Initial package, providing: tui, tui-printf, tui-echo, 
-                             tui-header, tui-title, tui-newscript
- 'High' version number because it is the "framework" i was using
- for Script-Tools, extracted and (in process to) polished up for reusage
