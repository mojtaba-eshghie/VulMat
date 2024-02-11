// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-06ce31002922e91aa40898dacd18d1c7f8d0e48f/contracts/interfaces/IBaseSynthetixBridge.sol

pragma solidity >=0.4.24;
pragma experimental ABIEncoderV2;

interface IBaseSynthetixBridge {
    function suspendInitiation() external;

    function resumeInitiation() external;
}
