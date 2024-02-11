// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/mocks/attackers/OutOfGasFallbackAttacker.sol

pragma solidity 0.5.11;

contract OutOfGasFallbackAttacker {
    function () external payable {
        while (true) {}
    }
}
