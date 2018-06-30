DEST:=.build
VER?=_

##########################################################################
##########################################################################

TASS:=64tass --m65xx --nostart -Wall -Wno-implied-reg
BOOT:=../../beeb/beeb-files/stuff/65boot/0

.PHONY:build
build:
	mkdir -p $(DEST)
	$(TASS) -D COPRO=0 basiced.s65 -L$(DEST)/basiced.lst -o$(DEST)/basiced.rom
	$(TASS) -D COPRO=1 basiced.s65 -L$(DEST)/hibasiced.lst -o$(DEST)/hibasiced.rom
#	dasm basiced.s65 -DCOPRO=2 -f3 -l$(DEST)/rbasiced_8000.lst -s$(DEST)/rbasiced_8000.sym -o$(DEST)/rbasiced_8000.rom
#	dasm basiced.s65 -DCOPRO=3 -f3 -l$(DEST)/rbasiced_b800.lst -s$(DEST)/rbasiced_b800.sym -o$(DEST)/rbasiced_b800.rom

	@test -d $(BOOT) && cp -v $(DEST)/basiced.rom $(BOOT)/RBETOM
	@test -d $(BOOT) && cp -v $(DEST)/hibasiced.rom $(BOOT)/RHBETOM

	@python tools/checksize.py $(DEST)/basiced.rom $(DEST)/hibasiced.rom
#	python checksize.py $(DEST)/rbasiced_b800.rom

	@test -f lkg/basiced.rom && md5sum $(DEST)/basiced.rom lkg/basiced.rom || true
	@test -f lkg/hibasiced.rom && md5sum $(DEST)/hibasiced.rom lkg/hibasiced.rom || true
#
#	python tools/make_reloc.py --not-emacs $(DEST)/rbasiced_8000.rom $(DEST)/rbasiced_b800.rom

##########################################################################
##########################################################################

#	python set_rom_version.py -o $(DEST)/$(VER)/zip/basiced.rom $(DEST)/basiced.rom $(VER)
#	python set_rom_version.py -o $(DEST)/$(VER)/zip/hibasiced.rom $(DEST)/hibasiced.rom $(VER)

##########################################################################
##########################################################################

