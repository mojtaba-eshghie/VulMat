// File: ../sc_datasets/DAppSCAN/QuillAudits-AAVE-ParaSwap Adapter/aave-protocol-v2-14e2ab47d95f42ec5ee486f367067e78a7588878/contracts/interfaces/IParaSwapAugustus.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

interface IParaSwapAugustus {
  function getTokenTransferProxy() external view returns (address);
}
