// File: ../sc_datasets/DAppSCAN/Hacken-CGU/CGUToken0x747D74dB20cc422F39ab54EDB2A3Ce21f3C98AF1/contracts/interfaces/IERC677Receiver.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC677Receiver {
    function onTokenTransfer(address _sender, uint _value, bytes memory _data) external;
}
