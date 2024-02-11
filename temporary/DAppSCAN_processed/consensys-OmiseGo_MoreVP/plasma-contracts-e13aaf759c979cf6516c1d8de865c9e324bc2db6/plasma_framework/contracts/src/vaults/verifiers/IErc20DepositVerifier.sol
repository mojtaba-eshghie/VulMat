// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/src/vaults/verifiers/IErc20DepositVerifier.sol

pragma solidity 0.5.11;

interface IErc20DepositVerifier {
    /**
     * @notice Verifies a deposit transaction
     * @param depositTx The deposit transaction
     * @param sender The owner of the deposit transaction
     * @param vault The address of the Erc20Vault contract
     * @return Verified (owner, token, amount) of the deposit ERC20 token data
     */
    function verify(bytes calldata depositTx, address sender, address vault)
        external
        view
        returns (address owner, address token, uint256 amount);
}
