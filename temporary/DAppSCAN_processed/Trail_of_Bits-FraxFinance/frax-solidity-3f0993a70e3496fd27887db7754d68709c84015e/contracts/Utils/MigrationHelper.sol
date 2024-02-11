// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/Utils/MigrationHelper.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;

contract MigrationHelper {
  address public owner;
  uint256 public gov_to_timelock_eta;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  constructor(address _owner) public {
    owner = _owner;
  }

  function setGovToTimeLockETA(uint256 _eta) public restricted {
    gov_to_timelock_eta = _eta;
  }
}
