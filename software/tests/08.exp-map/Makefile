# # #
DEMO_NUMBER             := 08
DEMO_NAME               := exp-map

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

ATAPS			:= slave
BTAPS			:= 
CTAPS			:= $(PROJECT)

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS))

common_SRC 		:= compat.s pp.s oricexos.s

$(PROJECT)_SRC		:= $(common_SRC) libsedoric.s $(PROJECT).c
$(PROJECT)_AUTORUN	:= 1
$(PROJECT)_ADDRESS	:= $(START_ADDRESS)

slave_SRC               := slave.s $(common_SRC)
slave_AUTORUN           := 1
slave_ADDRESS           := $(shell echo $$((0x2000)))

OSDK			:= ${HOME}/work/projects/8Bit/devtools/osdk
CC65			:= ${HOME}/work/projects/8Bit/devtools/cc65
TOOLCHAIN		:= CC65

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

# 
.PHONY: gom gos1 gos2 gos3

# use atmos config to run as master
gom: all
	@oric -ma -km -r:$(PROJECT_DIR)/$(PROJECT).brk \
        -s $(PROJECT_DIR)/$(PROJECT).sym \
        -s $(PROJECT_DIR)/slave.sym $(PROJECT_DIR)/master.dsk

# use oric-1 config to run as slave 1
gos1: all
	@oric -m1 -kn -r:$(PROJECT_DIR)/$(PROJECT).brk \
        -s $(PROJECT_DIR)/$(PROJECT).sym \
        -s $(PROJECT_DIR)/slave.sym $(PROJECT_DIR)/slave.tap

# use pravetz config to run as slave 2
gos2: all
	@oric -mp -kn -r:$(PROJECT_DIR)/$(PROJECT).brk \
        -s $(PROJECT_DIR)/$(PROJECT).sym \
        -s $(PROJECT_DIR)/slave.sym $(PROJECT_DIR)/slave.tap

# use telestrat config to run as slave 3
gos3: all
	@oric -mt -kn -r:$(PROJECT_DIR)/$(PROJECT).brk \
        -s $(PROJECT_DIR)/$(PROJECT).sym \
        -s $(PROJECT_DIR)/slave.sym $(PROJECT_DIR)/slave.tap
