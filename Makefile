ifeq ($(OS),Windows_NT)
TASS?=tools\64tass.exe
PYTHON?=py -3
else
TASS?=64tass
PYTHON?=python3
endif

##########################################################################
##########################################################################

ifeq ($(VERBOSE),1)
_V:=
else
_V:=@
endif

##########################################################################
##########################################################################

DEST:=.build
RELEASES:=./releases
DRIVE:=./beeb/0
SHELLCMD:=$(PYTHON) submodules/shellcmd.py/shellcmd.py

##########################################################################
##########################################################################

TASS:=64tass --m65xx --nostart -Wall -Wno-implied-reg -q --long-branch

.PHONY:build
build: VER:=$(shell $(SHELLCMD) strftime -d _ '_Y-_m-_d _H:_M:_S')
build:
	$(_V)$(SHELLCMD) mkdir $(DEST)
	$(_V)$(SHELLCMD) mkdir $(DRIVE)

	$(_V)$(MAKE) _assemble BUILD_TYPE=4 VER= STEM=basiced_type4
	$(_V)$(MAKE) _assemble BUILD_TYPE=0 "VER=$(VER)" STEM=basiced
	$(_V)$(MAKE) _assemble BUILD_TYPE=1 "VER=$(VER)" STEM=hibasiced
	$(_V)$(MAKE) _assemble BUILD_TYPE=8 "VER=$(VER)" STEM=elkbasiced
	$(_V)$(MAKE) _assemble BUILD_TYPE=9 "VER=$(VER)" STEM=elkhibasiced

	$(_V)$(MAKE) _copy STEM=basiced DRIVE=$(DRIVE) BBC=R.BETOM
	$(_V)$(MAKE) _copy STEM=hibasiced DRIVE=$(DRIVE) BBC=R.HBETOM
	$(_V)$(MAKE) _copy STEM=elkbasiced DRIVE=$(DRIVE) BBC=R.EBETOM
	$(_V)$(MAKE) _copy STEM=elkhibasiced DRIVE=$(DRIVE) BBC=R.EHBETOM
	$(_V)$(MAKE) _copy STEM=basiced_type4 DRIVE=$(DRIVE) BBC=R.BE4TOM

	$(_V)$(SHELLCMD) stat --size-budget=16384 $(DEST)/basiced_.rom $(DEST)/basiced.rom $(DEST)/hibasiced.rom $(DEST)/elkbasiced.rom $(DEST)/elkhibasiced.rom

	$(_V)$(SHELLCMD) sha1 "--ignore=$(VER)" $(DEST)/basiced.rom

##########################################################################
##########################################################################

.PHONY:_copy
_copy:
	$(_V)$(SHELLCMD) copy-file $(DEST)/$(STEM).rom $(DRIVE)/$(BBC)

##########################################################################
##########################################################################

.PHONY:_assemble
_assemble:
	$(_V)$(TASS) -D BUILD_TYPE=$(BUILD_TYPE) -D "VER=\"$(VER)\"" basiced.s65 -L$(DEST)/$(STEM).lst -o$(DEST)/$(STEM).rom -l$(DEST)/$(STEM).sym

##########################################################################
##########################################################################

.PHONY:release
release: VER=$(error must set VER)
release:
	$(_V)$(SHELLCMD) rm-tree $(RELEASES)/$(VER)
	$(_V)$(SHELLCMD) mkdir $(RELEASES)/$(VER)
	$(_V)$(MAKE) build
	$(_V)$(SHELLCMD) copy-file $(DEST)/basiced.rom $(RELEASES)/$(VER)/
	$(_V)$(SHELLCMD) copy-file $(DEST)/hibasiced.rom $(RELEASES)/$(VER)/
	$(_V)$(SHELLCMD) copy-file $(DEST)/elkbasiced.rom $(RELEASES)/$(VER)/
	$(_V)$(SHELLCMD) copy-file $(DEST)/elkhibasiced.rom $(RELEASES)/$(VER)/

##########################################################################
##########################################################################

.PHONY:clean
clean:
	$(_V)$(SHELLCMD) rm-tree $(DEST)
