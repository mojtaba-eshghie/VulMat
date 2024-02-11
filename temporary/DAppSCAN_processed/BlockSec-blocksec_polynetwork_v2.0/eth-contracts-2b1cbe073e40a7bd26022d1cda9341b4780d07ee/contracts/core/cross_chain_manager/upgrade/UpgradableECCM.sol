// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_polynetwork_v2.0/eth-contracts-2b1cbe073e40a7bd26022d1cda9341b4780d07ee/contracts/core/cross_chain_manager/interface/IEthCrossChainData.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the EthCrossChainData contract, the implementation is in EthCrossChainData.sol
 */
interface IEthCrossChainData {
    function putCurEpochStartHeight(uint32 curEpochStartHeight) external returns (bool);
    function getCurEpochStartHeight() external view returns (uint32);
    function putCurEpochConPubKeyBytes(bytes calldata curEpochPkBytes) external returns (bool);
    function getCurEpochConPubKeyBytes() external view returns (bytes memory);
    function markFromChainTxExist(uint64 fromChainId, bytes32 fromChainTx) external returns (bool);
    function checkIfFromChainTxExist(uint64 fromChainId, bytes32 fromChainTx) external view returns (bool);
    function getEthTxHashIndex() external view returns (uint256);
    function putEthTxHash(bytes32 ethTxHash) external returns (bool);
    function putExtraData(bytes32 key1, bytes32 key2, bytes calldata value) external returns (bool);
    function getExtraData(bytes32 key1, bytes32 key2) external view returns (bytes memory);
    function transferOwnership(address newOwner) external;
    function pause() external returns (bool);
    function unpause() external returns (bool);
    function paused() external view returns (bool);
    // Not used currently by ECCM
    function getEthTxHash(uint256 ethTxHashIndex) external view returns (bytes32);
}

// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_polynetwork_v2.0/eth-contracts-2b1cbe073e40a7bd26022d1cda9341b4780d07ee/contracts/core/cross_chain_manager/interface/IUpgradableECCM.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of upgradableECCM to make ECCM be upgradable, the implementation is in UpgradableECCM.sol
 */
interface IUpgradableECCM {
    function pause() external returns (bool);
    function unpause() external returns (bool);
    function paused() external view returns (bool);
    function upgradeToNew(address) external returns (bool);
    function isOwner() external view returns (bool);
    function setChainId(uint64 _newChainId) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_polynetwork_v2.0/eth-contracts-2b1cbe073e40a7bd26022d1cda9341b4780d07ee/contracts/libs/GSN/Context.sol

pragma solidity ^0.5.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 * Refer from https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/GSN/Context.sol
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_polynetwork_v2.0/eth-contracts-2b1cbe073e40a7bd26022d1cda9341b4780d07ee/contracts/libs/lifecycle/Pausable.sol

pragma solidity ^0.5.0;

/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
contract Pausable is Context {
    /**
     * @dev Emitted when the pause is triggered by a pauser (`account`).
     */
    event Paused(address account);

    /**
     * @dev Emitted when the pause is lifted by a pauser (`account`).
     */
    event Unpaused(address account);

    bool private _paused;

    /**
     * @dev Initializes the contract in unpaused state.
     */
    constructor () internal {
        _paused = false;
    }

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function paused() public view returns (bool) {
        return _paused;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     */
    modifier whenNotPaused() {
        require(!_paused, "Pausable: paused");
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     */
    modifier whenPaused() {
        require(_paused, "Pausable: not paused");
        _;
    }

    /**
     * @dev Called to pause, triggers stopped state.
     */
    function _pause() internal whenNotPaused {
        _paused = true;
        emit Paused(_msgSender());
    }

    /**
     * @dev Called to unpause, returns to normal state.
     */
    function _unpause() internal whenPaused {
        _paused = false;
        emit Unpaused(_msgSender());
    }
}

// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_polynetwork_v2.0/eth-contracts-2b1cbe073e40a7bd26022d1cda9341b4780d07ee/contracts/libs/ownership/Ownable.sol

pragma solidity ^0.5.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public  onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_polynetwork_v2.0/eth-contracts-2b1cbe073e40a7bd26022d1cda9341b4780d07ee/contracts/core/cross_chain_manager/upgrade/UpgradableECCM.sol

pragma solidity ^0.5.0;




contract UpgradableECCM is IUpgradableECCM, Ownable, Pausable {
    address public EthCrossChainDataAddress;
    uint64 public chainId;  
    
    constructor (address ethCrossChainDataAddr, uint64 _chainId) Pausable() Ownable()  public {
        EthCrossChainDataAddress = ethCrossChainDataAddr;
        chainId = _chainId;
    }
    function pause() onlyOwner public returns (bool) {
        if (!paused()) {
            _pause();
        }
        IEthCrossChainData eccd = IEthCrossChainData(EthCrossChainDataAddress);
        if (!eccd.paused()) {
            require(eccd.pause(), "pause EthCrossChainData contract failed");
        }
        return true;
    }
    
    function unpause() onlyOwner public returns (bool) {
        if (paused()) {
            _unpause();
        }
        IEthCrossChainData eccd = IEthCrossChainData(EthCrossChainDataAddress);
        if (eccd.paused()) {
            require(eccd.unpause(), "unpause EthCrossChainData contract failed");
        }
        return true;
    }

    // if we want to upgrade this contract, we need to invoke this method 
    function upgradeToNew(address newEthCrossChainManagerAddress) whenPaused onlyOwner public returns (bool) {
        IEthCrossChainData eccd = IEthCrossChainData(EthCrossChainDataAddress);
        eccd.transferOwnership(newEthCrossChainManagerAddress);
        return true;
    }
    
    function setChainId(uint64 _newChainId) whenPaused onlyOwner public returns (bool) {
        chainId = _newChainId;
        return true;
    }
}
