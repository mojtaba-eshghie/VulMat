// File: ../sc_datasets/DAppSCAN/Solidity_Finance-OKLG - Smart Contract/contracts-e167d0d742d21bcc62d7a5b770a1f0ed1cf31eca/contracts/interfaces/IOKLGSpend.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
 * @title IOKLGSpend
 * @dev Logic for spending OKLG on products in the product ecosystem.
 */
interface IOKLGSpend {
  function spendOnProduct(address _payor, uint8 _product) external payable;
}
