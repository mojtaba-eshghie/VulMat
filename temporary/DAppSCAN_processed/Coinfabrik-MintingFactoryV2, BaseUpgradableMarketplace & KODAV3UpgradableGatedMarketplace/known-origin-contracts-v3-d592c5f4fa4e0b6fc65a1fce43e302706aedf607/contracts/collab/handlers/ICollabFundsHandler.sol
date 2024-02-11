// File: ../sc_datasets/DAppSCAN/Coinfabrik-MintingFactoryV2, BaseUpgradableMarketplace & KODAV3UpgradableGatedMarketplace/known-origin-contracts-v3-d592c5f4fa4e0b6fc65a1fce43e302706aedf607/contracts/collab/handlers/ICollabFundsHandler.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

interface ICollabFundsHandler {

    function init(address[] calldata _recipients, uint256[] calldata _splits) external;

    function totalRecipients() external view returns (uint256);

    function shareAtIndex(uint256 index) external view returns (address _recipient, uint256 _split);
}
