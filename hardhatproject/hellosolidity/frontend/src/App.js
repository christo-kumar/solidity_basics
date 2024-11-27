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
