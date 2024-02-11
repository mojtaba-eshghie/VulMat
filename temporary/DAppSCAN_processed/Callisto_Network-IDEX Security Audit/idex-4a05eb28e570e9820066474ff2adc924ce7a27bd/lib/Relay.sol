// File: ../sc_datasets/DAppSCAN/Callisto_Network-IDEX Security Audit/idex-4a05eb28e570e9820066474ff2adc924ce7a27bd/lib/Relay.sol

pragma solidity ^0.4.18;
contract Relay {
  function relayTransferFrom(address token, address from, address to, uint256 value) returns (bool success);
  function relayTransfer(address token, uint256 amount) returns (bool success);
  function relaySendEther(address target, uint256 amount) returns (bool success);
}
