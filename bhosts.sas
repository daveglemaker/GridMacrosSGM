/*******************************************************************************
            Macro name: bhosts
              Location: <SASCONFIGDIR>/LevN/SASApp/SASEnvironment/SASMacro
            Written by: Dave Glemaker, David.Glemaker@sas.com.
         Creation date: April 11 2019.
            As of date: March 11 2020.
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001.
               Purpose: List Grid Host Names, the state they are in, number of
                        jobs running and suspended on each, and Operating System
                 Usage: %bhosts
            Parameters: none
   Optional Parameters: none
     Data sets created: work.bhosts
File Reference created: bhosts
           Limitations: 
                 Notes: requires xcmd turned on and grid client CLI configured 
                        requires authinfo file to reside in users home directory
                        requires &gauconfigdir, 
                        ex. /sas/sasconfig/Lev1/Applications/GridAdminUtiility
               History: 04/24/2019 Dave Glemaker added Documentation
                        03/11/2020 Dave Glemaker added Disclaimer
     Sample Macro call: %bhosts
This macro is made available “as is” and disclaims any and all representations 
and warranties, including without limitation, implied warranties of 
merchantability, accuracy, and fitness for a particular purpose.
*******************************************************************************/    

%macro bhosts;
filename bhosts pipe "&gauconfigdir/sas-grid-cli.sh --mhost &mhost --mport &mport --authinfo ~/.authinfo show-hosts";

data bhosts;
   infile bhosts missover dlm=' ' firstobs=6;
      length name $25. state $20. maxjobsallowed 8. jobsrunning 8. jobssuspended 8. operatingsystem $25.;
      input NAME STATE MAXJOBSALLOWED JOBSRUNNING JOBSSUSPENDED  OPERATINGSYSTEM;     
      label name='Name'
            state='State'
            maxjobsallowed='Max Jobs Allowed'
            jobsrunning='Jobs Running'
            jobssuspended='Jobs Suspended'
            operatingsystem='Operating System';
run;
title "Grid Host Listing";
proc print label;
   run;
title;
%mend bhosts;
