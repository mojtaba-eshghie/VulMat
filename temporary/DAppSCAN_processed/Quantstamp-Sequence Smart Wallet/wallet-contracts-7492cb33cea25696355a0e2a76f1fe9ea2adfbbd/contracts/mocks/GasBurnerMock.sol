// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/mocks/GasBurnerMock.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


contract GasBurnerMock {
  event ProvidedGas(uint256 _val);

  function burnGas(uint256 _burn) external {
    emit ProvidedGas(gasleft());

    bytes32 stub;
    uint256 initial = gasleft();

    while (initial - gasleft() < _burn) {
      stub = keccak256(abi.encode(stub));
    }
  }
}
