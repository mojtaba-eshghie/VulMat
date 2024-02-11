// File: ../sc_datasets/DAppSCAN/QuillAudits-Alium Finance Smart Contract/alium-farm-e37d6af39af68049c2684085f025385407b4bd55/contracts/libs/Migrations.sol

pragma solidity >=0.4.25 <0.7.0;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  constructor() public {
    owner = msg.sender;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }
}
