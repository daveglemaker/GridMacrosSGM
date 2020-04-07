# SAS Grid Manager CLI and SASGSUB Macros
           SAS version: SAS 9.4M6 SAS Grid Manager Hotfix E3N001.
                        SAS® Workload Orchestrator Administration Utility,
                        (build date: May 17 2019 14:17:45)

Usage and Setup can be found in "SAS Grid and Gsub Macros 2019 SGM" powerpoint file

# Macros for the SAS User Role
- %mygsub %mygsubque - submit a .sas program with sasgsub
- %gjobs and %gsstatus – reports on job status
- %gsresults – move job results to a different directory
- %gskill – terminate a gsub job

# Macros for the SAS Admin role
- %gjobs – reports on job status of all users
- %bhosts – reports on Grid node status and number of jobs by machine
- %bqueues - reports on queue priority, status, and number of jobs by queue
- %lsload – reports on Grid node resources
- %kill – terminates a grid job
- %resume – resumes a suspended grid job
- %suspend – suspends a grid job

These macros are made available “as is” and disclaims any and all representations
and warranties, including without limitation, implied warranties of
merchantability, accuracy, and fitness for a particular purpose.