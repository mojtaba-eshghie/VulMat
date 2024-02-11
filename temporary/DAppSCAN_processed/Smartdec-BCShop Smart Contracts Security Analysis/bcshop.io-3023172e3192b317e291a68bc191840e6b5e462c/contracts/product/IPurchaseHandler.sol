// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/product/IPurchaseHandler.sol

pragma solidity ^0.4.18;

/**@dev Interface of custom PurchaseHandler that performs additional work after payment is made */
contract IPurchaseHandler {
    function handlePurchase(address buyer, uint256 unitsBought, uint256 price) public {}
}
