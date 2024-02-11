// File: ../sc_datasets/DAppSCAN/Solidity_Finance-OKLG - Smart Contract/contracts-e167d0d742d21bcc62d7a5b770a1f0ed1cf31eca/contracts/interfaces/IOKLGDividendDistributor.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IOKLGDividendDistributor {
  function depositDividends(address tokenAddress, uint256 erc20DirectAmount)
    external
    payable;

  function getShares(address wallet) external view returns (uint256);

  function getBoostNfts(address wallet)
    external
    view
    returns (uint256[] memory);
}
