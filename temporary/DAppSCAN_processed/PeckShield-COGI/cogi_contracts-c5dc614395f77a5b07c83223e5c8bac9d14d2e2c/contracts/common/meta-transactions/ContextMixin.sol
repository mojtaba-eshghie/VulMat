// File: ../sc_datasets/DAppSCAN/PeckShield-COGI/cogi_contracts-c5dc614395f77a5b07c83223e5c8bac9d14d2e2c/contracts/common/meta-transactions/ContextMixin.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

abstract contract ContextMixin {
    function msgSender()
        internal
        view
        returns (address payable sender)
    {
        if (msg.sender == address(this)) {
            bytes memory array = msg.data;
            uint256 index = msg.data.length;
            assembly {
                // Load the 32 bytes word from memory with the address on the lower 20 bytes, and mask those.
                sender := and(
                    mload(add(array, index)),
                    0xffffffffffffffffffffffffffffffffffffffff
                )
            }
        } else {
            sender = payable(msg.sender);
        }
        return sender;
    }
}
