// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/src/vaults/verifiers/IErc20DepositVerifier.sol

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
