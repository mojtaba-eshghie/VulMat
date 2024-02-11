// File: ../sc_datasets/DAppSCAN/Quantstamp-RariCapital V2/rari-yield-pool-contracts-0d7d301b571ec9fee2ae5b3b3d0ef7598738ac26/contracts/external/mstable/ISavingsContract.sol

pragma solidity 0.5.17;

/**
 * @title ISavingsContract
 */
contract ISavingsContract {
    uint256 public exchangeRate;
    mapping(address => uint256) public creditBalances;
    function depositSavings(uint256 _amount) external returns (uint256 creditsIssued);
    function redeem(uint256 _amount) external returns (uint256 massetReturned);
}
