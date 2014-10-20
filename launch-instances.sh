#!/bin/bash

#####################################################
#
# launch-instances.sh
#
# Launches instances of event spiders.
#
# Parameters:
# 1. Number of instances
# 2. Path to the file to print output
# 
# Author: ovidiu
#
#####################################################

# Env import
source env.sh
# Functions import
source functions.sh

if [ "$#" -ne "2" ]; then
  printError "Usage: ./launch-instances.sh <INSTANCE_COUNT> <OUTPUT_FILE>"
  exit 1
fi

INSTANCE_COUNT=$1
OUTPUT_FILE=$2

printInfo "Launching instances..."
ec2-run-instances $SPIDER_AMI \
                  -n $INSTANCE_COUNT \
                  -k $SPIDER_VM_KEY \
                  -z $SPIDER_VM_ZONE \
                  -g $SPIDER_SECURITY \
                  -t $SPIDER_VM_TYPE \
                  > $OUTPUT_FILE
