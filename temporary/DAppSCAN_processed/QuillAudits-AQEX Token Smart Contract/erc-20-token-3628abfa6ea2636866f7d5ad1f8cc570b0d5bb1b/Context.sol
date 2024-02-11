// File: ../sc_datasets/DAppSCAN/QuillAudits-AQEX Token Smart Contract/erc-20-token-3628abfa6ea2636866f7d5ad1f8cc570b0d5bb1b/Context.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}
