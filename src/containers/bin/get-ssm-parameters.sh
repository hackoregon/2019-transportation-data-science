#! /bin/bash

# Pulls in HackO API env var values as parameters from AWS Parameter Store
# Depends on pre-installed awscli

# Modelled on https://aws.amazon.com/blogs/compute/managing-secrets-for-amazon-ecs-applications-using-parameter-store-and-iam-roles-for-tasks/

EC2_REGION="us-west-2" # unfortunately cannot rely on dynamic env var values that this script is meant to pull in
NAMESPACE="/production/2018/API" # future-proofing this script for subsequent or past containers
PROJECT_CANONICAL_NAME="backend-exemplar" # must be set to each project's "Final naming convention" from here https://github.com/hackoregon/civic-devops/issues/1

# Get unencrypted values
POSTGRES_HOST=`aws ssm get-parameters --names "$NAMESPACE"/"$PROJECT_CANONICAL_NAME"/POSTGRES_HOST --no-with-decryption --region $EC2_REGION --output text | awk '{print $4}'`
POSTGRES_NAME=`aws ssm get-parameters --names "$NAMESPACE"/"$PROJECT_CANONICAL_NAME"/POSTGRES_NAME --no-with-decryption --region $EC2_REGION --output text | awk '{print $4}'`
POSTGRES_PORT=`aws ssm get-parameters --names "$NAMESPACE"/"$PROJECT_CANONICAL_NAME"/POSTGRES_PORT --no-with-decryption --region $EC2_REGION --output text | awk '{print $4}'`
POSTGRES_USER=`aws ssm get-parameters --names "$NAMESPACE"/"$PROJECT_CANONICAL_NAME"/POSTGRES_USER --no-with-decryption --region $EC2_REGION --output text | awk '{print $4}'`

# Note: this env var value is for the WSGI startup - corresponds to the folder name where the base Django project is stored in the repo
PROJECT_NAME=`aws ssm get-parameters --names "$NAMESPACE"/"$PROJECT_CANONICAL_NAME"/PROJECT_NAME --no-with-decryption --region $EC2_REGION --output text | awk '{print $4}'`

# Get encrypted values
DJANGO_SECRET_KEY=`aws ssm get-parameters --names "$NAMESPACE"/"$PROJECT_CANONICAL_NAME"/DJANGO_SECRET_KEY --with-decryption --region $EC2_REGION --output text | awk '{print $4}'`
POSTGRES_PASSWORD=`aws ssm get-parameters --names "$NAMESPACE"/"$PROJECT_CANONICAL_NAME"/POSTGRES_PASSWORD --with-decryption --region $EC2_REGION --output text | awk '{print $4}'`

# Set environment variables in the container
export DJANGO_SECRET_KEY=$DJANGO_SECRET_KEY
export POSTGRES_HOST=$POSTGRES_HOST
export POSTGRES_NAME=$POSTGRES_NAME
export POSTGRES_PASSWORD=$POSTGRES_PASSWORD
export POSTGRES_PORT=$POSTGRES_PORT
export POSTGRES_USER=$POSTGRES_USER
export PROJECT_NAME=$PROJECT_NAME
