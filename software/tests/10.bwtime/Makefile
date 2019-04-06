# # #
DEMO_NUMBER             := 10
DEMO_NAME               := bwtime

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

START_ADDRESS           := $(shell echo $$((0x0700)))

ATAPS			:= pplink slave-01 slave
BTAPS			:= 
CTAPS			:= $(PROJECT)

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS))

common_SRC 		:= compat.s pp.s oricexos.s

$(PROJECT)_SRC		:= $(common_SRC) libsedoric.s $(PROJECT).c
$(PROJECT)_AUTORUN	:= 1
$(PROJECT)_ADDRESS	:= $(START_ADDRESS)

pplink_SRC              := pplink.s pp.s oricexos.s
pplink_AUTORUN          := 0
pplink_ADDRESS          := $(shell echo $$((0x0400)))

slave-01_SRC            := slave-01.s oricexos.s
slave-01_AUTORUN        := 0
slave-01_ADDRESS        := $(shell echo $$((0x0680)))

slave_SRC               := slave.s
slave_AUTORUN           := 0
slave_ADDRESS           := $(shell echo $$((0x2000)))

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
AFLAGS			+= -DSLAVE_01_ADDRESS=$(slave-01_ADDRESS)
AFLAGS			+= -DSLAVE_ADDRESS=$(slave_ADDRESS)
AFLAGS			+= -DPPLINK_ADDRESS=$(pplink_ADDRESS)
AFLAGS			+= -DUSE_HIRES

$(PROJECT)_AFLAGS 	:= -DPP_MASTER
pplink_AFLAGS		:= -DPP_SLAVE
slave-01_AFLAGS		:=
slave_AFLAGS		:= -DNO_ROM

CFLAGS			+= $(addprefix -I,$(VPATH))
CFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
CFLAGS			+= -DSLAVE_01_ADDRESS=$(slave-01_ADDRESS)
CFLAGS			+= -DSLAVE_ADDRESS=$(slave_ADDRESS)
CFLAGS			+= -DPPLINK_ADDRESS=$(pplink_ADDRESS)

$(PROJECT)_CFLAGS 	:=
pplink_CFLAGS		:=
slave-01_CFLAGS		:=
slave_CFLAGS		:= -DNO_ROM

LFLAGS			+=

$(PROJECT)_LFLAGS 	:=
pplink_LFLAGS		:=
slave-01_LFLAGS		:=
slave_LFLAGS		:=

TEMP_FILES 		+= *.HFE *.hfe $(PROJECT).tap

prepare:
	@echo "Building..."

finalize: hxc
	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@cp -f $(PROJECT).dsk ../$(DEMO_NUMBER).$(DEMO_NAME).dsk
	@cp -f $(PROJECT)_dsk.hfe ../$(DEMO_NUMBER).$(DEMO_NAME).hfe
	@printf "[MEM]   master   : #%.4X .. #%.4X\\n" $$(($(master_ADDRESS))) $$(expr `cat master | wc -c` + $$(($(master_ADDRESS))))
	@printf "[MEM]   pplink   : #%.4X .. #%.4X\\n" $$(($(pplink_ADDRESS))) $$(expr `cat pplink | wc -c` + $$(($(pplink_ADDRESS))))
	@printf "[MEM]   slave-01 : #%.4X .. #%.4X\\n" $$(($(slave-01_ADDRESS))) $$(expr `cat slave | wc -c` + $$(($(slave-01_ADDRESS))))
	@printf "[MEM]   slave    : #%.4X .. #%.4X\\n" $$(($(slave_ADDRESS))) $$(expr `cat slave | wc -c` + $$(($(slave_ADDRESS))))
	@echo "Done"

# 
.PHONY: gom gos1 gos2 gos3 goplink

gopplink: all
	@oric -ma -kn -r:$(PROJECT_DIR)/$(PROJECT).brk \
        -s $(PROJECT_DIR)/pplink.sym pplink.tap

# use atmos config to run as master
gom: all
	@oric -ma -km -r:$(PROJECT_DIR)/$(PROJECT).brk \
        -s $(PROJECT_DIR)/$(PROJECT).sym master.dsk

# use oric-1 config to run as slave 1
gos1: all
	@oric -m1 -kn -r:$(PROJECT_DIR)/$(PROJECT).brk \
        -s $(PROJECT_DIR)/$(PROJECT).sym \
        -s $(PROJECT_DIR)/slave.sym slave.tap

# use pravetz config to run as slave 2
gos2: all
	@oric -mp -kn -r:$(PROJECT_DIR)/$(PROJECT).brk \
        -s $(PROJECT_DIR)/$(PROJECT).sym \
        -s $(PROJECT_DIR)/slave.sym slave.tap

# no more config to run as slave 3
gos3:
	@echo "no more config to run as slave 3"
