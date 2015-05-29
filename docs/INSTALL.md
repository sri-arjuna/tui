Installation from Tarball or GIT repositry:
-------------------------------------------
Fedora Repositry see at bottom.
The paths used here are what i have come to known as the most default paths on most unix-like systems around.
Expections and custom/individual preferences granted, thus the change to the use of the RC file.


Download tarball:
        cd
        wget http://sea.fedorapeople.org/Review/tui/tui-0.4.0.tar.gz
        tar -axf tui*
        cd tui
Download zipfile from Github:
        cd
        wget https://github.com/sri-arjuna/tui/archive/master.zip
        unzip master.zip
        cd tui-master
Download from GIT repositry:
        cd
        git clone https://github.com/sri-arjuna/tui.git tui
        cd tui


Solaris users only!
--------------------
Before installing TUI, please adjust the 'awk' setting in **./conf.etc/commands.conf** before installing it.


Install and uninstall using provided scripts
--------------------------------------------
Using the **install.sh** script will provide different default paths upon wether the executer is root or regular user.
I highly recomend to use either one of the suggested paths, however, you may change those paths by prefixing the below commands with:
	su
	CHROOT=/usr/local PREFIX=/usr/local ./install.sh
	
If you agree on the default install, you could run now:
	sudo ./install.sh
or	
	su
	./install.sh

To update from the tarball, or from a pull'd git repositry, just rerun the install script like:
	cd /path/to/files
	echo y n | sudo ./install.sh

Install manually
---------------
Create the target directories (if required):
        mkdir -p /etc/tui /usr/bin /usr/share/{man/man1,doc/tui,tui,bash-completions/completions}

Then copy all files to their supposed places:
        cp -r ./docs/*             /usr/share/doc/tui/
	cp -r ./conf.home          /usr/share/tui/
        cp -r ./conf.etc           /usr/share/tui/
	cp ./conf.etc/*            /etc/tui/
        cp ./bin/*                 /usr/bin/
        cp ./man/*1                /usr/share/man/man1/
	cp ./tui_compl.bash        /usr/share/bash-completions/completions/


Install from Fedora Repositry:
---------------------------
        su -
        cd /etc/yum.repos.d
        wget http://sea.fedorapeople.org/sea-devel.repo -O sea-devel.repo
        dnf install tui
