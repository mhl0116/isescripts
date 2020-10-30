n=`ls *twx | wc -l`

#for i in {1..100}
for (( i=1; i<=${n}; i++ ))
do
    minPeriod=`grep "<twStats" v3_20_ucsb_odmb_seed${i}.twx | awk -F "twMinPer" '{print $2}' | awk -F ">" '{print $2}' | awk -F "<" '{print $1}'`
    maxPathDelay=`grep "<twStats" v3_20_ucsb_odmb_seed${i}.twx | awk -F "twMaxFromToDel" '{print $2}' | awk -F ">" '{print $2}' | awk -F "<" '{print $1}'`
    echo "random seed "${i}", min period: "${minPeriod}", max delay: "${maxPathDelay}
done
