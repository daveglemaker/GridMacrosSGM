/*******************************************************************************
            Macro name: mygsubwait
              Location: <SASCONFIGDIR>/LevN/SASApp/SASEnvironment/SASMacro
            Written by: Dave Glemaker, David.Glemaker@sas.com.
         Creation date: April 11 2019.
            As of date: March 11 2020.
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001.
               Purpose: Submit a sas program with sasgsub with the wait option
                        and List Grid Job information for that job
                 Usage: %mygsubwait(mypgm)
            Parameters: mypgm=fully qualified path and filename of sas program
   Optional Parameters: none
     Data sets created: work.mygsubjob
File Reference created: results
           Limitations:
                 Notes: requires xcmd on and sasgsub configured on gridnodes 
                        requires authinfo file to reside in users home directory
                        requires &gsconfigdir to be set in autoexec or pre-code
                        .../Lev1/Applications/SASGridManagerClientUtility/9.4
               History: 04/24/2019 Dave Glemaker added Documentation
                        03/11/2020 Dave Glemaker added Disclaimer
     Sample Macro call: %mygsubwait(/myshared_dir/pgms/sleep1.sas)
This macro is made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.
*******************************************************************************/

%macro mygsubwait(mypgm);
options spool;
filename results pipe "&gsconfigdir./sasgsub -gridsubmitpgm &mypgm -gridwait";
data mygsubjob;
   infile results dlm=":" missover truncover;
   length Job $200. Info $200. info2 $200. ;
   input Job Info Info2;
   if substr(job,1,1) not in ("J") then delete;
   if substr(info2,1,1) not in (" ") then info=compress(info)||":"||compress(info2);
run;
title "My SASGSUB Job";
proc print data=mygsubjob; where info ne " ";
var job info;
run;

options nospool;
%mend mygsubwait;
