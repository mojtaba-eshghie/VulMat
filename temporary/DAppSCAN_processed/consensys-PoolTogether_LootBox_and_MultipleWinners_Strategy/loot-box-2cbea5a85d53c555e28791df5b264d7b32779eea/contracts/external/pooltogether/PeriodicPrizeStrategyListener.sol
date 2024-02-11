// File: ../sc_datasets/DAppSCAN/consensys-PoolTogether_LootBox_and_MultipleWinners_Strategy/loot-box-2cbea5a85d53c555e28791df5b264d7b32779eea/contracts/external/pooltogether/PeriodicPrizeStrategyListener.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.7.0;

/* solium-disable security/no-block-members */
interface PeriodicPrizeStrategyListener {
  function afterDistributeAwards(uint256 randomNumber, uint256 prizePeriodStartedAt) external;
}
