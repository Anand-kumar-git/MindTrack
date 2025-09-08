#!/bin/bash
set -e

echo "Starting new container..."

# Login to ECR
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com

# Extract image URI from imagedefinitions.json
IMAGE_URI=$(cat /home/ubuntu/app/imagedefinitions.json | jq -r '.[0].imageUri')

docker run -d --name my-app -p 80:80 $IMAGE_URI
