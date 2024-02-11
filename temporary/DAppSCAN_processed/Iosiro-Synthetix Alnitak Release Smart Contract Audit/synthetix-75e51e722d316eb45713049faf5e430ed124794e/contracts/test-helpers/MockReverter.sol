// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-75e51e722d316eb45713049faf5e430ed124794e/contracts/test-helpers/MockReverter.sol

pragma solidity ^0.5.16;

contract MockReverter {
    function revertWithMsg(string calldata _msg) external pure {
        revert(_msg);
    }
}
