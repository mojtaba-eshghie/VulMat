// File: ../sc_datasets/DAppSCAN/Quantstamp-Idle Finance/idle-contracts-937f989c46beaf9405fab0bc4530a3a8b14c1fb7/contracts/interfaces/ILendingProtocol.sol

pragma solidity 0.5.11;

interface ILendingProtocol {
  function mint() external returns (uint256);
  function redeem(address account) external returns (uint256);
  function nextSupplyRate(uint256 amount) external view returns (uint256);
  function nextSupplyRateWithParams(uint256[] calldata params) external pure returns (uint256);
  function getAPR() external view returns (uint256);
  function getPriceInToken() external view returns (uint256);
  function token() external view returns (address);
  function underlying() external view returns (address);
}
