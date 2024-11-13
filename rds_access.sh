#!/bin/bash

# Define variables
ROLE_NAME="EC2RDSFullAccessRole"
POLICY_NAME="EC2RDSFullAccessPolicy"
POLICY_ARN="arn:aws:iam::601139476230:policy/$POLICY_NAME"
POLICY_DOCUMENT='{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "rds:Describe*",
        "rds:Connect",
        "rds:ListTagsForResource",
        "rds:DescribeDBInstances",
        "rds:DescribeDBSecurityGroups",
        "rds:DescribeDBParameterGroups",
        "rds:DescribeDBClusterEndpoints",
        "rds:DescribeDBClusters"
      ],
      "Resource": "*"
    }
  ]
}'

# Step 1: Create the IAM role
aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}'

# Check if role creation succeeded
if [ $? -ne 0 ]; then
  echo "Failed to create IAM role $ROLE_NAME"
  exit 1
fi

echo "IAM role $ROLE_NAME created successfully."

# Step 2: Create the policy
aws iam create-policy --policy-name $POLICY_NAME --policy-document "$POLICY_DOCUMENT"

# Check if policy creation succeeded
if [ $? -ne 0 ]; then
  echo "Failed to create IAM policy $POLICY_NAME"
  exit 1
fi

echo "IAM policy $POLICY_NAME created successfully."

# Step 3: Attach the policy to the role
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN

# Check if policy attachment succeeded
if [ $? -ne 0 ]; then
  echo "Failed to attach policy $POLICY_NAME to role $ROLE_NAME"
  exit 1
fi

echo "Policy $POLICY_NAME attached to role $ROLE_NAME successfully."

echo "IAM role with EC2 and RDS permissions created successfully."
