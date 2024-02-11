// File: ../sc_datasets/DAppSCAN/Coinfabrik-Avalaunch Audit Allocation Staking and Sales/xava-protocol-master/contracts/interfaces/IAdmin.sol

//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;

interface IAdmin {
    function isAdmin(address user) external view returns (bool);
}
