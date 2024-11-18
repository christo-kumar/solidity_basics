// SPDX-License-Identifier: GPL-3.0

//Compiler Version for solidity
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract DataTypes {

    event ShopStatus(string shopState);

    enum ShopState {
        Open,
        Closed
    }

    struct Shop {
        string ownerName;
        string shopName;
        uint ownerAge;
        address ownerAddress;
        bytes ownerDP;
        bool isSmallScale;
        ShopState shopState;
    }

    Shop public firstShop;
    Shop[] public shoppingMall;
    mapping(string => Shop[]) market;

    constructor() {
        firstShop = Shop("Abhinav", "Four Blocks", 65, msg.sender, "someBase64String", false, ShopState.Closed);
        shoppingMall.push(firstShop);
        market["walmart"] = shoppingMall; 
    }

    function logShop() public {
        Shop[] memory walmart = market["walmart"];
        for(uint i; i<walmart.length;i++){
            Shop memory shop = shoppingMall[i];
            
            //require(shop.shopState == ShopState.Open, 'In order to complete the transaction, Shop should be open');
            /*if(shop.shopState == ShopState.Closed) {
                revert('In order to complete the transaction, Shop should be open');
            }*/
            assert(shop.shopState == ShopState.Open);
             
            console.log('OwnerName: ', shop.ownerName);
            console.log('OwnerName: ', shop.ownerName);
            if (shop.shopState == ShopState.Open) {
                console.log("Shop is open");
            } else {
                console.log("Shop is closed");
            }

            shop.shopState = ShopState.Closed;
            emit ShopStatus("Shop_Is_Closed");
        }
    }
}