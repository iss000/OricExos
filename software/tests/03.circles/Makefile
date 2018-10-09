# # #
PROJECT 		:= master
PROJECT_DIR		:= $(shell pwd)

# # # Only if floppybuilder
# PROJECT_DSK		:= $(PROJECT).dsk

# # #
# CPU			:= 65816

# # # Autorun main project file
PROJECT_AUTORUN		:= 0

# # # Leave DOS
PROJECT_QUITDOS		:= 1

ATAPS			:= 
BTAPS			:= $(PROJECT)
CTAPS			:= slave slave-debug

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS))

common_SRC 		:=

$(PROJECT)_SRC 		:= master.txt
$(PROJECT)_AUTORUN	:= 1

slave_SRC 		:= slave.c
slave_AUTORUN		:= 0

slave-debug_SRC 	:= slave.c
slave-debug_AUTORUN	:= 1

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

TEMP_FILES 		+= DSKA0*.HFE circles-demo.tap

prepare:
	@echo "Building..."

finalize: hxc
# 	@cp -f $(PROJECT)_dsk.hfe DSKA0000.HFE
	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@cat $(PROJECT).tap slave.tap > circles-demo.tap
	@cp -f circles-demo.tap ../03.circles-demo.tap
	@echo "Done"

# 
.PHONY: gom gos1 gos2

gom: all
	@oric -ma -r:$(PROJECT_DIR)/$(PROJECT).brk \
	-s $(PROJECT_DIR)/$(PROJECT).sym \
	-s $(PROJECT_DIR)/slave.sym circles-demo.tap

gos1: all
	@oric -m1 -r:$(PROJECT_DIR)/$(PROJECT).brk \
	-s $(PROJECT_DIR)/$(PROJECT).sym \
	-s $(PROJECT_DIR)/slave.sym slave-debug.tap

gos2: all
	@oric -mp -r:$(PROJECT_DIR)/$(PROJECT).brk \
	-s $(PROJECT_DIR)/$(PROJECT).sym \
	-s $(PROJECT_DIR)/slave.sym slave-debug.tap
