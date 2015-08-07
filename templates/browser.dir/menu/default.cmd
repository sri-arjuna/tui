tui-bol-root && \
	tui-status "$?" "You are root -- shown by $0" || \
	tui-status "$?" "You are $USER -- shown by $0"