// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit v2/EasyPool-master/contracts/abstract/IFeeService.sol

pragma solidity ^0.4.24;


/**
 * @title FeeService Interface 
 */
contract IFeeService {
    function getFeePerEther() public view returns(uint);
    function sendFee(address feePayer) external payable;
}
