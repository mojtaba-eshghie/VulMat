// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/eternal-storage/EternalStorage.sol

pragma solidity 0.5.9;


/// @dev This contract holds all the necessary state variables to carry out the storage of any upgradable contract
/// and to support the upgrade functionality.
contract EternalStorage {

    // An address of the owner of the contract
    address internal _owner;

    // Storage mappings
    mapping(bytes32 => uint256) internal uintStorage;
    mapping(bytes32 => string) internal stringStorage;
    mapping(bytes32 => address) internal addressStorage;
    mapping(bytes32 => bytes) internal bytesStorage;
    mapping(bytes32 => bool) internal boolStorage;
    mapping(bytes32 => int256) internal intStorage;
    mapping(bytes32 => bytes32) internal bytes32Storage;

    mapping(bytes32 => uint256[]) internal uintArrayStorage;
    mapping(bytes32 => string[]) internal stringArrayStorage;
    mapping(bytes32 => address[]) internal addressArrayStorage;
    mapping(bytes32 => bytes[]) internal bytesArrayStorage;
    mapping(bytes32 => bool[]) internal boolArrayStorage;
    mapping(bytes32 => int256[]) internal intArrayStorage;
    mapping(bytes32 => bytes32[]) internal bytes32ArrayStorage;

}
