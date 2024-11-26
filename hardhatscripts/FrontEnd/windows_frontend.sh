@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Step 1: Prompt for Project Name
set /p PROJECT_NAME="Enter the project name: "

:: Validate Input
if "%PROJECT_NAME%"=="" (
    echo Error: Project name cannot be empty.
    exit /b 1
)

:: Step 2: Create Primary Project Directory and Navigate
mkdir "%PROJECT_NAME%"
cd "%PROJECT_NAME%" || exit /b 1

:: Step 3: Create React App (Frontend)
npx create-react-app frontend
cd frontend || exit /b 1

:: Step 4: Install Required Dependencies
npm install --save ethers
npm install react-bootstrap bootstrap react-router-dom

:: Step 5: Remove Unnecessary Files
del /f /q src\App.css src\App.test.js src\logo.svg src\reportWebVitals.js src\setupTests.js src\index.css

:: Step 6: Configure index.js
echo import React from "react"; > src\index.js
echo import ReactDOM from "react-dom/client"; >> src\index.js
echo import App from "./App"; >> src\index.js
echo. >> src\index.js
echo const root = ReactDOM.createRoot(document.getElementById("root")); >> src\index.js
echo root.render( >> src\index.js
echo   <React.StrictMode> >> src\index.js
echo     <App /> >> src\index.js
echo   </React.StrictMode> >> src\index.js
echo ); >> src\index.js

:: Step 7: Add contract.js
echo import { ethers } from "ethers"; > src\contract.js
echo. >> src\contract.js
echo const address = ""; >> src\contract.js
echo const abi = []; >> src\contract.js
echo. >> src\contract.js
echo const provider = new ethers.BrowserProvider(window.ethereum); >> src\contract.js
echo. >> src\contract.js
echo export const connect = async () => { >> src\contract.js
echo   await provider.send("eth_requestAccounts", []); >> src\contract.js
echo   return getContract(); >> src\contract.js
echo }; >> src\contract.js
echo. >> src\contract.js
echo export const getContract = async () => { >> src\contract.js
echo   const signer = provider.getSigner(); >> src\contract.js
echo   const contract = new ethers.Contract(address, abi, signer); >> src\contract.js
echo   return { signer: signer, contract: contract }; >> src\contract.js
echo }; >> src\contract.js

:: Step 8: Configure App.js
del /f /q src\App.js
echo import React, { useState } from "react"; > src\App.js
echo import "bootstrap/dist/css/bootstrap.min.css"; >> src\App.js
echo import { connect } from "./contract"; >> src\App.js
echo. >> src\App.js
echo function App() { >> src\App.js
echo   const [connected, setConnected] = useState(false); >> src\App.js
echo   const [errorMessage, setErrorMessage] = useState(""); >> src\App.js
echo. >> src\App.js
echo   const handleConnect = async () => { >> src\App.js
echo     try { >> src\App.js
echo       await connect(); >> src\App.js
echo       setConnected(true); >> src\App.js
echo       setErrorMessage(""); >> src\App.js
echo       console.log("Connected to MetaMask successfully."); >> src\App.js
echo     } catch (error) { >> src\App.js
echo       setConnected(false); >> src\App.js
echo       setErrorMessage(error.message || "Failed to connect to MetaMask."); >> src\App.js
echo       console.error("Error connecting to MetaMask:", error); >> src\App.js
echo     } >> src\App.js
echo   }; >> src\App.js
echo. >> src\App.js
echo   return ( >> src\App.js
echo     <div className="App"> >> src\App.js
echo       <div className="container text-center mt-5"> >> src\App.js
echo         <h1>Welcome to Hello Solidity App</h1> >> src\App.js
echo         <p> >> src\App.js
echo           {connected >> src\App.js
echo             ? "You are connected to MetaMask!" >> src\App.js
echo             : "Click the button below to connect your MetaMask wallet."} >> src\App.js
echo         </p> >> src\App.js
echo         <button >> src\App.js
echo           className="btn btn-primary" >> src\App.js
echo           onClick={handleConnect} >> src\App.js
echo           disabled={connected} >> src\App.js
echo         > >> src\App.js
echo           {connected ? "Connected" : "Connect to MetaMask"} >> src\App.js
echo         </button> >> src\App.js
echo         {errorMessage && ( >> src\App.js
echo           <div className="alert alert-danger mt-3" role="alert"> >> src\App.js
echo             {errorMessage} >> src\App.js
echo           </div> >> src\App.js
echo         )} >> src\App.js
echo       </div> >> src\App.js
echo     </div> >> src\App.js
echo   ); >> src\App.js
echo } >> src\App.js
echo. >> src\App.js
echo export default App; >> src\App.js

:: Completion Message
echo Frontend React project has been created and configured inside %PROJECT_NAME%\frontend.
pause
