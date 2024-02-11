// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_stnd_v1.7_signed/standard-evm-d7c016ca098a4e5a554583c499fc0cead4db7088/contracts/tokens/multichain/interfaces/IChildToken.sol

// SPDX-License-Identifier: Apache-2.0

// File: contracts/lib/IChildToken.sol

pragma solidity 0.6.12;

interface IChildToken {
    function deposit(address user, bytes calldata depositData) external;
}
