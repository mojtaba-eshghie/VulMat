// File: ../sc_datasets/DAppSCAN/Solidified-Origin Governance/origin-dollar-30564e25d640749af447fb9e5d7c4fb00c37779f/contracts/contracts/interfaces/IMinMaxOracle.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

interface IMinMaxOracle {
    //Assuming 8 decimals
    function priceMin(string calldata symbol) external view returns (uint256);

    function priceMax(string calldata symbol) external view returns (uint256);
}
