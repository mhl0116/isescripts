#!/bin/bash

mkdir -p bitFiles timingReports logs

for i in {1..100}
do
   echo "Make bit file with random seed $i"
   make clean
   make odmb.bit SEED=$i 2>&1 > logs/compile_log${i}.log 
   cp ODMB_UCSB_V2.bit bitFiles/v3_20_ucsb_odmb_seed${i}.bit
   cp ODMB_UCSB_V2.twx timingReports/v3_20_ucsb_odmb_seed${i}.twx
done
