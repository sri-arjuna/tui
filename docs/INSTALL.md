Installation from Tarball or GIT repositry:
-------------------------------------------
Fedora Repositry see at bottom.


Download Tarball:
        cd
        wget http://sea.fedorapeople.org/Review/tui/tui-0.4.0.tar.gz
        tar -axf tui*
        cd tui
Download Github:
        cd
        wget https://github.com/sri-arjuna/tui/archive/master.zip
        unzip master
        cd tui
Download Repositry:
        cd
        git clone https://github.com/sri-arjuna/tui.git tui
        cd tui


Setup from Tarball & Repositry:
-------------------------------
Create the target directories (if required):
        mkdir -p /etc/tui /usr/bin /usr/share/{man,man1,doc/tui,tui}

And copy all files to their supposed places:
        cp ./docs/user.conf        /usr/share/tui/
        cp ./bin/*                 /usr/bin/
        cp ./conf/*                /etc/tui
        cp ./docs/*                /usr/share/doc/tui/
        cp ./man/*1                /usr/share/man/man1/
        cp ./profile.d/*        /etc/profile.d/


Setup for Fedora Repositry:
---------------------------
        su -
        cd /etc/yum.repos.d
        wget http://sea.fedorapeople.org/all.repo -O sea-current.repo
        yum install tui
