// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyBaseReputationRegistry.sol

pragma solidity ^0.4.24;
/**
 * @author Nikola Madjarevic
 * Created at 2/4/19
 */
contract ITwoKeyBaseReputationRegistry {
    function updateOnConversionExecutedEvent(address converter, address contractor, address acquisitionCampaign) public;
    function updateOnConversionRejectedEvent(address converter, address contractor, address acquisitionCampaign) public;
}
