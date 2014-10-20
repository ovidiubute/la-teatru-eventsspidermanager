#!/bin/bash

#####################################################
#
# run-month.sh
#
# Launch and send job requests to event spiders.
# Default parameters for jobs are current year/month.
#
# Parameters:
# 1. (optional) Run for next month
# 
# Author: ovidiu
#
######################################################

# Functions import

source /opt/eventsspidermanager/functions.sh

printInfo "Starting eventsspidermanager"

./launch-instances.sh $SPIDER_VM_COUNT $RUNNING_INSTANCES_FILE

while read line; do
  instance_id=`echo $line | grep "INSTANCE" | awk '{print $2}'`
  if [ ! -n "$instance_id" ]; then
    # First line is reservation...
    continue
  fi
  instance_state=`echo $line | grep "instance_id" | awk '{print $4}'`
  while [ "$instance_state" != "running" ]; do
    printInfo "Instance $instance_id not ready yet. Sleeping 30s..."
    sleep 30
    instance_state=`ec2-describe-instances $instance_id | grep "INSTANCE" | awk '{print $6}'`
  done
  instance_ip=`ec2-describe-instances $instance_id | grep "INSTANCE" | awk '{print $5}'`
  # ssh init on boot takes longer sometimes, compensate
  printInfo "Waiting 120s for instances to configure ssh..."
  sleep 120
  if [[ "$1" == "-next" ]]; then
    # Date parameters set for next month
    YEAR=`date --date="1 month" +%Y`
    MONTH=`date --date="1 month" +%m`
    # Launch job for next month!
    ./remote-run-month.sh $instance_ip $YEAR $MONTH $SPIDER_USERNAME $SPIDER_KEY
  else
    # Date parameters set for current month
    YEAR=`date -u +%Y`
    MONTH=`date -u +%m`
    # Launch job for current month!
    ./remote-run-month.sh $instance_ip $YEAR $MONTH $SPIDER_USERNAME $SPIDER_KEY
  fi  
done < $RUNNING_INSTANCES_FILE

# Kill spiders
./terminate-instances.sh $RUNNING_INSTANCES_FILE
 
# Cleanup
printInfo "Cleaning up..."
rm $RUNNING_INSTANCES_FILE

printInfo "Exiting eventsspidermanager"
