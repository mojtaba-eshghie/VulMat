// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_alpaca_v1.0_signed/bsc-alpaca-contract-cb13e32fe5a4ba6f63b0235bd4624715592e4abe/contracts/8.10/protocol/interfaces/IVault.sol

// SPDX-License-Identifier: BUSL
/**
  ∩~~~~∩ 
  ξ ･×･ ξ 
  ξ　~　ξ 
  ξ　　 ξ 
  ξ　　 “~～~～〇 
  ξ　　　　　　 ξ 
  ξ ξ ξ~～~ξ ξ ξ 
　 ξ_ξξ_ξ　ξ_ξξ_ξ
Alpaca Fin Corporation
*/

pragma solidity 0.8.10;

abstract contract IVault {
  struct Position {
    address worker;
    address owner;
    uint256 debtShare;
  }

  mapping(uint256 => Position) public positions;

  //@dev Return address of the token to be deposited in vault
  function token() external view virtual returns (address);

  uint256 public vaultDebtShare;

  uint256 public vaultDebtVal;

  //@dev Return next position id of vault
  function nextPositionID() external view virtual returns (uint256);

  //@dev Return the pending interest that will be accrued in the next call.
  function pendingInterest(uint256 value) external view virtual returns (uint256);

  function fairLaunchPoolId() external view virtual returns (uint256);

  /// @dev a function for interacting with position
  function work(
    uint256 id,
    address worker,
    uint256 principalAmount,
    uint256 borrowAmount,
    uint256 maxReturn,
    bytes calldata data
  ) external payable virtual;
}
