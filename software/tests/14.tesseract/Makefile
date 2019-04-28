# # #
DEMO_NUMBER             := 14
DEMO_NAME               := tesseract

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

START_ADDRESS           := $(shell echo $$((0x0600)))

ATAPS			:= 
BTAPS			:= 
CTAPS			:= $(PROJECT) slave

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS))

common_SRC 		:= pp.s oricexos.s

$(PROJECT)_SRC		:= $(common_SRC) compat.s libsedoric.s $(PROJECT).c
$(PROJECT)_AUTORUN	:= 1
$(PROJECT)_ADDRESS	:= $(START_ADDRESS)
$(PROJECT)_ACPP		:= 1

slave_SRC 		:= slave.c charmap.s draw.s random.s inlay.s
slave_AUTORUN		:= 1
slave_ADDRESS		:= $(shell echo $$((0x2000)))
slave_ACPP		:= 1

# # # 
OSDK			:= ${HOME}/work/projects/8Bit/devtools/osdk
OSDK_OPT65		:= 0
CC65			:= ${HOME}/work/projects/8Bit/devtools/cc65
CC65_ALIGNED		:= 0
# 
TOOLCHAIN		:= OSDK

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
AFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
AFLAGS			+= -DSLAVE_ADDRESS=$(slave_ADDRESS)
AFLAGS			+= -DUSE_TEXT

$(PROJECT)_AFLAGS 	:= -DPP_MASTER
slave_AFLAGS 		:= -DPP_SLAVE

CFLAGS			+= $(addprefix -I,$(VPATH))
CFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
CFLAGS			+= -DSLAVE_ADDRESS=$(slave_ADDRESS)

$(PROJECT)_CFLAGS 	:= -DPP_MASTER
slave_CFLAGS 		:= -DPP_SLAVE

LFLAGS			+=
$(PROJECT)_LFLAGS 	:=
slave_LFLAGS 		:= 

TEMP_FILES 		+= *.HFE *.hfe $(PROJECT).tap

prepare:
	@echo "Building..."

finalize: hxc
	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@cp -f $(PROJECT).dsk ../$(DEMO_NUMBER).$(DEMO_NAME).dsk
	@cp -f $(PROJECT)_dsk.hfe ../$(DEMO_NUMBER).$(DEMO_NAME).hfe
	@printf "[MEM]   master: #%.4X .. #%.4X\\n" $$(($(master_ADDRESS))) $$(expr `cat master | wc -c` + $$(($(master_ADDRESS))))
	@printf "[MEM]   slave : #%.4X .. #%.4X\\n" $$(($(slave_ADDRESS))) $$(expr `cat slave | wc -c` + $$(($(slave_ADDRESS))))
	@echo "Done"


# # # 
# Oricutron callers
# make gom - go master
# make gos1 - go slave 1
# make gos2 - go slave 4
# make gos3 - go slave 3

SLAVE_TAP=slave.tap
include ../../emulator.rules
