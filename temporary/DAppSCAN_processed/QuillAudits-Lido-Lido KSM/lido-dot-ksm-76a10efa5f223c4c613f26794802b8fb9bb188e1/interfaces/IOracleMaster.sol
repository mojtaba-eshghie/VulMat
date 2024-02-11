// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Lido KSM/lido-dot-ksm-76a10efa5f223c4c613f26794802b8fb9bb188e1/interfaces/IOracleMaster.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IOracleMaster {
    function addLedger(address ledger) external;

    function removeLedger(address ledger) external;

    function getOracle(address ledger) view external returns (address);

    function eraId() view external returns (uint64);

    function setRelayParams(uint64 relayGenesisTs, uint64 relaySecondsPerEra) external;

    function setLido(address lido) external;
}
