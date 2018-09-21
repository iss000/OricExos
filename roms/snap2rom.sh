#!/bin/sh

# Utility to extract patched ROM part from an Oricutron snapshot file
# Usage: snap2rom.sh snapshot-file.bin > output.rom

dd if=$1 bs=1 skip=65573 count=16384
