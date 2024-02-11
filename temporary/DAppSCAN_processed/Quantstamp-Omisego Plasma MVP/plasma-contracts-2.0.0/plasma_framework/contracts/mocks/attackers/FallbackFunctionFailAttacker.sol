// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/mocks/attackers/FallbackFunctionFailAttacker.sol

pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;

contract FallbackFunctionFailAttacker {
    function () external payable {
        revert("fail on fallback function");
    }
}
