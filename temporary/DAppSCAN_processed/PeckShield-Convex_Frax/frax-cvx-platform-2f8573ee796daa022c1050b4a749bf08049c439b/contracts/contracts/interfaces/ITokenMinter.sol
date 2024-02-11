// File: ../sc_datasets/DAppSCAN/PeckShield-Convex_Frax/frax-cvx-platform-2f8573ee796daa022c1050b4a749bf08049c439b/contracts/contracts/interfaces/ITokenMinter.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface ITokenMinter{
    function mint(address,uint256) external;
    function burn(address,uint256) external;
}
