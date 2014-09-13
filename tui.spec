Name:        tui
Version:     0.5.2
Release:     0%{?dist}
Summary:     Text User Interface for scripts

License:     GPLv3
URL:         https://github.com/sri-arjuna/tui
#Source0:     https://github.com/sri-arjuna/tui/archive/master.zip
Source0:     http://sea.fedorapeople.org/review/%{name}/%{name}-%{version}.tar.gz

BuildArch:   noarch

#Requires:    gedit
#Requires:    nano
#Requires:    w3m
Requires:    coreutils
Requires:    wget
#Requires:    xterm

%description
It does NOT try to emulate a windowed system,
as it is a Text Interface for scripts,
its output is per-line.


It enables you to write scripts which simulate a TUI
in Emergency, Multiuser and Graphical stages.
Furthermore, the TUI should work in all shells,
as long 'sh' is available.

This package offers various commands to display text
in different alignments, an 'optical interpretation'
of last exit code (status), handlers for download (wget), 'tar'
and 'dd' to display transferred amount of data.

Those commands are thought to be used in your scripts, 
'replacing' other/some calls of 'echo' and/or 'printf'.
They will give you the opportunity to place strings left,
center or right aligned.
Other commands will return strings or bool (true/false) values,
and handle the passed info to be displayed accordingly if applicable.

It is also open to customization,
and easy accessible by executing 'tui':
~/.config/tui/apps.conf
    Provides your favorite ${BROWSER,EDITOR}_{GUI_CLI} and $TERMINAL
~/.config/tui/user.conf
    Provides $USER_{NAME,EMAIL} and $DEFAULT_LICENSE[_URL]
    tui-new-script for example will re-use that information
    to provide you with 'filled in' with your values .

%prep
%setup -q -c %{name}-%{version}

%build
# nothing to do

%install
rm -rf       %{buildroot}
rm %{name}/install.sh \
	%{name}/uninstall.sh \
	%{name}/README.md \
	%{name}/build-rpm-%{name}.sh \
#	config.etc/color-org.conf \
#	%{name}/config.etc/status-org.conf \
	#%{name}/tui.spec
mkdir -p     %{buildroot}%{_bindir}/ \
                     %{buildroot}%{_mandir}/man1 \
                     %{buildroot}%{_sysconfdir}/%{name}/ \
                     %{buildroot}%{_sysconfdir}/profile.d/ \
                     %{buildroot}%{_datarootdir}/%{name}/templates \
                     %{buildroot}%{_docdir}/%{name}
mv %{name}/bin/*     %{buildroot}%{_bindir}/
mv %{name}/conf.etc/*    %{buildroot}%{_sysconfdir}/%{name}/
mv %{name}/conf.home/*     %{buildroot}%{_datarootdir}/%{name}/
mv %{name}/templates/* %{buildroot}%{_datarootdir}/%{name}/templates/
mv %{name}/docs/*    %{buildroot}%{_docdir}/%{name}
mv %{name}/man/*.1   %{buildroot}%{_mandir}/man1
mv %{name}/profile.d/tui.sh	%{buildroot}%{_sysconfdir}/profile.d/tui.sh

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)   
%doc %{_docdir}/%{name}/
%{_mandir}/man1/%{name}*.1.gz
%{_datarootdir}/%{name}/
%{_bindir}/%{name}
%{_bindir}/%{name}-*
#%{_sysconfdir}/%{name}/
#%{_sysconfdir}/profile.d/%{name}.sh

%config
%{_sysconfdir}/%{name}/
%{_sysconfdir}/profile.d/%{name}.sh


%changelog
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
