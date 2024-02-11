// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_stnd_v1.7_signed/standard-evm-d7c016ca098a4e5a554583c499fc0cead4db7088/contracts/oracle/DiaCoinInfoInterface.sol

// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

interface DiaCoinInfoInterface {
    function getCoinInfo(string memory name) external view returns (uint256, uint256, uint256, string memory);
}
