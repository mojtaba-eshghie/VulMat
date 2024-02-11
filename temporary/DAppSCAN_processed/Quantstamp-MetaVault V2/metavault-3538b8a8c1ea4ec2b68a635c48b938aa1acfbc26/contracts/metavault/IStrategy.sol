// File: ../sc_datasets/DAppSCAN/Quantstamp-MetaVault V2/metavault-3538b8a8c1ea4ec2b68a635c48b938aa1acfbc26/contracts/metavault/IStrategy.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface IStrategy {
    function balanceOf() external view returns (uint256);
    function balanceOfPool() external view returns (uint256);
    function balanceOfWant() external view returns (uint256);
    function deposit() external;
    function harvest() external;
    function skim() external;
    function want() external view returns (address);
    function withdraw(address) external;
    function withdraw(uint256) external;
    function withdrawAll() external returns (uint256);
}
