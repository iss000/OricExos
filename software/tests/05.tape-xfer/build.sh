#!/bin/sh


bit_treshold=20



for bit_time in 40 60 80; do
  make clean
  echo -e "bit_time=\$$bit_time\nbit_treshold=\$$bit_treshold\n" > bit_values.s
  make all
  mv master.dsk master-$bit_time.dsk
done
