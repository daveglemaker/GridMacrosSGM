/*******************************************************************************
            Macro name: resume
              Location: <SASCONFIGDIR>/LevN/SASApp/SASEnvironment/SASMacro
            Written by: Dave Glemaker, David.Glemaker@sas.com.
         Creation date: April 11 2019.
            As of date: March 11 2020.
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001.
               Purpose: Resumess Grid job of jobid provided and List the status
                        of the resume command for that jobid
                 Usage: %resume(jobid)
            Parameters: jobid=numeric Grid Job ID or IDs
   Optional Parameters: none
     Data sets created: work.resume
File Reference created: resume
           Limitations:
                 Notes: requires xcmd turned on and grid client CLI configured
                        requires authinfo file to reside in users home directory
               History: 04/24/2019 Dave Glemaker added Documentation
                        03/11/2020 Dave Glemaker added Disclaimer
     Sample Macro call: %resume(1789)
                        %resume(1789 1790)
This macro is made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.
*******************************************************************************/

%macro resume(jobid);
options spool;
filename resume pipe "&gauconfigdir/sas-grid-cli.sh --mhost &mhost --mport &mport --authinfo ~/.authinfo resume-job --id &jobid";

data resume;
   infile resume missover dlm="?" firstobs=5;
   length JobInfo $200. ;
   input JobInfo;
run;
title "Resume Job &jobid status";
proc print data=resume; where jobinfo ne " ";
var jobinfo;
run;

options nospool;
%mend resume;
