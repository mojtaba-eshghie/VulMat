// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/shop/IWallet.sol

pragma solidity ^0.4.18;

/**@dev Wallet that stores some amount of currency (eth or tokens) */
contract IWallet {

    //
    // Methods

    /**@dev Returns balance of the wallet */
    function getBalance() public constant returns (uint256) {}
    
    /**@dev Withdraws caller's share */
    function withdraw(uint amount) public;

    /**@dev Withdraws caller's share to a given address */
    function withdrawTo(address to, uint256 amount) public;
}
