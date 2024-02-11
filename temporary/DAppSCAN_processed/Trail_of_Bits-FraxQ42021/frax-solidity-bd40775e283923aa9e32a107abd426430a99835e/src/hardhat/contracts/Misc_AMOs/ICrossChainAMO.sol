// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/ICrossChainAMO.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

interface ICrossChainAMO {
    function allDollarBalances() external view returns (uint256 frax_val_e18, uint256 fxs_val_e18, uint256 collat_val_e18, uint256 total_val_e18);
}
