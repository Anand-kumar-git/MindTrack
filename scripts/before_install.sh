#!/bin/bash
set -e

echo "Ensuring Docker is running..."

if ! sudo systemctl is-active --quiet docker; then
  sudo systemctl start docker
fi

sudo usermod -aG docker ec2-user
