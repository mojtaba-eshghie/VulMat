// File: ../sc_datasets/DAppSCAN/consensys-Connext_NXTP_Noncustodial_Xchain_Transfer_Protocol/nxtp-494d07d3707df91658de45e2177a79adc80cf5fe/packages/contracts/contracts/interfaces/IFulfillInterpreter.sol

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
  ) external payable;
}
