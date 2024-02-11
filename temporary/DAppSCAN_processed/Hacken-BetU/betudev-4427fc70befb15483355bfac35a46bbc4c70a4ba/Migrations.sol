// File: ../sc_datasets/DAppSCAN/Hacken-BetU/betudev-4427fc70befb15483355bfac35a46bbc4c70a4ba/Migrations.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
//SWC-Outdated Compiler Version: L2
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
