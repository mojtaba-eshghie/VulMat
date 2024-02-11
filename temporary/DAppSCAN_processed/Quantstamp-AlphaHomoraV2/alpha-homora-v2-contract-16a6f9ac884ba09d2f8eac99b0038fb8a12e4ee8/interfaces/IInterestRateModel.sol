// File: ../sc_datasets/DAppSCAN/Quantstamp-AlphaHomoraV2/alpha-homora-v2-contract-16a6f9ac884ba09d2f8eac99b0038fb8a12e4ee8/interfaces/IInterestRateModel.sol

pragma solidity 0.6.12;

interface IInterestRateModel {
  /// @dev Return the interest rate per year in basis point given the parameters.
  /// @param token The token address to query for interest rate.
  /// @param supply The current total supply value from lenders.
  /// @param borrow The current total borrow value from borrowers.
  /// @param reserve The current unwithdrawn reserve funds.
  function getBorrowRate(
    address token,
    uint supply,
    uint borrow,
    uint reserve
  ) external view returns (uint);
}
