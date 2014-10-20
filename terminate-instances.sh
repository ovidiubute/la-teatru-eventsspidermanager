#!/bin/bash

###########################################################
#
# terminate-instances.sh
#
# Shuts down all instances found in given file (generated
# by ec2-run-instances command)
#
# Parameters:
# 1. Path to running instances file
# 
# Author: ovidiu
#
###########################################################

# Functions import
source functions.sh

if [ "$#" -ne "1" ]; then
  printError "Usage: ./terminate-instances.sh <INSTANCE_FILE>"
  exit 1
fi

RUNNING_INSTANCES_FILE=$1

if [ -f $RUNNING_INSTANCES_FILE ]; then
  printInfo "Terminating instances..."
  while read line; do
    instance_id=`echo $line | grep "INSTANCE" | awk '{print $2}'`
    if [ -n "$instance_id" ]; then
      printInfo "Terminating instance $instance_id"
      ec2-terminate-instances $instance_id
    fi
  done < $RUNNING_INSTANCES_FILE
else
  printError "File not found $RUNNING_INSTANCES_FILE"
  exit 2
fi
