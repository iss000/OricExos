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
BTAPS			:= $(PROJECT)
CTAPS			:=

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS))

common_SRC 		:=

$(PROJECT)_SRC 		:= master.txt
$(PROJECT)_AUTORUN	:= 1

master-helper_SRC 	:= master-helper.s
master-helper_AUTORUN	:= 0
master-helper_ADDRESS	:= $(shell echo $$((0x0f00)))

slave_SRC 		:= slave.s
slave_AUTORUN		:= 0
slave_ADDRESS		:= $(shell echo $$((0x1000)))

slave-debug_SRC 	:= slave.s
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

COMMON			:= ${HOME}/work/projects/8Bit/work/common

START_ADDRESS		:= $(shell echo $$((0x1000)))

VPATH           	:= $(VPATH) $(COMMON)

PREPARE			:= prepare
FINALIZE		:= finalize

# # #
include $($(TOOLCHAIN))/atmos.make

AFLAGS			+= -DASSEMBLER
AFLAGS			+= -I$(COMMON)
$(PROJECT)_AFLAGS 	:=

CFLAGS			+= -I$(COMMON)
CFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
$(PROJECT)_CFLAGS 	:=

LFLAGS			+=
$(PROJECT)_LFLAGS 	:=

TEMP_FILES 		+= *.HFE *.hfe bars-demo.tap

prepare:
	@echo "Building..."

finalize: hxc
	@cp -f $(PROJECT)_dsk.hfe 02.bars-demo.hfe
	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@cat $(PROJECT).tap slave.tap > bars-demo.tap
# 	@cp -f bars-demo.tap ../02.bars-demo.tap
	@cp -f $(PROJECT).dsk ../02.bars-demo.dsk
	@echo "Done"

# 
.PHONY: gom gos1 gos2

gom: all
	@oric -ma -r:$(PROJECT_DIR)/$(PROJECT).brk \
	-s $(PROJECT_DIR)/$(PROJECT).sym \
	-s $(PROJECT_DIR)/slave.sym bars-demo.tap

gos1: all
	@oric -m1 -r:$(PROJECT_DIR)/$(PROJECT).brk \
	-s $(PROJECT_DIR)/$(PROJECT).sym \
	-s $(PROJECT_DIR)/slave.sym slave-debug.tap

gos2: all
	@oric -mp -r:$(PROJECT_DIR)/$(PROJECT).brk \
	-s $(PROJECT_DIR)/$(PROJECT).sym \
	-s $(PROJECT_DIR)/slave.sym slave-debug.tap
