// File: ../sc_datasets/DAppSCAN/Coinfabrik-DreamTeam Smart Contracts Audit for Players Compensation/smart-contracts-c1efcabf8a56a4d0a1fa5185a095052c110bdd87/contracts/storage/StorageInterface.sol

pragma solidity ^0.4.18;

interface StorageInterface {

    function transferOwnership (address newOwner) public; // Owners only: revoke access from the calling account and grant access to newOwner
    function grantAccess (address newOwner) public; // Owners only: just grant access to newOwner without revoking the access from the current owner
    function revokeAccess (address previousOwner) public; // Just revoke access from the current owner
    function isOwner (address addr) public view returns(bool);
    function getUint (bytes32 record) public view returns (uint);
    function getString (bytes32 record) public view returns (string);
    function getAddress (bytes32 record) public view returns (address);
    function getBytes (bytes32 record) public view returns (bytes);
    function getBoolean (bytes32 record) public view returns (bool);
    function getInt (bytes32 record) public view returns (int);
    function setString (bytes32 record, string value) public;
    function setUint (bytes32 record, uint value) public;
    function setAddress (bytes32 record, address value) public;
    function setBytes (bytes32 record, bytes value) public;
    function setBoolean (bytes32 record, bool value) public;
    function setInt (bytes32 record, int value) public;

}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-DreamTeam Smart Contracts Audit for Players Compensation/smart-contracts-c1efcabf8a56a4d0a1fa5185a095052c110bdd87/contracts/storage/BasicStorage.sol

pragma solidity ^0.4.18;

contract BasicStorage {

    mapping(address => bool) public owners; // Database owners, addresses that have permissions to write data to DB

    modifier ownersOnly {require(owners[msg.sender]); _;}

    function BasicStorage (address[] initialOwners) public {
        for (uint i; i < initialOwners.length; i++) {
            owners[initialOwners[i]] = true;
        }
    }

    function transferOwnership (address newOwner) public ownersOnly {
        owners[newOwner] = true;
        delete owners[msg.sender];
    }

    function grantAccess (address newOwner) public ownersOnly {
        owners[newOwner] = true;
    }

    function revokeAccess (address previousOwner) public ownersOnly {
        delete owners[previousOwner];
    }

    function isOwner (address addr) public view returns(bool) {
        return owners[addr] == true;
    }

}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-DreamTeam Smart Contracts Audit for Players Compensation/smart-contracts-c1efcabf8a56a4d0a1fa5185a095052c110bdd87/contracts/storage/DreamTeamStorage.sol

pragma solidity ^0.4.18;


contract DreamTeamStorage is BasicStorage {

    mapping(bytes32 => uint) uintStorage;
    mapping(bytes32 => string) stringStorage;
    mapping(bytes32 => address) addressStorage;
    mapping(bytes32 => bytes) bytesStorage;
    mapping(bytes32 => bool) booleanStorage;
    mapping(bytes32 => int) intStorage;

    function DreamTeamStorage (address[] initialOwners) BasicStorage(initialOwners) public {}

    function getUint (bytes32 record) public view returns (uint) { return uintStorage[record]; }
    function getString (bytes32 record) public view returns (string) { return stringStorage[record]; }
    function getAddress (bytes32 record) public view returns (address) { return addressStorage[record]; }
    function getBytes (bytes32 record) public view returns (bytes) { return bytesStorage[record]; }
    function getBoolean (bytes32 record) public view returns (bool) { return booleanStorage[record]; }
    function getInt (bytes32 record) public view returns (int) { return intStorage[record]; }
    function setString (bytes32 record, string value) public ownersOnly { stringStorage[record] = value; }
    function setUint (bytes32 record, uint value) public ownersOnly { uintStorage[record] = value; }
    function setAddress (bytes32 record, address value) public ownersOnly { addressStorage[record] = value; }
    function setBytes (bytes32 record, bytes value) public ownersOnly { bytesStorage[record] = value; }
    function setBoolean (bytes32 record, bool value) public ownersOnly { booleanStorage[record] = value; }
    function setInt (bytes32 record, int value) public ownersOnly { intStorage[record] = value; }

}
