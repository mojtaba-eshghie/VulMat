// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Aave stETH/aave-protocol-v2-12c9111990c9699e84a36f30ba849486ef8f2a84/contracts/misc/interfaces/IWETHGateway.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

interface IWETHGateway {
  function depositETH(address onBehalfOf, uint16 referralCode) external payable;

  function withdrawETH(uint256 amount, address onBehalfOf) external;

  function repayETH(
    uint256 amount,
    uint256 rateMode,
    address onBehalfOf
  ) external payable;

  function borrowETH(
    uint256 amount,
    uint256 interesRateMode,
    uint16 referralCode
  ) external;
}
