// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyWeightedVoteContract.sol

pragma solidity ^0.4.24;

contract ITwoKeyWeightedVoteContract {
    function getDescription() public view returns(string);
    function transferSig(bytes sig) public returns (address[]);
    function setValid() public;
    function getDynamicData() public view returns (uint,uint,uint,uint,uint,uint);
    function getHowMuchAddressPutPower(address add) public view returns (uint);
    function getVoteAndChoicePerAddress(address voter) public view returns (bool, uint);
    function getAllVoters() public view returns (address[]);
}
