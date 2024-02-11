// File: ../sc_datasets/DAppSCAN/PeckShield-COGI/cogi_contracts-c5dc614395f77a5b07c83223e5c8bac9d14d2e2c/contracts/common/interfaces/IERC20Mintable.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

interface IERC20Mintable {
    function transfer(address _to, uint256 _value) external returns (bool);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool);
    function mint(address _to, uint256 _value) external returns (bool);
    function balanceOf(address _account) external view returns (uint256);
    function totalSupply() external view returns (uint256);
}
