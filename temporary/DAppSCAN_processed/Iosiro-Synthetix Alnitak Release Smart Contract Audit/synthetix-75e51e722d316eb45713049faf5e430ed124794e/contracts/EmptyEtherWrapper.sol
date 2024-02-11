// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-75e51e722d316eb45713049faf5e430ed124794e/contracts/EmptyEtherWrapper.sol

pragma solidity ^0.5.16;

// Stub functions required by the DebtCache and FeePool contracts.
// https://docs.synthetix.io/contracts/source/contracts/etherwrapper
contract EmptyEtherWrapper {
    constructor() public {}

    /* ========== VIEWS ========== */

    function totalIssuedSynths() public view returns (uint) {
        return 0;
    }

    function distributeFees() external {}
}
