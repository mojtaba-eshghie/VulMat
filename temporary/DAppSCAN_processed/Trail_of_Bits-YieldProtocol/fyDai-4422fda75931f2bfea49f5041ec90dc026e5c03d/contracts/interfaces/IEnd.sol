// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-YieldProtocol/fyDai-4422fda75931f2bfea49f5041ec90dc026e5c03d/contracts/interfaces/IEnd.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.10;


/// @dev interface for the End contract from MakerDAO
interface IEnd {
    function tag(bytes32) external returns(uint256);
    function fix(bytes32) external returns(uint256);
    function skim(bytes32, address) external;
    function free(bytes32) external;
    function pack(uint256) external;
    function cash(bytes32, uint) external;
}
