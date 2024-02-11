// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-75e51e722d316eb45713049faf5e430ed124794e/contracts/test-helpers/MockPayable.sol

pragma solidity ^0.5.16;

contract MockPayable {
    uint256 public paidTimes;

    function pay() external payable {
        require(msg.value > 0, "No value paid");
        paidTimes = paidTimes + 1;
    }
}
