// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_stnd_v1.7_signed/standard-evm-d7c016ca098a4e5a554583c499fc0cead4db7088/contracts/oracle/DiaKeyValueInterface.sol

// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

interface DiaKeyValueInterface {
    function getValue(string memory key)
        external
        view
        returns (uint128, uint128);
}
