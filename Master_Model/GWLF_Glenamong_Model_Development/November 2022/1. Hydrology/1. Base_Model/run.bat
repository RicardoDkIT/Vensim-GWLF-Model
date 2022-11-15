
Rem Run Vensim calibration script
"c:\Program Files\Vensim\vendss64" Cmd_SE6_DOC_Method7.cmd

Rem combine all Temp files of step parameter values into a single file, then delete the temp files

type  Temp_Precip.tab > ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_RunoffCorr.tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_SoilWaterCap.Tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_DeepGWCap.tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_RecessCoeff.tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_SlowRecessCoeff.tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_MeltCoeff.tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_ChannelFlowCoeff.Tab >> ParamterChanges.txt
echo. >> ParamterChanges.txt

type  Temp_NSEstreamflow.dat > Stat.txt
echo. >> Stat.txt

type  Temp_NSErunoff.dat >> Stat.txt
echo. >> Stat.txt

type  Temp_NSEbaseflow.dat >> Stat.txt
echo. >> Stat.txt

Del Temp*.tab
Del Temp*.dat


