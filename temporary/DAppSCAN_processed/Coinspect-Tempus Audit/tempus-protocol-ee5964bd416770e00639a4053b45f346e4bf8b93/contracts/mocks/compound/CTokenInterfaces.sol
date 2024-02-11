// File: ../sc_datasets/DAppSCAN/Coinspect-Tempus Audit/tempus-protocol-ee5964bd416770e00639a4053b45f346e4bf8b93/contracts/mocks/compound/ComptrollerInterface.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.6;

abstract contract ComptrollerInterface {
    /// Assets You Are In
    function enterMarkets(address[] calldata cTokens) external virtual returns (uint[] memory);

    function exitMarket(address cToken) external virtual returns (uint);

    /// Policy Hooks

    function mintAllowed(
        address cToken,
        address minter,
        uint mintAmount
    ) external virtual returns (uint);
}

// File: ../sc_datasets/DAppSCAN/Coinspect-Tempus Audit/tempus-protocol-ee5964bd416770e00639a4053b45f346e4bf8b93/contracts/mocks/compound/CTokenInterfaces.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.6;

contract CTokenStorage {
    /**
     * @notice Contract which oversees inter-cToken operations
     */
    ComptrollerInterface public comptroller;
}

abstract contract CTokenInterface is CTokenStorage {
    /**
     * @notice Indicator that this is a CToken contract (for inspection)
     */
    bool public constant isCToken = true;

    // as defined in Compound protocol
    function exchangeRateStored() external view virtual returns (uint);

    function exchangeRateCurrent() external virtual returns (uint);
}

contract CErc20Storage {
    /**
     * @notice Underlying asset for this CToken
     */
    address public underlying;
}

abstract contract CErc20Interface is CErc20Storage {
    /**
     * This is used to deposit into Compound with CErc20 tokens
     */
    function mint(uint mintAmount) external virtual returns (uint);

    function redeem(uint redeemTokens) external virtual returns (uint);
}
