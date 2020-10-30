name=$1
#name="v3_21_ucsb_odmb_seed25"

mkdir -p firmware
./bitToMcs.sh $name bitFiles_v320/${name}.bit odmb_toprom.hex                                                                                                                                          
mv ${name}.* firmware
