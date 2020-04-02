/*******************************************************************************
            Macro name: lsload
              Location: <SASCONFIGDIR>/LevN/SASApp/SASEnvironment/SASMacro
            Written by: Dave Glemaker, David.Glemaker@sas.com.
         Creation date: April 11 2019.
            As of date: March 11 2020.
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001.
               Purpose: List Grid Host with thier loads
                 Usage: %lsload
            Parameters: none
   Optional Parameters: none
     Data sets created: work.lsldmerge lsload.hosts lsload.hosts_dynamicinfo
File Reference created: jslsload lsload
           Limitations:
                 Notes: requires xcmd turned on and grid client CLI configured
                        requires authinfo file to reside in users home directory
                        requires &gauconfigdir, 
                        ex. /sas/sasconfig/Lev1/Applications/GridAdminUtiility
               History: 04/24/2019 Dave Glemaker added Documentation
                        08/15/2019 David Glemaker added format statement
                        08/15/2019 David Glemaker added saswork var to label 
                          and format statement, saswork was defined as a 
                          resource to grid configuration
                        03/11/2020 Dave Glemaker added Disclaimer
     Sample Macro call: %lsload
This macro is made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.
*******************************************************************************/

%macro lsload;
filename jslsload pipe "&gauconfigdir/sas-grid-cli.sh --mhost &mhost --mport &mport --authinfo ~/.authinfo --output json show-hosts";
filename lsload temp;
data _null_;
   infile jslsload missover firstobs=5;
   file lsload;
   input ;
   put _infile_;
run; 

libname lsload json;run;

data lsldmerge(drop=ordinal_root ordinal_hosts fqdn version ordinal_dynamicInfo lastUpdateTime hostClosed licenseValid licenseType jobsRunning jobsSuspended);
   merge lsload.hosts lsload.hosts_dynamicinfo;
   by ordinal_hosts;
   format utilization runQueue15s runQueue1m runQueue15m diskIORate netIORate ioRate pgRate 6.2 usedMemory usedSwap usedTemp saswork comma17.;
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
         usedTemp='Used Temp'
         saswork='SASWork Available'; 
run;
title "Grid Load Listing";
proc print label;
run;
title;
%mend lsload;
