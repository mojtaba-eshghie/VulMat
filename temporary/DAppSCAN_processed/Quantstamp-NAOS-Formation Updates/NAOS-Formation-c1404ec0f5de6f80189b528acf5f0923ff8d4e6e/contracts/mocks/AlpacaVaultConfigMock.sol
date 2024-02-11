// File: ../sc_datasets/DAppSCAN/Quantstamp-NAOS-Formation Updates/NAOS-Formation-c1404ec0f5de6f80189b528acf5f0923ff8d4e6e/contracts/mocks/AlpacaVaultConfigMock.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;

contract AlpacaVaultConfigMock {
  function getInterestRate(uint256 debt, uint256 floating) external view returns (uint256) {
    return 1;
  }

  function getReservePoolBps() external view returns (uint256) {
    return 1;
  }
}
