// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-Layer_Zero/LayerZero-a5b266aa54714035314cbe5e451b2ec0db81b552/contracts/chainlink/ERC677Receiver.sol

// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.7.6;

interface ERC677Receiver {
    function onTokenTransfer(address _sender, uint _value, bytes memory _data) external;
}
