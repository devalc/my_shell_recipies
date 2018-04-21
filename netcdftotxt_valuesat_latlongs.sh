	#!/bin/bash
	
############################################################################################################
#Created on Thu Sep 29 12:40:21 2016
#@author: chinmay deval
#This script reads the netcdf file and outputs timeseries of the varibale at a given lat long. 
#Requires: CDO (climate data operator) library  
############################################################################################################
	
	latitude=("34.3286" "33.2000" "32.6700" "25.2000" "24.0698" "19.2900" "18.7122" "17.6800" "19.6418" "19.0800" "18.5600" "19.2244" "19.0200" "19.3182" "17.5029" "19.1073" "17.4800" \
	          "17.8200" "19.2704" "18.8300" "19.0400" "19.2008" "18.8500" "18.5439" "17.2400" "18.1884" "19.1800" "18.6089" "18.6209" "19.0116" "19.0403" "31.6578" "31.8872" "32.0761" \
	          "32.1467" "31.6678" "31.2119" "31.3569" "31.8233" "32.2342" "31.7131" "31.7892" "32.0056" "31.6869" "31.8936" "31.4400" "31.7267" "31.8383" "31.2453" "31.7225")
	
	longitude=("72.8560" "73.6500" "74.4600" "89.7000" "89.0295" "81.7900" "77.5426" "80.8900" "81.4925" "81.3000" "77.5800" "76.3633" "76.7200" "74.1773" "81.2222" "82.0237" "81.3900" \
	           "81.3900" "82.2276" "79.4500" "82.2808" "82.5275" "80.3500" "80.3816" "81.6600" "81.7967" "77.0132" "82.1289" "79.8079" "81.2324" "77.4606" "77.0911" "77.1489" "76.1031" \
	           "76.0244" "77.0558" "76.7811" "76.8783" "78.6708" "77.1883" "76.9333" "76.3472" "76.1564" "77.0456" "77.1469" "77.6278" "77.2247" "76.5111" "77.1147" "77.2272")
	
	for ((i=0;i<${#latitude[@]};++i)); do
            echo "${latitude[i]}" "${longitude[i]}"
	    location=dailydischarge_${latitude[i]}_${longitude[i]}.txt
	    cdo outputtab,value -remapnn,lon=${longitude[i]}_lat=${latitude[i]} /scratch/chinmay/IGB_Outputs/04.02.2016/chirsp_run/netcdf/discharge_dailyTot_output.nc > $location
	done
	
	paste dailydischarge_34.3286_72.8560.txt dailydischarge_33.2000_73.6500.txt dailydischarge_32.6700_74.4600.txt dailydischarge_32.2342_77.1883.txt \
		  dailydischarge_32.1467_76.0244.txt dailydischarge_32.0761_76.1031.txt dailydischarge_32.0056_76.1564.txt dailydischarge_31.8936_77.1469.txt dailydischarge_31.8872_77.1489.txt dailydischarge_31.8383_76.5111.txt dailydischarge_31.8233_78.6708.txt dailydischarge_31.7892_76.3472.txt \
		  dailydischarge_31.7267_77.2247.txt dailydischarge_31.7225_77.2272.txt dailydischarge_31.7131_76.9333.txt dailydischarge_31.6869_77.0456.txt dailydischarge_31.6678_77.0558.txt dailydischarge_31.6578_77.0911.txt \
		  dailydischarge_31.4400_77.6278.txt dailydischarge_31.3569_76.8783.txt dailydischarge_31.2453_77.1147.txt dailydischarge_31.2119_76.7811.txt dailydischarge_25.2000_89.7000.txt dailydischarge_24.0698_89.0295.txt \
		  dailydischarge_19.6418_81.4925.txt dailydischarge_19.3182_74.1773.txt dailydischarge_19.2900_81.7900.txt dailydischarge_19.2704_82.2276.txt dailydischarge_19.2244_76.3633.txt dailydischarge_19.2008_82.5275.txt \
		  dailydischarge_19.1800_77.0132.txt dailydischarge_19.1073_82.0237.txt dailydischarge_19.0800_81.3000.txt dailydischarge_19.0403_77.4606.txt dailydischarge_19.0400_82.2808.txt dailydischarge_19.0200_76.7200.txt \
		  dailydischarge_19.0116_81.2324.txt dailydischarge_18.8500_80.3500.txt dailydischarge_18.8300_79.4500.txt dailydischarge_18.7122_77.5426.txt dailydischarge_18.6209_79.8079.txt dailydischarge_18.6089_82.1289.txt \
		  dailydischarge_18.5600_77.5800.txt dailydischarge_18.5439_80.3816.txt dailydischarge_18.1884_81.7967.txt dailydischarge_17.8200_81.3900.txt dailydischarge_17.6800_80.8900.txt dailydischarge_17.5029_81.2222.txt \
		  dailydischarge_17.4800_81.3900.txt dailydischarge_17.2400_81.6600.txt -d"\t">>daily_discharge_all_locations.txt

	rm dailydischarge*.txt
