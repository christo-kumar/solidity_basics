// SPDX-License-Identifier: GPL-3.0

//Compiler Version for solidity
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract Memory {
    //1 Storage: Persisted on blockchain
    //2 Memory: Not Persisted on blockchain
    //3 Stack: Local Variable
    //4 CallData: Array coming in as parameter

    struct User {
        string name;
    }

    User[] users;

    constructor() {
        User memory first = User("Abhinav");
        users.push(first);
    }

    function printUserName() external view {
        console.log(users[0].name);
    }

    function demoStorage() external {
        User storage user = users[0];
        user.name = "GunsNroses";
    }

    function demoMemory() external view {
        User memory user = users[0];
        user.name = "U2";
    }

    function demoStack() external pure {
        /*Local Variables are of stack type*/
        uint num1 = 5;
        uint num2 = 5;
        num2 = num1 + num2;
    }

    /*primitive array passed to function is of calldata type*/
    function demoCallData(uint[] calldata params) external {

    }
}