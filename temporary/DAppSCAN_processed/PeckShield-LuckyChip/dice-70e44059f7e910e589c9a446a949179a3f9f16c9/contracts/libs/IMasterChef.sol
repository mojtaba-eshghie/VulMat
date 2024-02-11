// File: ../sc_datasets/DAppSCAN/PeckShield-LuckyChip/dice-70e44059f7e910e589c9a446a949179a3f9f16c9/contracts/libs/IMasterChef.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface IMasterChef {
    /**
     * @dev Update bonus.
     */
    function updateBonus(uint256 _pid) external;
}
