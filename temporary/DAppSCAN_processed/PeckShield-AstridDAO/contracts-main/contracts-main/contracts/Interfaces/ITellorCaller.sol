// File: ../sc_datasets/DAppSCAN/PeckShield-AstridDAO/contracts-main/contracts-main/contracts/Interfaces/ITellorCaller.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

interface ITellorCaller {
    function getTellorCurrentValue(uint256 _requestId) external view returns (bool, uint256, uint256);
}
