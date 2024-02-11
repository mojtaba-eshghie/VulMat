// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/src/vaults/verifiers/IEthDepositVerifier.sol

pragma solidity 0.5.11;

interface IEthDepositVerifier {
    /**
     * @notice Verifies a deposit transaction
     * @param depositTx The deposit transaction
     * @param amount The amount deposited
     * @param sender The owner of the deposit transaction
     */
    function verify(bytes calldata depositTx, uint256 amount, address sender) external view;
}
