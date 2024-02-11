// File: ../sc_datasets/DAppSCAN/Smartdec-MinerOne Smart Contracts Security Analysis/openzeppelin-contracts-1.6.0/contracts/mocks/ForceEther.sol

pragma solidity ^0.4.18;


// @title Force Ether into a contract.
// @notice  even
// if the contract is not payable.
// @notice To use, construct the contract with the target as argument.
// @author Remco Bloemen <remco@neufund.org>
contract ForceEther {

  function ForceEther() public payable { }

  function destroyAndSend(address _recipient) public {
    selfdestruct(_recipient);
  }
}
