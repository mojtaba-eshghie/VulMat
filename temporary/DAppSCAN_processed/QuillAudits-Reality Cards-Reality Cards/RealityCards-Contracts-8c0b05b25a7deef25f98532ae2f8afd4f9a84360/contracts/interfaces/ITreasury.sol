// File: ../sc_datasets/DAppSCAN/QuillAudits-Reality Cards-Reality Cards/RealityCards-Contracts-8c0b05b25a7deef25f98532ae2f8afd4f9a84360/contracts/interfaces/ITreasury.sol

pragma solidity 0.5.13;

interface ITreasury
{
    function payout(address,uint256) external returns (bool);
    function payRent(address,uint256) external returns (bool);
    function addMarket(address) external returns (bool);
    function deposits(address) external returns (uint256);
    function setFactoryAddress() external returns(bool);
    function allocateCardSpecificDeposit(address,address,uint256,uint256) external returns (bool);
    function processHarbergerPayment(address,address,uint256) external returns (bool);
    function cardSpecificDeposits(address,address,uint256) external returns(uint256);
    function deposit(address) external payable returns (bool);
    function sponsor() external payable returns (bool);
    function hotPotatoDivisor() external payable returns (uint256);
    function updateTotalRental(address,uint256,bool) external returns (bool);
    function userTotalRentals(address) external returns (uint256);
    function updateLastRentalTime(address) external returns (bool);
    function minRentalDivisor() external returns (uint256);
    function maxContractBalance() external returns (uint256);
}
