// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyExchangeRateContract.sol

pragma solidity ^0.4.24;

/**
 * @author Nikola Madjarevic
 * @notice Interface for exchange contract to get the eth-currency rate
 */
contract ITwoKeyExchangeRateContract {
    function getBaseToTargetRate(string _currency) public view returns (uint);
}
