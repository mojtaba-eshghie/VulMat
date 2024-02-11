// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Connext NXTP — Noncustodial Xchain Transfer Protocol/nxtp-0656436d654cfe0313fa3c2bbc81aa86232ade16/packages/contracts/contracts/interfaces/IFulfillInterpreter.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

interface IFulfillInterpreter {

  event Executed(
    bytes32 indexed transactionId,
    address payable callTo,
    address assetId,
    address payable fallbackAddress,
    uint256 amount,
    bytes callData,
    bytes returnData,
    bool success
  );

  function getTransactionManager() external returns (address);

  function execute(
    bytes32 transactionId,
    address payable callTo,
    address assetId,
    address payable fallbackAddress,
    uint256 amount,
    bytes calldata callData
  ) external payable returns (bool success, bytes memory returnData);
}
