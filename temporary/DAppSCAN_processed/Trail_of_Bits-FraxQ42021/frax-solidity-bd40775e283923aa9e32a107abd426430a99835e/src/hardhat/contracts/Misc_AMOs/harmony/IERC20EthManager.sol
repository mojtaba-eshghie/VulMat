// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/harmony/IERC20EthManager.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;
pragma experimental ABIEncoderV2;

interface IERC20EthManager {
  function lockToken(address ethTokenAddr, uint256 amount, address recipient) external;
  function lockTokenFor(address ethTokenAddr, address userAddr, uint256 amount, address recipient) external;
  function unlockToken(address ethTokenAddr, uint256 amount, address recipient, bytes32 receiptId) external;
  function usedEvents_(bytes32) external view returns(bool);
  function wallet() external view returns(address);
}
