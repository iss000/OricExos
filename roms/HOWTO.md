Files:
------
master.rom - original Oric v1.1 ROM for the master Oric

master.pch - patches, both 'master.*' files can be used in Oricutron

slave-1.rom  - ROM for slave #1

slave-2.rom  - ROM for slave #2

slave-3.rom  - ROM for slave #3


How To create slave.rom:
------------------------
Copy 'master.rom' and 'master.pch' to Oricutron roms/ sub-directory

Edit 'oricutron.cfg':

 atmosrom = 'roms/master'
 
Run Oricutron (patches will be applied automaticaly) and save a snapshot file 'slave.bin'

Use the bash script 'snap2rom.sh' to extract patched binary for slave:

 $./make-slave.sh slave.bin
 
