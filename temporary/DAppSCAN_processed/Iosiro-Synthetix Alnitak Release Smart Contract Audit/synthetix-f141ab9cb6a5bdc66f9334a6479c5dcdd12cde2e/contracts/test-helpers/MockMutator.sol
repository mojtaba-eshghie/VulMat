// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-f141ab9cb6a5bdc66f9334a6479c5dcdd12cde2e/contracts/test-helpers/MockMutator.sol

pragma solidity ^0.5.16;

contract MockMutator {
    uint256 public count;

    function read() external view returns (uint) {
        return count;
    }

    function update() external {
        count = count + 1;
    }
}
