// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Aloith Release Smart Contract Audit/synthetix-1159c8aad0a1880d71e77e3b14f3a17826819136/contracts/test-helpers/MockReverter.sol

pragma solidity ^0.5.16;

contract MockReverter {
    function revertWithMsg(string calldata _msg) external pure {
        revert(_msg);
    }
}
