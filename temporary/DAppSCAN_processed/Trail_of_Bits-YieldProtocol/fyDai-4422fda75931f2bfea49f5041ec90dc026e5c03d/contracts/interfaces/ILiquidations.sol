// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-YieldProtocol/fyDai-4422fda75931f2bfea49f5041ec90dc026e5c03d/contracts/interfaces/ILiquidations.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.10;


interface ILiquidations {
    function shutdown() external;
    function totals() external view returns(uint128, uint128);
    function erase(address) external returns(uint128, uint128);
}
