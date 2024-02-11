// File: ../sc_datasets/DAppSCAN/Quantstamp-OriginTrail Starfleet Staking/starfleet-boarding-contract-79012dbbfe1501870a090f2e6561e0f05cdf1bed/contracts/mocks/IBridgeCustodian.sol

pragma solidity ^0.6.10;

/// @title IBridgeCustodian interface - The interface required for an address to qualify as a custodian.
interface IBridgeCustodian {
    function getOwners() external view returns (address[] memory);
}
