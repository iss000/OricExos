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

START_ADDRESS           := $(shell echo $$((0x0500)))

ATAPS			:= pplink splayer mplayer movie-00 movie-01 movie-02 movie-03
BTAPS			:= 
CTAPS			:= $(PROJECT)

TAPS 			:= $(addsuffix .tap,$(ATAPS) $(BTAPS) $(CTAPS))

common_SRC 		:= compat.s pp.s oricexos.s

$(PROJECT)_SRC		:= $(common_SRC) libsedoric.s $(PROJECT).c
$(PROJECT)_AUTORUN	:= 1
$(PROJECT)_ADDRESS	:= $(START_ADDRESS)

pplink_SRC              := pplink.s pp.s oricexos.s
pplink_AUTORUN          := 1
pplink_ADDRESS          := $(shell echo $$((0x0400)))

splayer_SRC            := splayer.s oricexos.s
splayer_AUTORUN        := 1
splayer_ADDRESS        := $(shell echo $$((0x0680)))

mplayer_SRC             := mplayer.s oricexos.s
mplayer_AUTORUN         := 1
mplayer_ADDRESS         := $(shell echo $$((0x0500)))

# 
MOVIE_ADDRESS           := $(shell echo $$((0x1680)))

movie-00_SRC            := movie-00.s
movie-00_AUTORUN        := 0
movie-00_ADDRESS        := $(MOVIE_ADDRESS)

movie-01_SRC            := movie-01.s
movie-01_AUTORUN        := 0
movie-01_ADDRESS        := $(MOVIE_ADDRESS)

movie-02_SRC            := movie-02.s
movie-02_AUTORUN        := 0
movie-02_ADDRESS        := $(MOVIE_ADDRESS)

movie-03_SRC            := movie-03.s
movie-03_AUTORUN        := 0
movie-03_ADDRESS        := $(MOVIE_ADDRESS)


OSDK			:= ${HOME}/work/projects/8Bit/devtools/osdk
CC65			:= ${HOME}/work/projects/8Bit/devtools/cc65
TOOLCHAIN		:= CC65

EMU 			:= ./oricutron
EMUDIR 			:= ${HOME}/work/projects/8Bit/emulators/oricutron-build
EMUARG 			:= -m a
EMUARG 			+= -k m
EMUARG 			+= --serial none
EMUARG 			+= --vsynchack on
EMUARG 			+= --scanlines on
EMUARG 			+= --rendermode opengl

# EMUPARAM              += -r $(shell echo $$(($(START_ADDRESS))))
EMUPARAM                += -s $(PROJECT_DIR)/$(PROJECT).sym 
EMUPARAM                += -s $(PROJECT_DIR)/mplayer.sym
EMUPARAM                += -s $(PROJECT_DIR)/splayer.sym
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
AFLAGS			+= -DMOVIE_ADDRESS=$(MOVIE_ADDRESS)
AFLAGS			+= -DMPLAYER_ADDRESS=$(mplayer_ADDRESS)
AFLAGS			+= -DPPLINK_ADDRESS=$(pplink_ADDRESS)
AFLAGS			+= -DSPLAYER_ADDRESS=$(splayer_ADDRESS)
AFLAGS			+= -DUSE_HIRES

$(PROJECT)_AFLAGS 	:= -DMASTER -DPP_MASTER
pplink_AFLAGS		:= -DSLAVE -DPP_SLAVE
splayer_AFLAGS		:= -DSPLAYER
mplayer_AFLAGS		:= -DMPLAYER

CFLAGS			+= $(addprefix -I,$(VPATH))
CFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
CFLAGS			+= -DMOVIE_ADDRESS=$(MOVIE_ADDRESS)
CFLAGS			+= -DMPLAYER_ADDRESS=$(mplayer_ADDRESS)
CFLAGS			+= -DPPLINK_ADDRESS=$(pplink_ADDRESS)
CFLAGS			+= -DSPLAYER_ADDRESS=$(splayer_ADDRESS)
CFLAGS			+= -DUSE_HIRES

$(PROJECT)_CFLAGS 	:= -DMASTER -DPP_MASTER
mplayer_CFLAGS		:= -DMPLAYER
pplink_CFLAGS		:= -DSLAVE -DPP_SLAVE
splayer_CFLAGS		:= -DSPLAYER

LFLAGS			+=

$(PROJECT)_LFLAGS 	:=
pplink_LFLAGS		:=
splayer_LFLAGS		:=
mplayer_LFLAGS		:=

TEMP_FILES 		+= *.HFE *.hfe $(PROJECT).tap res/out

prepare: resources
	@echo "Building..."

finalize: hxc
	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@cp -f $(PROJECT).dsk ../$(DEMO_NUMBER).$(DEMO_NAME).dsk
	@cp -f $(PROJECT)_dsk.hfe ../$(DEMO_NUMBER).$(DEMO_NAME).hfe
	@ echo ""
	@printf "[MEM]   master   : #%.4X .. #%.4X\\n" $$(($(master_ADDRESS))) $$(expr `cat master | wc -c` + $$(($(master_ADDRESS))))
	@printf "[MEM]   mplayer  : #%.4X .. #%.4X\\n" $$(($(mplayer_ADDRESS))) $$(expr `cat mplayer | wc -c` + $$(($(mplayer_ADDRESS))))
	@printf "[MEM]   pplink   : #%.4X .. #%.4X\\n" $$(($(pplink_ADDRESS))) $$(expr `cat pplink | wc -c` + $$(($(pplink_ADDRESS))))
	@printf "[MEM]   splayer  : #%.4X .. #%.4X\\n" $$(($(splayer_ADDRESS))) $$(expr `cat splayer | wc -c` + $$(($(splayer_ADDRESS))))
	@printf "[MEM]   movies   : #%.4X .. #%.4X\\n" $$(($(MOVIE_ADDRESS))) $$(expr `cat movie-00 | wc -c` + $$(($(MOVIE_ADDRESS))))
	@echo "Done"

# 
.PHONY: resources gom gos1 gos2 gos3 goplink 

resources:
	@rm -rf res/out/*
	@mkdir -p res/out/{0,1,2,3}
	@for i in res/*.bmp; do \
		label=`echo $$(basename $$i)|sed -e 's/.bmp//g'` && \
		\
		convert $$i -crop 240x50+0+0 +repage -type truecolor bmp3:res/out/0/$$(basename $$i) && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic0$$label res/out/0/$$(basename $$i) res/out/0/$$(basename $$i).s && \
		\
		convert $$i -crop 240x50+0+50 +repage -type truecolor bmp3:res/out/1/$$(basename $$i) && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic1$$label  res/out/1/$$(basename $$i) res/out/1/$$(basename $$i).s && \
		\
		convert $$i -crop 240x50+0+100 +repage -type truecolor bmp3:res/out/2/$$(basename $$i) && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic2$$label  res/out/2/$$(basename $$i) res/out/2/$$(basename $$i).s && \
		\
		convert $$i -crop 240x50+0+150 +repage -type truecolor bmp3:res/out/3/$$(basename $$i) && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic3$$label  res/out/3/$$(basename $$i) res/out/3/$$(basename $$i).s ; \
	done
	@rm -f res/out/{0,1,2,3}/*.bmp

gopplink: all
	@oric -ma -kn -r:$(PROJECT_DIR)/$(PROJECT).brk \
        -s $(PROJECT_DIR)/pplink.sym pplink.tap

# # # 
# Oricutron callers
# make gom - go master
# make gos1 - go slave 1
# make gos2 - go slave 4
# make gos3 - go slave 3

SLAVE_TAP=slave.tap
include ../../emulator.rules
