// File: ../sc_datasets/DAppSCAN/QuillAudits-AAVE-Governance Crosschain Bridges V3/governance-crosschain-bridges-7f56e7ae63f30ba8dcd7ced6a11a34c2eb865a1d/contracts/interfaces/IFxMessageProcessor.sol

//SPDX-License-Identifier: Unlicense
pragma solidity 0.7.5;

interface IFxMessageProcessor {
  /**
   * @dev Process the cross-chain message from an FxChild contract through the ETH/Polygon StateSender
   * @param stateId Id of the cross-chain message created in the ETH/Polygon StateSender
   * @param rootMessageSender address that initally sent this message on ethereum
   * @param data the data from the abi-encoded cross-chain message
   **/
  function processMessageFromRoot(
    uint256 stateId,
    address rootMessageSender,
    bytes calldata data
  ) external;
}
