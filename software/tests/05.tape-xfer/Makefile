# # #
DEMO_NUMBER		:= 05
DEMO_NAME		:= tape-xfer

# # #
PROJECT 		:= master
PROJECT_DIR		:= $(shell pwd)

# # # Only if floppybuilder
# PROJECT_DSK		:= $(PROJECT).dsk

# # #
# CPU			:= 65816

# # # Autorun main project file
PROJECT_AUTORUN		:= 1

# # # Leave DOS
PROJECT_QUITDOS		:= 0

ATAPS			:= master-helper slave slave-debug
BTAPS			:= $(PROJECT) master-tape
CTAPS			:=

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS))

common_SRC 		:=

$(PROJECT)_SRC		:= $(PROJECT).txt
$(PROJECT)_AUTORUN	:= 1

master-tape_SRC		:= master-tape.txt
master-tape_AUTORUN	:= 1

master-helper_SRC 	:= master-helper.s
master-helper_AUTORUN	:= 0
master-helper_ADDRESS	:= $(shell echo $$((0x0f00)))

slave_SRC 		:= slave.s tape.s
slave_AUTORUN		:= 0
slave_ADDRESS		:= $(shell echo $$((0x1000)))

slave-debug_SRC 	:= $(slave_SRC)
slave-debug_AUTORUN	:= 1
slave-debug_ADDRESS	:= $(shell echo $$((0x1000)))

OSDK			:= ${HOME}/work/projects/8Bit/devtools/osdk
CC65			:= ${HOME}/work/projects/8Bit/devtools/cc65
TOOLCHAIN		:= OSDK

EMU 			:= ./oricutron
EMUDIR 			:= ${HOME}/work/projects/8Bit/emulators/oricutron-build
EMUARG 			:= -m a
EMUARG 			+= -k m
EMUARG 			+= --serial none
EMUARG 			+= --vsynchack off
EMUARG 			+= --scanlines off
EMUARG 			+= --rendermode opengl

# EMUPARAM		+= -r $(shell echo $$(($(START_ADDRESS))))
EMUPARAM		+= -s $(PROJECT_DIR)/$(PROJECT).sym
EMUPARAM		+= -r:$(PROJECT_DIR)/$(PROJECT).brk

COMMON			:= ../common

START_ADDRESS		:= $(shell echo $$((0x1000)))

VPATH           	:= $(VPATH) $(COMMON) tape

PREPARE			:= prepare
FINALIZE		:= finalize

# # #
include $($(TOOLCHAIN))/atmos.make

AFLAGS			+= $(addprefix -I,$(VPATH))
AFLAGS			+= -DASSEMBLER
AFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
AFLAGS 			+= -DUSE_HIRES

$(PROJECT)_AFLAGS 	:=

CFLAGS			+= $(addprefix -I,$(VPATH))
CFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
$(PROJECT)_CFLAGS 	:=

LFLAGS			+=
$(PROJECT)_LFLAGS 	:=

TEMP_FILES 		+= *.HFE *.hfe $(PROJECT).tap $(DEMO_NAME).tap master-*.dsk

prepare:
	@echo "Building..."

finalize: hxc
	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@cat master-tape.tap slave.tap > $(DEMO_NAME).tap
	@cp -f $(DEMO_NAME).tap ../$(DEMO_NUMBER).$(DEMO_NAME).tap
# 	@cp -f $(PROJECT).dsk ../$(DEMO_NUMBER).$(DEMO_NAME).dsk
# 	@cp -f $(PROJECT)_dsk.hfe ../$(DEMO_NUMBER).$(DEMO_NAME).hfe
	@echo "Done"


# # # 
# Oricutron callers
# make gom - go master
# make gos1 - go slave 1
# make gos2 - go slave 4
# make gos3 - go slave 3

SLAVE_TAP=slave-debug.tap
include ../../emulator.rules
