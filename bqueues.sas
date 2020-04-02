/*******************************************************************************
            Macro name: bqueues
              Location: <SASCONFIGDIR>/LevN/SASApp/SASEnvironment/SASMacro
            Written by: Dave Glemaker, David.Glemaker@sas.com.
         Creation date: April 11 2019.
            As of date: March 11 2020.
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001.
               Purpose: List Grid Queue Names, the state they are in, priority,
                        number of jobs running and pending on each, Max Jobs, 
                        and Max Jobs per Host
                 Usage: %bqueues
            Parameters: none
   Optional Parameters: none
     Data sets created: work.bqueues
File Reference created: bqueues
           Limitations:
                 Notes: requires xcmd turned on and grid client CLI configured
                        requires authinfo file to reside in users home directory
                        requires &gauconfigdir, 
                        ex. /sas/sasconfig/Lev1/Applications/GridAdminUtiility
               History: 04/24/2019 Dave Glemaker added Documentation
                        03/11/2020 Dave Glemaker added Disclaimer
     Sample Macro call: %bqueues
This macro is made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.
*******************************************************************************/

%macro bqueues;
filename bqueues pipe "&gauconfigdir/sas-grid-cli.sh --mhost &mhost --mport &mport --authinfo ~/.authinfo show-queues";

data bqueues;
   infile bqueues missover dlm=' ' firstobs=6;
      length name $25. state $20. priority 8. jobspending 8. jobsrunning 8. maxjobs 8. maxjobsperhost 8.;
      input NAME STATE PRIORITY JOBSPENDING JOBSRUNNING MAXJOBS MAXJOBSperHOST;
      label name='Name'
            state='State'
            priority='Priority'
            jobspending='Jobs Pending'
            jobsrunning='Jobs Running'
            maxjobs='Max Jobs'
            maxjobsperhost='Max Jobs/Hosts'
      ;
run;
title "Grid Queue Listing";
proc print label;
   var NAME STATE PRIORITY JOBSRUNNING JOBSPENDING MAXJOBS MAXJOBSperHOST;
run;
title;
%mend bqueues;
