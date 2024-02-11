// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Vault V2 (Vyper part)/contracts-461ff006f6da63b339819fdb5e76468656d6625c/lending-optimizer/contracts/interfaces/IInvestmentToken.sol

pragma solidity ^0.6.2;

interface IInvestmentToken {
    function isInvestmentToken(address _investmentToken)
        external
        view
        returns (bool);

    function removeInvestmentToken(address _investmentToken) external;

    function addInvestmentToken(address _investmentToken) external;
}
