DEST:=.build
RELEASES:=./releases
DRIVE:=./beeb/0

##########################################################################
##########################################################################

TASS:=64tass --m65xx --nostart -Wall -Wno-implied-reg -q

.PHONY:build
build: VER?=$(shell date '+%Y-%m-%d %H:%M:%S')
build:
	mkdir -p $(DEST) $(DRIVE)

	@$(MAKE) _assemble BUILD_TYPE=0 VER=_ STEM=basiced_
	@$(MAKE) _assemble BUILD_TYPE=4 VER=_ STEM=basiced_type4
	@$(MAKE) _assemble BUILD_TYPE=0 "VER=$(VER)" STEM=basiced
	@$(MAKE) _assemble BUILD_TYPE=1 "VER=$(VER)" STEM=hibasiced

	@$(MAKE) _copy STEM=basiced DRIVE=$(DRIVE) BBC=R.BETOM
	@$(MAKE) _copy STEM=hibasiced DRIVE=$(DRIVE) BBC=R.HBETOM
	@$(MAKE) _copy STEM=basiced_type4 DRIVE=$(DRIVE) BBC=R.BE4TOM

	@python tools/checksize.py $(DEST)/basiced_.rom $(DEST)/basiced.rom $(DEST)/hibasiced.rom

	@sha1sum $(DEST)/basiced_.rom

##########################################################################
##########################################################################

.PHONY:_copy
_copy:
	cp -v $(DEST)/$(STEM).rom $(DRIVE)/$(BBC)
	touch $(DRIVE)/$(BBC).inf

##########################################################################
##########################################################################

.PHONY:_assemble
_assemble:
	$(TASS) -D BUILD_TYPE=$(BUILD_TYPE) -D "VER=\"$(VER)\"" basiced.s65 -L$(DEST)/$(STEM).lst -o$(DEST)/$(STEM).rom -l$(DEST)/$(STEM).sym

##########################################################################
##########################################################################

.PHONY:release
release:
	test -n "$(VER)" # VER variable must be set.
	rm -Rvf $(RELEASES)/$(VER)
	mkdir -p $(RELEASES)/$(VER)
	$(MAKE) build
	cp $(DEST)/basiced.rom $(RELEASES)/$(VER)/
	cp $(DEST)/hibasiced.rom $(RELEASES)/$(VER)/

##########################################################################
##########################################################################

.PHONY:clean
clean:
	rm -Rf $(DEST)
