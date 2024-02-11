// File: ../sc_datasets/DAppSCAN/consensys-DeFi_Saver/defisaver-v3-contracts-cb29669a84c2d6fffaf2231c0938eb407c060919/contracts/interfaces/mcd/IGetCdps.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract IGetCdps {
    function getCdpsAsc(address manager, address guy) external virtual view returns (uint[] memory ids, address[] memory urns, bytes32[] memory ilks);

    function getCdpsDesc(address manager, address guy) external virtual view returns (uint[] memory ids, address[] memory urns, bytes32[] memory ilks);
}
