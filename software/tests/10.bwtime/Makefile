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

ATAPS			:= pplink slave-01 splayer mplayer movie-00 movie-01 movie-02 movie-03 movie-10 movie-11 movie-12 movie-13
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

# 
PLAYER_ADDRESS          := $(shell echo $$((0x0800)))

splayer_SRC             := splayer.s
splayer_AUTORUN         := 0
splayer_ADDRESS         := $(PLAYER_ADDRESS)

mplayer_SRC             := mplayer.s
mplayer_AUTORUN         := 0
mplayer_ADDRESS         := $(PLAYER_ADDRESS)

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

movie-10_SRC            := movie-10.s
movie-10_AUTORUN        := 0
movie-10_ADDRESS        := $(MOVIE_ADDRESS)

movie-11_SRC            := movie-11.s
movie-11_AUTORUN        := 0
movie-11_ADDRESS        := $(MOVIE_ADDRESS)

movie-12_SRC            := movie-12.s
movie-12_AUTORUN        := 0
movie-12_ADDRESS        := $(MOVIE_ADDRESS)

movie-13_SRC            := movie-13.s
movie-13_AUTORUN        := 0
movie-13_ADDRESS        := $(MOVIE_ADDRESS)



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
AFLAGS			+= -DSLAVE_01_ADDRESS=$(slave-01_ADDRESS)
AFLAGS			+= -DSPLAYER_ADDRESS=$(splayer_ADDRESS)
AFLAGS			+= -DMPLAYER_ADDRESS=$(mplayer_ADDRESS)
AFLAGS			+= -DPPLINK_ADDRESS=$(pplink_ADDRESS)
AFLAGS			+= -DUSE_HIRES

$(PROJECT)_AFLAGS 	:= -DPP_MASTER
pplink_AFLAGS		:= -DPP_SLAVE
slave-01_AFLAGS		:=
splayer_AFLAGS		:= -DNO_ROM
mplayer_AFLAGS		:= -DNO_ROM

CFLAGS			+= $(addprefix -I,$(VPATH))
CFLAGS			+= -DSTART_ADDRESS=$(START_ADDRESS)
CFLAGS			+= -DMOVIE_ADDRESS=$(MOVIE_ADDRESS)
CFLAGS			+= -DSLAVE_01_ADDRESS=$(slave-01_ADDRESS)
CFLAGS			+= -DSPLAYER_ADDRESS=$(splayer_ADDRESS)
CFLAGS			+= -DMPLAYER_ADDRESS=$(mplayer_ADDRESS)
CFLAGS			+= -DPPLINK_ADDRESS=$(pplink_ADDRESS)

$(PROJECT)_CFLAGS 	:=
pplink_CFLAGS		:=
slave-01_CFLAGS		:=
splayer_CFLAGS		:= -DNO_ROM
mplayer_CFLAGS		:= -DNO_ROM

LFLAGS			+=

$(PROJECT)_LFLAGS 	:=
pplink_LFLAGS		:=
slave-01_LFLAGS		:=
splayer_LFLAGS		:=
mplayer_LFLAGS		:=

TEMP_FILES 		+= *.HFE *.hfe $(PROJECT).tap tools/bmpsplitter res/out res-1/out

prepare: resources
	@echo "Building..."

finalize: hxc
	@[ -e $(PROJECT).brk ] || touch $(PROJECT).brk
	@cp -f $(PROJECT).dsk ../$(DEMO_NUMBER).$(DEMO_NAME).dsk
	@cp -f $(PROJECT)_dsk.hfe ../$(DEMO_NUMBER).$(DEMO_NAME).hfe
	@ echo ""
	@printf "[MEM]   master   : #%.4X .. #%.4X\\n" $$(($(master_ADDRESS))) $$(expr `cat master | wc -c` + $$(($(master_ADDRESS))))
	@printf "[MEM]   pplink   : #%.4X .. #%.4X\\n" $$(($(pplink_ADDRESS))) $$(expr `cat pplink | wc -c` + $$(($(pplink_ADDRESS))))
	@printf "[MEM]   slave-01 : #%.4X .. #%.4X\\n" $$(($(slave-01_ADDRESS))) $$(expr `cat slave-01 | wc -c` + $$(($(slave-01_ADDRESS))))
	@printf "[MEM]   splayer  : #%.4X .. #%.4X\\n" $$(($(splayer_ADDRESS))) $$(expr `cat splayer | wc -c` + $$(($(splayer_ADDRESS))))
	@printf "[MEM]   mplayer  : #%.4X .. #%.4X\\n" $$(($(mplayer_ADDRESS))) $$(expr `cat mplayer | wc -c` + $$(($(mplayer_ADDRESS))))
	@printf "[MEM]   movie    : #%.4X .. #%.4X\\n" $$(($(MOVIE_ADDRESS))) $$(expr `cat movie-00 | wc -c` + $$(($(MOVIE_ADDRESS))))
	@echo "Done"

# 
.PHONY: tools/bmpsplitter resources gom gos1 gos2 gos3 goplink 

resources: tools/bmpsplitter
	@rm -rf res/out/* res-1/out/*
	@mkdir -p res/out/{0,1,2,3} res-1/out/{0,1,2,3}
	@for i in res/*.bmp; do \
		label=`echo $$(basename $$i)|sed -e 's/.bmp//g'` && \
		convert $$i -crop 150x120+40+30 +repage +dither -posterize 6 -type truecolor bmp3:res/out/$$(basename $$i) && \
		\
		tools/bmpsplitter res/out/$$(basename $$i) res/out/0/$$(basename $$i) 0 && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic0$$label res/out/0/$$(basename $$i) res/out/0/$$(basename $$i).s && \
		\
		tools/bmpsplitter res/out/$$(basename $$i) res/out/1/$$(basename $$i) 1 && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic1$$label  res/out/1/$$(basename $$i) res/out/1/$$(basename $$i).s && \
		\
		tools/bmpsplitter res/out/$$(basename $$i) res/out/2/$$(basename $$i) 2 && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic2$$label  res/out/2/$$(basename $$i) res/out/2/$$(basename $$i).s && \
		\
		tools/bmpsplitter res/out/$$(basename $$i) res/out/3/$$(basename $$i) 3 && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic3$$label  res/out/3/$$(basename $$i) res/out/3/$$(basename $$i).s ; \
	done
	@for i in res-1/*.bmp; do \
		label=`echo $$(basename $$i)|sed -e 's/.bmp//g'` && \
		convert $$i -crop 150x120+40+30 +repage +dither -posterize 6 -type truecolor bmp3:res-1/out/$$(basename $$i) && \
		\
		tools/bmpsplitter res-1/out/$$(basename $$i) res-1/out/0/$$(basename $$i) 0 && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic0$$label res-1/out/0/$$(basename $$i) res-1/out/0/$$(basename $$i).s && \
		\
		tools/bmpsplitter res-1/out/$$(basename $$i) res-1/out/1/$$(basename $$i) 1 && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic1$$label  res-1/out/1/$$(basename $$i) res-1/out/1/$$(basename $$i).s && \
		\
		tools/bmpsplitter res-1/out/$$(basename $$i) res-1/out/2/$$(basename $$i) 2 && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic2$$label  res-1/out/2/$$(basename $$i) res-1/out/2/$$(basename $$i).s && \
		\
		tools/bmpsplitter res-1/out/$$(basename $$i) res-1/out/3/$$(basename $$i) 3 && \
		$(OSDK)/bin/pictconv -f0 -d0 -o4pic3$$label  res-1/out/3/$$(basename $$i) res-1/out/3/$$(basename $$i).s ; \
	done
	@rm -f res/out/{0,1,2,3}/*.bmp

tools/bmpsplitter:
	@gcc -o $@ tools/bmpsplitter.c

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
	
# 0x97E8 - frames tab
