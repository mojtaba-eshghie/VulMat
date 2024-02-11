// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Mirfak Release Smart Contract Audit/synthetix-70ef93e3681b4fea4ac0dbd832485b576bdc1e43/EmptyEtherCollateral.sol

pragma solidity ^0.5.16;
//SWC-Code With No Effects:L1-9
// Empty contract for ether collateral placeholder for OVM
// https://docs.synthetix.io/contracts/source/contracts/emptyethercollateral
contract EmptyEtherCollateral {
    function totalIssuedSynths() external pure returns (uint) {
        return 0;
    }
}
