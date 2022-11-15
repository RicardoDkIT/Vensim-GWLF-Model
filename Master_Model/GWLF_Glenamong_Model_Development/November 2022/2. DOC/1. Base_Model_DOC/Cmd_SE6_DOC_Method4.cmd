! ************************************ Model DOC caibration workflow 4 ************************************
! Using a spin up period
!
!This calibration preforms the following steps
!
!Step 1 optimize anaerobic temp dependent decomposition, slow rate and ratio by comparing simulated and 
!   measured concentrations.  Comparison is only made a the time of measured concentrations
!Step 2 optimize andecomp the anaerobic temp dependent decomposition during times when the unsaturated zone was near SWC
!Step 3 optimize aerdecomp the aerobic moisture depedent decomposition rate during times when the unsaturated zone was below SWC 
!Step 4 optimize the mineral soil adjustment factor to measured concentrations.
!Step 5  optimize hydrology slow rate and ratio by comparing simulated and measured concentrations under all conditions.
!Step 5 reoptimize andecomp the anaerobic temp dependent decomposition during times when the unsaturated zone was near SWC
!Step 7 reoptimize aerdecomp rate the aerobic moisture depedent decomposition rate during times when the unsaturated zone was below SWC
!Step 8 reoptimize the mineral soil adjustment factor to measured concentrations. 

! This workflow is set up to run with a spin up period that will bring the model state variables to a good inital state at the
! Start of the actual optimization which is defined by the start of the DOC measurments used in calibration.
!
!Simulation are output to separate temporary files.  At the end fo the calibration these 
!are combined into a single file that will show how all parameter values change.
!between steps

!TO RUN ON DIFFERENT BASIN 1) use a text editor to change the basin ID (ie Glenamong) in the different
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

SIMULATE>READCIN|Glenamong_Hydrology_1.cin
SIMULATE>ADDCIN|Glenamong_InputFiles.cin
SIMULATE>ADDCIN|Glenamong_DOC_1.cin

!Step 1 optimize the sim DOC concentration directly to the meas DOC

SIMULATE>RUNNAME|Step1_DOC_SE6C_Glenamong_DOCMethod4
SIMULATE>PAYOFF|Sim_vs_Meas_Concs2.vpd
SIMULATE>OPTPARM|ThreeDOCparameters.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step1_DOC_SE6C_Glenamong_DOCMethod4|Temp_Andecomp.tab|OptAndecomp.lst|!
MENU>VDF2TAB|Step1_DOC_SE6C_Glenamong_DOCMethod4|Temp_Aerdecomp_rate.tab|OptAerdecomp_rate.lst|!
MENU>VDF2TAB|Step1_DOC_SE6C_Glenamong_DOCMethod4|Temp_SlowRate.tab|OptSlowRate.lst|!
MENU>VDF2TAB|Step1_DOC_SE6C_Glenamong_DOCMethod4|Temp_ratio.tab|OptRatio.lst|!
MENU>VDF2TAB|Step1_DOC_SE6C_Glenamong_DOCMethod4|Temp_MinSoilAdj.tab|OptMinSoilAdj.lst|!
MENU>VDF2DAT|Step1_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_Conc.dat|Final_NSE_DOC_Conc.lst|!
MENU>VDF2DAT|Step1_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_DailyLoad.dat|Final_NSE_DOC_DailyLoads.lst|!
MENU>VDF2DAT|Step1_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_MoLoad.dat|Final_NSE_DOC_MoLoads.lst|!

!Step 2 optimize andecomp the anaerobic temp dependent decomposition during times when the unsaturated zone was near SWC

SIMULATE>READRUNCHG|Step1_DOC_SE6C_Glenamong_DOCMethod4.vdf
SIMULATE>ADDCIN|Glenamong_InputFiles.cin

SIMULATE>RUNNAME|Step2_DOC_SE6C_Glenamong_DOCMethod4
SIMULATE>PAYOFF|Sim_vs_Meas_SatDOC.vpd
SIMULATE>OPTPARM|Andecomp.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step2_DOC_SE6C_Glenamong_DOCMethod4|Temp_Andecomp.tab|OptAndecomp.lst|+!
MENU>VDF2TAB|Step2_DOC_SE6C_Glenamong_DOCMethod4|Temp_Aerdecomp_rate.tab|OptAerdecomp_rate.lst|+!
MENU>VDF2TAB|Step2_DOC_SE6C_Glenamong_DOCMethod4|Temp_SlowRate.tab|OptSlowRate.lst|+!
MENU>VDF2TAB|Step2_DOC_SE6C_Glenamong_DOCMethod4|Temp_ratio.tab|OptRatio.lst|+!
MENU>VDF2TAB|Step2_DOC_SE6C_Glenamong_DOCMethod4|Temp_MinSoilAdj.tab|OptMinSoilAdj.lst|+!
MENU>VDF2DAT|Step2_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_Conc.dat|Final_NSE_DOC_Conc.lst|+!
MENU>VDF2DAT|Step2_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_DailyLoad.dat|Final_NSE_DOC_DailyLoads.lst|+!
MENU>VDF2DAT|Step2_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_MoLoad.dat|Final_NSE_DOC_MoLoads.lst|+!

!Step 3 optimize aerdecomp rate the aerobic moisture depedent decomposition rate during times when the unsaturated zone was below SWC 

SIMULATE>READRUNCHG|Step2_DOC_SE6C_Glenamong_DOCMethod4.vdf
SIMULATE>ADDCIN|Glenamong_InputFiles.cin

SIMULATE>RUNNAME|Step3_DOC_SE6C_Glenamong_DOCMethod4
SIMULATE>PAYOFF|Sim_vs_Meas_UnSatDOC.vpd
SIMULATE>OPTPARM|AerdecompRate.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step3_DOC_SE6C_Glenamong_DOCMethod4|Temp_Andecomp.tab|OptAndecomp.lst|+!
MENU>VDF2TAB|Step3_DOC_SE6C_Glenamong_DOCMethod4|Temp_Aerdecomp_rate.tab|OptAerdecomp_rate.lst|+!
MENU>VDF2TAB|Step3_DOC_SE6C_Glenamong_DOCMethod4|Temp_SlowRate.tab|OptSlowRate.lst|+!
MENU>VDF2TAB|Step3_DOC_SE6C_Glenamong_DOCMethod4|Temp_ratio.tab|OptRatio.lst|+!
MENU>VDF2TAB|Step3_DOC_SE6C_Glenamong_DOCMethod4|Temp_MinSoilAdj.tab|OptMinSoilAdj.lst|+!
MENU>VDF2DAT|Step3_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_Conc.dat|Final_NSE_DOC_Conc.lst|+!
MENU>VDF2DAT|Step3_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_DailyLoad.dat|Final_NSE_DOC_DailyLoads.lst|+!
MENU>VDF2DAT|Step3_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_MoLoad.dat|Final_NSE_DOC_MoLoads.lst|+!

!Step 4 optimize the mineral soil adjustment factor to measured Concentrations

SIMULATE>READRUNCHG|Step3_DOC_SE6C_Glenamong_DOCMethod4.vdf
SIMULATE>ADDCIN|Glenamong_InputFiles.cin

SIMULATE>RUNNAME|Step4_DOC_SE6C_Glenamong_DOCMethod4
SIMULATE>PAYOFF|Sim_vs_Meas_Concs2.vpd
SIMULATE>OPTPARM|MineralAdj.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step4_DOC_SE6C_Glenamong_DOCMethod4|Temp_Andecomp.tab|OptAndecomp.lst|+!
MENU>VDF2TAB|Step4_DOC_SE6C_Glenamong_DOCMethod4|Temp_Aerdecomp_rate.tab|OptAerdecomp_rate.lst|+!
MENU>VDF2TAB|Step4_DOC_SE6C_Glenamong_DOCMethod4|Temp_SlowRate.tab|OptSlowRate.lst|+!
MENU>VDF2TAB|Step4_DOC_SE6C_Glenamong_DOCMethod4|Temp_ratio.tab|OptRatio.lst|+!
MENU>VDF2TAB|Step4_DOC_SE6C_Glenamong_DOCMethod4|Temp_MinSoilAdj.tab|OptMinSoilAdj.lst|+!
MENU>VDF2DAT|Step4_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_Conc.dat|Final_NSE_DOC_Conc.lst|+!
MENU>VDF2DAT|Step4_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_DailyLoad.dat|Final_NSE_DOC_DailyLoads.lst|+!
MENU>VDF2DAT|Step4_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_MoLoad.dat|Final_NSE_DOC_MoLoads.lst|+!

!Step5  optimize hydrology slow rate and ratio by comparing simulated and measured concentrations under all conditions.

SIMULATE>READRUNCHG|Step4_DOC_SE6C_Glenamong_DOCMethod4.vdf
SIMULATE>ADDCIN|Glenamong_InputFiles.cin

SIMULATE>RUNNAME|Step5_DOC_SE6C_Glenamong_DOCMethod4
SIMULATE>PAYOFF|Sim_vs_Meas_Concs2.vpd
SIMULATE>OPTPARM|Hyd_parameters.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step5_DOC_SE6C_Glenamong_DOCMethod4|Temp_Andecomp.tab|OptAndecomp.lst|+!
MENU>VDF2TAB|Step5_DOC_SE6C_Glenamong_DOCMethod4|Temp_Aerdecomp_rate.tab|OptAerdecomp_rate.lst|+!
MENU>VDF2TAB|Step5_DOC_SE6C_Glenamong_DOCMethod4|Temp_SlowRate.tab|OptSlowRate.lst|+!
MENU>VDF2TAB|Step5_DOC_SE6C_Glenamong_DOCMethod4|Temp_ratio.tab|OptRatio.lst|+!
MENU>VDF2TAB|Step5_DOC_SE6C_Glenamong_DOCMethod4|Temp_MinSoilAdj.tab|OptMinSoilAdj.lst|+!
MENU>VDF2DAT|Step5_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_Conc.dat|Final_NSE_DOC_Conc.lst|+!
MENU>VDF2DAT|Step5_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_DailyLoad.dat|Final_NSE_DOC_DailyLoads.lst|+!
MENU>VDF2DAT|Step5_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_MoLoad.dat|Final_NSE_DOC_MoLoads.lst|+!

!Step 6 reoptimize andecomp the anaerobic temp dependent decomposition during times when the unsaturated zone was near SWC

SIMULATE>READRUNCHG|Step5_DOC_SE6C_Glenamong_DOCMethod4.vdf
SIMULATE>ADDCIN|Glenamong_InputFiles.cin

SIMULATE>RUNNAME|Step6_DOC_SE6C_Glenamong_DOCMethod4
SIMULATE>PAYOFF|Sim_vs_Meas_SatDOC.vpd
SIMULATE>OPTPARM|Andecomp.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step6_DOC_SE6C_Glenamong_DOCMethod4|Temp_Andecomp.tab|OptAndecomp.lst|+!
MENU>VDF2TAB|Step6_DOC_SE6C_Glenamong_DOCMethod4|Temp_Aerdecomp_rate.tab|OptAerdecomp_rate.lst|+!
MENU>VDF2TAB|Step6_DOC_SE6C_Glenamong_DOCMethod4|Temp_SlowRate.tab|OptSlowRate.lst|+!
MENU>VDF2TAB|Step6_DOC_SE6C_Glenamong_DOCMethod4|Temp_ratio.tab|OptRatio.lst|+!
MENU>VDF2TAB|Step6_DOC_SE6C_Glenamong_DOCMethod4|Temp_MinSoilAdj.tab|OptMinSoilAdj.lst|+!
MENU>VDF2DAT|Step6_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_Conc.dat|Final_NSE_DOC_Conc.lst|+!
MENU>VDF2DAT|Step6_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_DailyLoad.dat|Final_NSE_DOC_DailyLoads.lst|+!
MENU>VDF2DAT|Step6_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_MoLoad.dat|Final_NSE_DOC_MoLoads.lst|+!

!Step 8 optimize aerdecomp rate the aerobic moisture depedent decomposition rate during times when the unsaturated zone was below SWC 

SIMULATE>READRUNCHG|Step6_DOC_SE6C_Glenamong_DOCMethod4.vdf
SIMULATE>ADDCIN|Glenamong_InputFiles.cin

SIMULATE>RUNNAME|Step7_DOC_SE6C_Glenamong_DOCMethod4
SIMULATE>PAYOFF|Sim_vs_Meas_UnSatDOC.vpd
SIMULATE>OPTPARM|AerdecompRate.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step7_DOC_SE6C_Glenamong_DOCMethod4|Temp_Andecomp.tab|OptAndecomp.lst|+!
MENU>VDF2TAB|Step7_DOC_SE6C_Glenamong_DOCMethod4|Temp_Aerdecomp_rate.tab|OptAerdecomp_rate.lst|+!
MENU>VDF2TAB|Step7_DOC_SE6C_Glenamong_DOCMethod4|Temp_SlowRate.tab|OptSlowRate.lst|+!
MENU>VDF2TAB|Step7_DOC_SE6C_Glenamong_DOCMethod4|Temp_ratio.tab|OptRatio.lst|+!
MENU>VDF2TAB|Step7_DOC_SE6C_Glenamong_DOCMethod4|Temp_MinSoilAdj.tab|OptMinSoilAdj.lst|+!
MENU>VDF2DAT|Step7_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_Conc.dat|Final_NSE_DOC_Conc.lst|+!
MENU>VDF2DAT|Step7_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_DailyLoad.dat|Final_NSE_DOC_DailyLoads.lst|+!
MENU>VDF2DAT|Step7_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_MoLoad.dat|Final_NSE_DOC_MoLoads.lst|+!

!Step 8 optimize the mineral soil adjustment factor to measured Concentrations

SIMULATE>READRUNCHG|Step7_DOC_SE6C_Glenamong_DOCMethod4.vdf
SIMULATE>ADDCIN|Glenamong_InputFiles.cin

SIMULATE>RUNNAME|Step8_DOC_SE6C_Glenamong_DOCMethod4
SIMULATE>PAYOFF|Sim_vs_Meas_Concs2.vpd
SIMULATE>OPTPARM|MineralAdj.voc
MENU>RUN_OPTIMIZE|o
MENU>VDF2TAB|Step8_DOC_SE6C_Glenamong_DOCMethod4|Temp_Andecomp.tab|OptAndecomp.lst|+!
MENU>VDF2TAB|Step8_DOC_SE6C_Glenamong_DOCMethod4|Temp_Aerdecomp_rate.tab|OptAerdecomp_rate.lst|+!
MENU>VDF2TAB|Step8_DOC_SE6C_Glenamong_DOCMethod4|Temp_SlowRate.tab|OptSlowRate.lst|+!
MENU>VDF2TAB|Step8_DOC_SE6C_Glenamong_DOCMethod4|Temp_ratio.tab|OptRatio.lst|+!
MENU>VDF2TAB|Step8_DOC_SE6C_Glenamong_DOCMethod4|Temp_MinSoilAdj.tab|OptMinSoilAdj.lst|+!
MENU>VDF2DAT|Step8_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_Conc.dat|Final_NSE_DOC_Conc.lst|+!
MENU>VDF2DAT|Step8_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_DailyLoad.dat|Final_NSE_DOC_DailyLoads.lst|+!
MENU>VDF2DAT|Step8_DOC_SE6C_Glenamong_DOCMethod4|Temp_Final_NSE_Doc_MoLoad.dat|Final_NSE_DOC_MoLoads.lst|+!

MENU>EXIT
