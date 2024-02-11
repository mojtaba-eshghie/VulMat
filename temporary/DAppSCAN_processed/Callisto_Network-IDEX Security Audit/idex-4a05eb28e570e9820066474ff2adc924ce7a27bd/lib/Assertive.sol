// File: ../sc_datasets/DAppSCAN/Callisto_Network-IDEX Security Audit/idex-4a05eb28e570e9820066474ff2adc924ce7a27bd/lib/Assertive.sol

pragma solidity ^0.4.18;
contract Assertive {
  function assert(bool assertion) {
    if (!assertion) throw;
  }
}
