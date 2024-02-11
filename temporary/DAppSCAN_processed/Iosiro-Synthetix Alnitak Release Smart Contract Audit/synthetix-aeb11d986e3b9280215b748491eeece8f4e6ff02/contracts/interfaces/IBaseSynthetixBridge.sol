// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-aeb11d986e3b9280215b748491eeece8f4e6ff02/contracts/interfaces/IBaseSynthetixBridge.sol

pragma solidity >=0.4.24;
pragma experimental ABIEncoderV2;

interface IBaseSynthetixBridge {
    function suspendInitiation() external;

    function resumeInitiation() external;
}
