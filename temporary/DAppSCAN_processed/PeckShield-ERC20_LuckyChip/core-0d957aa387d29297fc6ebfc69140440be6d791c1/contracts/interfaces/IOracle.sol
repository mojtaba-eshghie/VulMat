// File: ../sc_datasets/DAppSCAN/PeckShield-ERC20_LuckyChip/core-0d957aa387d29297fc6ebfc69140440be6d791c1/contracts/interfaces/IOracle.sol

// SPDX-License-Identifier: MIT
  
pragma solidity 0.6.12;

interface IOracle {
    function update(address tokenA, address tokenB) external returns (bool);
    function updateBlockInfo() external returns (bool);
    function getQuantity(address token, uint256 amount) external view returns (uint256);
    function getLpTokenValue(address _lpToken, uint256 _amount) external view returns (uint256 value);
    function getDiceTokenValue(address _diceToken, uint256 _amount) external view returns (uint256 value);
}
