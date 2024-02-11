// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/src/vaults/verifiers/IEthDepositVerifier.sol

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
