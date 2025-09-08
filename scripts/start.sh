#!/bin/bash
set -e

echo "Starting new container.."

# Login to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 787755074992.dkr.ecr.ap-south-1.amazonaws.com

# Extract image URI from imagedefinitions.json
IMAGE_URI=$(cat /home/ubuntu/app/imagedefinitions.json | jq -r '.[0].imageUri')

docker run -d --name my-app -p 9050:80 $IMAGE_URI
