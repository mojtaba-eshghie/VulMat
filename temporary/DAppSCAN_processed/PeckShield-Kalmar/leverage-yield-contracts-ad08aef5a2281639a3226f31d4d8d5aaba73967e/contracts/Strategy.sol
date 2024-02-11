// File: ../sc_datasets/DAppSCAN/PeckShield-Kalmar/leverage-yield-contracts-ad08aef5a2281639a3226f31d4d8d5aaba73967e/contracts/Strategy.sol

pragma solidity 0.5.16;

interface Strategy {
    /// @dev Execute worker strategy. Take LP tokens + ETH. Return LP tokens + ETH.
    /// @param user The original user that is interacting with the operator.
    /// @param debt The user's total debt, for better decision making context.
    /// @param data Extra calldata information passed along to this strategy.
    function execute(address user, uint256 debt, bytes calldata data) external payable;
}
