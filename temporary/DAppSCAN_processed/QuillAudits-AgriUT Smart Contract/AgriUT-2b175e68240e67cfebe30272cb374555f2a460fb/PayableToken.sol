// File: ../sc_datasets/DAppSCAN/QuillAudits-AgriUT Smart Contract/AgriUT-2b175e68240e67cfebe30272cb374555f2a460fb/PayableToken.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

abstract contract PayableToken {
    address private _owner;

 /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    constructor() 
    {
        _owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == _owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner public {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _owner = payable(newOwner);
    }
}
