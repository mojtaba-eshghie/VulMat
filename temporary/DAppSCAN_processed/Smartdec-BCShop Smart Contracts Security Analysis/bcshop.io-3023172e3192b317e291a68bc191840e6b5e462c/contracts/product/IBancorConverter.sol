// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/product/IBancorConverter.sol

pragma solidity ^0.4.18;

contract IBancorConverter {
    function convertFor(address[] _path, uint256 _amount, uint256 _minReturn, address _for)
        public
        payable
        returns (uint256);
}
