// SPDX-License-Identifier: GPL-3.0

//Compiler Version for solidity
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

//Car has a chassis
contract Car {
    Chassis private chassis;

    constructor(Chassis _chassis) {
        chassis = _chassis;
    }

    function getCarChassis() public view returns (string memory) {
       return chassis.getChassisNo();
    }
}

//chassis has a chassis number
contract Chassis {
    string private chassisNo;

    constructor(string memory _chassisNo) {
        chassisNo = _chassisNo;
    }

    function getChassisNo() public view returns (string memory) {
        return chassisNo;
    }
}