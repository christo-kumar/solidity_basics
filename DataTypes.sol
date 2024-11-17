// SPDX-License-Identifier: GPL-3.0

//Compiler Version for solidity
pragma solidity >=0.7.0 <0.9.0;

contract DataTypes {
    //ownerName, shopName, ownerAge, ownerAddress, ownerDP, isSmallScale
    string public ownerName;
    string public shopName;
    uint public ownerAge;
    address public ownerAddress;
    bytes public ownerDP;
    bool public isSmallScale;

    constructor() {
        ownerName = "Abhinav Kumar";
        shopName = "four Blocks";
        ownerAge = 40;
        //wallet address of invoker
        ownerAddress = msg.sender;
        ownerDP = "some base64 string";
        isSmallScale = false;
    }
}