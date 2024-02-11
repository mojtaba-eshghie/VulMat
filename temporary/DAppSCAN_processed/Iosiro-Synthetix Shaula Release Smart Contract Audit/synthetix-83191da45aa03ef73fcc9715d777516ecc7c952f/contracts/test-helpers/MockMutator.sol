// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-83191da45aa03ef73fcc9715d777516ecc7c952f/contracts/test-helpers/MockMutator.sol

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
