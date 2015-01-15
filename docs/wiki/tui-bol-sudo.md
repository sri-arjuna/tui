### tui-bol-sudo

Description:
------------

A simply coding assistant, to help you decide wether you can use sudo or not in your scripts.

Examples:
---------

    tui-bol-sudo
    case $? in
    0)    echo sudo possible or root   ;;
    1)    echo requires su    ;;
    -1)   echo sudo not installed
          exit 1
	  ;;
    esac
    
    
    if tui-bol-sudo
    then    sudo grep $USER /etc/passed
    else    su -c "grep $USER /etc/passwd"
    fi
    
    
    tui-bol-sudo && \
        sudo grep $USER /etc/passed || \
        su -c "grep $USER /etc/passwd"