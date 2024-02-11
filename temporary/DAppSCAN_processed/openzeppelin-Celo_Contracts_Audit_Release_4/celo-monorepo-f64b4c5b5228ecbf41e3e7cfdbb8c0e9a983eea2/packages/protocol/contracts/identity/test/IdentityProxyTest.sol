// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/contracts/identity/test/IdentityProxyTest.sol

pragma solidity ^0.5.13;

contract IdentityProxyTest {
  address public lastAddress;
  uint256 public x;
  uint256 public amountLastPaid;

  function callMe() external {
    lastAddress = msg.sender;
  }

  function payMe() external payable {
    amountLastPaid = msg.value;
  }

  function setX(uint256 _x) external {
    x = _x;
  }
}
