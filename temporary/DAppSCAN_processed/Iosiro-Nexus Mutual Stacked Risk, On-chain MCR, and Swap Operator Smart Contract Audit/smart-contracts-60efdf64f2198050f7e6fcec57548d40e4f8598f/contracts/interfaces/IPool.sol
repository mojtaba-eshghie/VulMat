// File: ../sc_datasets/DAppSCAN/Iosiro-Nexus Mutual Stacked Risk, On-chain MCR, and Swap Operator Smart Contract Audit/smart-contracts-60efdf64f2198050f7e6fcec57548d40e4f8598f/contracts/interfaces/IPool.sol

// SPDX-License-Identifier: AGPL-3.0-only

/* Copyright (C) 2020 NexusMutual.io

  This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

  This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/ */

pragma solidity ^0.8.0;

interface IPool {
  function transferAssetToSwapOperator (address asset, uint amount) external;
  function setAssetDataLatestLastSwapTime(address asset, uint32 lastSwapTime) external;

  function getAssetDetails(address _asset) external view returns (
    uint balance,
    uint112 min,
    uint112 max,
    uint32 lastAssetSwapTime,
    uint maxSlippageRatio
  );

  function setAssetDataLastSwapTime(address asset, uint32 lastSwapTime) external;

  function minPoolEth() external returns (uint);
}
