// File: ../sc_datasets/DAppSCAN/Quantstamp-Idle Finance/idle-contracts-937f989c46beaf9405fab0bc4530a3a8b14c1fb7/contracts/interfaces/WhitePaperInterestRateModel.sol

pragma solidity 0.5.11;

interface WhitePaperInterestRateModel {
  function getBorrowRate(uint256 cash, uint256 borrows, uint256 _reserves) external view returns (uint256, uint256);
  function multiplier() external view returns (uint256);
  function baseRate() external view returns (uint256);
  function blocksPerYear() external view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Idle Finance/idle-contracts-937f989c46beaf9405fab0bc4530a3a8b14c1fb7/contracts/mocks/WhitePaperMock.sol

pragma solidity 0.5.11;

contract WhitePaperMock is WhitePaperInterestRateModel {
  uint256 public borrowRate;
  uint256 public baseRate;
  uint256 public multiplier;
  uint256 public blocksPerYear;
  constructor() public {
    baseRate = 50000000000000000;
    multiplier = 120000000000000000;
    blocksPerYear = 2102400;
  }
  function getBorrowRate(uint256 cash, uint256 borrows, uint256 _reserves) external view returns (uint256, uint256) {

  }
}
