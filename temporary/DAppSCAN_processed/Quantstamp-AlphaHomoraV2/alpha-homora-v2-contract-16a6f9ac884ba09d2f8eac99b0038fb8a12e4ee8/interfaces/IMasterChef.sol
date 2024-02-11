// File: ../sc_datasets/DAppSCAN/Quantstamp-AlphaHomoraV2/alpha-homora-v2-contract-16a6f9ac884ba09d2f8eac99b0038fb8a12e4ee8/interfaces/IMasterChef.sol

pragma solidity 0.6.12;

interface IMasterChef {
  function sushi() external view returns (address);

  function poolInfo(uint pid)
    external
    view
    returns (
      address lpToken,
      uint allocPoint,
      uint lastRewardBlock,
      uint accSushiPerShare
    );

  function deposit(uint pid, uint amount) external;

  function withdraw(uint pid, uint amount) external;
}
