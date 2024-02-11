// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-dharma-smartwallet/dharma-smart-wallet-b1d510d03b97a9c8457b9c0b9c91568a09ccc95d/interfaces/CTokenInterface.sol

pragma solidity 0.5.11;


interface CTokenInterface {
  function mint(uint256 mintAmount) external returns (uint256 err);

  function redeem(uint256 redeemAmount) external returns (uint256 err);
  
  function redeemUnderlying(uint256 redeemAmount) external returns (uint256 err);

  function balanceOf(address account) external returns (uint256 balance);

  function balanceOfUnderlying(address account) external returns (uint256 balance);

  function borrow(uint256 borrowAmount) external returns (uint256 err);

  function repayBorrow(uint256 borrowAmount) external returns (uint256 err);

  // NOTE: we could use borrowBalanceStored if interest has already been accrued
  function borrowBalanceCurrent(address account) external returns (uint256 err);
  
  function getAccountSnapshot(address account) external view returns (
    uint256 err,
    uint256 cTokenBalance,
    uint256 borrowBalance,
    uint256 exchangeRateMantissa
  ); // balanceOfUnderlying = (cTokenBalance * exchangeRateMantissa) / 1e18
}
