// File: ../sc_datasets/DAppSCAN/Byterocket-RealityCards v2[09.18.2021]/RealityCards-Contracts-4d2316e4628425f35edae26f1e0627a4142d053b/contracts/interfaces/IRCBridge.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

interface IRCBridge {
    function withdrawToMainnet(address _user, uint256 _amount) external;
}
