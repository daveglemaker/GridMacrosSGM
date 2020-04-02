/*******************************************************************************
            Macro name: gjobs
              Location: <SASCONFIGDIR>/LevN/SASApp/SASEnvironment/SASMacro
            Written by: Dave Glemaker, David.Glemaker@sas.com.
         Creation date: April 11 2019.
            As of date: March 11 2020.
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001.
               Purpose: List Grid Job information for active user
                 Usage: %gjobs
            Parameters: none
   Optional Parameters: none
     Data sets created: work.gjobs
File Reference created: gjobs 
           Limitations:
                 Notes: requires xcmd turned on and grid client CLI configured
                        requires authinfo file to reside in users home directory
                        requires &gauconfigdir, 
                        ex. /sas/sasconfig/Lev1/Applications/GridAdminUtiility
               History: 04/24/2019 Dave Glemaker added Documentation
                        03/11/2020 Dave Glemaker added Disclaimer
     Sample Macro call: %gjobs
This macro is made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.
*******************************************************************************/

%macro gjobs;
filename gjobs pipe "&gauconfigdir/sas-grid-cli.sh --mhost &mhost --mport &mport --authinfo ~/.authinfo show-jobs --state all";

data gjobs;
   infile gjobs missover dlm=' ' firstobs=6;
      length id $25. state $20. user $10. name $18. queue $15. executionhost $20. submittime $20. starttime $20.;
      input ID STATE USER NAME 37-55  QUEUE EXECUTIONHOST 69-84 SUBMITTIME  STARTTIME;
      label id='JobID'
            state='State'
            user='User'
            name='Job Name'
            queue='Queue'
            executionhost='Execution Host'
            submittime='Submit Time'
            starttime='Start Time';
run;
title "Grid Job Listing";
proc print label;
   run;
title;
%mend gjobs;
