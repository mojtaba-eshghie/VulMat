// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-PoolTogether - Pods/pods-v3-contracts-879dc8b911fc506dd6bead1f36eade919ccfea57/contracts/interfaces/IERC20Minimal.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.8.0;

interface IERC20Minimal {
    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}
