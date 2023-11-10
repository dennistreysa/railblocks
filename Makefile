ROMNAME := railblocks
ROMEXT := gbc
GAMEID := RAIL
TITLE = RAILBLOCKS

# HomeBrew
LICENSEE := HB
# Old licensee, please set to 0x33 (required to get SGB compatibility)
OLDLIC := 0x33
# MBC type, tells which hardware is in the cart
# See https://gbdev.io/pandocs/#_0147-cartridge-type or consult any copy of Pan
# Docs if using no MBC, consider enabling `-t` below
MBC := 0x00
# ROM version (typically starting at 0 and incremented for each published
# version)
ROMVERSION := 0
# Size of the on-board SRAM; MBC type should indicate the presence of RAM
# See https://gbdev.io/pandocs/#_0149-ram-size or consult any copy of Pan Docs
# Set this to 0 when using MBC2's built-in SRAM
RAMSIZE := 0x00


# Directories for the generated files
SOURCE := src
BINDIR := bin
OBJDIR := obj
# These dirs are searched for the included files
INCLUDEDIRS := include lib

# List of relative paths to all folders within the source directory
SOURCE_ALL_DIRS := $(shell find $(SOURCE) -type d -print)

# All files with extension asm are assembled.
ASMFILES := $(foreach dir,$(SOURCE_ALL_DIRS),$(wildcard $(dir)/*.asm))

# List of include directories: All source and data folders.
# A '/' is appended to the path.
INCLUDES := $(foreach dir,$(INCLUDEDIRS),--include $(SOURCE)/$(dir)/)

# Prepare object paths from source files.
OBJ := $(ASMFILES:.asm=.o)

# Directories of the tools (Note: path needed for RGBDS if installed globally)
RGBDS   :=
RGBASM  := $(RGBDS)rgbasm
RGBLINK := $(RGBDS)rgblink
RGBFIX  := $(RGBDS)rgbfix

# Flags for the specific tools
ASMFLAGS = --verbose --preserve-ld --halt-without-nop --export-all -Wall -Weverything $(INCLUDES)
LINKFLAGS = --verbose
FIXFLAGS = --validate --color-only --game-id "$(GAMEID)" -p 0xff --new-licensee "$(LICENSEE)" --old-licensee $(OLDLIC) --mbc-type $(MBC) --rom-version $(ROMVERSION) --ram-size $(RAMSIZE) --title "$(TITLE)"

ROMFILE := $(ROMNAME).$(ROMEXT)
ROMPATH = $(BINDIR)/$(ROMFILE)


###################################################################################################
#	Targets
###################################################################################################


all: $(ROMPATH)

%.o : %.asm
	@echo $(RGBASM) $(ASMFLAGS) -o $@ $<
	@$(RGBASM) $(ASMFLAGS) -o $@ $<


$(ROMPATH): $(OBJ)
	mkdir -p $(BINDIR)
	$(RGBLINK) $(LINKFLAGS) -o $@ $^
	$(RGBFIX) $(FIXFLAGS) $@

clean:
	rm -f $(OBJ) $(ROMPATH)
	rm -rf $(BINDIR)
.PHONY: clean


rebuild:
	$(MAKE) clean
	$(MAKE) all
.PHONY: rebuild