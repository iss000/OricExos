# # #
PROJECT 		:= master
PROJECT_DIR		:= $(shell pwd)

# # # Only if floppybuilder
PROJECT_DSK		:= $(PROJECT).dsk

# # #
# CPU			:= 65816

# # # Autorun main project file
PROJECT_AUTORUN		:= 0

# # # Leave DOS
PROJECT_QUITDOS		:= 0

ATAPS			:= $(PROJECT) $(PROJECT)-slave
BTAPS			:=
CTAPS			:=

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS))

START_ADDRESS		:= $(shell echo $$((0xc000)))

common_SRC 		:=

$(PROJECT)_SRC 		:= $(PROJECT).s
$(PROJECT)_AUTORUN	:= 0
$(PROJECT)_ADDRESS	:= $(START_ADDRESS)
$(PROJECT)_ACPP		:= 1

$(PROJECT)-slave_SRC 	:= $(PROJECT).s
$(PROJECT)-slave_AUTORUN:= 0
$(PROJECT)-slave_ADDRESS:= $(START_ADDRESS)
$(PROJECT)-slave_ACPP	:= 1

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
$(PROJECT)-slave_AFLAGS := -DORICEXOS

CFLAGS			+= -I$(COMMON)
CFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)

$(PROJECT)_CFLAGS 	:= 
$(PROJECT)-slave_CFLAGS := -DORICEXOS

LFLAGS			+=

$(PROJECT)_LFLAGS 	:=
$(PROJECT)-slave_LFLAGS := -DORICEXOS

TEMP_FILES 		+= DSKA0*.HFE

prepare:
	@echo "Building..."

finalize: #hxc
# 	@cp -f $(PROJECT)_dsk.hfe DSKA0000.HFE
# 	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@mv -f $(PROJECT) $(PROJECT).rom 
	@if [ 'c3a92bef' = `crc32 $(PROJECT).rom` ]; then echo "[CRC]   OK!"; else echo -n; fi
	@cat $(PROJECT)-slave | sed -e 's/. 1983/1 1983/g' -e 's/RGB OricExos 123 BGR/\x11\x10\x10\x10OricExos 1  \x10\x10\x10\x11/g' > slave-v2-1.rom
	@cat $(PROJECT)-slave | sed -e 's/. 1983/2 1983/g' -e 's/RGB OricExos 123 BGR/\x10\x12\x10\x10OricExos  2 \x10\x10\x12\x10/g' > slave-v2-2.rom
	@cat $(PROJECT)-slave | sed -e 's/. 1983/3 1983/g' -e 's/RGB OricExos 123 BGR/\x10\x10\x14\x10OricExos   3\x10\x14\x10\x10/g' > slave-v2-3.rom
	@echo "Done"
	cp -f $(PROJECT).rom $(PROJECT).pch slave-v2-1.rom slave-v2-2.rom slave-v2-3.rom $(EMUDIR)/roms/
	cat master.pch > $(EMUDIR)/roms/slave-v2-1.pch 
	cat master.pch > $(EMUDIR)/roms/slave-v2-2.pch 
	cat master.pch > $(EMUDIR)/roms/slave-v2-3.pch 

.PHONY: $(PROJECT).dsk
$(PROJECT).dsk: $(TAPS)
	@echo -n
