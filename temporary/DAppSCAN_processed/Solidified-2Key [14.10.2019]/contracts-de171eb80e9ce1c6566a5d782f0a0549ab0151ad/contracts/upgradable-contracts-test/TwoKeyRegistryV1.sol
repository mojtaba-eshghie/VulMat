// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/libraries/Call.sol

pragma solidity ^0.4.24;

library Call {
    function params0(address c, bytes _method) public view returns (uint answer) {
        // https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c
        //    dc = c;
        bytes4 sig = bytes4(keccak256(_method));
        assembly {
        // move pointer to free memory spot
            let ptr := mload(0x40)
        // put function sig at memory spot
            mstore(ptr,sig)

            let result := call(  // use WARNING because this should be staticcall BUT geth crash!
            15000, // gas limit
            c, // sload(dc_slot),  // to addr. append var to _slot to access storage variable
            0, // not transfer any ether (comment if using staticcall)
            ptr, // Inputs are stored at location ptr
            0x04, // Inputs are 0 bytes long
            ptr,  //Store output over input
            0x20) //Outputs are 1 bytes long

            if eq(result, 0) {
                revert(0, 0)
            }

            answer := mload(ptr) // Assign output to answer var
            mstore(0x40,add(ptr,0x24)) // Set storage pointer to new space
        }
    }

    function params1(address c, bytes _method, uint _val) public view returns (uint answer) {
        // https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c
        //    dc = c;
        bytes4 sig = bytes4(keccak256(_method));
        assembly {
        // move pointer to free memory spot
            let ptr := mload(0x40)
        // put function sig at memory spot
            mstore(ptr,sig)
        // append argument after function sig
            mstore(add(ptr,0x04), _val)

            let result := call(  // use WARNING because this should be staticcall BUT geth crash!
            15000, // gas limit
            c, // sload(dc_slot),  // to addr. append var to _slot to access storage variable
            0, // not transfer any ether (comment if using staticcall)
            ptr, // Inputs are stored at location ptr
            0x24, // Inputs are 0 bytes long
            ptr,  //Store output over input
            0x20) //Outputs are 1 bytes long

            if eq(result, 0) {
                revert(0, 0)
            }

            answer := mload(ptr) // Assign output to answer var
            mstore(0x40,add(ptr,0x24)) // Set storage pointer to new space
        }
    }

    function params2(address c, bytes _method, uint _val1, uint _val2) public view returns (uint answer) {
        // https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c
        //    dc = c;
        bytes4 sig = bytes4(keccak256(_method));
        assembly {
        // move pointer to free memory spot
            let ptr := mload(0x40)
        // put function sig at memory spot
            mstore(ptr,sig)
        // append argument after function sig
            mstore(add(ptr,0x04), _val1)
            mstore(add(ptr,0x24), _val2)

            let result := call(  // use WARNING because this should be staticcall BUT geth crash!
            15000, // gas limit
            c, // sload(dc_slot),  // to addr. append var to _slot to access storage variable
            0, // not transfer any ether (comment if using staticcall)
            ptr, // Inputs are stored at location ptr
            0x44, // Inputs are 4 bytes for signature and 2 uint256
            ptr,  //Store output over input
            0x20) //Outputs are 1 uint long

        // TODO cause revert
        //            if eq(result, 0) {
        //                revert(0, 0)
        //            }

            answer := mload(ptr) // Assign output to answer var
            mstore(0x40,add(ptr,0x20)) // Set storage pointer to new space
        }
    }

    function loadAddress(bytes sig, uint idx) public pure returns (address) {
        address influencer;
        idx += 20;
        assembly
        {
            influencer := mload(add(sig, idx))
        }
        return influencer;
    }

    function loadUint8(bytes sig, uint idx) public pure returns (uint8) {
        uint8 weight;
        idx += 1;
        assembly
        {
            weight := mload(add(sig, idx))
        }
        return weight;
    }


    function recoverHash(bytes32 hash, bytes sig, uint idx) public pure returns (address) {
        // same as recoverHash in utils/sign.js
        // The signature format is a compact form of:
        //   {bytes32 r}{bytes32 s}{uint8 v}
        // Compact means, uint8 is not padded to 32 bytes.
        require (sig.length >= 65+idx, 'bad signature length');
        idx += 32;
        bytes32 r;
        assembly
        {
            r := mload(add(sig, idx))
        }

        idx += 32;
        bytes32 s;
        assembly
        {
            s := mload(add(sig, idx))
        }

        idx += 1;
        uint8 v;
        assembly
        {
            v := mload(add(sig, idx))
        }
        if (v >= 32) { // handle case when signature was made with ethereum web3.eth.sign or getSign which is for signing ethereum transactions
            v -= 32;
            bytes memory prefix = "\x19Ethereum Signed Message:\n32"; // 32 is the number of bytes in the following hash
            hash = keccak256(abi.encodePacked(prefix, hash));
        }
        if (v <= 1) v += 27;
        require(v==27 || v==28,'bad sig v');
        return ecrecover(hash, v, r, s);

    }

    function recoverSigMemory(bytes sig) private pure returns (address[], address[], uint8[], uint[], uint) {
        uint8 version = loadUint8(sig, 0);
        uint msg_len = (version == 1) ? 1+65+20 : 1+20+20;
        uint n_influencers = (sig.length-21) / (65+msg_len);
        uint8[] memory weights = new uint8[](n_influencers);
        address[] memory keys = new address[](n_influencers);
        if ((sig.length-21) % (65+msg_len) > 0) {
            n_influencers++;
        }
        address[] memory influencers = new address[](n_influencers);
        uint[] memory offsets = new uint[](n_influencers);

        return (influencers, keys, weights, offsets, msg_len);
    }

    function recoverSigParts(bytes sig, address last_address) private pure returns (address[], address[], uint8[], uint[]) {
        // sig structure:
        // 1 byte version 0 or 1
        // 20 bytes are the address of the contractor or the influencer who created sig.
        //  this is the "anchor" of the link
        //  It must have a public key aleady stored for it in public_link_key
        // Begining of a loop on steps in the link:
        // * 65 bytes are step-signature using the secret from previous step
        // * message of the step that is going to be hashed and used to compute the above step-signature.
        //   message length depend on version 41 (version 0) or 86 (version 1):
        //   * 1 byte cut (percentage) each influencer takes from the bounty. the cut is stored in influencer2cut or weight for voting
        //   * 20 bytes address of influencer (version 0) or 65 bytes of signature of cut using the influencer address to sign
        //   * 20 bytes public key of the last secret
        // In the last step the message can be optional. If it is missing the message used is the address of the sender
        uint idx = 0;
        uint msg_len;
        uint8[] memory weights;
        address[] memory keys;
        address[] memory influencers;
        uint[] memory offsets;
        (influencers, keys, weights, offsets, msg_len) = recoverSigMemory(sig);
        idx += 1;  // skip version

        idx += 20; // skip old_address which should be read by the caller in order to get old_key
        uint count_influencers = 0;

        while (idx + 65 <= sig.length) {
            offsets[count_influencers] = idx;
            idx += 65;  // idx was increased by 65 for the signature at the begining which we will process later

            if (idx + msg_len <= sig.length) {  // its  a < and not a <= because we dont want this to be the final iteration for the converter
                weights[count_influencers] = loadUint8(sig, idx);
                require(weights[count_influencers] > 0,'weight not defined (1..255)');  // 255 are used to indicate default (equal part) behaviour
                idx++;


                if (msg_len == 41)  // 1+20+20 version 0
                {
                    influencers[count_influencers] = loadAddress(sig, idx);
                    idx += 20;
                    keys[count_influencers] = loadAddress(sig, idx);
                    idx += 20;
                } else if (msg_len == 86)  // 1+65+20 version 1
                {
                    keys[count_influencers] = loadAddress(sig, idx+65);
                    influencers[count_influencers] = recoverHash(
                        keccak256(
                            abi.encodePacked(
                                keccak256(abi.encodePacked("bytes binding to weight","bytes binding to public")),
                                keccak256(abi.encodePacked(weights[count_influencers],keys[count_influencers]))
                            )
                        ),sig,idx);
                    idx += 65;
                    idx += 20;
                }

            } else {
                // handle short signatures generated with free_take
                influencers[count_influencers] = last_address;
            }
            count_influencers++;
        }
        require(idx == sig.length,'illegal message size');

        return (influencers, keys, weights, offsets);
    }

    function recoverSig(bytes sig, address old_key, address last_address) public pure returns (address[], address[], uint8[]) {
        // validate sig AND
        // recover the information from the signature: influencers, public_link_keys, weights/cuts
        // influencers may have one more address than the keys and weights arrays
        //
        require(old_key != address(0),'no public link key');

        address[] memory influencers;
        address[] memory keys;
        uint8[] memory weights;
        uint[] memory offsets;
        (influencers, keys, weights, offsets) = recoverSigParts(sig, last_address);

        // check if we received a valid signature
        for(uint i = 0; i < influencers.length; i++) {
            if (i < weights.length) {
                require (recoverHash(keccak256(abi.encodePacked(weights[i], keys[i], influencers[i])),sig,offsets[i]) == old_key, 'illegal signature');
                old_key = keys[i];
            } else {
                // signed message for the last step is the address of the converter
                require (recoverHash(keccak256(abi.encodePacked(influencers[i])),sig,offsets[i]) == old_key, 'illegal last signature');
            }
        }

        return (influencers, keys, weights);
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyMaintainersRegistry.sol

pragma solidity ^0.4.24;

contract ITwoKeyMaintainersRegistry {
    function onlyMaintainer(address _sender) public view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/libraries/Utils.sol

pragma solidity ^0.4.0;

/**
 * @title Utils
 * @dev Utility functions to perform various repeated actions in contracts
 */
contract Utils {

    /**
     * @notice Function to transform string to bytes32
     * @dev string should be less than 32 chars
     */
    function stringToBytes32(
        string memory source
    )
    internal
    pure
    returns (bytes32 result)
    {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
            result := mload(add(source, 32))
        }
    }

    /**
     * @notice Function to concat at most 3 strings
     * @dev If you want to handle concatenation of less than 3, then pass first their values and for the left pass empty strings
     * @return string concatenated
     */
    function strConcat(
        string _a,
        string _b,
        string _c
    )
    internal
    pure
    returns (string)
    {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        string memory abcde = new string(_ba.length + _bb.length + _bc.length);
        bytes memory babcde = bytes(abcde);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
        for (i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
        for (i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
        return string(babcde);
    }


}

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

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeySingletoneRegistryFetchAddress.sol

pragma solidity ^0.4.24;
/**
 * @author Nikola Madjarevic
 * Created at 2/7/19
 */
contract ITwoKeySingletoneRegistryFetchAddress {
    function getContractProxyAddress(string _contractName) public view returns (address);
    function getNonUpgradableContractAddress(string contractName) public view returns (address);
    function getLatestContractVersion(string contractName) public view returns (string);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/singleton-contracts/ITwoKeySingletonUtils.sol

pragma solidity ^0.4.24;


contract ITwoKeySingletonUtils {

    address public TWO_KEY_SINGLETON_REGISTRY;

    // Modifier to restrict method calls only to maintainers
    modifier onlyMaintainer {
        address twoKeyMaintainersRegistry = getAddressFromTwoKeySingletonRegistry("TwoKeyMaintainersRegistry");
        require(ITwoKeyMaintainersRegistry(twoKeyMaintainersRegistry).onlyMaintainer(msg.sender));
        _;
    }

    // Internal function to fetch address from TwoKeyRegTwoistry
    function getAddressFromTwoKeySingletonRegistry(string contractName) internal view returns (address) {
        return ITwoKeySingletoneRegistryFetchAddress(TWO_KEY_SINGLETON_REGISTRY)
        .getContractProxyAddress(contractName);
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/IStructuredStorage.sol

pragma solidity ^0.4.0;

contract IStructuredStorage {

    function setProxyLogicContractAndDeployer(address _proxyLogicContract, address _deployer) external;
    function setProxyLogicContract(address _proxyLogicContract) external;

    // *** Getter Methods ***
    function getUint(bytes32 _key) external view returns(uint);
    function getString(bytes32 _key) external view returns(string);
    function getAddress(bytes32 _key) external view returns(address);
    function getBytes(bytes32 _key) external view returns(bytes);
    function getBool(bytes32 _key) external view returns(bool);
    function getInt(bytes32 _key) external view returns(int);
    function getBytes32(bytes32 _key) external view returns(bytes32);

    // *** Getter Methods For Arrays ***
    function getBytes32Array(bytes32 _key) external view returns (bytes32[]);
    function getAddressArray(bytes32 _key) external view returns (address[]);
    function getUintArray(bytes32 _key) external view returns (uint[]);
    function getIntArray(bytes32 _key) external view returns (int[]);
    function getBoolArray(bytes32 _key) external view returns (bool[]);

    // *** Setter Methods ***
    function setUint(bytes32 _key, uint _value) external;
    function setString(bytes32 _key, string _value) external;
    function setAddress(bytes32 _key, address _value) external;
    function setBytes(bytes32 _key, bytes _value) external;
    function setBool(bytes32 _key, bool _value) external;
    function setInt(bytes32 _key, int _value) external;
    function setBytes32(bytes32 _key, bytes32 _value) external;

    // *** Setter Methods For Arrays ***
    function setBytes32Array(bytes32 _key, bytes32[] _value) external;
    function setAddressArray(bytes32 _key, address[] _value) external;
    function setUintArray(bytes32 _key, uint[] _value) external;
    function setIntArray(bytes32 _key, int[] _value) external;
    function setBoolArray(bytes32 _key, bool[] _value) external;

    // *** Delete Methods ***
    function deleteUint(bytes32 _key) external;
    function deleteString(bytes32 _key) external;
    function deleteAddress(bytes32 _key) external;
    function deleteBytes(bytes32 _key) external;
    function deleteBool(bytes32 _key) external;
    function deleteInt(bytes32 _key) external;
    function deleteBytes32(bytes32 _key) external;
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/storage-contracts/ITwoKeyRegistryStorage.sol

pragma solidity ^0.4.24;

contract ITwoKeyRegistryStorage is IStructuredStorage {

}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/singleton-contracts/TwoKeyRegistry.sol

pragma solidity ^0.4.24;






contract TwoKeyRegistry is Upgradeable, Utils, ITwoKeySingletonUtils {

    using Call for *;

    bool initialized;

    ITwoKeyRegistryStorage public PROXY_STORAGE_CONTRACT;

    /// @notice Event is emitted when a user's name is changed
    event UserNameChanged(address owner, string name);


    function isMaintainer(address x) internal view returns (bool) {
        address twoKeyMaintainersRegistry = getAddressFromTwoKeySingletonRegistry("TwoKeyMaintainersRegistry");
        return ITwoKeyMaintainersRegistry(twoKeyMaintainersRegistry).onlyMaintainer(x);
    }


    /**
     * @notice Function which can be called only once
     */
    function setInitialParams(
        address _twoKeySingletonesRegistry,
        address _proxyStorage
    )
    external
    {
        require(initialized == false);

        TWO_KEY_SINGLETON_REGISTRY = _twoKeySingletonesRegistry;
        PROXY_STORAGE_CONTRACT = ITwoKeyRegistryStorage(_proxyStorage);

        initialized = true;
    }



    /// @notice Function where new name/address pair is added or an old address is updated with new name
    /// @dev private function
    /// @param _name is name of user
    /// @param _sender is address of user
    function addNameInternal(
        string _name,
        address _sender
    )
    internal
    {
        bytes32 name = stringToBytes32(_name);

        bytes32 keyHashUserNameToAddress = keccak256("username2currentAddress", name);
        bytes32 keyHashAddressToUserName = keccak256("address2username", _sender);

        // check if name is taken
        if (PROXY_STORAGE_CONTRACT.getAddress(keyHashUserNameToAddress) != address(0)) {
            revert();
        }

        PROXY_STORAGE_CONTRACT.setString(keyHashAddressToUserName, _name);
        PROXY_STORAGE_CONTRACT.setAddress(keyHashUserNameToAddress, _sender);

        emit UserNameChanged(_sender, _name);
    }

    /**
     * @notice Function to concat this 2 functions at once
     */
    function addNameAndSetWalletName(
        string _name,
        address _sender,
        string _fullName,
        string _email,
        string _username_walletName,
        bytes _signatureName,
        bytes _signatureWalletName
    )
    public
    {
        require(isMaintainer(msg.sender));
        addName(_name, _sender, _fullName, _email, _signatureName);
        setWalletName(_name, _sender, _username_walletName, _signatureWalletName);
    }

    /// @notice Function where only admin can add a name - address pair
    /// @param _name is name of user
    /// @param _sender is address of user
    function addName(
        string _name,
        address _sender,
        string _fullName,
        string _email,
        bytes signature
    )
    public
    {
        require(isMaintainer(msg.sender)== true || msg.sender == address(this));

        string memory concatenatedValues = strConcat(_name,_fullName,_email);
        bytes32 hash = keccak256(abi.encodePacked(keccak256(abi.encodePacked("bytes binding to name")),
            keccak256(abi.encodePacked(concatenatedValues))));
        address message_signer = Call.recoverHash(hash, signature, 0);
        require(message_signer == _sender);
        bytes32 keyHashUsername = keccak256("addressToUserData", "username", _sender);
        bytes32 keyHashFullName = keccak256("addressToUserData", "fullName", _sender);
        bytes32 keyHashEmail = keccak256("addressToUserData", "email", _sender);

        PROXY_STORAGE_CONTRACT.setString(keyHashUsername, _name);
        PROXY_STORAGE_CONTRACT.setString(keyHashFullName, _fullName);
        PROXY_STORAGE_CONTRACT.setString(keyHashEmail, _email);

        addNameInternal(_name, _sender);
    }

    /// @notice Add signed name
    /// @param _name is the name
    /// @param external_sig is the external signature
    function addNameSigned(
        string _name,
        bytes external_sig
    )
    public
    {
        bytes32 hash = keccak256(abi.encodePacked(keccak256(abi.encodePacked("bytes binding to name")),
            keccak256(abi.encodePacked(_name))));
        address eth_address = Call.recoverHash(hash,external_sig,0);
        require (msg.sender == eth_address || isMaintainer(msg.sender) == true, "only maintainer or user can change name");
        addNameInternal(_name, eth_address);
    }

    function setNoteInternal(
        bytes note,
        address me
    )
    private
    {
        bytes32 keyHashNotes = keccak256("notes", me);
        PROXY_STORAGE_CONTRACT.setBytes(keyHashNotes, note);
    }

    function setNoteByUser(
        bytes note
    )
    public
    {
        // note is a message you can store with sig. For example it could be the secret you used encrypted by you
        setNoteInternal(note, msg.sender);
    }


    /// @notice Function where TwoKeyMaintainer can add walletname to address
    /// @param username is the username of the user we want to update map for
    /// @param _address is the address of the user we want to update map for
    /// @param _username_walletName is the concatenated username + '_' + walletName, since sending from trusted provider no need to validate
    function setWalletName(
        string memory username,
        address _address,
        string memory _username_walletName,
        bytes signature
    )
    public
    {
        require(isMaintainer(msg.sender) == true || msg.sender == address(this));
        require(_address != address(0));
        bytes32 usernameHex = stringToBytes32(username);
        address usersAddress = PROXY_STORAGE_CONTRACT.getAddress(keccak256("username2currentAddress", usernameHex));
        require(usersAddress == _address); // validating that username exists

        string memory concatenatedValues = strConcat(username,_username_walletName,"");

        bytes32 hash = keccak256(abi.encodePacked(keccak256(abi.encodePacked("bytes binding to name")),
            keccak256(abi.encodePacked(concatenatedValues))));
        address message_signer = Call.recoverHash(hash, signature, 0);
        require(message_signer == _address);

        bytes32 walletTag = stringToBytes32(_username_walletName);
        bytes32 keyHashAddress2WalletTag = keccak256("address2walletTag", _address);
        PROXY_STORAGE_CONTRACT.setBytes32(keyHashAddress2WalletTag, walletTag);

        bytes32 keyHashWalletTag2Address = keccak256("walletTag2address", walletTag);
        PROXY_STORAGE_CONTRACT.setAddress(keyHashWalletTag2Address, _address);
    }

    function addPlasma2EthereumInternal(
        bytes sig,
        address eth_address
    )
    private
    {
        // add an entry connecting msg.sender to the ethereum address that was used to sign sig.
        // see setup_demo.js on how to generate sig
        bytes32 hash = keccak256(abi.encodePacked(keccak256(abi.encodePacked("bytes binding to ethereum address")),keccak256(abi.encodePacked(eth_address))));
        address plasma_address = Call.recoverHash(hash,sig,0);
        bytes32 keyHashPlasmaToEthereum = keccak256("plasma2ethereum", plasma_address);
        bytes32 keyHashEthereumToPlasma = keccak256("ethereum2plasma", eth_address);

        require(PROXY_STORAGE_CONTRACT.getAddress(keyHashPlasmaToEthereum) == address(0) || PROXY_STORAGE_CONTRACT.getAddress(keyHashPlasmaToEthereum) == eth_address, "cant change eth=>plasma");

        PROXY_STORAGE_CONTRACT.setAddress(keyHashPlasmaToEthereum, eth_address);
        PROXY_STORAGE_CONTRACT.setAddress(keyHashEthereumToPlasma, plasma_address);
    }

    function addPlasma2EthereumByUser(
        bytes sig
    )
    public
    {
        addPlasma2EthereumInternal(sig, msg.sender);
    }

    function setPlasma2EthereumAndNoteSigned(
        bytes sig,
        bytes note,
        bytes external_sig
    )
    public
    {
        bytes32 hash = keccak256(abi.encodePacked(keccak256(abi.encodePacked("bytes binding to ethereum-plasma")),
            keccak256(abi.encodePacked(sig,note))));
        address eth_address = Call.recoverHash(hash,external_sig,0);
        require (msg.sender == eth_address || isMaintainer(msg.sender), "only maintainer or user can change ethereum-plasma");
        addPlasma2EthereumInternal(sig, eth_address);
        setNoteInternal(note, eth_address);
    }

    /// View function - doesn't cost any gas to be executed
    /// @notice Function to fetch address of the user that corresponds to given name
    /// @param _name is name of user
    /// @return address of the user as type address
    function getUserName2UserAddress(
        string _name
    )
    external
    view
    returns (address)
    {
        bytes32 name = stringToBytes32(_name);
        return PROXY_STORAGE_CONTRACT.getAddress(keccak256("username2currentAddress", _name));
    }

    /// View function - doesn't cost any gas to be executed
    /// @notice Function to fetch name that corresponds to the address
    /// @param _sender is address of user
    /// @return name of the user as type string
    function getUserAddress2UserName(
        address _sender
    )
    external
    view
    returns (string)
    {
        return PROXY_STORAGE_CONTRACT.getString(keccak256("address2username", _sender));
    }

//    /**
//     */
//    function deleteUser(
//        string userName
//    )
//    public
//    {
//        require(isMaintainer(msg.sender));
//        bytes32 userNameHex = stringToBytes32(userName);
//        address _ethereumAddress = username2currentAddress[userNameHex];
//        username2currentAddress[userNameHex] = address(0);
//
//        address2username[_ethereumAddress] = "";
//
//        bytes32 walletTag = address2walletTag[_ethereumAddress];
//        address2walletTag[_ethereumAddress] = bytes32(0);
//        walletTag2address[walletTag] = address(0);
//
//        address plasma = ethereum2plasma[_ethereumAddress];
//        ethereum2plasma[_ethereumAddress] = address(0);
//        PROXY_STORAGE_CONTRACT.deleteAddress()
//        plasma2ethereum[plasma] = address(0);
//
//        UserData memory userdata = addressToUserData[_ethereumAddress];
//        userdata.username = "";
//        userdata.fullName = "";
//        userdata.email = "";
//        addressToUserData[_ethereumAddress] = userdata;
//
//        notes[_ethereumAddress] = "";
//    }


    /**
     * @notice Reading from mapping ethereum 2 plasma
     * @param plasma is the plasma address we're searching eth address for
     * @return ethereum address if exist otherwise 0x0 (address(0))
     */
    function getPlasmaToEthereum(
        address plasma
    )
    public
    view
    returns (address)
    {
        bytes32 keyHashPlasmaToEthereum = keccak256("plasma2ethereum", plasma);
        address ethereum = PROXY_STORAGE_CONTRACT.getAddress(keyHashPlasmaToEthereum);
        if(ethereum!= address(0)) {
            return ethereum;
        }
        return plasma;
    }

    /**
     * @notice Reading from mapping plasma 2 ethereum
     * @param ethereum is the ethereum address we're searching plasma address for
     * @return plasma address if exist otherwise 0x0 (address(0))
     */
    function getEthereumToPlasma(
        address ethereum
    )
    public
    view
    returns (address)
    {
        bytes32 keyHashEthereumToPlasma = keccak256("ethereum2plasma", ethereum);
        address plasma = PROXY_STORAGE_CONTRACT.getAddress(keyHashEthereumToPlasma);
        if(plasma != address(0)) {
            return plasma;
        }
        return ethereum;
    }


    /**
     * @notice Function to check if the user exists
     * @param _userAddress is the address of the user
     * @return true if exists otherwise false
     */
    function checkIfUserExists(
        address _userAddress
    )
    external
    view
    returns (bool)
    {
        string memory username = PROXY_STORAGE_CONTRACT.getString(keccak256("address2username", _userAddress));
        bytes memory tempEmptyStringTest = bytes(username);
        bytes32 keyHashEthereumToPlasma = keccak256("ethereum2plasma", _userAddress);
        address plasma = PROXY_STORAGE_CONTRACT.getAddress(keyHashEthereumToPlasma);
        //notes[_userAddress].length == 0
        bytes memory savedNotes = PROXY_STORAGE_CONTRACT.getBytes(keccak256("notes", _userAddress));
        bytes32 walletTag = PROXY_STORAGE_CONTRACT.getBytes32(keccak256("address2walletTag", _userAddress));
        if(tempEmptyStringTest.length == 0 || walletTag == 0 || plasma == address(0) || savedNotes.length == 0) {
            return false;
        }
        return true;
    }


    function getUserData(
        address _user
    )
    external
    view
    returns (bytes)
    {
        bytes32 keyHashUsername = keccak256("addressToUserData", "username", _user);
        bytes32 keyHashFullName = keccak256("addressToUserData", "fullName", _user);
        bytes32 keyHashEmail = keccak256("addressToUserData", "email", _user);


        bytes32 username = stringToBytes32(PROXY_STORAGE_CONTRACT.getString(keyHashUsername));
        bytes32 fullName = stringToBytes32(PROXY_STORAGE_CONTRACT.getString(keyHashFullName));
        bytes32 email = stringToBytes32(PROXY_STORAGE_CONTRACT.getString(keyHashEmail));

        return (abi.encodePacked(username, fullName, email));
    }

    function notes(
        address keyAddress
    )
    public
    view
    returns (bytes)
    {
        return PROXY_STORAGE_CONTRACT.getBytes(keccak256("notes", keyAddress));
    }

    function address2walletTag(
        address keyAddress
    )
    public
    view
    returns (bytes32)
    {
        return PROXY_STORAGE_CONTRACT.getBytes32(keccak256("address2walletTag", keyAddress));
    }

    function walletTag2address(
        bytes32 walletTag
    )
    public
    view
    returns (address)
    {
        return PROXY_STORAGE_CONTRACT.getAddress(keccak256("walletTag2address", walletTag));
    }

    function address2username(
        address keyAddress
    )
    public
    view
    returns (string)
    {
        return PROXY_STORAGE_CONTRACT.getString(keccak256("address2username", keyAddress));
    }

    function username2currentAddress(
        bytes32 _username
    )
    public
    view
    returns (address)
    {
        return PROXY_STORAGE_CONTRACT.getAddress(keccak256("username2currentAddress", _username));
    }



}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/upgradable-contracts-test/TwoKeyRegistryV1.sol

pragma solidity ^0.4.24;

contract TwoKeyRegistryV1 is TwoKeyRegistry {
    function getMaintainers() public view returns (address[]) {
        address [] memory add = new address[](1);
        add[0] = 0x9aace881c7a80b596d38eaff66edbb5368d2f2c5;
        return add;
    }
}
