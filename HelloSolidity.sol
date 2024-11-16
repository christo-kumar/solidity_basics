// SPDX-License-Identifier: GPL-3.0

//Compiler Version for solidity
pragma solidity >=0.7.0 <0.9.0;

//Different Memory Location
//Storage
//Memory
//CallData
//Stack

//Smart Contract Name
contract HelloSolidity {
    //States of SmartContracts
    //Storage
    string private messageHello;

    //Constructor
    constructor() {
        messageHello = "Hello World";
    }

    //private internal external public
    //getter ~ view
    function getMessage() public view returns (string memory) {
        return messageHello;
    }

    //setter
    function setMessage(string memory _msg) public {
        string memory message = getMessage();
        messageHello = _msg;
    }

    function getSum() public pure returns (uint) {
        return 2 + 2;
    }
}