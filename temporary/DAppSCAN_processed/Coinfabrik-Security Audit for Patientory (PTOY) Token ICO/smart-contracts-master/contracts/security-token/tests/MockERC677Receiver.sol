// File: ../sc_datasets/DAppSCAN/Coinfabrik-Security Audit for Patientory (PTOY) Token ICO/smart-contracts-master/contracts/security-token/ERC677.sol

pragma solidity ^0.4.18;

interface ERC677Receiver {
  function tokenFallback(address from, uint256 amount, bytes data) returns (bool success);
}

interface ERC677 {

  // TODO: Have a different event name to make sure that tools with bad APIs do not mix this with ERC-20 Transfer() event that lacks data parameter
  event ERC677Transfer(address from, address receiver, uint256 amount, bytes data);

  function transferAndCall(ERC677Receiver receiver, uint amount, bytes data) returns (bool success);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Security Audit for Patientory (PTOY) Token ICO/smart-contracts-master/contracts/security-token/tests/MockERC677Receiver.sol

pragma solidity ^0.4.18;

contract MockERC677Receiver is ERC677Receiver {
  function tokenFallback(address from, uint256 amount, bytes data) returns (bool success) {
    return true;
  }
}
