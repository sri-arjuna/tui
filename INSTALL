INSTALL
-------

1. The installation procedure is very simple, first log in as root, and change to the base source 
directory.
	su
	cd /usr/src

2. Clone the source code into a subdirectory and change to it.
	git clone https://github.com/sri-arjuna/tui.git
	cd tui

3. Use the autotools behaviour
	./configure [--prefix=/] && make && make install



UNINSTALL
---------
1. Change to the source dir as root.
	su
	cd /usr/src/tui

2. Use the autotools behaviour
	make uninstall


Manual Installation
-------------------
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
