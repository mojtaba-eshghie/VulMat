// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/contracts/common/test/MsgSenderCheck.sol

pragma solidity ^0.5.13;

contract MsgSenderCheck {
  function checkMsgSender(address addr) external view {
    require(addr == msg.sender, "address was not msg.sender");
  }
}
