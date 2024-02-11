// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/mocks/ModuleMock.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


contract ModuleMock {
  event Pong();

  function ping() external {
    emit Pong();
  }
}
