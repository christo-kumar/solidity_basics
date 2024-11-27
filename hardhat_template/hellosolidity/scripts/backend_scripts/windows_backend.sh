@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Prompt for project name
set /p PROJECT_NAME="Enter your project name: "

:: Create the parent project folder
mkdir "%PROJECT_NAME%"
cd "%PROJECT_NAME%" || exit /b 1

:: Create and initialize the backend folder
mkdir backend
cd backend || exit /b 1

:: Initialize npm and hardhat with JavaScript configuration
npm init -y
npx hardhat init --template javascript

:: Remove unwanted files and directories (Windows command to delete files)
del /f /q contracts\Lock.sol
rd /s /q ignition
mkdir scripts

:: Add the HelloSolidity contract
echo // SPDX-License-Identifier: GPL-3.0 > contracts\HelloSolidity.sol
echo pragma solidity ^0.8.27; >> contracts\HelloSolidity.sol
echo. >> contracts\HelloSolidity.sol
echo contract HelloSolidity { >> contracts\HelloSolidity.sol
echo     string private messageHello; >> contracts\HelloSolidity.sol
echo. >> contracts\HelloSolidity.sol
echo     constructor() { >> contracts\HelloSolidity.sol
echo         messageHello = "Hello, Solidity!"; >> contracts\HelloSolidity.sol
echo     } >> contracts\HelloSolidity.sol
echo. >> contracts\HelloSolidity.sol
echo     function getMessage() public view returns (string memory) { >> contracts\HelloSolidity.sol
echo         return messageHello; >> contracts\HelloSolidity.sol
echo     } >> contracts\HelloSolidity.sol
echo. >> contracts\HelloSolidity.sol
echo     function setMessage(string memory _msg) public { >> contracts\HelloSolidity.sol
echo         messageHello = _msg; >> contracts\HelloSolidity.sol
echo     } >> contracts\HelloSolidity.sol
echo } >> contracts\HelloSolidity.sol

:: Add the deployment script
echo const { ethers } = require("hardhat"); > scripts\deploy.js
echo const fs = require("fs/promises"); >> scripts\deploy.js
echo. >> scripts\deploy.js
echo async function main() { >> scripts\deploy.js
echo   const helloContract = await ethers.deployContract("HelloSolidity"); >> scripts\deploy.js
echo. >> scripts\deploy.js
echo   const artifact = await hre.artifacts.readArtifact("HelloSolidity"); >> scripts\deploy.js
echo. >> scripts\deploy.js
echo   await writeDeploymentInfo(helloContract, artifact, "HelloSolidity.json"); >> scripts\deploy.js
echo } >> scripts\deploy.js
echo. >> scripts\deploy.js
echo async function writeDeploymentInfo(contract, artifact, filename = "") { >> scripts\deploy.js
echo   const data = { >> scripts\deploy.js
echo     contract: { >> scripts\deploy.js
echo       address: contract.target, >> scripts\deploy.js
echo       signerAddress: contract.runner.address, >> scripts\deploy.js
echo       abi: artifact.abi, >> scripts\deploy.js
echo     }, >> scripts\deploy.js
echo   }; >> scripts\deploy.js
echo. >> scripts\deploy.js
echo   const content = JSON.stringify(data, null, 2); >> scripts\deploy.js
echo   await fs.writeFile(filename, content, { encoding: "utf-8" }); >> scripts\deploy.js
echo } >> scripts\deploy.js
echo. >> scripts\deploy.js
echo main().catch((error) => { >> scripts\deploy.js
echo   console.error("Error during deployment:", error); >> scripts\deploy.js
echo   process.exitCode = 1; >> scripts\deploy.js
echo }); >> scripts\deploy.js

:: Success message
echo Project "%PROJECT_NAME%" is successfully created and configured.
echo Navigate to the backend directory and start developing your project!
echo Also configure your MetaMask wallet for local hosting.

ENDLOCAL
pause
