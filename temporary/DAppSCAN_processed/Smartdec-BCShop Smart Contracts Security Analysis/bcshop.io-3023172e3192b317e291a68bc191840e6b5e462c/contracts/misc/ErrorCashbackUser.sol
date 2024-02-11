// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/misc/ErrorCashbackUser.sol

pragma solidity ^0.4.18;

contract IWithdrawCashback {
    function withdrawCashback() public;
}

contract ErrorCashbackUser {

    //
    // Storage data
    uint8 a;
    IWithdrawCashback withdrawable;


    //
    // Methods

    function ErrorCashbackUser(IWithdrawCashback _withdrawable) public {
        withdrawable = _withdrawable;
    }    

    function() payable public  {
        if(a == 0) {
             a = 1;
             withdrawable.withdrawCashback();
        }
    }

    function withdraw() public {
        withdrawable.withdrawCashback();
    }
}
