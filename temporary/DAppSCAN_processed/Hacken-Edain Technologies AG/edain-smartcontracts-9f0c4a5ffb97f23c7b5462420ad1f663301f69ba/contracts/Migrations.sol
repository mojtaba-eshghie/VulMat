// File: ../sc_datasets/DAppSCAN/Hacken-Edain Technologies AG/edain-smartcontracts-9f0c4a5ffb97f23c7b5462420ad1f663301f69ba/contracts/Migrations.sol

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
