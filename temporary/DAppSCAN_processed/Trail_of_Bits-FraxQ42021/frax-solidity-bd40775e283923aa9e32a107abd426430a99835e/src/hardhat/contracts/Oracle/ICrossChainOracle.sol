// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Oracle/ICrossChainOracle.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

interface ICrossChainOracle {
    // Returns in USD E6
    function getPrice(address token_address) external view returns (uint256 token_price);
}
