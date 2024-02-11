// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-500c84f2d0998b9c7fd6f0965a2fb730ef698cb2/contracts/test-helpers/MockMutator.sol

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
