#!/bin/bash
set -e

echo "Starting new container..."

# Login to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 787755074992.dkr.ecr.ap-south-1.amazonaws.com

# Extract image URI from imagedefinitions.json (corrected path)
IMAGE_DEF_FILE="/home/ec2-user/app/imagedefinitions.json"

if [ ! -f "$IMAGE_DEF_FILE" ]; then
  echo "ERROR: $IMAGE_DEF_FILE not found!"
  exit 1
fi

IMAGE_URI=$(jq -r '.[0].imageUri' "$IMAGE_DEF_FILE")

if [ -z "$IMAGE_URI" ] || [ "$IMAGE_URI" == "null" ]; then
  echo "ERROR: Could not extract imageUri from $IMAGE_DEF_FILE"
  exit 1
fi

# Stop old container if already running
if [ "$(docker ps -q -f name=my-app)" ]; then
  echo "Stopping old container..."
  docker stop my-app
  docker rm my-app
fi

# Run new container
echo "Running container from image: $IMAGE_URI"
docker run -d --name my-app -p 3000:80 "$IMAGE_URI"

echo "Application started successfully."
