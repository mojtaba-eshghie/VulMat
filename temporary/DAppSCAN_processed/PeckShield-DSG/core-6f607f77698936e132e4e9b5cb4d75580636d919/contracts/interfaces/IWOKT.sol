// File: ../sc_datasets/DAppSCAN/PeckShield-DSG/core-6f607f77698936e132e4e9b5cb4d75580636d919/contracts/interfaces/IWOKT.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

interface IWOKT {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function deposit() external payable;

    function transfer(address to, uint256 value) external returns (bool);

    function withdraw(uint256) external;
}
