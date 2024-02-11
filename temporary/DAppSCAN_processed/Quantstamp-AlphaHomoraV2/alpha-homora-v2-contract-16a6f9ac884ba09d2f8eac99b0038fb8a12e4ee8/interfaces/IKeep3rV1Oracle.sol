// File: ../sc_datasets/DAppSCAN/Quantstamp-AlphaHomoraV2/alpha-homora-v2-contract-16a6f9ac884ba09d2f8eac99b0038fb8a12e4ee8/interfaces/IKeep3rV1Oracle.sol

pragma solidity 0.6.12;

abstract contract IKeep3rV1Oracle {
  struct Observation {
    uint timestamp;
    uint price0Cumulative;
    uint price1Cumulative;
  }

  function WETH() public pure virtual returns (address);

  function factory() public pure virtual returns (address);

  mapping(address => Observation[]) public observations;

  function observationLength(address pair) external view virtual returns (uint);
}
