#!/bin/sh

# Utility to create slave rom images
# Usage: ./make-slaves.sh snapshot-file.bin

./snap2rom.sh $1 > slave-1.rom
cat slave-1.rom | sed -e 's/1 1983/2 1983/g' > slave-2.rom
cat slave-1.rom | sed -e 's/1 1983/3 1983/g' > slave-3.rom

# duplicate rom content for use with 27356 eproms
# cat slave-1.rom slave-1.rom > slave-1-27256.rom
# cat slave-2.rom slave-2.rom > slave-2-27256.rom
# cat slave-3.rom slave-3.rom > slave-3-27256.rom

cat slave.pch > slave-1.pch
cat slave.pch > slave-2.pch
cat slave.pch > slave-3.pch

cat slave.sym > slave-1.sym
cat slave.sym > slave-2.sym
cat slave.sym > slave-3.sym
