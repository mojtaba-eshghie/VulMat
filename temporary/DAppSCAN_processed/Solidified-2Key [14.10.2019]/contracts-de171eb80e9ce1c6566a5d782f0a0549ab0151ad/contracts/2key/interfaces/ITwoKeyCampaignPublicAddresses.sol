// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyCampaignPublicAddresses.sol

pragma solidity ^0.4.24;
/**
 * @author Nikola Madjarevic
 * Created at 2/27/19
 */
contract ITwoKeyCampaignPublicAddresses {
    address public twoKeySingletonesRegistry;
    address public contractor; //contractor address
    address public moderator; //moderator address
    function publicLinkKeyOf(address me) public view returns (address);
}
