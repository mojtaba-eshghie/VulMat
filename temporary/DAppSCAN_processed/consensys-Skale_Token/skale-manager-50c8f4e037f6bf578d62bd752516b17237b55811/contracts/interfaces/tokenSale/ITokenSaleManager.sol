// File: ../sc_datasets/DAppSCAN/consensys-Skale_Token/skale-manager-50c8f4e037f6bf578d62bd752516b17237b55811/contracts/interfaces/tokenSale/ITokenSaleManager.sol

pragma solidity ^0.5.3;

interface ITokenSaleManager {

    /// @notice Allocates values for `walletAddresses`
    function approve(address[] calldata walletAddress, uint[] calldata value) external;

    /// @notice Transfers the entire value to sender address. Tokens are locked.
    function retrieve() external;

    /// @notice Allows seller address to approve tokens transfers
    function registerSeller(address seller) external;
}
