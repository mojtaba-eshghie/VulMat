// File: ../sc_datasets/DAppSCAN/Quantstamp-Atomic Loans/atomicloans-eth-contracts-10c2493d6851dcf59ee3d99519f0228b4bc2afaf/contracts/P2WSHInterface.sol

pragma solidity ^0.5.10;

interface P2WSHInterface {
  function getP2WSH(bytes32 loan, bool sez) external view returns (bytes memory, bytes32);
}
