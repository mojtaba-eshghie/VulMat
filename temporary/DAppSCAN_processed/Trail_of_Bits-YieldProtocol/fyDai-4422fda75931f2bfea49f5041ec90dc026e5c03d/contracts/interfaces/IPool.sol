// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-YieldProtocol/fyDai-4422fda75931f2bfea49f5041ec90dc026e5c03d/contracts/interfaces/IPool.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.10;


interface IPool {
    function sellDai(address from, address to, uint128 daiIn) external returns(uint128);
    function buyDai(address from, address to, uint128 daiOut) external returns(uint128);
    function sellYDai(address from, address to, uint128 yDaiIn) external returns(uint128);
    function buyYDai(address from, address to, uint128 yDaiOut) external returns(uint128);
    function sellDaiPreview(uint128 daiIn) external view returns(uint128);
    function buyDaiPreview(uint128 daiOut) external view returns(uint128);
    function sellYDaiPreview(uint128 yDaiIn) external view returns(uint128);
    function buyYDaiPreview(uint128 yDaiOut) external view returns(uint128);
}
