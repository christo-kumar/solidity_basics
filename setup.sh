#!/bin/bash

# Exit on error
set -e

# Use a temporary directory for npm cache to avoid permission issues
export npm_config_cache=/tmp/.npm-cache

# Prompt for the project name
echo "Enter the name for your decentralized project:"
read project_name

# Create the parent folder
mkdir -p "$project_name"
cd "$project_name"

echo "🚀 Initializing decentralized voting project: $project_name"

# Create backend (Hardhat project)
echo "🛠️ Setting up the backend..."
mkdir -p backend
cd backend
npm init -y

# Initialize Hardhat non-interactively
npm install --save-dev hardhat
npx hardhat init --template javascript

# Add a basic Hardhat configuration file
cat > hardhat.config.js <<EOL
require("@nomiclabs/hardhat-ethers");

module.exports = {
  solidity: "0.8.18",
};
EOL

# Create necessary directories
mkdir -p contracts
mkdir -p scripts

echo "✅ Backend setup complete."
cd ..

# Create frontend (React app)
echo "🎨 Setting up the frontend..."
npx create-react-app frontend
cd frontend
npm install react-bootstrap bootstrap react-router-dom ethers
echo "✅ Frontend setup complete."
cd ..

# Final output
echo "✅ Decentralized voting project '$project_name' is set up!"
echo "📂 Project structure:"
tree "$project_name"
