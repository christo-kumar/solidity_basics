#!/bin/bash

# Prompt for project name
read -p "Enter your project name: " project_name

# Create the parent directory
mkdir "$project_name"
cd "$project_name" || { echo "Failed to enter project directory"; exit 1; }

# Create and initialize the backend folder
mkdir backend
cd backend || { echo "Failed to enter backend directory"; exit 1; }

# Initialize npm and hardhat with JavaScript configuration
npm init -y
npx hardhat init --template javascript

# Remove unwanted files and directories
rm -f contracts/Lock.sol
rm -rf ignition
mkdir scripts

# Add the HelloSolidity Contract
cat > contracts/HelloSolidity.sol <<EOL
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.27;

contract HelloSolidity {
    string private messageHello;

    constructor() {
        messageHello = "Hello, Solidity!";
    }

    function getMessage() public view returns (string memory) {
        return messageHello;
    }

    function setMessage(string memory _msg) public {
        messageHello = _msg;
    }
}
EOL

# Set permissions for the contract file
chmod 644 contracts/HelloSolidity.sol

# Add the deployment script
cat > scripts/deploy.js <<EOL
const { ethers } = require("hardhat");
const fs = require("fs/promises");

async function main() {
  const helloContract = await ethers.deployContract("HelloSolidity");

  const artifact = await hre.artifacts.readArtifact("HelloSolidity");

  await writeDeploymentInfo(helloContract, artifact, "HelloSolidity.json");
}

async function writeDeploymentInfo(contract, artifact, filename = "") {
  const data = {
    contract: {
      address: contract.target,
      signerAddress: contract.runner.address,
      abi: artifact.abi,
    },
  };

  const content = JSON.stringify(data, null, 2);
  await fs.writeFile(filename, content, { encoding: "utf-8" });
}

main().catch((error) => {
  console.error("Error during deployment:", error);
  process.exitCode = 1;
});
EOL

# Set permissions for the deployment script
chmod 644 scripts/deploy.js

# Success message
echo "Project '$project_name' is successfully created and configured."
echo "Navigate to the backend directory and start developing your project!"
echo "Also configure your metamask wallet for local hosting"
