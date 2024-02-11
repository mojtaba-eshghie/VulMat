// File: ../sc_datasets/DAppSCAN/Quantstamp-88mph/88mph-contracts-2fc696b2573c0c06b2613cb9abd09f87c2509041/contracts/rewards/dumpers/imports/yERC20.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.5.17;

// NOTE: Basically an alias for Vaults
interface yERC20 {
    function balanceOf(address owner) external view returns (uint256);

    function deposit(uint256 _amount) external;

    function withdraw(uint256 _amount) external;

    function getPricePerFullShare() external view returns (uint256);
}
