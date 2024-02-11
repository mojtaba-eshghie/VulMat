// File: ../sc_datasets/DAppSCAN/QuillAudits-Alium Finance Smart Contract/alium-farm-e37d6af39af68049c2684085f025385407b4bd55/contracts/interfaces/IAliumCashbox.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0;

/**
 * @dev Interface of the AliumCashbox
 */
interface IAliumCashbox {
    function getBalance() external view returns (uint256);

    function getWalletLimit(address _wallet) external view returns (uint256);

    function getWalletWithdrawals(address _wallet)
        external
        view
        returns (uint256);

    // @dev Error if not enough {_amount} on cashbox contract
    //      or not balance not resolved.
    function withdraw(uint256 _amount) external;
}
