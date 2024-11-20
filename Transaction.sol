// SPDX-License-Identifier: GPL-3.0

//Compiler Version for solidity
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract Transaction {
    //Getting money INTO smart contract
    function getMoney() external payable {
        console.log('Amount Recieved: ', address(this).balance);
    }

    //Transferring money FROM smart contract
    function transferMoneyTo(address payable recipient) external {
        recipient.transfer(address(this).balance);
        console.log('Amount Left: ', address(this).balance);
    }
}