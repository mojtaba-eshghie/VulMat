// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Gamma/hypervisor-9a7a3dd88e8e8b106bf5d0e4c56e879442a72181/contracts/interfaces/IUniProxy.sol

// SPDX-License-Identifier: BUSL-1.1

pragma solidity =0.7.6;
pragma abicoder v2;

interface IUniProxy {

  function deposit(
    uint256 deposit0,
    uint256 deposit1,
    address to,
    address from,
    address pos
  ) external returns (uint256 shares);

  function getDepositAmount(
    address pos,
    address token,
    uint256 _deposit
  ) external view returns (
    uint256 amountStart,
    uint256 amountEnd
  );
}
