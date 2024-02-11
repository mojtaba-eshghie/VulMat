// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Aloith Release Smart Contract Audit/synthetix-b16096e70ab88eff7d0e423974a2958edff42b2a/contracts/interfaces/IBaseSynthetixBridge.sol

pragma solidity >=0.4.24;
pragma experimental ABIEncoderV2;

interface IBaseSynthetixBridge {
    function suspendInitiation() external;

    function resumeInitiation() external;
}
