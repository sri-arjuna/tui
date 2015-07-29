AUTOMAKE_OPTIONS = gnu
SUBDIRS = bin docs conf.etc conf.home lists man templates themes
EXTRA_DIST = 

compldir = $(datadir)/bash-completion/completions
compl_DATA = @PACKAGE@_compl.bash

trcdir = /etc
trc_DATA = @PACKAGE@rc

uninstall-hook:
	rm -fr $(sysconfdir)/@PACKAGE@
	rm -fr $(datarootdir)/@PACKAGE@
	rm -fr $(docdir)
	