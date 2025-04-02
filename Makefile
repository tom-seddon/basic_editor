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

TASSCMD:=64tass --m65xx --nostart -Wall -Wno-implied-reg -q --long-branch --case-sensitive

.PHONY:build
build: VER:=$(shell $(SHELLCMD) strftime -d _ '_Y-_m-_d _H:_M:_S')
build: _make_output_folders
	$(_V)$(MAKE) _assemble BUILD_TYPE=4 VER= STEM=basiced_type4
	$(_V)$(MAKE) _assemble BUILD_TYPE=0 "VER=$(VER)" STEM=basiced
	$(_V)$(MAKE) _assemble BUILD_TYPE=1 "VER=$(VER)" STEM=hibasiced
	$(_V)$(MAKE) _assemble BUILD_TYPE=8 "VER=$(VER)" STEM=elkbasiced
	$(_V)$(MAKE) _assemble BUILD_TYPE=9 "VER=$(VER)" STEM=elkhibasiced
	$(_V)$(MAKE) _assemble BUILD_TYPE=2 "VER=$(VER)" STEM=rbasiced
	$(_V)$(MAKE) _assemble BUILD_TYPE=3 "VER=$(VER)" STEM=rbasiced2

	$(_V)$(MAKE) _copy STEM=basiced DRIVE=$(DRIVE) BBC=R.BETOM
	$(_V)$(MAKE) _copy STEM=hibasiced DRIVE=$(DRIVE) BBC=R.HBETOM
	$(_V)$(MAKE) _copy STEM=elkbasiced DRIVE=$(DRIVE) BBC=R.EBETOM
	$(_V)$(MAKE) _copy STEM=elkhibasiced DRIVE=$(DRIVE) BBC=R.EHBETOM
	$(_V)$(MAKE) _copy STEM=basiced_type4 DRIVE=$(DRIVE) BBC=R.BE4TOM
#	$(_V)$(MAKE) _copy STEM=rbasiced DRIVE=$(DRIVE) BBC=R.BE4TOMR

	$(_V)$(PYTHON) submodules/beeb/bin/tube_relocation.py create -o $(DEST)/rbasiced.relocation.dat $(DEST)/rbasiced.rom $(DEST)/rbasiced2.rom 

	$(_V)$(SHELLCMD) stat --size-budget=16384 $(DEST)/basiced_.rom $(DEST)/basiced.rom $(DEST)/hibasiced.rom $(DEST)/elkbasiced.rom $(DEST)/elkhibasiced.rom $(DEST)/rbasiced.rom
	$(_V)$(SHELLCMD) stat $(DEST)/rbasiced.relocation.dat

	$(_V)$(SHELLCMD) sha1 "--ignore=$(VER)" $(DEST)/basiced.rom

##########################################################################
##########################################################################

.PHONY:_make_output_folders
_make_output_folders:
	$(_V)$(SHELLCMD) mkdir $(DEST) $(DRIVE)

##########################################################################
##########################################################################

.PHONY:_copy
_copy:
	$(_V)$(SHELLCMD) copy-file $(DEST)/$(STEM).rom $(DRIVE)/$(BBC)

##########################################################################
##########################################################################

.PHONY:_assemble
_assemble:
	$(_V)$(TASSCMD) -D BUILD_TYPE=$(BUILD_TYPE) -D "VER=\"$(VER)\"" basiced.s65 -L$(DEST)/$(STEM).lst -o$(DEST)/$(STEM).rom -l$(DEST)/$(STEM).sym

##########################################################################
##########################################################################

# .PHONY:release
# release: VER=$(error must set VER)
# release:
# 	$(_V)$(SHELLCMD) rm-tree $(RELEASES)/$(VER)
# 	$(_V)$(SHELLCMD) mkdir $(RELEASES)/$(VER)
# 	$(_V)$(MAKE) build
# 	$(_V)$(SHELLCMD) copy-file $(DEST)/basiced.rom $(RELEASES)/$(VER)/
# 	$(_V)$(SHELLCMD) copy-file $(DEST)/hibasiced.rom $(RELEASES)/$(VER)/
# 	$(_V)$(SHELLCMD) copy-file $(DEST)/elkbasiced.rom $(RELEASES)/$(VER)/
# 	$(_V)$(SHELLCMD) copy-file $(DEST)/elkhibasiced.rom $(RELEASES)/$(VER)/
# 	$(_V)$(SHELLCMD) copy-file $(DEST)/rbasiced.rom $(RELEASES)/$(VER)/
# 	$(_V)$(SHELLCMD) copy-file $(DEST)/rbasiced.relocation.dat $(RELEASES)/$(VER)/

##########################################################################
##########################################################################

.PHONY:clean
clean:
	$(_V)$(SHELLCMD) rm-tree $(DEST)

##########################################################################
##########################################################################

.PHONY:_pres_stuff
_pres_stuff: _make_output_folders
	$(_V)$(MAKE) _pres_butils_assemble STEM=butils FLAG=baseds1_version
	$(_V)$(MAKE) _pres_butils_assemble STEM=butils2 FLAG=baseds1_all_version
	$(_V)$(MAKE) _pres_butils_assemble STEM=butils_elk FLAG=baseds1_elk_version
	$(_V)$(MAKE) _pres_butils_assemble STEM=butils_abe FLAG=abe_version

	$(SHELLCMD) cmp "$(DEST)/butils.rom" "./beeb/1/$$.ELECTRON"
	$(SHELLCMD) cmp "$(DEST)/butils2.rom" "./beeb/1/$$.ELECTRON2"
# Don't compare butils_elk.rom. It won't match.
	$(SHELLCMD) cmp "$(DEST)/butils_abe.rom" "./pres/ABE.0.rom"

	$(_V)$(MAKE) _pres_bedit_assemble STEM=bedit_acornsoft FLAG=acornsoft_version
	$(SHELLCMD) cmp "$(DEST)/bedit_acornsoft.rom" "./old_releases/1.32_original/basiced.rom"

	$(_V)$(MAKE) _pres_bedit_assemble STEM=bedit_bet2 FLAG=bet2_version
	$(SHELLCMD) cmp "$(DEST)/bedit_bet2.rom" "./pres/BET2.0.rom"

.PHONY:_pres_beditor_assemble
_pres_bedit_assemble: STEM=$(error must specify STEM)
_pres_bedit_assemble: FLAG=$(error must specify FLAG)
_pres_bedit_assemble: _TASS:=$(TASS) -Wall --nostart -q -Wno-implied-reg
_pres_bedit_assemble:
	$(_V)$(_TASS) "./pres/bedit/pres_bedit.s65" "-D$(FLAG)=true" "-o$(DEST)/$(STEM).rom" "-L$(DEST)/$(STEM).lst"

.PHONY:_pres_butils_assemble
_pres_butils_assemble: STEM=$(error must specify STEM)
_pres_butils_assemble: FLAG=$(error must specify FLAG)
_pres_butils_assemble: _TASS:=$(TASS) --case-sensitive -Wall --nostart -q
_pres_butils_assemble:
	$(_V)$(_TASS) "./pres/butils/pres_butils.s65" "-D$(FLAG)=true" "-o$(DEST)/$(STEM).rom" "-L$(DEST)/$(STEM).lst"

##########################################################################
##########################################################################

.PHONY:_pres_stuff_2
_pres_stuff_2: _make_output_folders
	$(_V)$(PYTHON) "submodules/beeb/bin/convert_ddtmass.py" "./beeb/1/$$.!MAKROM" -o "$(DEST)/butils_conv.s65"
	$(_V)64tass --case-sensitive -Wall --nostart "$(DEST)/butils_conv.s65" "-o$(DEST)/butils_conv.rom" "-L$(DEST)/butils_conv.lst"
	$(SHELLCMD) cmp "$(DEST)/butils_conv.rom" "./beeb/1/$$.ELECTRON2"

##########################################################################
##########################################################################

.PHONY:_tom_emacs
_tom_emacs:
	$(_V)$(MAKE) build


