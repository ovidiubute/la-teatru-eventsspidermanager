#!/bin/bash

#####################################################
#
# env.sh
#
# Sets aws and application environment variables.
# 
# Author: ovidiu
#
#####################################################

#####################################################
#
# Amazon web services environment variables.
#
#####################################################
export EC2_URL="https://eu-west-1.ec2.amazonaws.com"
export EC2_PRIVATE_KEY="/opt/keys/pk-NDYPZVTFYZ322F73DAPCPKOBWBI5H75A.pem"
export EC2_CERT="/opt/keys/cert-NDYPZVTFYZ322F73DAPCPKOBWBI5H75A.pem"
export EC2_HOME="/opt/aws/apitools/ec2"
export PATH="$PATH:/opt/aws/bin"
export JAVA_HOME="/usr/lib/jvm/jre"

#####################################################
#
# Application specific environment variables.
#
#####################################################
export LOG_FILE="/var/eventsspidermanager/log/eventsspidermanager.log"
export RUNNING_INSTANCES_FILE="running_instances"
export SPIDER_AMI="ami-2b9ba75f"
export SPIDER_KEY="/home/eventspider/.ssh/id_rsa"
export SPIDER_SECURITY="ovi.events.spider.security"
export SPIDER_USERNAME="eventspider"
export SPIDER_VM_COUNT=1
export SPIDER_VM_KEY="ovi_spider"
export SPIDER_VM_TYPE="t1.micro"
export SPIDER_VM_ZONE="eu-west-1b"
