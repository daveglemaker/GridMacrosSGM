# SAS Grid Manager CLI and SASGSUB Macros
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001,E3N001,E3Q016la
                        E3Y006pt,E3Y008pt
                        SAS® Workload Orchestrator Administration Utility,
                        Version 9.4M6 (build date: Sep 17 2019  09:50:02)

Usage and Setup can be found in "SAS Grid and Gsub Macros 2019 SGM" powerpoint file

-Currently for Linux only, working on Windows version to be ready for end of Mar 2023.

## Macros for the SAS User Role
- %mygsub %mygsubque - submit a .sas program with sasgsub to the default queue or a named queue
- %gjobs and %gsstatus – reports on job status
- %gsresults – move job results to a different directory
- %gskill – terminate a gsub job

## Macros for the SAS Admin role
- %gjobs – reports on job status of all users
- %bhosts – reports on Grid node status and number of jobs by machine
- %bqueues - reports on queue priority, status, and number of jobs by queue
- %lsload – reports on Grid node resources
- %kill – terminates a grid job
- %resume – resumes a suspended grid job
- %suspend – suspends a grid job

## Install Steps
1. Copy all .sas Files to ...SASCOMPUTECONFIGDIR.../Lev1/SASApp/SASEnvironment/SASMacro  
           repeat for each server context as desired, i.e. Server context = SASApp
    
2. Edit ...SASCOMPUTECONFIGDIR.../Lev1/SASApp/appserver_autoexec_usermods.sas with code below for mygsub and CLI macros to work  
           change "Yourconfigdir" to your actual configuration directory and "sasgridswomasterhost" to your master host name.

           %let gsconfigdir=/Yourconfigdir/Lev1/Applications/SASGridManagerClientUtility/9.4;   
           %let gauconfigdir=/Yourconfigdir/Lev1/Applications/GridAdminUtility/;   
           %let mhost=sasgridswomasterhostname;   
           %let mport=8901;  
           
- Be sure to update your sasgsub.cfg to not prompt for password
- CLI macros assumes .authinfo file exist in user home directory  
-- Sample content of .authinfo file: default user sasdemo password {SAS002}1D57933958C580064BD3DCA81A33DFB2
           
### SMC setup
#### Enable xcmd, repeat for each server context desired, i.e. Server context = SASApp
 In SAS Management Console enable xcmd on Logical Workspace Server:
 1. Expand 'Server Manager'
 2. Expand Server Context i.e. SASApp
 3. Expand Logical Workspace Server i.e. 'SASApp - Logical Workspace Server'
 4. Right Click on Workspace Serve 'SASApp - Workspace Server' and Select Properties
 5. Click on 'Options' Tab
 6. Click on 'Advanced Options' Button
 7. Click on 'Launch Properties' Tab
 8. Click on 'Launch Properties' Tab
 9. Check the 'Allow XCMD' Box
 10. Click 'OK'
 11. Click 'OK'
#### Refresh Spawner
 In SAS Management Console Refresh Spawner:
 1. Expand 'Server Manager'
 2. Expand 'Object Spawner - YourServername
 3. Right Click on each Server and select 'Connect'
 4. Right Click on each Server and select 'Refresh Spawner' and click 'Yes',  Note: clicking 'Refresh' will not work, you must select 'Refresh Spawner'
    
 Now all NEW SASApp Sessions will be able to run SAS Grid Macros

## Disclaimer
These macros are made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.
