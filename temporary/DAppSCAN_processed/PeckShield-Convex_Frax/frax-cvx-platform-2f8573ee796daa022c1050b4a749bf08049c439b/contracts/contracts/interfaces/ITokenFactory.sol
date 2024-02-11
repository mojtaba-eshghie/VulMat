// File: ../sc_datasets/DAppSCAN/PeckShield-Convex_Frax/frax-cvx-platform-2f8573ee796daa022c1050b4a749bf08049c439b/contracts/contracts/interfaces/ITokenFactory.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface ITokenFactory{
    function CreateDepositToken(address) external returns(address);
}
