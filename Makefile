DEST:=.build
RELEASES:=./releases

##########################################################################
##########################################################################

TASS:=64tass --m65xx --nostart -Wall -Wno-implied-reg -q
BOOTDRIVE:=../../beeb/beeb-files/stuff/65boot/0
BEDRIVE:=../../beeb/beeb-files/stuff/basic_editor/0

.PHONY:build
build: VER?=$(shell date '+%Y-%m-%d %H:%M:%S')
build:
	mkdir -p $(DEST)

	@$(MAKE) _assemble BUILD_TYPE=0 VER=_ STEM=basiced_
	@$(MAKE) _assemble BUILD_TYPE=4 VER=_ STEM=basiced_type4
	@$(MAKE) _assemble BUILD_TYPE=0 "VER=$(VER)" STEM=basiced
	@$(MAKE) _assemble BUILD_TYPE=1 "VER=$(VER)" STEM=hibasiced

	@$(MAKE) _copy STEM=basiced DRIVE=$(BOOTDRIVE) BBC=R.BETOM
	@$(MAKE) _copy STEM=hibasiced DRIVE=$(BOOTDRIVE) BBC=R.HBETOM
	@$(MAKE) _copy STEM=basiced DRIVE=$(BEDRIVE) BBC=R.BETOM
	@$(MAKE) _copy STEM=hibasiced DRIVE=$(BEDRIVE) BBC=R.HBETOM
	@$(MAKE) _copy STEM=basiced_type4 DRIVE=$(BEDRIVE) BBC=R.BE4TOM

	@python tools/checksize.py $(DEST)/basiced_.rom $(DEST)/basiced.rom $(DEST)/hibasiced.rom

	@sha1sum $(DEST)/basiced_.rom

##########################################################################
##########################################################################

.PHONY:_copy
_copy:
	@test -d $(DRIVE) && cp -v $(DEST)/$(STEM).rom $(DRIVE)/$(BBC) && touch $(DRIVE)/$(BBC).inf

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
