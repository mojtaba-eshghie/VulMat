// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/product/IFeePolicy.sol

pragma solidity ^0.4.18;


/**Abstraction of fee policy */
contract IFeePolicy {

    /**@dev Returns total fee amount depending on payment */
    function calculateFeeAmount(address owner, uint256 productId, uint256 payment) public returns(uint256);

    /**@dev Sends fee amount to service provider  */
    function sendFee() public payable;
}
