// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyRegistry.sol

pragma solidity ^0.4.24;

contract ITwoKeyRegistry {
    function checkIfUserExists(address _userAddress) public view returns (bool);
    function getUserData(address _user) public view returns (bytes32,bytes32,bytes32);
}
