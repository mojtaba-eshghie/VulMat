// File: ../sc_datasets/DAppSCAN/Hacken-Samurai Legends/contract_samurai-legends-tokens-aff9f451dffc6854f29375ac21f8cedba8ee1101/contracts/Generatable.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
@title Generatable
@author Leo
@notice Generates a unique id
*/
contract Generatable {
    uint private id;

    /**
    @notice Generates a unique id
    @return id The newly generated id
    */
    function unique() internal returns (uint) {
        id += 1;
        return id;
    }
}
