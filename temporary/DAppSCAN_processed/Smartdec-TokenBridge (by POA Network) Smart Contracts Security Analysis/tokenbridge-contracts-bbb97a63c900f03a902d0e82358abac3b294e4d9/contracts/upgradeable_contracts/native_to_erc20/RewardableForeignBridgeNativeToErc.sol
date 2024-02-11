// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeability/EternalStorage.sol

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

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeable_contracts/Ownable.sol

pragma solidity 0.4.24;

/**
 * @title Ownable
 * @dev This contract has an owner address providing basic authorization control
 */
contract Ownable is EternalStorage {
    /**
    * @dev Event to show ownership has been transferred
    * @param previousOwner representing the address of the previous owner
    * @param newOwner representing the address of the new owner
    */
    event OwnershipTransferred(address previousOwner, address newOwner);

    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyOwner() {
        require(msg.sender == owner());
        _;
    }

    /**
    * @dev Tells the address of the owner
    * @return the address of the owner
    */
    function owner() public view returns (address) {
        return addressStorage[keccak256(abi.encodePacked("owner"))];
    }

    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param newOwner the address to transfer ownership to.
    */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        setOwner(newOwner);
    }

    /**
    * @dev Sets a new owner address
    */
    function setOwner(address newOwner) internal {
        emit OwnershipTransferred(owner(), newOwner);
        addressStorage[keccak256(abi.encodePacked("owner"))] = newOwner;
    }
}

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeable_contracts/FeeTypes.sol

pragma solidity 0.4.24;


contract FeeTypes {
    bytes32 internal constant HOME_FEE = keccak256(abi.encodePacked("home-fee"));
    bytes32 internal constant FOREIGN_FEE = keccak256(abi.encodePacked("foreign-fee"));
}

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeable_contracts/RewardableBridge.sol

pragma solidity 0.4.24;


contract RewardableBridge is Ownable, FeeTypes {

    event FeeDistributedFromAffirmation(uint256 feeAmount, bytes32 indexed transactionHash);
    event FeeDistributedFromSignatures(uint256 feeAmount, bytes32 indexed transactionHash);

    function _getFee(bytes32 _feeType) internal view returns(uint256) {
        uint256 fee;
        address feeManager = feeManagerContract();
        string memory method = _feeType == HOME_FEE ? "getHomeFee()" : "getForeignFee()";
        bytes memory callData = abi.encodeWithSignature(method);

        assembly {
            let result := callcode(gas, feeManager, 0x0, add(callData, 0x20), mload(callData), 0, 32)
            fee := mload(0)

            switch result
            case 0 { revert(0, 0) }
        }
        return fee;
    }

    function getFeeManagerMode() public view returns(bytes4) {
        bytes4 mode;
        bytes memory callData = abi.encodeWithSignature("getFeeManagerMode()");
        address feeManager = feeManagerContract();
        assembly {
            let result := callcode(gas, feeManager, 0x0, add(callData, 0x20), mload(callData), 0, 4)
            mode := mload(0)

            switch result
            case 0 { revert(0, 0) }
        }
        return mode;
    }

    function feeManagerContract() public view returns(address) {
        return addressStorage[keccak256(abi.encodePacked("feeManagerContract"))];
    }

    function setFeeManagerContract(address _feeManager) public onlyOwner {
        require(_feeManager == address(0) || isContract(_feeManager));
        addressStorage[keccak256(abi.encodePacked("feeManagerContract"))] = _feeManager;
    }

    function _setFee(address _feeManager, uint256 _fee, bytes32 _feeType) internal {
        string memory method = _feeType == HOME_FEE ? "setHomeFee(uint256)" : "setForeignFee(uint256)";
        require(_feeManager.delegatecall(abi.encodeWithSignature(method, _fee)));
    }

    function isContract(address _addr) internal view returns (bool)
    {
        uint length;
        assembly { length := extcodesize(_addr) }
        return length > 0;
    }

    function calculateFee(uint256 _value, bool _recover, address _impl, bytes32 _feeType) internal view returns(uint256) {
        uint256 fee;
        bytes memory callData = abi.encodeWithSignature("calculateFee(uint256,bool,bytes32)", _value, _recover, _feeType);
        assembly {
            let result := callcode(gas, _impl, 0x0, add(callData, 0x20), mload(callData), 0, 32)
            fee := mload(0)

            switch result
            case 0 { revert(0, 0) }
        }
        return fee;
    }

    function distributeFeeFromSignatures(uint256 _fee, address _feeManager, bytes32 _txHash) internal {
        require(_feeManager.delegatecall(abi.encodeWithSignature("distributeFeeFromSignatures(uint256)", _fee)));
        emit FeeDistributedFromSignatures(_fee, _txHash);
    }

    function distributeFeeFromAffirmation(uint256 _fee, address _feeManager, bytes32 _txHash) internal {
        require(_feeManager.delegatecall(abi.encodeWithSignature("distributeFeeFromAffirmation(uint256)", _fee)));
        emit FeeDistributedFromAffirmation(_fee, _txHash);
    }
}

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeable_contracts/native_to_erc20/RewardableForeignBridgeNativeToErc.sol

pragma solidity 0.4.24;

contract RewardableForeignBridgeNativeToErc is RewardableBridge {

    function setHomeFee(uint256 _fee) external onlyOwner {
        _setFee(feeManagerContract(), _fee, HOME_FEE);
    }

    function getHomeFee() public view returns(uint256) {
        return _getFee(HOME_FEE);
    }
}
