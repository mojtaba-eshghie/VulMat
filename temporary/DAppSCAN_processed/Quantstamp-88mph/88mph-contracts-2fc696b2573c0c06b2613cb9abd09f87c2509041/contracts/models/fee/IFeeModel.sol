// File: ../sc_datasets/DAppSCAN/Quantstamp-88mph/88mph-contracts-2fc696b2573c0c06b2613cb9abd09f87c2509041/contracts/models/fee/IFeeModel.sol

pragma solidity 0.5.17;

interface IFeeModel {
    function beneficiary() external view returns (address payable);

    function getFee(uint256 _txAmount)
        external
        pure
        returns (uint256 _feeAmount);
}
