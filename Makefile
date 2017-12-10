prefix        := $(DESTDIR)/usr/local

bindir        := $(prefix)/bin

datarootdir   := $(prefix)/share

datadir       := $(datarootdir)

mandir        := $(datarootdir)/man
man1          := $(mandir)/man1
man1ext       := 1

INSTALL         := install
INSTALL_PROGRAM := $(INSTALL)
INSTALL_DATA    := $(INSTALL) -m 644

PROGNAME        := chext

.PHONY: install test

install:
	$(INSTALL_PROGRAM) -t $(bindir) $(PROGNAME)
	$(INSTALL_DATA) -t $(man1) $(PROGNAME).$(man1ext) 

test:
	./test.sh
