/*******************************************************************************
            Macro name: gsstatus
              Location: <SASCONFIGDIR>/LevN/SASApp/SASEnvironment/SASMacro
            Written by: Dave Glemaker, David.Glemaker@sas.com.
         Creation date: April 11 2019.
            As of date: March 11 2020.
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001.
               Purpose: List Grid Job information for active user
                 Usage: %gsstatus
            Parameters: none
   Optional Parameters: none
     Data sets created: work.status
File Reference created: status
           Limitations:
                 Notes: requires xcmd on and sasgsub configured on gridnodes 
                        requires authinfo file to reside in users home directory
                        requires &gsconfigdir to be set in autoexec or pre-code
                        .../Lev1/Applications/SASGridManagerClientUtility/9.4
               History: 04/24/2019 Dave Glemaker added Documentation
                        03/11/2020 Dave Glemaker added Disclaimer
     Sample Macro call: %gsstatus or %gsstatus(jobid)
This macro is made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.
*********************************************************************************/

%macro gsstatus(jobid=all);
options spool;
filename results pipe "&gsconfigdir./sasgsub -gridgetstatus &jobid";
data status;
   infile results dlm="," missover truncover;
   length jobid $10. status $200. start $200. end $200. rc $10.;
   input status start end rc;
   if substr(status,1,1) in (" ","C","S","E") then delete;
   jobid=scan(status,1);
run;
title "My SASGSUB Jobs Status";
proc print data=status;
run;
options nospool;
%mend gsstatus;



