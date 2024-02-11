// File: ../sc_datasets/DAppSCAN/PeckShield-Donut/crossroad-550a8c3c010dc8c1a46ea9191d3841462bd58d82/contracts/interfaces/IDjinnAutoBuyer.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

interface IDjinnAutoBuyer
{
    function costInBnb(uint256 _amountOut) external view returns (uint256);
    function buyDjinn(uint256 _amountOut, address _outTarget, address _refundTarget) external payable returns (uint256);
}
