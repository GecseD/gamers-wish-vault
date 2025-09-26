#!/bin/bash
set -e  # exit on error

# Check if .env exists
if [ ! -f ".env" ]; then
  echo "Error: .env file not found!"
  echo "Please copy .env.example to .env and fill in your environment variables."
  exit 1
fi

# Build frontend
echo "Building frontend..."
cd client
npm install
npm run build
cd ..

# Start Docker Compose
echo "Starting backend and nginx..."
docker-compose up --build
