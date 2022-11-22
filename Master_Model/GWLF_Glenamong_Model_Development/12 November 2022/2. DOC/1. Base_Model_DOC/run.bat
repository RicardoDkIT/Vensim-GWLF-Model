
Rem Run Vensim calibration script
"c:\Program Files\Vensim\vendss64" Cmd_SE6_DOC_Method4.cmd

Rem combine all Temp files of step parameter values into a single file, then delete the temp files

type  Temp_Andecomp.tab > ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_Aerdecomp_rate.tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_SlowRate.tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_ratio.tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_MinSoilAdj.tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt


type  Temp_Final_NSE_Doc_Conc.dat > Stat.txt
echo. >> Stat.txt

type  Temp_Final_NSE_Doc_DailyLoad.dat >> Stat.txt
echo. >> Stat.txt

type  Temp_Final_NSE_Doc_MoLoad.dat >> Stat.txt
echo. >> Stat.txt

Del Temp*.tab
Del Temp*.dat


