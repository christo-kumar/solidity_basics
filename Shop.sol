// SPDX-License-Identifier: GPL-3.0

//Compiler Version for solidity
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract DataTypes {
    
    struct Shop {
        string ownerName;
        string shopName;
        uint ownerAge;
        address ownerAddress;
        bytes ownerDP;
        bool isSmallScale;
    }

    Shop public firstShop;

    constructor() {
        firstShop = Shop("Abhinav", "Four Blocks", 65, msg.sender, "someBase64String", false);
    }

    function logShop() public {
        console.log('OwnerName: ', firstShop.ownerName);
        firstShop.ownerName = "Another Name";
        console.log('OwnerName: ', firstShop.ownerName);
    }
}