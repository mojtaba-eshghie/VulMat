// File: ../sc_datasets/DAppSCAN/QuillAudits-1inch-Limit Order Protocol/limit-order-protocol-a14bde6a260458de5083cee117d734221e1cbc05/contracts/helpers/ImmutableOwner.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;

/// @title A helper contract with helper modifiers to allow access to original contract creator only
contract ImmutableOwner {
    address public immutable immutableOwner;

    modifier onlyImmutableOwner {
        require(msg.sender == immutableOwner, "IO: Access denied");
        _;
    }

    constructor(address _immutableOwner) {
        immutableOwner = _immutableOwner;
    }
}
