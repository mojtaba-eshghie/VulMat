// File: ../sc_datasets/DAppSCAN/Coinfabrik-Rightmesh Token Sale Smart Contract Audit (Master)/solidity-f24ea6c5787b2d40423f4dc312d832592b1cd335/rightmesh/contracts/Migrations.sol

pragma solidity ^0.4.18;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function Migrations() public {
    owner = msg.sender;
  }

  function setCompleted(uint completed) external restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) external restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
