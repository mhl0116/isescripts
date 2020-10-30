# https://www.fpgarelated.com/showarticle/786.php

DEVICE = xc6vlx130t-1-ff1156
BOARD = ODMB_UCSB_V2
CONSTRAIN = source/odmb_pinout_v2.ucf
TOPMODULE = source/odmb_ucsb_v2.vhd  

SEED ?= 1

default: odmb.bit

odmb.ngc: $(TOPMODULE) $(CONSTRAIN) $(BOARD).prj  
       #xst -intstyle silent -ifn "/net/top/homes/hmei/ODMB/firmware/checkTiming/odmb_ucsb_v2/ODMB_UCSB_V2.xst" -ofn "/net/top/homes/hmei/ODMB/firmware/checkTiming/odmb_ucsb_v2/ODMB_UCSB_V2.syr"
	xst -intstyle silent -ifn $(BOARD).xst -ofn $(BOARD).syr

odmb.ngd: odmb.ngc 
       #ngdbuild -intstyle silent -dd _ngo -sd ipcore_dir -nt timestamp -uc source/odmb_pinout_v2.ucf -p xc6vlx130t-1-ff1156 ODMB_UCSB_V2.ngc ODMB_UCSB_V2.ngd 
	ngdbuild -intstyle silent -dd _ngo -sd ipcore_dir -nt timestamp -uc $(CONSTRAIN) -p $(DEVICE) $(BOARD).ngc $(BOARD).ngd 

odmb.pcf: odmb.ngd odmb.ngc
#odmb.pcf: 
	map -intstyle silent -p $(DEVICE) -w -logic_opt off -ol high -xe n -t $(SEED) -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr b -lc off -power off -o $(BOARD)_map.ncd $(BOARD).ngd $(BOARD).pcf

odmb.ncd: odmb.ngd odmb.ngc odmb.pcf $(BOARD)_map.ncd
#odmb.ncd: odmb.pcf $(BOARD)_map.ncd
       #par -w -intstyle silent -ol high -xe n -mt off ODMB_UCSB_V2_map.ncd ODMB_UCSB_V2.ncd ODMB_UCSB_V2.pcf
	par -w -intstyle silent -ol high -xe n -mt off $(BOARD)_map.ncd $(BOARD).ncd $(BOARD).pcf

odmb.twx: odmb.ncd odmb.pcf
#odmb.twx: odmb.pcf
       #trce -intstyle silent -v 3 -s 1 -n 3 -fastpaths -xml ODMB_UCSB_V2.twx ODMB_UCSB_V2.ncd -o ODMB_UCSB_V2.twr ODMB_UCSB_V2.pcf  
	trce -intstyle silent -v 3 -s 1 -n 3 -fastpaths -xml $(BOARD).twx $(BOARD).ncd -o $(BOARD).twr $(BOARD).pcf  

odmb.bit: odmb.ncd odmb.twx
       #bitgen -intstyle silent -f ODMB_UCSB_V2.ut ODMB_UCSB_V2.ncd
	bitgen -intstyle silent -f $(BOARD).ut $(BOARD).ncd

CLEAN_EXTS := .bgn .bit _bitgen.xwbt .bld .drc .lso _map.map _map.mrp _map.ncd
CLEAN_EXTS += _map.ngm _map.xrpt .ncd  _ngdbuild.xrpt .ngr .pad
#CLEAN_EXTS += _map.ngm _map.xrpt .ncd .ngc .ngd _ngdbuild.xrpt .ngr .pad
CLEAN_EXTS += _pad.csv _pad.txt .par _par.xrpt .pcf .ptwx .srp _summary.xml
CLEAN_EXTS += .twr .twr_pad.txt .twx .unroutes _usage.xml .xpi _xst.xrpt

clean:
	rm -f $(foreach x,$(CLEAN_EXTS),$(BOARD)$(x))
	rm -f par_usage_statistics.html webtalk.log
	rm -f usage_statistics_webtalk.html
	rm -f '#Makefile#' '.#Makefile'
	rm -f _impactbatch.log
	rm -rf _ngo xlnx_auto_0_xdb  _xmsgs 


        #map -intstyle silent -p xc6vlx130t-1-ff1156 -w -logic_opt off -ol high -xe n -t 6 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr b -lc off -power off -o ODMB_UCSB_V2_map.ncd ODMB_UCSB_V2.ngd ODMB_UCSB_V2.pcf
