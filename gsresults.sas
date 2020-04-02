/*******************************************************************************
            Macro name: gsresults
              Location: <SASCONFIGDIR>/LevN/SASApp/SASEnvironment/SASMacro
            Written by: Dave Glemaker, David.Glemaker@sas.com.
         Creation date: April 11 2019.
            As of date: March 11 2020.
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001.
               Purpose: List Grid Job information for active user
                 Usage: %gsresults
            Parameters: none
   Optional Parameters: none
     Data sets created: work.results
File Reference created: results
           Limitations:
                 Notes: requires xcmd on and sasgsub configured on gridnodes
                        requires authinfo file to reside in users home directory
                        requires &gsconfigdir to be set in autoexec or pre-code
                        .../Lev1/Applications/SASGridManagerClientUtility/9.4
               History: 04/24/2019 Dave Glemaker added Documentation
                        03/11/2020 Dave Glemaker added Disclaimer
     Sample Macro call: %gsresults or %gsresults(jobid=1202) 
                        or %gsresults(jobid=all,mydir=/tmp)
This macro is made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.
*******************************************************************************/

%macro gsresults(jobid=all, mydir=/tmp);
options spool;
 filename results pipe "&gsconfigdir./sasgsub -gridgetresults &jobid -gridresultsdir &mydir";
data results;
   infile results dlm="," missover truncover;
   length Result_Status $100. Start $100. End $100. RC $10.;
   input Result_Status Start End RC;
   if substr(Result_Status,1,1) in ("S","C"," ") then delete;
run;
title "Move Results JobID &jobid to &mydir";
proc print data=results;
  var Result_Status ;
run;
options nospool;
%mend gsresults;

