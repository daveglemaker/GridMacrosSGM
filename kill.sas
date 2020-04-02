/*******************************************************************************
            Macro name: kill
              Location: <SASCONFIGDIR>/LevN/SASApp/SASEnvironment/SASMacro
            Written by: Dave Glemaker, David.Glemaker@sas.com.
         Creation date: April 11 2019.
            As of date: March 11 2020.
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001.
               Purpose: Kills Grid job of jobid provided and List the status
                        of the kill command for that jobid
                 Usage: %kill(jobid)
            Parameters: jobid=numeric Grid Job ID or IDs
   Optional Parameters: none
     Data sets created: work.kill
File Reference created: kill
           Limitations:
                 Notes: requires xcmd turned on and grid client CLI configured
                        requires authinfo file to reside in users home directory
               History: 04/24/2019 Dave Glemaker added Documentation
                        03/11/2020 Dave Glemaker added Disclaimer
     Sample Macro call: %kill(1789)
                        %kill(1789 1790) 
This macro is made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.
*******************************************************************************/

%macro kill(jobid);
options spool;
filename kill pipe "&gauconfigdir/sas-grid-cli.sh --mhost &mhost --mport &mport --authinfo ~/.authinfo cancel-job --id &jobid";

data kill;
   infile kill missover dlm="?" firstobs=5;
   length JobInfo $200. ;
   input JobInfo;
run;
title "Cancel Job &jobid status";
proc print data=kill; where jobinfo ne " ";
var jobinfo;
run;

options nospool;
%mend kill;
