// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-06ce31002922e91aa40898dacd18d1c7f8d0e48f/contracts/test-helpers/MockPayable.sol

pragma solidity ^0.5.16;

contract MockPayable {
    uint256 public paidTimes;

    function pay() external payable {
        require(msg.value > 0, "No value paid");
        paidTimes = paidTimes + 1;
    }
}
