#!/bin/sh
convert Roger_Patterson_Bigfoot_Footage.mp4 \
  -crop 96x64+92+83 +repage +grayscale \
  -type truecolor 'bmp3:xxx-%04d.bmp'
  
# ls *.bmp| wc -l
# crc32 *.bmp| cut -f1| sort -u | wc -l
# 
# gawk '
#   {
#     cmd="md5sum " q FILENAME q
#     cmd | getline cksm
#     close(cmd)
#     sub(/ .*$/,"",cksm)
#     if(a[cksm]++){
#       cmd="rm -f " q FILENAME q
#       system(cmd)
#       close(cmd)
#     }
#     nextfile
#   }' q='"' *
# 
# ls *.bmp| wc -l
# crc32 *.bmp| cut -f1| sort -u | wc -l
# 

rm -rf res && mkdir -p res
mv -f `cat frames.txt` res/
