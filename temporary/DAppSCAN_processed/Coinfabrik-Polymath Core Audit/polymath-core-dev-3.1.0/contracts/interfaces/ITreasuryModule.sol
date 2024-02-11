// File: ../sc_datasets/DAppSCAN/Coinfabrik-Polymath Core Audit/polymath-core-dev-3.1.0/contracts/interfaces/ITreasuryModule.sol

pragma solidity 0.5.8;

interface ITreasuryModule {

    /**
     * @notice use to return the treasury wallet
     */
    function getTreasuryWallet() external view returns(address);

}
