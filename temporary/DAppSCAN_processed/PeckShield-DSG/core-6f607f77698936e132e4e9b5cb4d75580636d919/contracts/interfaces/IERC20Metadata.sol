// File: ../sc_datasets/DAppSCAN/PeckShield-DSG/core-6f607f77698936e132e4e9b5cb4d75580636d919/contracts/interfaces/IERC20Metadata.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

interface IERC20Metadata {

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

}
