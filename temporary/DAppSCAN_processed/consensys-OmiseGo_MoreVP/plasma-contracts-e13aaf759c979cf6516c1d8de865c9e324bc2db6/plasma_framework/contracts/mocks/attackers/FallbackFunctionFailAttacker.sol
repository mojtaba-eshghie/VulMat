// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/mocks/attackers/FallbackFunctionFailAttacker.sol

pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;

contract FallbackFunctionFailAttacker {
    function () external payable {
        revert("fail on fallback function");
    }
}
