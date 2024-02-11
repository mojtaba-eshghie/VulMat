// File: ../sc_datasets/DAppSCAN/PeckShield-Convex_Frax/frax-cvx-platform-2f8573ee796daa022c1050b4a749bf08049c439b/contracts/contracts/interfaces/IDelegation.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface IDelegation{
    function clearDelegate(bytes32 _id) external;
    function setDelegate(bytes32 _id, address _delegate) external;
    function delegation(address _address, bytes32 _id) external view returns(address);
}
