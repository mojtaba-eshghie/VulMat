// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/harmony/IDeposit.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

interface IDeposit {
  function deposit(uint256 amount) external;
  function owner() external view returns(address);
  function payout() external;
  function renounceOwnership() external;
  function transferOwnership(address newOwner) external;
  function wallet() external view returns(address);
  function withdraw(address recipient, uint256 amount) external;
}
