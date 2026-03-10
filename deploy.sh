#!/bin/bash

# =============================
# Mini CI/CD Deployment Script
# =============================

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
NC="\033[0m" # No Color

# 1️⃣ Pull latest changes
echo -e "${YELLOW}Pulling latest changes from Git...${NC}"
git pull origin main || { echo -e "${RED}Git pull failed!${NC}"; exit 1; }

# 2️⃣ Stop & remove old container (if exists)
CONTAINER_NAME="avinwebproject"
if [ $(docker ps -aq -f name=$CONTAINER_NAME) ]; then
    echo -e "${YELLOW}Stopping old container...${NC}"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# 3️⃣ Build & start container
echo -e "${YELLOW}Rebuilding Docker container...${NC}"
docker compose up -d --build --force-recreate || { echo -e "${RED}Docker rebuild failed!${NC}"; exit 1; }

# 4️⃣ Show container status
echo -e "${GREEN}✅ Deployment complete! Current containers:${NC}"
docker ps

# 5️⃣ Optional: Tail logs
echo -e "${YELLOW}Tailing logs (Press Ctrl+C to stop)...${NC}"
docker compose logs -f
