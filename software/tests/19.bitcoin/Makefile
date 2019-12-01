# # #
DEMO_NUMBER             := 19
DEMO_NAME               := bitcoin

# # #
PROJECT                 := master
PROJECT_DIR		:= $(shell pwd)

# # # Only if floppybuilder
# PROJECT_DSK		:= $(PROJECT).dsk

# # #
# CPU			:= 65816

# # # Autorun main project file
PROJECT_AUTORUN		:= 1

# # # Leave DOS
PROJECT_QUITDOS		:= 0

START_ADDRESS           := $(shell echo $$((0x0800)))

ATAPS			:= pplink
BTAPS			:= 
CTAPS			:= $(PROJECT) slave
OTHER			:= hash res/linemod

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS) $(OTHER))

common_SRC 		:= pp.s oricexos.s

$(PROJECT)_SRC		:= $(common_SRC) compat.s libsedoric.s $(PROJECT).c
$(PROJECT)_AUTORUN	:= 1
$(PROJECT)_ADDRESS	:= $(START_ADDRESS)
$(PROJECT)_ACPP		:= 1

pplink_SRC              := pplink.s pp.s oricexos.s
pplink_AUTORUN          := 1
pplink_ADDRESS          := $(shell echo $$((0x0500)))

slave_SRC               := oricexos.s slave.c 
slave_AUTORUN           := 1
slave_ADDRESS           := $(shell echo $$((0x2000)))
slave_ACPP              := 1

hash_SRC                := hash.m32
hash_AUTORUN            := 0
hash_ADDRESS            := $(shell echo $$((0x5000)))
hash_ACPP               := 0



# # # 
OSDK			:= ${HOME}/work/projects/8Bit/devtools/osdk
OSDK_OPT65		:= 0
CC65			:= ${HOME}/work/projects/8Bit/devtools/cc65
CC65_ALIGNED		:= 0
# 
TOOLCHAIN		:= CC65

# # # 
EMU 			:= ./oricutron
EMUDIR 			:= ${HOME}/work/projects/8Bit/emulators/oricutron-build
EMUARG 			:= -m a
EMUARG 			+= -k m
EMUARG 			+= --serial none
EMUARG 			+= --vsynchack off
EMUARG 			+= --scanlines off
EMUARG 			+= --rendermode opengl

# EMUPARAM              += -r $(shell echo $$(($(START_ADDRESS))))
EMUPARAM                += -s $(PROJECT_DIR)/$(PROJECT).sym 
EMUPARAM                += -s $(PROJECT_DIR)/slave.sym
EMUPARAM                += -r:$(PROJECT_DIR)/$(PROJECT).brk

COMMON                  := ../common

VPATH                   := $(VPATH) . $(COMMON)

PREPARE                 := prepare
FINALIZE                := finalize

# # #
include $($(TOOLCHAIN))/atmos.make

AFLAGS			+= $(addprefix -I,$(VPATH))
AFLAGS			+= -DASSEMBLER
AFLAGS			+= -DPPLINK_ADDRESS=$(pplink_ADDRESS)
AFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
AFLAGS			+= -DSLAVE_ADDRESS=$(slave_ADDRESS)
AFLAGS			+= -DHASH_ADDRESS=$(hash_ADDRESS)
AFLAGS			+= -DUSE_TEXT

$(PROJECT)_AFLAGS 	:= -DMASTER -DPP_MASTER
slave_AFLAGS 		:= -DSLAVE -DPP_SLAVE
pplink_AFLAGS		:= -DSLAVE -DPP_SLAVE

CFLAGS			+= $(addprefix -I,$(VPATH))
CFLAGS			+= -DPPLINK_ADDRESS=$(pplink_ADDRESS)
CFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
CFLAGS			+= -DSLAVE_ADDRESS=$(slave_ADDRESS)
CFLAGS			+= -DHASH_ADDRESS=$(hash_ADDRESS)
CFLAGS			+= -DUSE_TEXT

$(PROJECT)_CFLAGS 	:= -DMASTER -DPP_MASTER
slave_CFLAGS 		:= -DSLAVE -DPP_SLAVE
pplink_CFLAGS		:= -DSLAVE -DPP_SLAVE

LFLAGS			+=
$(PROJECT)_LFLAGS 	:=
slave_LFLAGS 		:= 

TEMP_FILES 		+= *.HFE *.hfe $(PROJECT).tap hash.tap hash

prepare:
	@echo "Building with $(TOOLCHAIN) ..."

finalize: hxc
	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@cp -f $(PROJECT).dsk ../$(DEMO_NUMBER).$(DEMO_NAME).dsk
	@cp -f $(PROJECT)_dsk.hfe ../$(DEMO_NUMBER).$(DEMO_NAME).hfe
	@printf "[MEM]   pplink: #%.4X .. #%.4X\\n" $$(($(pplink_ADDRESS))) $$(expr `cat pplink | wc -c` + $$(($(pplink_ADDRESS))))
	@printf "[MEM]   master: #%.4X .. #%.4X\\n" $$(($(master_ADDRESS))) $$(expr `cat master | wc -c` + $$(($(master_ADDRESS))))
	@printf "[MEM]   slave : #%.4X .. #%.4X\\n" $$(($(slave_ADDRESS))) $$(expr `cat slave | wc -c` + $$(($(slave_ADDRESS))))
	@printf "[MEM]   hash  : #%.4X .. #%.4X\\n" $$(($(hash_ADDRESS))) $$(expr `cat hash | wc -c` + $$(($(hash_ADDRESS))))
	@echo "Done"


# # # 
# Oricutron callers
# make gom - go master
# make gos1 - go slave 1
# make gos2 - go slave 4
# make gos3 - go slave 3

SLAVE_TAP=slave.tap
include ../../emulator.rules

MERLIN32_TEMP := _FileInformation.txt *_Output.txt
MERLIN32_SILENT := $(SILENT)

%.tap: %.m32
	@echo -n "[M32]   $< -> $(shell echo $<|sed -e 's/\.m32//g')"
	@$(MERLIN32) $< $(MERLIN32_SILENT) && echo
	@mv -f $(shell echo $<|tr [a-z] [A-Z]|sed -e 's/\.M32//g') $(shell echo $<|sed -e 's/\.m32//g')
	@rm -f $(MERLIN32_TEMP)
	@echo -n "[HDR]   $< -> $@ : "
	@$(OSDK)/bin/header2 -4 -n$(shell echo $<|sed -e 's/\.m32//g') -a0 $(shell echo $<|sed -e 's/\.m32//g') $@ $($(shell echo $<|sed -e 's/\.m32//g')_ADDRESS)|awk '{ print $$11" "$$12  };' 
	@echo "[TAP]   $@ : CALL#$(shell printf "%X" $($(shell echo $<|sed -e 's/\.m32//g')_ADDRESS))"
