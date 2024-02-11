// File: ../sc_datasets/DAppSCAN/consensys-Fei_Protocol_v2_Phase_1/fei-protocol-core-5e3e2ab889f06831f4fe2e8460066ded40ccf0a8/contracts/pcv/IPCVSwapper.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

/// @title a PCV Swapper interface
/// @author eswak
interface IPCVSwapper {

    // ----------- Events -----------
    event UpdateReceivingAddress(address oldTokenReceivingAddress, address newTokenReceivingAddress);

    event Swap(
        address indexed _caller,
        address indexed _tokenSpent,
        address indexed _tokenReceived,
        uint256 _amountSpent,
        uint256 _amountReceived
    );

    // ----------- State changing api -----------

    function swap() external;

    // ----------- Governor only state changing api -----------

    function setReceivingAddress(address _tokenReceivingAddress) external;

    // ----------- Getters -----------

    function tokenSpent() external view returns (address);
    function tokenReceived() external view returns (address);
    function tokenReceivingAddress() external view returns (address);

}
