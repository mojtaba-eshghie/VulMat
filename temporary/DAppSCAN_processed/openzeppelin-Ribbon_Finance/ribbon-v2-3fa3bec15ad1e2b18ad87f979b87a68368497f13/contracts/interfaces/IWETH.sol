// File: ../sc_datasets/DAppSCAN/openzeppelin-Ribbon_Finance/ribbon-v2-3fa3bec15ad1e2b18ad87f979b87a68368497f13/contracts/interfaces/IWETH.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.7.2;

interface IWETH {
    function deposit() external payable;

    function withdraw(uint256) external;

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}
