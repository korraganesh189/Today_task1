#!/bin/bash

# Set your AWS credentials
export AWS_ACCESS_KEY_ID="AKIA3SZ52I736MTVJVWE"
export AWS_SECRET_ACCESS_KEY="dWayQTNu6+AtJI8vdXDXVAikKs84YLCVHW/lUg/9"
export AWS_DEFAULT_REGION="us-west-1"  # Replace with your desired AWS region

# Set the EC2 instance details
INSTANCE_TYPE="t2.micro"
AMI_ID="ami-087bf433bedbc2ef7"  # Replace with the desired AMI ID
KEY_PAIR_NAME="tata"  # Replace with the desired key pair name
SECURITY_GROUP_NAME="default"  # Replace with the desired security group name

# Create the EC2 instance 
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_PAIR_NAME \
  --security-groups $SECURITY_GROUP_NAME \
  --query 'Instances[0].InstanceId' \
  --output text)

# Wait for the instance to be in a running state
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

# Retrieve the public IP address of the instance
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

# Output the instance details
echo "EC2 instance created successfully!"
echo "Instance ID: $INSTANCE_ID"
echo "Public IP: $PUBLIC_IP"




