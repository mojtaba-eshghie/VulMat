// File: ../sc_datasets/DAppSCAN/Quantstamp-LI.FI/contracts-7a4a6675f12f7980bde7794b60fb8fc7b3e6c9e8/src/Interfaces/ICBridge.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ICBridge {
    function send(
        address _receiver,
        address _token,
        uint256 _amount,
        uint64 _dstChinId,
        uint64 _nonce,
        uint32 _maxSlippage
    ) external;

    function sendNative(
        address _receiver,
        uint256 _amount,
        uint64 _dstChinId,
        uint64 _nonce,
        uint32 _maxSlippage
    ) external payable;

    function relay(
        bytes calldata _relayRequest,
        bytes[] calldata _sigs,
        address[] calldata _signers,
        uint256[] calldata _powers
    ) external;
}
