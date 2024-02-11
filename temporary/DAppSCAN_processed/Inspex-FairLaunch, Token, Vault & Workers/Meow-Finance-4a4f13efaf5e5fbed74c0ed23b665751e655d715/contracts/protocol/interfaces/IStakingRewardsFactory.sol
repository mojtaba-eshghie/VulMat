// File: ../sc_datasets/DAppSCAN/Inspex-FairLaunch, Token, Vault & Workers/Meow-Finance-4a4f13efaf5e5fbed74c0ed23b665751e655d715/contracts/protocol/interfaces/IStakingRewardsFactory.sol

pragma solidity 0.6.6;

interface IStakingRewardsFactory {
  // Views
  function rewardsToken() external view returns (address);

  function stakingRewardsGenesis() external view returns (uint256);

  function stakingTokens(uint256 _pid) external view returns (address);

  function stakingRewardsInfoByStakingToken(address _stakingToken)
    external
    view
    returns (
      address,
      uint256,
      uint256
    );
}
