-include config.mk

SUBDIRS	= include lib bin

ifdef BUILD_API_DOCS
SUBDIRS += doc
endif

.PHONY: all
all:
	@for dir in $(SUBDIRS); do		\
		$(MAKE) -C $$dir || exit 1;	\
	done

.PHONY: install
install:
	@for dir in $(SUBDIRS); do		\
		$(MAKE) -C $$dir install || exit 1;	\
	done
	@echo
	@echo "Binaries have been installed into $(DESTDIR)$(SBINDIR)."
	@echo "Librares have been installed into $(DESTDIR)$(LIBDIR)."
	@echo
	@echo "WARNING: Don't forget to rerun ldconfig(1)."
	@echo

.PHONY: uninstall
uninstall:
	@for dir in $(SUBDIRS); do		\
		$(MAKE) -C $$dir uninstall || exit 1;	\
	done

.PHONY: clean
clean:
	@for dir in $(SUBDIRS); do		\
		$(MAKE) -C $$dir clean || exit 1;	\
	done
	-rm -f config.h config.mk

dist:
ifndef REV
	@echo "Please specify revision/tag with REV, i.e:"
	@echo " > make REV=0.6.1 dist"
	@exit 1
endif
	@echo "Building distribution tarball for revision/tag: $(REV) ..."
	-@hg archive --rev $(REV) --type tgz ~/xbps-$(REV).tar.gz
