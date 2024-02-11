// File: ../sc_datasets/DAppSCAN/Quantstamp-88mph/88mph-contracts-2fc696b2573c0c06b2613cb9abd09f87c2509041/contracts/moneymarkets/compound/imports/IComptroller.sol

pragma solidity 0.5.17;


// Compound finance Comptroller interface
// Documentation: https://compound.finance/docs/comptroller
interface IComptroller {
    function claimComp(address holder) external;
    function getCompAddress() external view returns (address);
}
