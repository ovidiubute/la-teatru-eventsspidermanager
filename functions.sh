#!/bin/bash

#####################################################
#
# functions.sh
#
# General use functions.
# 
# Author: ovidiu
#
#####################################################

export MANAGER_DIR="/opt/eventsspidermanager"
source $MANAGER_DIR/env.sh

# Check for log file
log_dir=`dirname $LOG_FILE`
if [ ! -d $log_dir ]; then
  mkdir -p $log_dir
  touch $LOG_FILE
fi

function printInfo {
  echo `eval date --rfc-3339=seconds` " : INFO  : $1" | tee -a $LOG_FILE
}

function printError {
  echo `eval date --rfc-3339=seconds` " : ERROR  : $1" | tee -a $LOG_FILE
}

function printWarn {
  echo `eval date --rfc-3339=seconds` " : WARN  : $1" | tee -a $LOG_FILE
}
