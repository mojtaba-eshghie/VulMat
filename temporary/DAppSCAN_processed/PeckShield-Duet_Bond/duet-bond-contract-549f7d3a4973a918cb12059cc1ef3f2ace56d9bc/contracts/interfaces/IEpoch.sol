// File: ../sc_datasets/DAppSCAN/PeckShield-Duet_Bond/duet-bond-contract-549f7d3a4973a918cb12059cc1ef3f2ace56d9bc/contracts/interfaces/IEpoch.sol

pragma solidity >=0.8.0;

interface IEpoch {
  function end() external view returns (uint256);
  function bond() external view returns (address);
}
