// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Bridges/Boba/IDiscretionaryExitBurn.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

interface IDiscretionaryExitBurn {
  function burnAndWithdraw(address _l2Token, uint256 _amount, uint32 _l1Gas, bytes calldata _data) external payable;
}
