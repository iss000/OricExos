Files:
------
master.rom - original Oric v1.1 ROM for the master Oric

master.pch - patches, both 'master.*' files can be used in Oricutron

slave.rom  - ROM for the 3 slave Orics

How To create slave.rom:
------------------------
Copy 'master.rom' and 'master.pch' to Oricutron roms/ sub-directory

Edit 'oricutron.cfg':

 atmosrom = 'roms/master'
 
Run Oricutron (patches will be applied automaticaly) and save a snapshot file 'slave.bin'

Use the bash script 'snap2rom.sh' to extract patched binary for slave:

 $./snap2rom.sh slave.bin > slave.rom
 
