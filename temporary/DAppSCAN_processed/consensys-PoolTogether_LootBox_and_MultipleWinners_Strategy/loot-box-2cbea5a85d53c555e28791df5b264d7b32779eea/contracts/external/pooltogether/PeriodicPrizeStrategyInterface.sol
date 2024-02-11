// File: ../sc_datasets/DAppSCAN/consensys-PoolTogether_LootBox_and_MultipleWinners_Strategy/loot-box-2cbea5a85d53c555e28791df5b264d7b32779eea/contracts/external/pooltogether/PeriodicPrizeStrategyInterface.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.7.0;

/* solium-disable security/no-block-members */
interface PeriodicPrizeStrategyInterface {
  function prizePool() external view returns (address);
  function addExternalErc721Award(address _externalErc721, uint256[] calldata _tokenIds) external;
}
