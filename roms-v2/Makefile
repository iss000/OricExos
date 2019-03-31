# # #
PROJECT 		:= basic11b
PROJECT_DIR		:= $(shell pwd)

# # # Only if floppybuilder
# PROJECT_DSK		:= $(PROJECT).dsk

# # #
# CPU			:= 65816

# # # Autorun main project file
PROJECT_AUTORUN		:= 1

# # # Leave DOS
PROJECT_QUITDOS		:= 1

ATAPS			:= $(PROJECT) $(PROJECT)-boot
BTAPS			:=
CTAPS			:=

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS))

START_ADDRESS		:= $(shell echo $$((0xc000)))

common_SRC 		:=

$(PROJECT)_SRC 		:= $(PROJECT).s
$(PROJECT)_AUTORUN	:= 1
$(PROJECT)_ADDRESS	:= $(START_ADDRESS)
$(PROJECT)_ACPP		:= 1

$(PROJECT)-boot_SRC 	:= $(PROJECT)-boot.s
$(PROJECT)-boot_AUTORUN	:= 1
$(PROJECT)-boot_ADDRESS	:= $(START_ADDRESS)
$(PROJECT)-boot_ACPP	:= 1

OSDK			:= ${HOME}/work/projects/8Bit/devtools/osdk
CC65			:= ${HOME}/work/projects/8Bit/devtools/cc65
TOOLCHAIN		:= OSDK

EMU 			:= ./oricutron
EMUDIR 			:= ~/work/projects/8Bit/emulators/oricutron-build
EMUARG 			:= -m a
EMUARG 			+= -k n
# EMUARG 		+= --serial com:19200,8,N,1,/dev/pts/2
EMUARG 			+= --serial modem:65020
EMUARG 			+= --vsynchack off
EMUARG 			+= --scanlines on
EMUARG 			+= --rendermode opengl

EMUPARAM		+= -s $(PROJECT_DIR)/$(PROJECT).sym
EMUPARAM		+= -r:$(PROJECT_DIR)/$(PROJECT).brk

# EMUPARAM		+= -r $(shell echo $$(($(START_ADDRESS))))

COMMON			:= ../commpack/common

VPATH           	:= $(VPATH) $(COMMON)

PREPARE			:= prepare
FINALIZE		:= finalize

# # #
include $($(TOOLCHAIN))/atmos.make

AFLAGS			+= -DASSEMBLER
AFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
AFLAGS			+= -I$(COMMON)

$(PROJECT)_AFLAGS 	:=

CFLAGS			+= -I$(COMMON)
CFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)

$(PROJECT)_CFLAGS 	:=

LFLAGS			+=

$(PROJECT)_LFLAGS 	:=

TEMP_FILES 		+= DSKA0*.HFE

prepare:
	@echo "Building..."

finalize: hxc
# 	@cp -f $(PROJECT)_dsk.hfe DSKA0000.HFE
	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@if [ 'c3a92bef' = `crc32 $(PROJECT)` ]; then echo "[CRC]   OK!"; else echo -n; fi
	@echo "Done"
