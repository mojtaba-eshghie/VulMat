// File: ../sc_datasets/DAppSCAN/Quantstamp-SeleCT x StormX NFT/nft-shrug-1d5d0ec1986b692d50d45e0a6d597bf97697a576/contracts/Migrations.sol

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
