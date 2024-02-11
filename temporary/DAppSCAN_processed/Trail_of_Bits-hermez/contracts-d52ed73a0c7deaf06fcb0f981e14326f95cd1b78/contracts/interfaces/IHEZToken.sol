// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-hermez/contracts-d52ed73a0c7deaf06fcb0f981e14326f95cd1b78/contracts/interfaces/IHEZToken.sol

// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.6.12;

interface IHEZToken {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function burn(uint256 value) external returns (bool);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
}
