// File: ../sc_datasets/DAppSCAN/Quantstamp-Idle Finance/idle-contracts-937f989c46beaf9405fab0bc4530a3a8b14c1fb7/contracts/interfaces/WhitePaperInterestRateModel.sol

pragma solidity 0.5.11;

interface WhitePaperInterestRateModel {
  function getBorrowRate(uint256 cash, uint256 borrows, uint256 _reserves) external view returns (uint256, uint256);
  function multiplier() external view returns (uint256);
  function baseRate() external view returns (uint256);
  function blocksPerYear() external view returns (uint256);
}
