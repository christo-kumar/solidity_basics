#Go to the directory where you want to create the project

#install node if not installed, validate by checking version
npm -v
#install hardhat if not installed
npm install --save-dev hardhat 

mkdir “project_name”
cd “project_name”

#start creating the backend
mkdir backend
cd backend
npm init
npx hardhat init
#Configure projects by removing unwanted files and adding wanted folders
rm -f contracts/Lock.sol
rm -rf ignition
mkdir scripts

#Add HelloSolidity Contract to contracts folder
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

#make the file read write
chmod 644 contracts/HelloSolidity.sol

#Add Deployment Script
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

#make the file read write
chmod 644 scripts/deploy.js

#make sure to manually save HelloSolidity.sol
sudo npx hardhat compile
sudo npx hardhat node
#create new terminal window
sudo npx hardhat run scripts/deploy.js --network localhost

# Now configure the metamask wallet and import accounts
