#!/bin/bash
set -e

echo "Stopping existing container..."
docker stop my-app || true
docker rm my-app || true
