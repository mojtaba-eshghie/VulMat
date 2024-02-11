// File: ../sc_datasets/DAppSCAN/consensys-DeFi_Saver/defisaver-v3-contracts-cb29669a84c2d6fffaf2231c0938eb407c060919/contracts/interfaces/reflexer/IGetSafes.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract IGetSafes {
    function getSafesAsc(address manager, address guy) external virtual view returns (uint[] memory ids, address[] memory safes, bytes32[] memory collateralTypes);
    function getSafesDesc(address manager, address guy) external virtual view returns (uint[] memory ids, address[] memory safes, bytes32[] memory collateralTypes);

}
