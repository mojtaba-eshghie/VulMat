// File: ../sc_datasets/DAppSCAN/openzeppelin-Origin_Dollar/origin-dollar-bf4ff28d5944ecc277e66294fd2c702fee5cd58b/contracts/contracts/interfaces/IComptroller.sol

pragma solidity 0.5.11;

interface IComptroller {
    /**
     * @notice Claim all the comp accrued by holder in all markets
     * @param holder The address to claim COMP for
     */
    function claimComp(address holder) external;
}
