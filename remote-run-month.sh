#!/bin/bash

#####################################################
#
# remote-run-month.sh
#
# Executes a job on a remote VM and captures output
# to stdout.
#
# Parameters:
# 1. VM IP (preferably internal)
# 2/3. Job parameters:
#   a. YEAR (yyyy)
#   b. MONTH (mm)
# 4. Username to login with
# 5. Private key to use on ssh login
# 
# Author: ovidiu
#
#####################################################

# Functions import
source functions.sh

if [ "$#" -ne "5" ]; then
  printError "Usage: ./remote-run-month.sh <HOST> <YEAR> <MONTH> <USER> <PKEY>"
  exit 1
fi

REMOTE_HOST=$1
YEAR=$2
MONTH=$3
SPIDER_USER=$4
SPIDER_KEY=$5

# Clean known_hosts file
cat /dev/null > /home/${SPIDER_USER}/.ssh/known_hosts

printInfo "Launching month job on remote instance: $instance_ip with parameters: YEAR=$YEAR, MONTH=$MONTH"
ssh -o 'StrictHostKeyChecking=no' -i $SPIDER_KEY ${SPIDER_USER}@${REMOTE_HOST} "cd /opt/eventspider/bin && ./run-spiders-month.sh $YEAR $MONTH" | tee -a $LOG_FILE
