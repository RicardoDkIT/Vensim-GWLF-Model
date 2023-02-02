! ************************************ Model caibration workflow 7 ************************************
!
!This calibration preforms the following steps
!Step 1 optimize the PrecipCorr factor to WB1
!Step 2 optimize the CN adj factor by comparing the total cumualtive simulated and measured runoff.
!Step 3 optimize the MeltCoeff factor to streamflow
!Step 4 Optimize remaining Hydro model coefficients using ppt corr from previous step and 
!  by comparing simulated gwflow with baseflow discharge based on hydrograph seperation.
!Step 5 Optimize slow recess coefficient and deep gw cap with 20th percentile slow baseflow
!Step 6 Optimize the channel flow coefficient by comparing simulated and measured (hydro sep) runoff
!  with measured streamflow.
!Step 6 Optimize the ppt corr factor again now using WB2
!Step 7 optimize the CN adj factor by comparing the total cumualtive simulated and measured runoff.
!Step 8 optimize the MeltCoeff factor to streamflow
!Step 9 Optimize remaining Hydro model coefficients using ppt corr from previous step and 
!  by comparing simulated gwflow with baseflow discharge based on hydrograph seperation.
!Step 10 Optimize slow recess coefficient and deep gw cap with 20th percentile slow baseflow
!Step 11 Optimize the channel flow coefficient by comparing simulated and measured (hydro sep) runoff
!  with measured streamflow.
!Step 12 Optimize the ppt corr factor again now using WB2
!Step 13 Optimize both recess coefficients using GW RMS
!Step 14 Optimize the ppt corr factor again now using WB2

!
!Note that at each step all of the 6 coefficient that affect the model streamflow
!Simulation are output to separate temporary files.  At the end fo the calibration these 
!are combined into a single file that will show how all parameter values change.
!between steps

!TO RUN ON DIFFERENT BASIN 1) use a text editor to change the basin ID (ie Vattholma) in the different
!  file names to a different basin ID. 2) change the basin specific CIN files and 3) change the
!  excel files that the input met data and the discharge data used for calibration.

SPECIAL>NOINTERACTION
SPECIAL>LOADMODEL|Ven GWLFHydro_SE6C_DOC.mdl

!Reset based and savelist and CIN changes to empty.  This ensures model starts
!  using default level parameters and that no old file remain in the sim control dialogue box


SIMULATE>BASED
SIMULATE>SAVELIST
SIMULATE>READCIN

!Read in basin specific information

SIMULATE>READCIN|Mal_Vattholma_SE6C_1.cin
SIMULATE>ADDCIN|Input_Files_Vattholma.cin
SIMULATE>ADDCIN|Mal_Vattholma_SE6_DOC_1.cin

!Step 1 optimize the PrecipCorr factor to WB1

SIMULATE>RUNNAME|Step1_SE6C_Vattholma_Method7
SIMULATE>PAYOFF|WB1_payoff.vpd
SIMULATE>OPTPARM|OptPrecipCorr1.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step1_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|!
MENU>VDF2TAB|Step1_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|!
MENU>VDF2TAB|Step1_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|!
MENU>VDF2TAB|Step1_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|!
MENU>VDF2TAB|Step1_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|!
MENU>VDF2TAB|Step1_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|!
MENU>VDF2TAB|Step1_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|!
MENU>VDF2TAB|Step1_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|!
MENU>VDF2DAT|Step1_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|!
MENU>VDF2DAT|Step1_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|!
MENU>VDF2DAT|Step1_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|!

!Step 2 optimize the runoff correction factor by comparing the total cumualtive simulated and measured runoff.

SIMULATE>READRUNCHG|Step1_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step2_SE6C_Vattholma_Method7
SIMULATE>PAYOFF|Cum_Runoff_payoff.vpd
SIMULATE>OPTPARM|Opt_Runoff_Adj.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step2_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step2_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step2_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step2_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step2_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step2_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step2_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step2_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step2_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step2_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step2_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!

!Step 3 optimize the MeltCoeff factor to streamflow

SIMULATE>READRUNCHG|Step2_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step3_SE6C_Vattholma_Method7
SIMULATE>PAYOFF|QRMS_payoff.vpd
SIMULATE>OPTPARM|Opt_MeltCoeff.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step3_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step3_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step3_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step3_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step3_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step3_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step3_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step3_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step3_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step3_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step3_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!


!Step 4 Optimize remaining Hydro model coefficients fixed coeffs from previous step and 
!  by comparing simulated gwflow with baseflow discharge based on hydrograph seperation.

SIMULATE>READRUNCHG|Step3_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step4_SE6C_Vattholma_Method7.vdf
SIMULATE>PAYOFF|GW_RMS_payoff.vpd
SIMULATE>OPTPARM|Opt_HydroBaseFlow.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step4_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step4_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step4_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step4_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step4_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step4_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step4_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step4_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step4_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step4_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step4_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!

! Step 5 Optimize slow recess coefficient and deep gw cap with 20th percentile slow baseflow
!

SIMULATE>READRUNCHG|Step4_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step5_SE6C_Vattholma_Method7.vdf
SIMULATE>PAYOFF|SlowGW_RMS_payoff.vpd
SIMULATE>OPTPARM|Opt_SlowGW.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step5_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step5_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step5_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step5_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step5_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step5_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step5_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step5_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step5_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step5_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step5_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!


!Step 6 Optimize the channel flow coefficient by comparing simulated and measured (hydro sep) runoff
!  with measured streamflow.

SIMULATE>READRUNCHG|Step5_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step6_SE6C_Vattholma_Method7.vdf
SIMULATE>PAYOFF| Runoff_RMS_payoff.vpd
SIMULATE>OPTPARM|Opt_ChannelFlow.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step6_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step6_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step6_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step6_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step6_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step6_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step6_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step6_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step6_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step6_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step6_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!


!Itteration 2 now that there is an inital optimization of all model coefficients
!  reoptimize the Precipitation coefficent to WB2 (ET limited by Soil Water Capacity)
!  Following this reoptimize all remaining model coefficients
!  NOTE to avoid saving too many runs these steps are saved over the previous 
!  runs 1-4

!Step 7 Optimize the ppt corr factor again now using WB2
SIMULATE>READRUNCHG|Step6_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step7_SE6C_Vattholma_Method7.vdf
SIMULATE>PAYOFF|WB2_payoff.vpd
SIMULATE>OPTPARM|OptPrecipCorr1.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step7_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step7_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step7_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step7_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step7_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step7_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step7_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step7_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step7_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step7_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step7_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!

!Step 8 optimize the runoff correction factor by comparing the total cumualtive simulated and measured runoff.

SIMULATE>READRUNCHG|Step7_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step8_SE6C_Vattholma_Method7
SIMULATE>PAYOFF|Cum_Runoff_payoff.vpd
SIMULATE>OPTPARM|Opt_Runoff_Adj.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step8_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step8_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step8_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step8_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step8_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step8_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step8_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step8_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step8_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step8_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step8_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!

!Step 9 optimize the MeltCoeff factor to streamflow

SIMULATE>READRUNCHG|Step8_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step9_SE6C_Vattholma_Method7
SIMULATE>PAYOFF|QRMS_payoff.vpd
SIMULATE>OPTPARM|Opt_MeltCoeff.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step9_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step9_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step9_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step9_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step9_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step9_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step9_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step9_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step9_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step9_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step9_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!


!Step 10 ReOptimize remaining Hydro model coefficients using ppt corr from previous step and 
!  by comparing simulated gwflow with baseflow discharge based on hydrograph seperation.
SIMULATE>READRUNCHG|Step9_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step10_SE6C_Vattholma_Method7.vdf
SIMULATE>PAYOFF|GW_RMS_payoff.vpd
SIMULATE>OPTPARM|Opt_HydroBaseFlow.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step10_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step10_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step10_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step10_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step10_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step10_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step10_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step10_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step10_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step10_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step10_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!


! Step 11 Optimize slow recess coefficient and deep gw cap with 20th percentile slow baseflow
!

SIMULATE>READRUNCHG|Step10_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step11_SE6C_Vattholma_Method7.vdf
SIMULATE>PAYOFF|SlowGW_RMS_payoff.vpd
SIMULATE>OPTPARM|Opt_SlowGW.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step11_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step11_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step11_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step11_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step11_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step11_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step11_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step11_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step11_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step11_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step11_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!

!Step 12 Optimize the channel flow coefficient by comparing the simulated channel flow
!  with measured streamflow.

SIMULATE>READRUNCHG|Step11_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step12_SE6C_Vattholma_Method7.vdf
SIMULATE>PAYOFF| Runoff_RMS_payoff.vpd
SIMULATE>OPTPARM|Opt_ChannelFlow.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step12_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step12_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step12_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step12_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step12_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step12_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step12_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step12_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step12_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step12_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step12_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!


!Step 13 Optimize both recess coefficients using GW RMS

SIMULATE>READRUNCHG|Step12_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step13_SE6C_Vattholma_Method7.vdf
SIMULATE>PAYOFF|GW_RMS_payoff.vpd
SIMULATE>OPTPARM|Opt_recess.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step13_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step13_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step13_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step13_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step13_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step13_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step13_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step13_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step13_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step13_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step13_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!


!Step 14 Optimize the ppt corr factor again now using WB2
SIMULATE>READRUNCHG|Step13_SE6C_Vattholma_Method7.vdf
SIMULATE>ADDCIN|Input_Files_Vattholma.cin

SIMULATE>RUNNAME|Step14_SE6C_Vattholma_Method7.vdf
SIMULATE>PAYOFF|WB2_payoff.vpd
SIMULATE>OPTPARM|OptPrecipCorr1.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step14_SE6C_Vattholma_Method7|Temp_Precip.tab|OptPrecipSave.lst|+!
MENU>VDF2TAB|Step14_SE6C_Vattholma_Method7|Temp_RunoffCorr.tab|OptRunoffCorrFactorSave.lst|+!
MENU>VDF2TAB|Step14_SE6C_Vattholma_Method7|Temp_MeltCoeff.tab|OptMeltCoeff.lst|+!
MENU>VDF2TAB|Step14_SE6C_Vattholma_Method7|Temp_RecessCoeff.tab|OptRecessCoeffSave.lst|+!
MENU>VDF2TAB|Step14_SE6C_Vattholma_Method7|Temp_SlowRecessCoeff.tab|OptSlowRecessCoeff.lst|+!
MENU>VDF2TAB|Step14_SE6C_Vattholma_Method7|Temp_SoilWaterCap.Tab|OptSoilWaterCapSave.lst|+!
MENU>VDF2TAB|Step14_SE6C_Vattholma_Method7|Temp_DeepGWCap.tab|OptDeepGWCap.lst|+!
MENU>VDF2TAB|Step14_SE6C_Vattholma_Method7|Temp_ChannelFlowCoeff.Tab|OptChannelFlowCoeffSave.lst|+!
MENU>VDF2DAT|Step14_SE6C_Vattholma_Method7|Temp_NSEstreamflow.dat|OptFinalNSE.lst|+!
MENU>VDF2DAT|Step14_SE6C_Vattholma_Method7|Temp_NSErunoff.dat|OptFinalNSE_runoff.lst|+!
MENU>VDF2DAT|Step14_SE6C_Vattholma_Method7|Temp_NSEbaseflow.dat|OptFinalNSE_baseflow.lst|+!

MENU>EXIT
