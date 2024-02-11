// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/test/resources/compatibility/contracts_typechange/Migrations.sol

pragma solidity ^0.5.13;

contract Migrations {
  address public owner;
  uint256 public last_completed_migration; // solhint-disable var-name-mixedcase

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  constructor() public {
    owner = msg.sender;
  }

  function setCompleted(uint256 completed) external restricted {
    last_completed_migration = completed; // solhint-disable var-name-mixedcase
  }

  // solhint-disable-next-line func-param-name-mixedcase
  function upgrade(address new_address) external restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
