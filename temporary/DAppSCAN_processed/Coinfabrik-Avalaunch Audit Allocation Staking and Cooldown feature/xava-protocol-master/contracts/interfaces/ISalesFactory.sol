// File: ../sc_datasets/DAppSCAN/Coinfabrik-Avalaunch Audit Allocation Staking and Cooldown feature/xava-protocol-master/contracts/interfaces/ISalesFactory.sol

// "SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.6.12;

interface ISalesFactory {
    function isSaleCreatedThroughFactory(address sale) external view returns (bool);
}
