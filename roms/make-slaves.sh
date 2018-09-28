#!/bin/sh

# Utility to create slave rom images
# Usage: ./make-slaves.sh snapshot-file.bin

./snap2rom.sh $1 > slave-1.rom
cat slave-1.rom | sed -e 's/1 1983/2 1983/g' > slave-2.rom
cat slave-1.rom | sed -e 's/1 1983/3 1983/g' > slave-3.rom
