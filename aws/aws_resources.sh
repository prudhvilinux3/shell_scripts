#!/bin/bash
#
#####################################################
# Author: Prudhvi B
# Date: 20th Oct 2025 
# Purpose: To get the AWS resources as below:
# S3 Buckets
# EC2 Instances 
# Lamdas
# IAM users
# ###################################################
#
 
echo " Below are the details of EC2 Instances" 

aws ec2 describe-instances --query "Reservations[*].Instances[*].{ID:InstanceId,Type:InstanceType,Status:State.Name}" --output table

echo " List of IAM users and their last Loging" 

aws iam list-users --query "Users[*].{Name:UserName,When_last_login:PasswordLastUsed}" --output table

echo "Lst of buckets with creation date" 

aws s3api list-buckets --query "Buckets[*].{Name:Name,Created:CreationDate}" --output table
