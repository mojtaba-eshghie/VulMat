// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Aloith Release Smart Contract Audit/synthetix-1159c8aad0a1880d71e77e3b14f3a17826819136/contracts/test-helpers/MockPayable.sol

pragma solidity ^0.5.16;

contract MockPayable {
    uint256 public paidTimes;

    function pay() external payable {
        require(msg.value > 0, "No value paid");
        paidTimes = paidTimes + 1;
    }
}
