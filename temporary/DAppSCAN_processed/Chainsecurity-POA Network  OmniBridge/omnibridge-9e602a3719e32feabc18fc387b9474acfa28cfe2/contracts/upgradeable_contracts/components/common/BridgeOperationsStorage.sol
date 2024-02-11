// File: ../sc_datasets/DAppSCAN/Chainsecurity-POA Network  OmniBridge/omnibridge-9e602a3719e32feabc18fc387b9474acfa28cfe2/contracts/upgradeability/EternalStorage.sol

pragma solidity 0.7.5;

/**
 * @title EternalStorage
 * @dev This contract holds all the necessary state variables to carry out the storage of any contract.
 */
contract EternalStorage {
    mapping(bytes32 => uint256) internal uintStorage;
    mapping(bytes32 => string) internal stringStorage;
    mapping(bytes32 => address) internal addressStorage;
    mapping(bytes32 => bytes) internal bytesStorage;
    mapping(bytes32 => bool) internal boolStorage;
    mapping(bytes32 => int256) internal intStorage;
}

// File: ../sc_datasets/DAppSCAN/Chainsecurity-POA Network  OmniBridge/omnibridge-9e602a3719e32feabc18fc387b9474acfa28cfe2/contracts/upgradeable_contracts/components/common/BridgeOperationsStorage.sol

pragma solidity 0.7.5;

/**
 * @title BridgeOperationsStorage
 * @dev Functionality for storing processed bridged operations.
 */
abstract contract BridgeOperationsStorage is EternalStorage {
    /**
     * @dev Stores the bridged token of a message sent to the AMB bridge.
     * @param _messageId of the message sent to the bridge.
     * @param _token bridged token address.
     */
    function setMessageToken(bytes32 _messageId, address _token) internal {
        addressStorage[keccak256(abi.encodePacked("messageToken", _messageId))] = _token;
    }

    /**
     * @dev Tells the bridged token address of a message sent to the AMB bridge.
     * @return address of a token contract.
     */
    function messageToken(bytes32 _messageId) internal view returns (address) {
        return addressStorage[keccak256(abi.encodePacked("messageToken", _messageId))];
    }

    /**
     * @dev Stores the value of a message sent to the AMB bridge.
     * @param _messageId of the message sent to the bridge.
     * @param _value amount of tokens bridged.
     */
    function setMessageValue(bytes32 _messageId, uint256 _value) internal {
        uintStorage[keccak256(abi.encodePacked("messageValue", _messageId))] = _value;
    }

    /**
     * @dev Tells the amount of tokens of a message sent to the AMB bridge.
     * @return value representing amount of tokens.
     */
    function messageValue(bytes32 _messageId) internal view returns (uint256) {
        return uintStorage[keccak256(abi.encodePacked("messageValue", _messageId))];
    }

    /**
     * @dev Stores the receiver of a message sent to the AMB bridge.
     * @param _messageId of the message sent to the bridge.
     * @param _recipient receiver of the tokens bridged.
     */
    function setMessageRecipient(bytes32 _messageId, address _recipient) internal {
        addressStorage[keccak256(abi.encodePacked("messageRecipient", _messageId))] = _recipient;
    }

    /**
     * @dev Tells the receiver of a message sent to the AMB bridge.
     * @return address of the receiver.
     */
    function messageRecipient(bytes32 _messageId) internal view returns (address) {
        return addressStorage[keccak256(abi.encodePacked("messageRecipient", _messageId))];
    }
}
