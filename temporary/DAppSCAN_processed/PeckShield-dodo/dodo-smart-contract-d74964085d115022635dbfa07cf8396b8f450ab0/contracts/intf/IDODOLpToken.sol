// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/intf/IDODOLpToken.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;


interface IDODOLpToken {
    function mint(address user, uint256 value) external;

    function burn(address user, uint256 value) external;

    function balanceOf(address owner) external view returns (uint256);

    function totalSupply() external view returns (uint256);
}
