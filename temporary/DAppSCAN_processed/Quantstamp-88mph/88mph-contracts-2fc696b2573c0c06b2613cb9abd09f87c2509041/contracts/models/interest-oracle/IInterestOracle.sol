// File: ../sc_datasets/DAppSCAN/Quantstamp-88mph/88mph-contracts-2fc696b2573c0c06b2613cb9abd09f87c2509041/contracts/models/interest-oracle/IInterestOracle.sol

pragma solidity 0.5.17;

interface IInterestOracle {
    function updateAndQuery() external returns (bool updated, uint256 value);

    function query() external view returns (uint256 value);

    function moneyMarket() external view returns (address);
}
