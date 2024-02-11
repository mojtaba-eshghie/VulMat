// File: ../sc_datasets/DAppSCAN/Inspex-SimpliChef, Token, ZapBSC & Broker/simpli-smart-contract-4823d1ebbd84a35dd7e8f9fd7f5207ef5c85c419/contracts/zap/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Migrations {
  address public owner = msg.sender;
  uint public last_completed_migration;

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }
}
