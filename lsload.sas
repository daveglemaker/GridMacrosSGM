/*******************************************************************************
            Macro name: lsload
              Location: <SASCONFIGDIR>/LevN/SASApp/SASEnvironment/SASMacro
            Written by: Dave Glemaker, David.Glemaker@sas.com.
         Creation date: April 11 2019.
            As of date: April 2 2020.
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001,E3N001,E3Q016la
                        E3Y006pt,E3Y008pt
                        SAS® Workload Orchestrator Administration Utility,
                        Version 9.4M6 (build date: Sep 17 2019 @ 09:50:02)
               Purpose: List Grid Host with thier loads
                 Usage: %lsload
            Parameters: none
   Optional Parameters: none
     Data sets created: work.lsldmerge lsload.hosts lsload.hosts_dynamicinfo
File Reference created: jslsload lsload
           Limitations:
                 Notes: requires xcmd turned on and grid client CLI configured
                        requires authinfo file to reside in users home directory
               History: 04/24/2019 Dave Glemaker added Documentation
                        03/11/2020 Dave Glemaker added Disclaimer
     Sample Macro call: %lsload
This macro is made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.
*********************************************************************************/

%macro lsload;
filename jslsload pipe "&gauconfigdir/sas-grid-cli.sh --mhost &mhost --mport &mport --authinfo ~/.authinfo --output json show-hosts";
filename lsload temp;
data _null_;
   infile jslsload missover /*firstobs=5*/;
   file lsload;
   input ;
   put _infile_;
run; 

libname lsload json;run;

data lsldmerge(drop=ordinal_root ordinal_hosts fqdn version ordinal_dynamicInfo lastUpdateTime hostClosed licenseValid licenseType jobsRunning jobsSuspended);
   merge lsload.hosts lsload.hosts_dynamicinfo;
   by ordinal_hosts;
   label name='Name'
         state='State'
         licenseExpireDate='License Expire Date'
         utilization='CPU Util'
         runQueue15s='r15s'
         runQueue1m='r1m'
         runQueue15m='r15m'
         diskIORate='Disk IO Rate'
         netIORate='Net IO Rate'
         ioRate='IO Rate'
         pgRate='Page Rate' 
         usedMemory='Used Mem' 
         usedSwap='Used Swap'
         usedTemp='Used Temp'; 
run;
title "Grid Load Listing";
proc print label;
run;
title;
Axis1
        STYLE=1
        WIDTH=1
        MINOR=NONE


;
Axis2
        STYLE=1
        WIDTH=1


;
TITLE;
TITLE1 "Bar Chart";
FOOTNOTE;
FOOTNOTE1 "Generated by the SAS System (&_SASSERVERNAME, &SYSSCPL) on %TRIM(%QSYSFUNC(DATE(), NLDATE20.)) at %TRIM(%SYSFUNC
(TIME(), TIMEAMPM12.))";
PROC GCHART DATA=WORK.lsldmerge
;
        VBAR3D
         name
 /
        SUMVAR=utilization
        SHAPE=BLOCK
FRAME   TYPE=SUM
SUM
        NOLEGEND
        COUTLINE=BLACK
        RAXIS=AXIS1
        MAXIS=AXIS2
PATTERNID=MIDPOINT
        LREF=1
        CREF=BLACK
        REF=.1 .25 .5 .75 1.0
;
/* -------------------------------------------------------------------
   End of task code
   ------------------------------------------------------------------- */
RUN; QUIT;
TITLE; FOOTNOTE;
%mend lsload;
