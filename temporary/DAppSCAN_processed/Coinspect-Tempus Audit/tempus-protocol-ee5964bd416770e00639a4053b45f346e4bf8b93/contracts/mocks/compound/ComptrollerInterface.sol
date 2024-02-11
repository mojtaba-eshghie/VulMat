// File: ../sc_datasets/DAppSCAN/Coinspect-Tempus Audit/tempus-protocol-ee5964bd416770e00639a4053b45f346e4bf8b93/contracts/mocks/compound/ComptrollerInterface.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.6;

abstract contract ComptrollerInterface {
    /// Assets You Are In
    function enterMarkets(address[] calldata cTokens) external virtual returns (uint[] memory);

    function exitMarket(address cToken) external virtual returns (uint);

    /// Policy Hooks

    function mintAllowed(
        address cToken,
        address minter,
        uint mintAmount
    ) external virtual returns (uint);
}
