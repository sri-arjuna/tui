This document is about how to install TUI (0.9.0 or later), which is copyrighted by the GPLv3 (or later).

INSTALL
-------

1. The installation procedure is very simple, first log in as root, and change to the base source directory.

        su
        cd /usr/src

2. Clone the source code into a sub directory and change to it.

        git clone https://github.com/sri-arjuna/tui.git
        cd tui

3. Use the auto-tools behaviour, provided by [YASSI (Yet Another Simple Script Installer)](https://github.com/sri-arjuna/yassi)

        ./configure [--prefix=/usr] [--chroot=$HOME/buildroot]


You may then call either

        make && sudo make install-all

or

        ./make
        sudo ./make-install-all



UNINSTALL
---------

1. Change to the source dir as root.

        su
        cd /usr/src/tui

2. Use the auto-tools behaviour by either invoking:


        make uninstall

or

        ./make-uninstall




