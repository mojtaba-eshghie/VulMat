// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FujiProtocol/fuji-protocol-933ea57b11889d87744efa23e95c90b7bf589402/contracts/interfaces/aave/IAaveLiquidityMining.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IAaveLiquidityMining {
  function claimRewards(
    address[] calldata assets,
    uint256 amount,
    address to
  ) external returns (uint256);

  function getUserUnclaimedRewards(address _user) external view returns (uint256);

  function getRewardsBalance(address[] calldata assets, address user)
    external
    view
    returns (uint256);
}
