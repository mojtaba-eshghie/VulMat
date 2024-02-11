// File: ../sc_datasets/DAppSCAN/Quantstamp-Aavegotchi GHST Staking/ghst-staking-af267c0f066794e1944f876f27c35126d931e8c9/contracts/interfaces/IERC20.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1;

interface IERC20 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool success);

    function transfer(address _to, uint256 _value) external returns (bool success);

    function totalSupply() external view returns (uint256);

    function balanceOf(address _owner) external view returns (uint256 balance);
}
