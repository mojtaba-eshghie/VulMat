// File: ../sc_datasets/DAppSCAN/PeckShield-LuckyChip/staking-23e5db6078aa12754ae69048c7754c7f1e90b375/contracts/libs/IMasterChef.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface IMasterChef {
    /**
     * @dev Update bonus.
     */
    function updateBonus(uint256 _pid) external;
}
