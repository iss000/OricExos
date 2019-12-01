# # #
DEMO_NUMBER             := 20
DEMO_NAME               := multisound

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
PROJECT_QUITDOS		:= 1

START_ADDRESS           := $(shell echo $$((0x0600)))
SLAVE_ADDRESS           := $(shell echo $$((0x2000)))
MUSIC_DATA           	:= $(shell echo $$((0x5000)))

ATAPS			:= pplink psg0 psg1 psg2 psg3
BTAPS			:= 
CTAPS			:= $(PROJECT) slave

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS))

common_SRC 		:= pp.s oricexos.s

$(PROJECT)_SRC		:= $(common_SRC) compat.s libsedoric.s $(PROJECT).c
$(PROJECT)_AUTORUN	:= 1
$(PROJECT)_ADDRESS	:= $(START_ADDRESS)
$(PROJECT)_ACPP		:= 1

pplink_SRC              := pplink.s $(common_SRC)
pplink_AUTORUN          := 1
pplink_ADDRESS          := $(shell echo $$((0x0500)))

slave_SRC               := compat.s isr.s vsync.s via.s psg.s oricexos.s slave.c kick.s mym.s
slave_AUTORUN           := 1
slave_ADDRESS           := $(SLAVE_ADDRESS)
slave_ACPP              := 1

psg0_SRC                := psg0.s
psg0_AUTORUN            := 0
psg0_ADDRESS            := $(MUSIC_DATA)
psg0_ACPP               := 0
                        
psg1_SRC                := psg1.s
psg1_AUTORUN            := 0
psg1_ADDRESS            := $(MUSIC_DATA)
psg1_ACPP               := 0
                        
psg2_SRC                := psg2.s
psg2_AUTORUN            := 0
psg2_ADDRESS            := $(MUSIC_DATA)
psg2_ACPP               := 0
                        
psg3_SRC                := psg3.s
psg3_AUTORUN            := 0
psg3_ADDRESS            := $(MUSIC_DATA)
psg3_ACPP               := 0

# # # 
OSDK			:= ${HOME}/work/projects/8Bit/devtools/osdk
OSDK_OPT65		:= 0
CC65			:= ${HOME}/work/projects/8Bit/devtools/cc65
CC65_ALIGNED		:= 1
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
LIBS                    := libs/

VPATH                   := $(VPATH) . $(LIBS) $(COMMON)

PREPARE                 := prepare
FINALIZE                := finalize

# # #
include $($(TOOLCHAIN))/atmos.make

AFLAGS			+= $(addprefix -I,$(VPATH))
AFLAGS			+= -DASSEMBLER
AFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
AFLAGS			+= -DSLAVE_ADDRESS=$(SLAVE_ADDRESS)
AFLAGS			+= -DPPLINK_ADDRESS=$(pplink_ADDRESS)
AFLAGS			+= -DUSE_TEXT
AFLAGS                  += -DMUSIC_DATA=$(MUSIC_DATA)

# 
AFLAGS                  += -DUSE_VSYNC
AFLAGS                  += -DUSE_VSYNC_50HZ
# AFLAGS                += -DUSE_VSYNC_60HZ
AFLAGS                  += -DUSE_VSYNC_SOFT
# AFLAGS                += -DUSE_VSYNC_HARD
AFLAGS                  += -DUSE_VSYNC_NEGEDGE
AFLAGS                  += -DUSE_VSYNC_AUTO_TEXT

$(PROJECT)_AFLAGS 	:= -DMASTER -DPP_MASTER
slave_AFLAGS 		:= -DSLAVE -DPP_SLAVE
pplink_AFLAGS		:= -DSLAVE -DPP_SLAVE

CFLAGS			+= $(addprefix -I,$(VPATH))
CFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
CFLAGS			+= -DSLAVE_ADDRESS=$(SLAVE_ADDRESS)
CFLAGS			+= -DPPLINK_ADDRESS=$(pplink_ADDRESS)
CFLAGS                  += -DMUSIC_DATA=$(MUSIC_DATA)

# 
CFLAGS                  += -DUSE_VSYNC_50HZ
CFLAGS			+= -DUSE_TEXT

$(PROJECT)_CFLAGS 	:= -DMASTER -DPP_MASTER
slave_CFLAGS 		:= -DSLAVE -DPP_SLAVE
pplink_CFLAGS		:= -DSLAVE -DPP_SLAVE

LFLAGS			+=
$(PROJECT)_LFLAGS 	:=
slave_LFLAGS 		:= 


TEMP_FILES 		+= *.HFE *.hfe $(PROJECT).tap

YM2MYM  := $(OSDK)/bin/ym2mym2
BIN2TXT := $(OSDK)/bin/bin2txt

prepare:
	@echo "Building with $(TOOLCHAIN) ..."

finalize: hxc
	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@cp -f $(PROJECT).dsk ../$(DEMO_NUMBER).$(DEMO_NAME).dsk
	@cp -f $(PROJECT)_dsk.hfe ../$(DEMO_NUMBER).$(DEMO_NAME).hfe
	@printf "[MEM]   master: #%.4X .. #%.4X\\n" $$(($(master_ADDRESS))) $$(expr `cat master | wc -c` + $$(($(master_ADDRESS))))
	@printf "[MEM]   pplink: #%.4X .. #%.4X\\n" $$(($(pplink_ADDRESS))) $$(expr `cat pplink | wc -c` + $$(($(pplink_ADDRESS))))
	@printf "[MEM]   slave : #%.4X .. #%.4X\\n" $$(($(slave_ADDRESS))) $$(expr `cat slave | wc -c` + $$(($(slave_ADDRESS))))
	@echo "Done"

.PHONY: res
# MUSIC_LEN := -df9100
res:
	@$(YM2MYM) $(MUSIC_LEN) -t0 -f0 -h0 -v1 res/psg1.ym res/psg1.mym
	@$(BIN2TXT) -s1 -f2 -h1 -n16 res/psg1.mym psg0.s song
	@$(BIN2TXT) -s1 -f2 -h1 -n16 res/psg1.mym psg1.s song
	@echo "Song is: `cat res/psg1.mym | wc -c` bytes long."
	@$(YM2MYM) $(MUSIC_LEN) -t0 -f0 -h0 -v1 res/psg2.ym res/psg2.mym
	@$(BIN2TXT) -s1 -f2 -h1 -n16 res/psg2.mym psg2.s song
	@echo "Song is: `cat res/psg2.mym | wc -c` bytes long."
	@$(YM2MYM) $(MUSIC_LEN) -t0 -f0 -h0 -v1 res/psg3.ym res/psg3.mym
	@$(BIN2TXT) -s1 -f2 -h1 -n16 res/psg3.mym psg3.s song
	@echo "Song is: `cat res/psg3.mym | wc -c` bytes long."
	@$(RM) res/psg*.mym

# # # 
# Oricutron callers
# make gom - go master
# make gos1 - go slave 1
# make gos2 - go slave 4
# make gos3 - go slave 3

SLAVE_TAP=slave.tap
include ../../emulator.rules
