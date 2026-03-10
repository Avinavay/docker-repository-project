#!/bin/bash
# Simple local “CI/CD” deploy script
echo "Pulling latest changes..."
git pull origin main

echo "Rebuilding Docker container..."
docker compose up -d
