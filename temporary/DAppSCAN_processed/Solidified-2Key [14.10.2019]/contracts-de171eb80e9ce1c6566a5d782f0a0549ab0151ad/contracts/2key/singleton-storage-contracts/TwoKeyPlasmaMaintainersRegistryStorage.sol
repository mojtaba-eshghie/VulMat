// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeySingletonesRegistry.sol

pragma solidity ^0.4.24;

/**
 * @title IRegistry
 * @dev This contract represents the interface of a registry contract
 */
interface ITwoKeySingletonesRegistry {

    /**
    * @dev This event will be emitted every time a new proxy is created
    * @param proxy representing the address of the proxy created
    */
    event ProxyCreated(address proxy);


    /**
    * @dev This event will be emitted every time a new implementation is registered
    * @param version representing the version name of the registered implementation
    * @param implementation representing the address of the registered implementation
    */
    event VersionAdded(string version, address implementation);

    /**
    * @dev Registers a new version with its implementation address
    * @param version representing the version name of the new implementation to be registered
    * @param implementation representing the address of the new implementation to be registered
    */
    function addVersion(string _contractName, string version, address implementation) public;

    /**
    * @dev Tells the address of the implementation for a given version
    * @param _contractName is the name of the contract we're querying
    * @param version to query the implementation of
    * @return address of the implementation registered for the given version
    */
    function getVersion(string _contractName, string version) public view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/upgradability/UpgradabilityStorage.sol

pragma solidity ^0.4.24;

/**
 * @title UpgradeabilityStorage
 * @dev This contract holds all the necessary state variables to support the upgrade functionality
 */
contract UpgradeabilityStorage {
    // Versions registry
    ITwoKeySingletonesRegistry internal registry;

    // Address of the current implementation
    address internal _implementation;

    /**
    * @dev Tells the address of the current implementation
    * @return address of the current implementation
    */
    function implementation() public view returns (address) {
        return _implementation;
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/upgradability/Upgradeable.sol

pragma solidity ^0.4.24;

contract Upgradeable is UpgradeabilityStorage {
    /**
     * @dev Validates the caller is the versions registry.
     * @param sender representing the address deploying the initial behavior of the contract
     */
    function initialize(address sender) public payable {
        require(msg.sender == address(registry));
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/upgradability/StructuredStorage.sol

pragma solidity ^0.4.0;

contract StructuredStorage is Upgradeable {

    bool initialized;

    address public PROXY_LOGIC_CONTRACT;
    address public DEPLOYER;

    // Single
    mapping(bytes32 => bytes32) bytes32Storage;
    mapping(bytes32 => uint) uIntStorage;
    mapping(bytes32 => string) stringStorage;
    mapping(bytes32 => address) addressStorage;
    mapping(bytes32 => bytes) bytesStorage;
    mapping(bytes32 => bool) boolStorage;
    mapping(bytes32 => int) intStorage;

    // Arrays
    mapping(bytes32 => bytes32[]) bytes32ArrayStorage;
    mapping(bytes32 => address[]) addressArrayStorage;
    mapping(bytes32 => uint[]) uintArrayStorage;
    mapping(bytes32 => bool[]) boolArrayStorage;
    mapping(bytes32 => int[]) intArrayStorage;

    modifier onlyDeployer {
        require(msg.sender == DEPLOYER);
        _;
    }

    modifier onlyProxyLogicContract {
        require(msg.sender == PROXY_LOGIC_CONTRACT);
        _;
    }

    // *** Setter for Contract which holds all the logic ***
    function setProxyLogicContractAndDeployer(address _proxyLogicContract, address deployer) external {
        require(initialized == false);

        PROXY_LOGIC_CONTRACT = _proxyLogicContract;
        DEPLOYER = deployer;

        initialized = true;
    }

    function setProxyLogicContract(address _proxyLogicContract) external onlyDeployer {
        PROXY_LOGIC_CONTRACT = _proxyLogicContract;
    }

    // *** Getter Methods ***
    function getUint(bytes32 _key) onlyProxyLogicContract external view returns (uint) {
        return uIntStorage[_key];
    }

    function getString(bytes32 _key) onlyProxyLogicContract external view returns(string) {
        return stringStorage[_key];
    }

    function getAddress(bytes32 _key) onlyProxyLogicContract external view returns(address) {
        return addressStorage[_key];
    }

    function getBytes(bytes32 _key) onlyProxyLogicContract external view returns(bytes) {
        return bytesStorage[_key];
    }

    function getBool(bytes32 _key) onlyProxyLogicContract external view returns(bool) {
        return boolStorage[_key];
    }

    function getInt(bytes32 _key) onlyProxyLogicContract external view returns(int) {
        return intStorage[_key];
    }

    function getBytes32(bytes32 _key) onlyProxyLogicContract external view returns (bytes32) {
        return bytes32Storage[_key];
    }

    function getBytes32Array(bytes32 _key) onlyProxyLogicContract external view returns (bytes32[]) {
        return bytes32ArrayStorage[_key];
    }

    function getAddressArray(bytes32 _key) onlyProxyLogicContract external view returns (address[]) {
        return addressArrayStorage[_key];
    }

    function getUintArray(bytes32 _key) onlyProxyLogicContract external view returns (uint[]) {
        return uintArrayStorage[_key];
    }

    function getIntArray(bytes32 _key) onlyProxyLogicContract external view returns (int[]) {
        return intArrayStorage[_key];
    }

    function getBoolArray(bytes32 _key) onlyProxyLogicContract external view returns (bool[]) {
        return boolArrayStorage[_key];
    }



    // *** Setter Methods ***
    function setUint(bytes32 _key, uint _value) onlyProxyLogicContract external {
        uIntStorage[_key] = _value;
    }

    function setString(bytes32 _key, string _value) onlyProxyLogicContract external {
        stringStorage[_key] = _value;
    }

    function setAddress(bytes32 _key, address _value) onlyProxyLogicContract external {
        addressStorage[_key] = _value;
    }

    function setBytes(bytes32 _key, bytes _value) onlyProxyLogicContract external {
        bytesStorage[_key] = _value;
    }

    function setBool(bytes32 _key, bool _value) onlyProxyLogicContract external {
        boolStorage[_key] = _value;
    }

    function setInt(bytes32 _key, int _value) onlyProxyLogicContract external {
        intStorage[_key] = _value;
    }

    function setBytes32(bytes32 _key, bytes32 _value) onlyProxyLogicContract external {
        bytes32Storage[_key] = _value;
    }

    function setBytes32Array(bytes32 _key, bytes32[] _value) onlyProxyLogicContract external {
        bytes32ArrayStorage[_key] = _value;
    }

    function setAddressArray(bytes32 _key, address[] _value) onlyProxyLogicContract external {
        addressArrayStorage[_key] = _value;
    }

    function setUintArray(bytes32 _key, uint[] _value) onlyProxyLogicContract external {
        uintArrayStorage[_key] = _value;
    }

    function setIntArray(bytes32 _key, int[] _value) onlyProxyLogicContract external {
        intArrayStorage[_key] = _value;
    }

    function setBoolArray(bytes32 _key, bool[] _value) onlyProxyLogicContract external {
        boolArrayStorage[_key] = _value;
    }

    // *** Delete Methods ***
    function deleteUint(bytes32 _key) onlyProxyLogicContract external {
        delete uIntStorage[_key];
    }

    function deleteString(bytes32 _key) onlyProxyLogicContract external {
        delete stringStorage[_key];
    }

    function deleteAddress(bytes32 _key) onlyProxyLogicContract external {
        delete addressStorage[_key];
    }

    function deleteBytes(bytes32 _key) onlyProxyLogicContract external {
        delete bytesStorage[_key];
    }

    function deleteBool(bytes32 _key) onlyProxyLogicContract external {
        delete boolStorage[_key];
    }

    function deleteInt(bytes32 _key) onlyProxyLogicContract external {
        delete intStorage[_key];
    }

    function deleteBytes32(bytes32 _key) onlyProxyLogicContract external {
        delete bytes32Storage[_key];
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/singleton-storage-contracts/TwoKeyPlasmaMaintainersRegistryStorage.sol

pragma solidity ^0.4.24;

contract TwoKeyPlasmaMaintainersRegistryStorage is StructuredStorage {

}
