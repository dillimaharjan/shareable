#!/bin/bash

if [ ! -e "refresh.conf" ]; then
    echo "Configuration file refresh.conf is missing. Please check configuration files"
    exit 1
elif [ ! -e "refresh.lib" ]; then
    echo "Library file refresh.lib is missing. Please check configuration files"
    exit 1
fi

source  /opt/DBrefresh/refresh.conf
source  /opt/DBrefresh/refresh.lib

export ORACLE_SID=${DEST_DB}
export ORACLE_HOME=/u01/app/oracle/product/12.1.0/dbhome1

# Creates export directory before expdp full database prior to refresh
[ ${M_createExportDir} == "Y" ] && createExportDir

# Export full database prior to database refresh
[ ${M_backupAUXDB} == "Y" ] && backupAUXDB

# List all the database files and stores in variables so that it can be checked the files are removed properly while dropping database.
[ ${M_saveDBFiles} == "Y" ] && saveDBFiles

# Generate spool file with alter command to reset password while post refresh
[ ${M_saveUserCredentail} == "Y" ] && saveUserCredentail

# Dropping auxuliary(Dest) Database.
[ ${M_dropAUXDB} == "Y" ] && dropAUXDB

# Verify that log files are removed properly while dropping database
[ ${M_validateDBfilesDrop} == "Y" ] && validateDBfilesDrop

# Creates rman script file to execute
[ ${M_createRMANScript} == "Y" ] && createRMANScript

# Creates password file
[ ${M_createPwdfile} == "Y" ] && createPwdfile

# Starts database in nomount mode
[ ${M_startDB} == "Y" ] && startDB ${TNSTEMP} "nomount"

# Execute rman script to duplicate database.
[ ${M_execRMANRestoreRecover} == "Y" ] && execRMANDuplicate

# Renaming database if database is cloned from active database.
[ ${M_renameDestDB} == "Y" ] && renameDestDB

# Perform post refresh script
[ ${M_performPostRefresh} == "Y" ] &&  performPostRefresh

# Perform datapatch apply
[ ${M_applyDatapatch} == "Y" ] && applyDatapatch

# Perform logfile cleanup
[ ${M_cleanLogFiles} == "Y" ] && cleanLogFiles 30

# Print success message to logfile
END_DATE=$(date +%s)
echo "Refresh task completed successfully at $(date +%Y-%m-%d_%H%M%S) Elapsed Time:   $((  ${END_DATE} - ${START_DATE}  )) Seconds." >> ${LOG_FILE}

# Email output to DBA
[ ${M_emailSummary} == "Y" ] && emailSummary
