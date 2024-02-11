// File: ../sc_datasets/DAppSCAN/PeckShield-Metatime/metatime-6fd2d5b132377b007c3baa79938a53132fd2f955/contracts/interfaces/IERC20Metadata.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

interface IERC20Metadata {

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

}
