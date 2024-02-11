// File: ../sc_datasets/DAppSCAN/Quantstamp-MetaVault V2/metavault-3538b8a8c1ea4ec2b68a635c48b938aa1acfbc26/contracts/metavault/IController.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface IController {
    function balanceOf(address) external view returns (uint256);
    function earn(address, uint256) external;
    function investEnabled() external view returns (bool);
    function harvestStrategy(address) external;
    function strategyTokens(address) external returns (address);
    function vaults(address) external view returns (address);
    function want(address) external view returns (address);
    function withdraw(address, uint256) external;
    function withdrawFee(address, uint256) external view returns (uint256);
}
