// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/IDecentralizedNation.sol

pragma solidity ^0.4.24;

contract IDecentralizedNation {

    function getMembersVotingPoints(
        address _memberAddress
    )
    public
    view
    returns (uint);


    function getMemberid(
        address _member
    )
    public
    view
    returns (uint);
}
