import { ethers } from "ethers";

const address = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
const abi = [
  {
    inputs: [],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "getMessage",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_msg",
        type: "string",
      },
    ],
    name: "setMessage",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

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

export async function getMessage() {
  try {
    // Use the provider directly for reading data (view function)
    const contract = new ethers.Contract(address, abi, provider);
    const message = await contract.getMessage();
    console.log("Message from contract:", message);
    return message;
  } catch (error) {
    console.error("Error fetching message:", error);
  }
}

export async function setMessage(newMessage) {
  try {
    const { contract } = await getContract(); // Get the contract with signer

    // Check if newMessage is not empty
    if (!newMessage || typeof newMessage !== "string") {
      throw new Error("Invalid message: Please provide a valid string.");
    }

    // Send the transaction to set the new message
    const tx = await contract.setMessage(newMessage);

    // Wait for the transaction to be mined
    const receipt = await tx.wait();

    // Log transaction details
    console.log("Transaction successful:", receipt.transactionHash);
    console.log("Message updated!");
  } catch (error) {
    console.error("Error setting message:", error.message || error);

    // Additional debugging information
    if (error.code) {
      console.error("Error code:", error.code);
    }

    if (error.data) {
      console.error("Error data:", error.data);
    }
  }
}
