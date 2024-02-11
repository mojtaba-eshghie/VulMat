// File: ../sc_datasets/DAppSCAN/PeckShield-Donut/crossroad-550a8c3c010dc8c1a46ea9191d3841462bd58d82/contracts/interfaces/IWETH.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}
