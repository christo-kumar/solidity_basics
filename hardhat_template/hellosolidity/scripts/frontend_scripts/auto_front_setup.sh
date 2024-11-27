#!/bin/bash

# Step 1: Create Primary Project Directory and Navigate
read -p "Enter the project name: " PROJECT_NAME
# Validate input
if [ -z "$PROJECT_NAME" ]; then
  echo "Error: Project name cannot be empty."
  exit 1
fi
# Create and navigate into the project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || { echo "Failed to navigate to $PROJECT_NAME"; exit 1; }

# Step 2: Create React App (Frontend)
npx create-react-app frontend
cd frontend

# Step 3: Install Required Dependencies
npm install --save ethers
npm install react-bootstrap bootstrap react-router-dom

# Step 4: Remove Unnecessary Files
rm -f src/App.css src/App.test.js src/logo.svg src/reportWebVitals.js src/setupTests.js src/index.css

# Step 5: Configure index.js
rm -f src/index.js
cat > src/index.js <<EOL
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOL
chmod 644 src/index.js

# Step 6: Add contract.js
cat > src/contract.js <<EOL
import { ethers } from "ethers";

const address = "";
const abi = [];

const provider = new ethers.BrowserProvider(window.ethereum);

export const connect = async () => {
  await provider.send("eth_requestAccounts", []);
  return getContract();
};

export const getContract = async () => {
  const signer = provider.getSigner();
  const contract = new ethers.Contract(address, abi, signer);
  return { signer: signer, contract: contract };
};
EOL
chmod 644 src/contract.js

# Step 7: Configure App.js
rm -f src/App.js
cat > src/App.js <<EOL
import React, { useState } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import { connect } from "./contract";

function App() {
  const [connected, setConnected] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");

  const handleConnect = async () => {
    try {
      await connect(); // Invoke the connect function from contract.js
      setConnected(true); // Update the state to indicate successful connection
      setErrorMessage(""); // Clear any previous error message
      console.log("Connected to MetaMask successfully.");
    } catch (error) {
      setConnected(false); // Ensure connected status is false on error
      setErrorMessage(error.message || "Failed to connect to MetaMask.");
      console.error("Error connecting to MetaMask:", error);
    }
  };

  return (
    <div className="App">
      <div className="container text-center mt-5">
        <h1>Welcome to Hello Solidity App</h1>
        <p>
          {connected
            ? "You are connected to MetaMask!"
            : "Click the button below to connect your MetaMask wallet."}
        </p>
        <button
          className="btn btn-primary"
          onClick={handleConnect}
          disabled={connected}
        >
          {connected ? "Connected" : "Connect to MetaMask"}
        </button>
        {errorMessage && (
          <div className="alert alert-danger mt-3" role="alert">
            {errorMessage}
          </div>
        )}
      </div>
    </div>
  );
}

export default App;
EOL
chmod 644 src/App.js

echo "Frontend React project has been created and configured inside $PROJECT_NAME/frontend."

#chmod +x AutoFrontendSetup.sh
#./AutoFrontendSetup.sh