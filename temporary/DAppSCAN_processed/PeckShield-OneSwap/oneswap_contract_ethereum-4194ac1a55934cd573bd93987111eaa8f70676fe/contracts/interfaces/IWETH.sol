// File: ../sc_datasets/DAppSCAN/PeckShield-OneSwap/oneswap_contract_ethereum-4194ac1a55934cd573bd93987111eaa8f70676fe/contracts/interfaces/IWETH.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}
