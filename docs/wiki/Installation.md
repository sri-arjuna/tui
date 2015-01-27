Installing TUI to your system is an easy task of 2 steps:

Fedora (_any_ RH based linux) users can use the repositry:

    sudo wget -O /etc/yum.repos.d/sea-devel.repo \
                 https://sea.fedorapeople.org/sea-devel.repo
    sudo yum install tui

All other can use **git**:

    sudo git clone https://github.com/sri-arjuna/tui.git /tmp/tui.inst
    cd /tmp/tui.inst
    sudo sh ./install.sh

Of course, **wget** could work too:

    wget "https://github.com/sri-arjuna/tui/archive/master.zip"
    unzip master.zip
    cd tui-master
    sudo sh ./install.sh