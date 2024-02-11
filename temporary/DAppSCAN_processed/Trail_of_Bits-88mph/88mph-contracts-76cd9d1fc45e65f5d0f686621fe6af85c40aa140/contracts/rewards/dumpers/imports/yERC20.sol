// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-88mph/88mph-contracts-76cd9d1fc45e65f5d0f686621fe6af85c40aa140/contracts/rewards/dumpers/imports/yERC20.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

// NOTE: Basically an alias for Vaults
interface yERC20 {
    function balanceOf(address owner) external view returns (uint256);

    function deposit(uint256 _amount) external;

    function withdraw(uint256 _amount) external;

    function getPricePerFullShare() external view returns (uint256);
}
