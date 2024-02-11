// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Bridge/tokenbridge-contracts-2bf70c7e9fd42968aec2dc352017618907834401/contracts/IBridgeValidators.sol

pragma solidity 0.4.24;


interface IBridgeValidators {
    function isValidator(address _validator) public view returns(bool);
    function requiredSignatures() public view returns(uint256);
    function owner() public view returns(address);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Bridge/tokenbridge-contracts-2bf70c7e9fd42968aec2dc352017618907834401/contracts/upgradeability/EternalStorage.sol

pragma solidity 0.4.24;


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

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Bridge/tokenbridge-contracts-2bf70c7e9fd42968aec2dc352017618907834401/contracts/upgradeable_contracts/Validatable.sol

pragma solidity 0.4.24;


contract Validatable is EternalStorage {
    function validatorContract() public view returns(IBridgeValidators) {
        return IBridgeValidators(addressStorage[keccak256(abi.encodePacked("validatorContract"))]);
    }

    modifier onlyValidator() {
        require(validatorContract().isValidator(msg.sender));
        _;
    }

    modifier onlyOwner() {
        require(validatorContract().owner() == msg.sender);
        _;
    }

    function requiredSignatures() public view returns(uint256) {
        return validatorContract().requiredSignatures();
    }

}
