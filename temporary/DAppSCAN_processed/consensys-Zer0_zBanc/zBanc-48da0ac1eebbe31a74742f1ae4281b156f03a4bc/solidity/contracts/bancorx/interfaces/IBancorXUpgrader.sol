// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/bancorx/interfaces/IBancorXUpgrader.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/*
    Bancor X Upgrader interface
*/
interface IBancorXUpgrader {
    function upgrade(uint16 _version, address[] memory _reporters) external;
}
