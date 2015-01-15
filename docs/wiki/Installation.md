Installing TUI to your system is an easy task of 2 steps:

Fedora users can use the repositry:

    sudo wget -O /etc/yum.repos.d/sea-devel.repo \
                 https://sea.fedorapeople.org/sea-devel.repo
    sudo yum install tui

All other can use git:

    sudo git clone https://github.com/sri-arjuna/tui.git /tmp/tui.inst
    sudo sh /tmp/tui.inst/install.sh

