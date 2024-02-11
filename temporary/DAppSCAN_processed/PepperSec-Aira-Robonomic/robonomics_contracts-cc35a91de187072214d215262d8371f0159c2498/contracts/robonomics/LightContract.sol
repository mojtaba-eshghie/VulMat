// File: ../sc_datasets/DAppSCAN/PepperSec-Aira-Robonomic/robonomics_contracts-cc35a91de187072214d215262d8371f0159c2498/contracts/robonomics/LightContract.sol

pragma solidity ^0.4.24;

contract LightContract {
    /**
     * @dev Shared code smart contract 
     */
    address lib;

    constructor(address _library) public {
        lib = _library;
    }

    function() public {
        require(lib.delegatecall(msg.data));
    }
}
