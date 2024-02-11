// File: ../sc_datasets/DAppSCAN/Inspex-FairLaunch, Token, Vault & Workers/Meow-Finance-4a4f13efaf5e5fbed74c0ed23b665751e655d715/contracts/protocol/interfaces/IDebtToken.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.6;

interface IDebtToken {
  function setOkHolders(address[] calldata _okHolders, bool _isOk) external;

  function mint(address to, uint256 amount) external;

  function burn(address from, uint256 amount) external;
}
