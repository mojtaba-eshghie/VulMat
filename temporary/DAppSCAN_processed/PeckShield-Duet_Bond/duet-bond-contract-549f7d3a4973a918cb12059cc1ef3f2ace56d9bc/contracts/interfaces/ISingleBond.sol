// File: ../sc_datasets/DAppSCAN/PeckShield-Duet_Bond/duet-bond-contract-549f7d3a4973a918cb12059cc1ef3f2ace56d9bc/contracts/interfaces/ISingleBond.sol

pragma solidity >=0.8.0;

interface ISingleBond {
  function getEpoches() external view returns(address[] memory);
  function getEpoch(uint256 id) external view returns(address);
  function redeem(address[] memory epochs, uint[] memory amounts, address to) external;
  function redeemOrTransfer(address[] memory epochs, uint[] memory amounts, address to) external;
  function multiTransfer(address[] memory epochs, uint[] memory amounts, address to) external;
}
