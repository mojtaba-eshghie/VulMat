// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Aloith Release Smart Contract Audit/synthetix-ac7dafbf461695ad10f41cdb2bcc32d3b9fc9caf/contracts/test-helpers/MockReverter.sol

pragma solidity ^0.5.16;

contract MockReverter {
    function revertWithMsg(string calldata _msg) external pure {
        revert(_msg);
    }
}
