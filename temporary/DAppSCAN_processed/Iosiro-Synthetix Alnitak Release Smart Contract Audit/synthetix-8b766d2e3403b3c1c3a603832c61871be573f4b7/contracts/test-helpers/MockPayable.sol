// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-8b766d2e3403b3c1c3a603832c61871be573f4b7/contracts/test-helpers/MockPayable.sol

pragma solidity ^0.5.16;

contract MockPayable {
    uint256 public paidTimes;

    function pay() external payable {
        require(msg.value > 0, "No value paid");
        paidTimes = paidTimes + 1;
    }
}
