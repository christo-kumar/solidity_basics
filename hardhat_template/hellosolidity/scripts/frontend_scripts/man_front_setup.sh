#start creating the frontend
#be at root folder which contains backend folder
cd ..
npx create-react-app frontend
cd frontend

npm install --save ethers
npm install react-bootstrap bootstrap react-router-dom

#remove App.css, App.test.js, logo.svg, reportWebVitals, setupTests.js
rm -f src/App.css
rm -f src/App.test.js
rm -f src/logo.svg
rm -f src/reportWebVitals.js
rm -f src/setupTests.js
rm -f src/index.css

#remove, add and update index.js
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

#add contract.js
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

#update App.js,
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

#copy address and abi from HelloSolidity.json

#start react site
npm start

