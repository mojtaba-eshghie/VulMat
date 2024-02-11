// File: ../sc_datasets/DAppSCAN/PeckShield-Duet_Bond/duet-bond-contract-549f7d3a4973a918cb12059cc1ef3f2ace56d9bc/contracts/interfaces/IVault.sol

pragma solidity >=0.8.0;

interface IVault {
  function underlying() external view  returns (address);
  function deposits(address user) external view returns (uint256);
}
