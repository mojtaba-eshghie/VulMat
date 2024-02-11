// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IBlockReward.sol

pragma solidity 0.5.9;


interface IBlockReward {
    function initialize(address) external;
    function DELEGATORS_ALIQUOT() external view returns(uint256); // solhint-disable-line func-name-mixedcase
    function isRewarding() external view returns(bool);
    function isSnapshotting() external view returns(bool);
    function mintedTotally() external view returns(uint256);
    function mintedTotallyByBridge(address _bridge) external view returns(uint256);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IValidatorSet.sol

pragma solidity 0.5.9;


interface IValidatorSet {
    function initialize(
        address,
        address,
        address,
        address[] calldata,
        address[] calldata,
        bool
    ) external;
    function newValidatorSet() external returns(bool, uint256);
    function setStakingAddress(address, address) external;
    function blockRewardContract() external view returns(address);
    function changeRequestCount() external view returns(uint256);
    function emitInitiateChangeCallable() external view returns(bool);
    function getPendingValidators() external view returns(address[] memory);
    function getPreviousValidators() external view returns(address[] memory);
    function getValidators() external view returns(address[] memory);
    function isReportValidatorValid(address) external view returns(bool);
    function isValidator(address) external view returns(bool);
    function isValidatorBanned(address) external view returns(bool);
    function MAX_VALIDATORS() external view returns(uint256); // solhint-disable-line func-name-mixedcase
    function miningByStakingAddress(address) external view returns(address);
    function randomContract() external view returns(address);
    function stakingByMiningAddress(address) external view returns(address);
    function stakingContract() external view returns(address);
    function unremovableValidator() external view returns(address);
    function validatorIndex(address) external view returns(uint256);
    function validatorSetApplyBlock() external view returns(uint256);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IStaking.sol

pragma solidity 0.5.9;


interface IStaking {
    function clearUnremovableValidator(address) external;
    function incrementStakingEpoch() external;
    function removePool(address) external;
    function erc20Restricted() external view returns(bool);
    function erc20TokenContract() external view returns(address);
    function getPoolsLikelihood() external view returns(int256[] memory, int256);
    function getPoolsToBeElected() external view returns(address[] memory);
    function getPoolsToBeRemoved() external view returns(address[] memory);
    function poolDelegators(address) external view returns(address[] memory);
    function stakeAmountMinusOrderedWithdraw(address, address) external view returns(uint256);
    function stakeAmountTotalMinusOrderedWithdraw(address) external view returns(uint256);
    function stakingEpoch() external view returns(uint256);
}

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

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/eternal-storage/OwnedEternalStorage.sol

pragma solidity 0.5.9;

/// @dev Provides access control functionality and extends the `EternalStorage` contract.
/// Using the `onlyOwner` modifier, a function can be restricted so that it can only be 
/// called by the owner of the contract. The owner of a contract can irrevocably transfer 
/// ownership using the `EternalStorageProxy.transferOwnership` function.
contract OwnedEternalStorage is EternalStorage {

    /// @dev Access check: revert unless `msg.sender` is the owner of the contract.
    modifier onlyOwner() {
        require(msg.sender == _owner);
        _;
    }

}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/libs/SafeMath.sol

pragma solidity 0.5.9;


/**
 * @title SafeMath
 * @dev Math operations with safety checks that revert on error
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns(uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns(uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns(uint256) {
        require(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns(uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/abstracts/BlockRewardBase.sol

pragma solidity 0.5.9;





/// @dev The base contract for the BlockRewardAuRa and BlockRewardHBBFT contracts.
contract BlockRewardBase is OwnedEternalStorage, IBlockReward {
    using SafeMath for uint256;

    // ============================================== Constants =======================================================

    /// @dev A constant that defines the number of sections the reward distribution
    /// and stakes snapshotting processes are split into for each pool. This is used to
    /// reduce the load on each block when reward distribution (at the end of staking epoch)
    /// and stakes snapshotting (at the beginning of staking epoch) occur. See the `_setSnapshot`
    /// and `_distributeRewards` functions.
    uint256 public constant DELEGATORS_ALIQUOT = 2;

    // ================================================ Events ========================================================

    /// @dev Emitted by the `addExtraReceiver` function.
    /// @param amount The amount of native coins which must be minted for the `receiver` by the `erc-to-native`
    /// `bridge` with the `reward` function.
    /// @param receiver The address for which the `amount` of native coins must be minted.
    /// @param bridge The bridge address which called the `addExtraReceiver` function.
    event AddedReceiver(uint256 amount, address indexed receiver, address indexed bridge);

    /// @dev Emitted by the `_mintNativeCoins` function which is called by the `reward` function.
    /// This event is only used by the unit tests because the `reward` function cannot emit events.
    /// @param receivers The array of receiver addresses for which native coins are minted. The length of this
    /// array is equal to the length of the `rewards` array.
    /// @param rewards The array of amounts minted for the relevant `receivers`. The length of this array
    /// is equal to the length of the `receivers` array.
    event MintedNative(address[] receivers, uint256[] rewards);

    // ============================================== Modifiers =======================================================

    /// @dev Ensures the caller is the `erc-to-native` bridge contract address.
    modifier onlyErcToNativeBridge {
        require(boolStorage[keccak256(abi.encode(ERC_TO_NATIVE_BRIDGE_ALLOWED, msg.sender))]);
        _;
    }

    /// @dev Ensures the caller is the `erc-to-erc` or `native-to-erc` bridge contract address.
    modifier onlyXToErcBridge {
        require(
            boolStorage[keccak256(abi.encode(ERC_TO_ERC_BRIDGE_ALLOWED, msg.sender))] ||
            boolStorage[keccak256(abi.encode(NATIVE_TO_ERC_BRIDGE_ALLOWED, msg.sender))]
        );
        _;
    }

    /// @dev Ensures the `initialize` function was called before.
    modifier onlyInitialized {
        require(isInitialized());
        _;
    }

    /// @dev Ensures the caller is the SYSTEM_ADDRESS. See https://wiki.parity.io/Block-Reward-Contract.html
    modifier onlySystem {
        require(msg.sender == 0xffffFFFfFFffffffffffffffFfFFFfffFFFfFFfE);
        _;
    }

    // =============================================== Setters ========================================================

    /// @dev Called by the `erc-to-native` bridge contract when a portion of the bridge fee should be distributed to
    /// participants (validators and their delegators) in native coins. The specified amount is used by the
    /// `_distributeRewards` function.
    /// @param _amount The fee amount distributed to participants.
    function addBridgeNativeFeeReceivers(uint256 _amount) external onlyErcToNativeBridge {
        require(_amount != 0);
        uintStorage[BRIDGE_NATIVE_FEE] = uintStorage[BRIDGE_NATIVE_FEE].add(_amount);
    }

    /// @dev Called by the `erc-to-erc` or `native-to-erc` bridge contract when a portion of the bridge fee should be
    /// distributed to participants in staking tokens. The specified amount is used by the `_distributeRewards`
    /// function.
    /// @param _amount The fee amount distributed to participants.
    function addBridgeTokenFeeReceivers(uint256 _amount) external onlyXToErcBridge {
        require(_amount != 0);
        uintStorage[BRIDGE_TOKEN_FEE] = uintStorage[BRIDGE_TOKEN_FEE].add(_amount);
    }

    /// @dev Called by the `erc-to-native` bridge contract when the bridge needs to mint a specified amount of native
    /// coins for a specified address using the `reward` function.
    /// @param _amount The amount of native coins which must be minted for the `_receiver` address.
    /// @param _receiver The address for which the `_amount` of native coins must be minted.
    function addExtraReceiver(uint256 _amount, address _receiver) external onlyErcToNativeBridge {
        require(_amount != 0);
        require(_receiver != address(0));
        require(boolStorage[QUEUE_ER_INITIALIZED]);
        _enqueueExtraReceiver(_amount, _receiver, msg.sender);
        emit AddedReceiver(_amount, _receiver, msg.sender);
    }

    /// @dev Initializes the contract at network startup.
    /// Must be called by the constructor of the `Initializer` contract.
    /// @param _validatorSet The address of the `ValidatorSet` contract.
    function initialize(address _validatorSet) external {
        require(!isInitialized());
        require(_validatorSet != address(0));
        addressStorage[VALIDATOR_SET_CONTRACT] = _validatorSet;
    }

    /// @dev Copies the minting statistics from the previous BlockReward contract
    /// for the `mintedTotally` and `mintedTotallyByBridge` getters. Can only be called once by the owner.
    /// This function assumes that the bridge contract address is not changed due to its upgradable nature.
    /// @param _bridge The address of a bridge contract.
    /// @param _prevBlockRewardContract The address of the previous BlockReward contract.
    function migrateMintingStatistics(address _bridge, IBlockReward _prevBlockRewardContract) external onlyOwner {
        require(mintedTotally() == 0);
        uint256 prevMinted = _prevBlockRewardContract.mintedTotally();
        uint256 prevMintedByBridge = _prevBlockRewardContract.mintedTotallyByBridge(_bridge);
        require(prevMinted != 0);
        require(prevMintedByBridge != 0);
        uintStorage[MINTED_TOTALLY] = prevMinted;
        uintStorage[keccak256(abi.encode(MINTED_TOTALLY_BY_BRIDGE, _bridge))] = prevMintedByBridge;
    }

    /// @dev Sets the array of `erc-to-native` bridge addresses which are allowed to call some of the functions with
    /// the `onlyErcToNativeBridge` modifier. This setter can only be called by the `owner`.
    /// @param _bridgesAllowed The array of bridge addresses.
    function setErcToNativeBridgesAllowed(address[] calldata _bridgesAllowed) external onlyOwner onlyInitialized {
        uint256 i;

        address[] storage oldBridgesAllowed = addressArrayStorage[ERC_TO_NATIVE_BRIDGES_ALLOWED];
        for (i = 0; i < oldBridgesAllowed.length; i++) {
            boolStorage[keccak256(abi.encode(ERC_TO_NATIVE_BRIDGE_ALLOWED, oldBridgesAllowed[i]))] = false;
        }

        addressArrayStorage[ERC_TO_NATIVE_BRIDGES_ALLOWED] = _bridgesAllowed;

        for (i = 0; i < _bridgesAllowed.length; i++) {
            boolStorage[keccak256(abi.encode(ERC_TO_NATIVE_BRIDGE_ALLOWED, _bridgesAllowed[i]))] = true;
        }
    }

    /// @dev Sets the array of `native-to-erc` bridge addresses which are allowed to call some of the functions with
    /// the `onlyXToErcBridge` modifier. This setter can only be called by the `owner`.
    /// @param _bridgesAllowed The array of bridge addresses.
    function setNativeToErcBridgesAllowed(address[] calldata _bridgesAllowed) external onlyOwner onlyInitialized {
        uint256 i;

        address[] storage oldBridgesAllowed = addressArrayStorage[NATIVE_TO_ERC_BRIDGES_ALLOWED];
        for (i = 0; i < oldBridgesAllowed.length; i++) {
            boolStorage[keccak256(abi.encode(NATIVE_TO_ERC_BRIDGE_ALLOWED, oldBridgesAllowed[i]))] = false;
        }

        addressArrayStorage[NATIVE_TO_ERC_BRIDGES_ALLOWED] = _bridgesAllowed;

        for (i = 0; i < _bridgesAllowed.length; i++) {
            boolStorage[keccak256(abi.encode(NATIVE_TO_ERC_BRIDGE_ALLOWED, _bridgesAllowed[i]))] = true;
        }
    }

    /// @dev Sets the array of `erc-to-erc` bridge addresses which are allowed to call some of the functions with
    /// the `onlyXToErcBridge` modifier. This setter can only be called by the `owner`.
    /// @param _bridgesAllowed The array of bridge addresses.
    function setErcToErcBridgesAllowed(address[] calldata _bridgesAllowed) external onlyOwner onlyInitialized {
        uint256 i;

        address[] storage oldBridgesAllowed = addressArrayStorage[ERC_TO_ERC_BRIDGES_ALLOWED];
        for (i = 0; i < oldBridgesAllowed.length; i++) {
            boolStorage[keccak256(abi.encode(ERC_TO_ERC_BRIDGE_ALLOWED, oldBridgesAllowed[i]))] = false;
        }

        addressArrayStorage[ERC_TO_ERC_BRIDGES_ALLOWED] = _bridgesAllowed;

        for (i = 0; i < _bridgesAllowed.length; i++) {
            boolStorage[keccak256(abi.encode(ERC_TO_ERC_BRIDGE_ALLOWED, _bridgesAllowed[i]))] = true;
        }
    }

    // =============================================== Getters ========================================================

    /// @dev Returns an identifier for the bridge contract so that the latter could
    /// ensure it works with the BlockReward contract.
    function blockRewardContractId() public pure returns(bytes4) {
        return BLOCK_REWARD_CONTRACT_ID;
    }

    /// @dev Returns the array of `erc-to-erc` bridge addresses set by the `setErcToErcBridgesAllowed` setter.
    function ercToErcBridgesAllowed() public view returns(address[] memory) {
        return addressArrayStorage[ERC_TO_ERC_BRIDGES_ALLOWED];
    }

    /// @dev Returns the array of `erc-to-native` bridge addresses set by the `setErcToNativeBridgesAllowed` setter.
    function ercToNativeBridgesAllowed() public view returns(address[] memory) {
        return addressArrayStorage[ERC_TO_NATIVE_BRIDGES_ALLOWED];
    }

    /// @dev Returns the current size of the address queue created by the `addExtraReceiver` function.
    function extraReceiversQueueSize() public view returns(uint256) {
        return uintStorage[QUEUE_ER_LAST] + 1 - uintStorage[QUEUE_ER_FIRST];
    }

    /// @dev Returns the current total fee amount of native coins accumulated by
    /// the `addBridgeNativeFeeReceivers` function.
    function getBridgeNativeFee() public view returns(uint256) {
        return uintStorage[BRIDGE_NATIVE_FEE];
    }

    /// @dev Returns the current total fee amount of staking tokens accumulated by
    /// the `addBridgeTokenFeeReceivers` function.
    function getBridgeTokenFee() public view returns(uint256) {
        return uintStorage[BRIDGE_TOKEN_FEE];
    }

    /// @dev Returns a boolean flag indicating if the `initialize` function has been called.
    function isInitialized() public view returns(bool) {
        return addressStorage[VALIDATOR_SET_CONTRACT] != address(0);
    }

    /// @dev Returns a boolean flag indicating if the reward process is occuring for the current block.
    /// The value of this boolean flag is changed by the `_distributeRewards` function.
    function isRewarding() public view returns(bool) {
        return boolStorage[IS_REWARDING];
    }

    /// @dev Returns a boolean flag indicating if the snapshotting process is occuring for the current block.
    /// The value of this boolean flag is changed by the `reward` function.
    function isSnapshotting() public view returns(bool) {
        return boolStorage[IS_SNAPSHOTTING];
    }

    /// @dev Returns the total amount of native coins minted for the specified address
    /// by the `erc-to-native` bridges through the `addExtraReceiver` function.
    /// @param _account The address for which the getter must return the minted amount.
    function mintedForAccount(address _account) public view returns(uint256) {
        return uintStorage[keccak256(abi.encode(MINTED_FOR_ACCOUNT, _account))];
    }

    /// @dev Returns the amount of native coins minted at the specified block for the specified
    /// address by the `erc-to-native` bridges through the `addExtraReceiver` function.
    /// @param _account The address for which the getter must return the amount minted at the `_blockNumber`.
    /// @param _blockNumber The block number for which the getter must return the amount minted for the `_account`.
    function mintedForAccountInBlock(address _account, uint256 _blockNumber)
        public
        view
        returns(uint256)
    {
        return uintStorage[
            keccak256(abi.encode(MINTED_FOR_ACCOUNT_IN_BLOCK, _account, _blockNumber))
        ];
    }

    /// @dev Returns the total amount of native coins minted at the specified block
    /// by the `erc-to-native` bridges through the `addExtraReceiver` function.
    /// @param _blockNumber The block number for which the getter must return the minted amount.
    function mintedInBlock(uint256 _blockNumber) public view returns(uint256) {
        return uintStorage[keccak256(abi.encode(MINTED_IN_BLOCK, _blockNumber))];
    }

    /// @dev Returns the total amount of native coins minted by the specified
    /// `erc-to-native` bridge through the `addExtraReceiver` function.
    /// @param _bridge The address of the bridge contract.
    function mintedTotallyByBridge(address _bridge) public view returns(uint256) {
        return uintStorage[keccak256(abi.encode(MINTED_TOTALLY_BY_BRIDGE, _bridge))];
    }

    /// @dev Returns the total amount of native coins minted by the
    /// `erc-to-native` bridges through the `addExtraReceiver` function.
    function mintedTotally() public view returns(uint256) {
        return uintStorage[MINTED_TOTALLY];
    }

    /// @dev Returns the array of `native-to-erc` bridge addresses which were set by
    /// the `setNativeToErcBridgesAllowed` setter.
    function nativeToErcBridgesAllowed() public view returns(address[] memory) {
        return addressArrayStorage[NATIVE_TO_ERC_BRIDGES_ALLOWED];
    }

    /// @dev Returns an array of reward coefficients which corresponds to the array of stakers
    /// for a specified validator and the current staking epoch. The size of the returned array
    /// is the same as the size of the staker array returned by the `snapshotStakers` getter. The reward
    /// coefficients are calculated by the `_setSnapshot` function at the beginning of the staking epoch
    /// and then used by the `_distributeRewards` function at the end of the staking epoch.
    /// @param _validatorStakingAddress The staking address of the validator pool for which the getter
    /// must return the coefficient array.
    function snapshotRewardPercents(address _validatorStakingAddress) public view returns(uint256[] memory) {
        return uintArrayStorage[
            keccak256(abi.encode(SNAPSHOT_REWARD_PERCENTS, _validatorStakingAddress))
        ];
    }

    /// @dev Returns an array of stakers for the specified validator and the current staking epoch
    /// snapshotted at the beginning of the staking epoch by the `_setSnapshot` function. This array is
    /// used by the `_distributeRewards` function at the end of the staking epoch.
    /// @param _validatorStakingAddress The staking address of the validator pool for which the getter
    /// must return the array of stakers.
    function snapshotStakers(address _validatorStakingAddress) public view returns(address[] memory) {
        return addressArrayStorage[
            keccak256(abi.encode(SNAPSHOT_STAKERS, _validatorStakingAddress))
        ];
    }

    /// @dev Returns an array of the pools snapshotted by the `_setSnapshot` function
    /// at the beginning of the current staking epoch.
    /// The getter returns the staking addresses of the pools.
    function snapshotStakingAddresses() public view returns(address[] memory) {
        return addressArrayStorage[SNAPSHOT_STAKING_ADDRESSES];
    }

    /// @dev Returns the total amount staked during the previous staking epoch. This value is used by the
    /// `_distributeRewards` function at the end of the current staking epoch to calculate the inflation amount 
    /// for the staking token in the current staking epoch.
    function snapshotTotalStakeAmount() public view returns(uint256) {
        return uintStorage[SNAPSHOT_TOTAL_STAKE_AMOUNT];
    }

    /// @dev Returns the address of the `ValidatorSet` contract.
    function validatorSetContract() public view returns(IValidatorSet) {
        return IValidatorSet(addressStorage[VALIDATOR_SET_CONTRACT]);
    }

    // =============================================== Private ========================================================

    bytes4  internal constant BLOCK_REWARD_CONTRACT_ID = bytes4(keccak256("blockReward"));
    bytes32 internal constant BRIDGE_NATIVE_FEE = keccak256("bridgeNativeFee");
    bytes32 internal constant BRIDGE_TOKEN_FEE = keccak256("bridgeTokenFee");
    bytes32 internal constant ERC_TO_ERC_BRIDGES_ALLOWED = keccak256("ercToErcBridgesAllowed");
    bytes32 internal constant ERC_TO_NATIVE_BRIDGES_ALLOWED = keccak256("ercToNativeBridgesAllowed");
    bytes32 internal constant IS_REWARDING = keccak256("isRewarding");
    bytes32 internal constant IS_SNAPSHOTTING = keccak256("isSnapshotting");
    bytes32 internal constant MINTED_TOTALLY = keccak256("mintedTotally");
    bytes32 internal constant NATIVE_TO_ERC_BRIDGES_ALLOWED = keccak256("nativeToErcBridgesAllowed");
    bytes32 internal constant QUEUE_ER_FIRST = keccak256("queueERFirst");
    bytes32 internal constant QUEUE_ER_INITIALIZED = keccak256("queueERInitialized");
    bytes32 internal constant QUEUE_ER_LAST = keccak256("queueERLast");
    bytes32 internal constant SNAPSHOT_STAKING_ADDRESSES = keccak256("snapshotStakingAddresses");
    bytes32 internal constant SNAPSHOT_TOTAL_STAKE_AMOUNT = keccak256("snapshotTotalStakeAmount");
    bytes32 internal constant VALIDATOR_SET_CONTRACT = keccak256("validatorSetContract");

    bytes32 internal constant ERC_TO_ERC_BRIDGE_ALLOWED = "ercToErcBridgeAllowed";
    bytes32 internal constant ERC_TO_NATIVE_BRIDGE_ALLOWED = "ercToNativeBridgeAllowed";
    bytes32 internal constant MINTED_FOR_ACCOUNT = "mintedForAccount";
    bytes32 internal constant MINTED_FOR_ACCOUNT_IN_BLOCK = "mintedForAccountInBlock";
    bytes32 internal constant MINTED_IN_BLOCK = "mintedInBlock";
    bytes32 internal constant MINTED_TOTALLY_BY_BRIDGE = "mintedTotallyByBridge";
    bytes32 internal constant NATIVE_TO_ERC_BRIDGE_ALLOWED = "nativeToErcBridgeAllowed";
    bytes32 internal constant QUEUE_ER_AMOUNT = "queueERAmount";
    bytes32 internal constant QUEUE_ER_BRIDGE = "queueERBridge";
    bytes32 internal constant QUEUE_ER_RECEIVER = "queueERReceiver";
    bytes32 internal constant SNAPSHOT_REWARD_PERCENTS = "snapshotRewardPercents";
    bytes32 internal constant SNAPSHOT_STAKERS = "snapshotStakers";

    uint256 internal constant REWARD_PERCENT_MULTIPLIER = 1000000;

    /// @dev Joins two native coin receiver elements into a single set and returns the result
    /// to the `reward` function: the first element comes from the `erc-to-native` bridge fee distribution
    /// (or from native coins fixed distribution), the second from the `erc-to-native` bridge when native
    /// coins are minted for the specified addresses.
    /// Dequeues the addresses enqueued with the `addExtraReceiver` function by the `erc-to-native` bridge.
    /// Accumulates minting statistics for the `erc-to-native` bridges.
    /// @param _receivers The array of native coin receivers formed by the `_distributeRewards` function.
    /// @param _rewards The array of native coin amounts to be minted for the corresponding
    /// `_receivers`. The size of this array is equal to the size of the `_receivers` array.
    /// @param _queueLimit Max number of addresses which can be dequeued from the queue formed by the
    /// `addExtraReceiver` function.
    function _mintNativeCoins(
        address[] memory _receivers,
        uint256[] memory _rewards,
        uint256 _queueLimit
    )
        internal
        returns(address[] memory receivers, uint256[] memory rewards)
    {
        uint256 extraLength = extraReceiversQueueSize();

        if (extraLength > _queueLimit) {
            extraLength = _queueLimit;
        }

        receivers = new address[](extraLength + _receivers.length);
        rewards = new uint256[](receivers.length);

        uint256 i;
        uint256 j = 0;

        for (i = 0; i < extraLength; i++) {
            (uint256 amount, address receiver, address bridge) = _dequeueExtraReceiver();
            receivers[i] = receiver;
            rewards[i] = amount;
            _setMinted(amount, receiver, bridge);
        }

        for (i = extraLength; i < receivers.length; i++) {
            receivers[i] = _receivers[j];
            rewards[i] = _rewards[j];
            j++;
        }

        emit MintedNative(receivers, rewards);

        return (receivers, rewards);
    }

    /// @dev Dequeues the information about the native coins receiver enqueued with the `addExtraReceiver`
    /// function by the `erc-to-native` bridge. This function is used by `_mintNativeCoins`.
    /// @return `uint256 amount` - The amount to be minted for the `receiver` address.
    /// `address receiver` - The address for which the `amount` is minted.
    /// `address bridge` - The address of the bridge contract which called the `addExtraReceiver` function.
    function _dequeueExtraReceiver() internal returns(uint256 amount, address receiver, address bridge) {
        uint256 queueFirst = uintStorage[QUEUE_ER_FIRST];
        uint256 queueLast = uintStorage[QUEUE_ER_LAST];

        if (queueLast < queueFirst) {
            amount = 0;
            receiver = address(0);
            bridge = address(0);
        } else {
            bytes32 amountHash = keccak256(abi.encode(QUEUE_ER_AMOUNT, queueFirst));
            bytes32 receiverHash = keccak256(abi.encode(QUEUE_ER_RECEIVER, queueFirst));
            bytes32 bridgeHash = keccak256(abi.encode(QUEUE_ER_BRIDGE, queueFirst));
            amount = uintStorage[amountHash];
            receiver = addressStorage[receiverHash];
            bridge = addressStorage[bridgeHash];
            delete uintStorage[amountHash];
            delete addressStorage[receiverHash];
            delete addressStorage[bridgeHash];
            uintStorage[QUEUE_ER_FIRST]++;
        }
    }

    /// @dev Enqueues the information about the receiver of native coins which must be minted for the
    /// specified `erc-to-native` bridge. This function is used by the `addExtraReceiver` function.
    /// @param _amount The amount of native coins which must be minted for the `_receiver` address.
    /// @param _receiver The address for which the `_amount` of native coins must be minted.
    /// @param _bridge The address of the bridge contract which requested the minting of native coins.
    function _enqueueExtraReceiver(uint256 _amount, address _receiver, address _bridge) internal {
        uint256 queueLast = uintStorage[QUEUE_ER_LAST] + 1;
        uintStorage[keccak256(abi.encode(QUEUE_ER_AMOUNT, queueLast))] = _amount;
        addressStorage[keccak256(abi.encode(QUEUE_ER_RECEIVER, queueLast))] = _receiver;
        addressStorage[keccak256(abi.encode(QUEUE_ER_BRIDGE, queueLast))] = _bridge;
        uintStorage[QUEUE_ER_LAST] = queueLast;
    }

    /// @dev Accumulates minting statistics for the `erc-to-native` bridge.
    /// This function is used by the `_mintNativeCoins` function.
    /// @param _amount The amount minted for the `_account` address.
    /// @param _account The address for which the `_amount` is minted.
    /// @param _bridge The address of the bridge contract which called the `addExtraReceiver` function.
    function _setMinted(uint256 _amount, address _account, address _bridge) internal {
        uintStorage[keccak256(abi.encode(MINTED_FOR_ACCOUNT_IN_BLOCK, _account, block.number))] = _amount;
        uintStorage[keccak256(abi.encode(MINTED_FOR_ACCOUNT, _account))] += _amount;
        uintStorage[keccak256(abi.encode(MINTED_IN_BLOCK, block.number))] += _amount;
        uintStorage[keccak256(abi.encode(MINTED_TOTALLY_BY_BRIDGE, _bridge))] += _amount;
        uintStorage[MINTED_TOTALLY] += _amount;
    }

    /// @dev Calculates the reward coefficient for each pool's staker and saves it so it can be used at
    /// the end of the staking epoch for the reward distribution phase. Specifies a section of the coefficients'
    /// snapshot thus limiting the coefficient calculations for each block. This function is called by
    /// the `reward` function at the beginning of the staking epoch.
    /// @param _stakingAddress The staking address of a pool for which the snapshot must be done.
    /// @param _stakingContract The address of the `Staking` contract.
    /// @param _offset The section of the delegator array to snapshot at the current block.
    /// The `_offset` range is [0, DELEGATORS_ALIQUOT - 1]. The `_offset` value is set based on the `DELEGATORS_ALIQUOT`
    /// constant - see the code of the `reward` function.
    function _setSnapshot(address _stakingAddress, IStaking _stakingContract, uint256 _offset) internal {
        uint256 validatorStake = _stakingContract.stakeAmountMinusOrderedWithdraw(_stakingAddress, _stakingAddress);
        uint256 totalStaked = _stakingContract.stakeAmountTotalMinusOrderedWithdraw(_stakingAddress);
        uint256 delegatorsAmount = totalStaked >= validatorStake ? totalStaked - validatorStake : 0;
        bool validatorHasMore30Per = validatorStake * 7 > delegatorsAmount * 3;

        address[] memory delegators = _stakingContract.poolDelegators(_stakingAddress);
        uint256 rewardPercent;

        address[] storage stakers = addressArrayStorage[keccak256(abi.encode(
            SNAPSHOT_STAKERS, _stakingAddress
        ))];

        uint256[] storage rewardPercents = uintArrayStorage[keccak256(abi.encode(
            SNAPSHOT_REWARD_PERCENTS, _stakingAddress
        ))];

        if (_offset == 0) {
            // Calculate reward percent for validator
            rewardPercent = 0;
            if (validatorStake != 0 && totalStaked != 0) {
                if (validatorHasMore30Per) {
                    rewardPercent = REWARD_PERCENT_MULTIPLIER * validatorStake / totalStaked;
                } else {
                    rewardPercent = REWARD_PERCENT_MULTIPLIER * 3 / 10;
                }
            }
            stakers.push(_stakingAddress);
            rewardPercents.push(rewardPercent);
            addressArrayStorage[SNAPSHOT_STAKING_ADDRESSES].push(_stakingAddress);
            uintStorage[SNAPSHOT_TOTAL_STAKE_AMOUNT] += totalStaked;
        }

        uint256 from = _offset * delegators.length / DELEGATORS_ALIQUOT;
        uint256 to = (_offset + 1) * delegators.length / DELEGATORS_ALIQUOT;

        if (_offset == 0) {
            to += delegators.length % DELEGATORS_ALIQUOT;
        } else {
            from += delegators.length % DELEGATORS_ALIQUOT;
        }

        // Calculate reward percent for each delegator
        for (uint256 i = from; i < to; i++) {
            rewardPercent = 0;

            if (validatorHasMore30Per) {
                if (totalStaked != 0) {
                    rewardPercent = _stakingContract.stakeAmountMinusOrderedWithdraw(_stakingAddress, delegators[i]);
                    rewardPercent = REWARD_PERCENT_MULTIPLIER * rewardPercent / totalStaked;
                }
            } else {
                if (delegatorsAmount != 0) {
                    rewardPercent = _stakingContract.stakeAmountMinusOrderedWithdraw(_stakingAddress, delegators[i]);
                    rewardPercent = REWARD_PERCENT_MULTIPLIER * rewardPercent * 7 / (delegatorsAmount * 10);
                }
            }

            stakers.push(delegators[i]);
            rewardPercents.push(rewardPercent);
        }
    }
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IERC20Minting.sol

pragma solidity 0.5.9;


interface IERC20Minting {
    // This function may only be called by BlockReward contract
    function mintReward(address[] calldata _receivers, uint256[] calldata _rewards) external;

    // These functions may only be called by ValidatorSet contract
    function stake(address _staker, uint256 _amount) external;
    function withdraw(address _staker, uint256 _amount) external;

    // Other ERC20 functions
    function balanceOf(address) external view returns(uint256);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IRandomAuRa.sol

pragma solidity 0.5.9;


interface IRandomAuRa {
    function initialize(uint256, address) external;
    function onFinishCollectRound() external;
    function commitHashCallable(address, bytes32) external view returns(bool);
    function revealSecretCallable(address, uint256) external view returns(bool);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IStakingAuRa.sol

pragma solidity 0.5.9;


interface IStakingAuRa {
    function initialize(
        address,
        address[] calldata,
        uint256,
        uint256,
        uint256,
        uint256,
        uint256,
        bool
    ) external;
    function setStakingEpochStartBlock(uint256) external;
    function stakeWithdrawDisallowPeriod() external view returns(uint256);
    function stakingEpochDuration() external view returns(uint256);
    function stakingEpochEndBlock() external view returns(uint256);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IValidatorSetAuRa.sol

pragma solidity 0.5.9;


interface IValidatorSetAuRa {
    function removeMaliciousValidator(address) external;
    function reportMaliciousCallable(address, address, uint256) external view returns(bool, bool);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/BlockRewardAuRa.sol

pragma solidity 0.5.9;





/// @dev Generates and distributes rewards according to the logic and formulas described in the POSDAO white paper.
contract BlockRewardAuRa is BlockRewardBase {

    /// @dev Called by the validator's node when producing and closing a block,
    /// see https://wiki.parity.io/Block-Reward-Contract.html.
    /// This function performs all of the automatic operations needed for controlling secrets revealing by validators,
    /// accumulating block producing statistics, starting a new staking epoch, snapshotting reward coefficients 
    /// at the beginning of a new staking epoch, rewards distributing at the end of a staking epoch, and minting
    /// native coins needed for the `erc-to-native` bridge.
    function reward(address[] calldata benefactors, uint16[] calldata kind)
        external
        onlySystem
        returns(address[] memory receiversNative, uint256[] memory rewardsNative)
    {
        if (benefactors.length != kind.length || benefactors.length != 1 || kind[0] != 0) {
            return (new address[](0), new uint256[](0));
        }

        IValidatorSet validatorSet = validatorSetContract();

        // Check if the validator is existed
        if (!validatorSet.isValidator(benefactors[0])) {
            return (new address[](0), new uint256[](0));
        }

        receiversNative = new address[](0);
        rewardsNative = new uint256[](0);

        // Check the current validators at the end of each collection round whether
        // they revealed their secrets, and remove a validator as a malicious if needed
        IRandomAuRa(validatorSet.randomContract()).onFinishCollectRound();

        // Initialize queues
        if (!boolStorage[QUEUE_V_INITIALIZED]) {
            uintStorage[QUEUE_V_FIRST] = 1;
            uintStorage[QUEUE_V_LAST] = 0;
            boolStorage[QUEUE_V_INITIALIZED] = true;
        }
        if (!boolStorage[QUEUE_ER_INITIALIZED]) {
            uintStorage[QUEUE_ER_FIRST] = 1;
            uintStorage[QUEUE_ER_LAST] = 0;
            boolStorage[QUEUE_ER_INITIALIZED] = true;
        }

        IStaking stakingContract = IStaking(validatorSet.stakingContract());
        uint256 bridgeQueueLimit = 100;
        uint256 stakingEpoch = stakingContract.stakingEpoch();
        uint256 rewardPointBlock = _rewardPointBlock(IStakingAuRa(address(stakingContract)), validatorSet);

        if (validatorSet.validatorSetApplyBlock() != 0 && block.number <= rewardPointBlock) {
            if (stakingEpoch != 0) {
                // Accumulate blocks producing statistics for each of the
                // active validators during the current staking epoch
                uintStorage[keccak256(abi.encode(BLOCKS_CREATED, stakingEpoch, benefactors[0]))]++;
            }
        }

        // Start a new staking epoch every `stakingEpochDuration()` blocks
        (bool newStakingEpochHasBegun, uint256 poolsToBeElectedLength) = validatorSet.newValidatorSet();

        if (newStakingEpochHasBegun) {
            // A new staking epoch has begun, so prepare for reward coefficients snapshotting
            // process which begins right from the following block
            address[] memory newValidatorSet = validatorSet.getPendingValidators();

            for (uint256 i = 0; i < newValidatorSet.length; i++) {
                address stakingAddress = validatorSet.stakingByMiningAddress(newValidatorSet[i]);

                _enqueueValidator(stakingAddress);

                delete addressArrayStorage[keccak256(abi.encode(SNAPSHOT_STAKERS, stakingAddress))];
                delete uintArrayStorage[keccak256(abi.encode(SNAPSHOT_REWARD_PERCENTS, stakingAddress))];
            }

            delete addressArrayStorage[SNAPSHOT_STAKING_ADDRESSES];
            uintStorage[SNAPSHOT_TOTAL_STAKE_AMOUNT] = 0;
            boolStorage[IS_SNAPSHOTTING] = (newValidatorSet.length != 0);

            if (poolsToBeElectedLength > 2000) {
                bridgeQueueLimit = 0;
            } else if (poolsToBeElectedLength > 1000) {
                bridgeQueueLimit = 30;
            } else {
                bridgeQueueLimit = 50;
            }
        } else if (boolStorage[IS_SNAPSHOTTING]) {
            // Snapshot reward coefficients for each new validator and their delegators
            // during the very first blocks of a new staking epoch
            address stakingAddress = _dequeueValidator();

            if (stakingAddress != address(0)) {
                uint256 validatorsQueueSize = _validatorsQueueSize();
                _setSnapshot(stakingAddress, stakingContract, (validatorsQueueSize + 1) % DELEGATORS_ALIQUOT);
                if (validatorsQueueSize == 0) {
                    // Snapshotting process has been finished
                    boolStorage[IS_SNAPSHOTTING] = false;
                }
                bridgeQueueLimit = 50;
            }
        } else if (stakingEpoch != 0) {
            // Distribute rewards at the end of staking epoch during the last
            // MAX_VALIDATORS * DELEGATORS_ALIQUOT blocks
            bool noop;
            (receiversNative, rewardsNative, noop) = _distributeRewards(
                validatorSet,
                stakingContract.erc20TokenContract(),
                stakingContract.erc20Restricted(),
                IStakingAuRa(address(stakingContract)),
                stakingEpoch,
                rewardPointBlock
            );
            if (!noop) {
                bridgeQueueLimit = 50;
            }
        }

        // Mint native coins if needed
        return _mintNativeCoins(receiversNative, rewardsNative, bridgeQueueLimit);
    }

    // =============================================== Getters ========================================================

    /// @dev Returns a number of blocks produced by the specified validator during the specified staking epoch
    /// (beginning from the block when the `finalizeChange` function is called until the block specified by the
    /// `_rewardPointBlock` function). The results are used by the `_distributeRewards` function to track
    /// each validator's downtime (when a validator's node is not running and doesn't produce blocks).
    /// @param _stakingEpoch The number of the staking epoch for which the statistics should be returned.
    /// @param _validatorMiningAddress The mining address of the validator for which the statistics should be returned.
    function getBlocksCreated(
        uint256 _stakingEpoch,
        address _validatorMiningAddress
    ) public view returns(uint256) {
        return uintStorage[keccak256(abi.encode(BLOCKS_CREATED, _stakingEpoch, _validatorMiningAddress))];
    }

    /// @dev Returns the reward amount to be distributed in native coins among participants (the validator and their
    /// delegators) of the specified pool at the end of the specified staking epoch.
    /// @param _stakingEpoch The number of the staking epoch for which the amount should be returned.
    /// @param _poolStakingAddress The staking address of the pool for which the amount should be returned.
    function getEpochPoolNativeReward(
        uint256 _stakingEpoch,
        address _poolStakingAddress
    ) public view returns(uint256) {
        return uintStorage[keccak256(abi.encode(
            EPOCH_POOL_NATIVE_REWARD, _stakingEpoch, _poolStakingAddress
        ))];
    }

    /// @dev Returns the reward amount to be distributed in staking tokens among participants (the validator and their
    /// delegators) of the specified pool at the end of the specified staking epoch.
    /// @param _stakingEpoch The number of the staking epoch for which the amount should be returned.
    /// @param _poolStakingAddress The staking address of the pool for which the amount should be returned.
    function getEpochPoolTokenReward(
        uint256 _stakingEpoch,
        address _poolStakingAddress
    ) public view returns(uint256) {
        return uintStorage[keccak256(abi.encode(
            EPOCH_POOL_TOKEN_REWARD, _stakingEpoch, _poolStakingAddress
        ))];
    }

    /// @dev Returns the total reward amount in native coins which is not yet distributed among participants.
    function getNativeRewardUndistributed() public view returns(uint256) {
        return uintStorage[NATIVE_REWARD_UNDISTRIBUTED];
    }

    /// @dev Returns the total reward amount in staking tokens which is not yet distributed among participants.
    function getTokenRewardUndistributed() public view returns(uint256) {
        return uintStorage[TOKEN_REWARD_UNDISTRIBUTED];
    }

    // =============================================== Private ========================================================

    bytes32 internal constant NATIVE_REWARD_UNDISTRIBUTED = keccak256("nativeRewardUndistributed");
    bytes32 internal constant QUEUE_V_FIRST = keccak256("queueVFirst");
    bytes32 internal constant QUEUE_V_INITIALIZED = keccak256("queueVInitialized");
    bytes32 internal constant QUEUE_V_LAST = keccak256("queueVLast");
    bytes32 internal constant TOKEN_REWARD_UNDISTRIBUTED = keccak256("tokenRewardUndistributed");

    bytes32 internal constant BLOCKS_CREATED = "blocksCreated";
    bytes32 internal constant EPOCH_POOL_NATIVE_REWARD = "epochPoolNativeReward";
    bytes32 internal constant EPOCH_POOL_TOKEN_REWARD = "epochPoolTokenReward";
    bytes32 internal constant QUEUE_V_LIST = "queueVList";

    /// @dev Distributes rewards among participants during the last MAX_VALIDATORS * DELEGATORS_ALIQUOT
    /// blocks of a staking epoch. This function is called by the `reward` function.
    /// @param _validatorSetContract The address of the ValidatorSet contract.
    /// @param _erc20TokenContract The address of the ERC20 staking token contract.
    /// @param _erc20Restricted A boolean flag indicating whether the StakingAuRa contract restricts using ERC20/677
    /// contract. If it's set to `true`, native staking coins are used instead of ERC staking tokens.
    /// @param _stakingContract The address of the Staking contract.
    /// @param _stakingEpoch The number of the current staking epoch.
    /// @param _rewardPointBlock The number of the block within the current staking epoch when the rewarding process
    /// should start. This number is calculated by the `_rewardPointBlock` getter.
    /// @return `address[] receivers` - The array of native coins receivers which should be
    /// rewarded at the current block by the `erc-to-native` bridge or by the fixed native reward.
    /// `uint256[] rewards` - The array of amounts corresponding to the `receivers` array.
    /// `bool noop` - The boolean flag which is set to `true` when there are no complex operations during the
    /// function launch. The flag is used by the `reward` function to control the load on the block inside the
    /// `_mintNativeCoins` function.
    function _distributeRewards(
        IValidatorSet _validatorSetContract,
        address _erc20TokenContract,
        bool _erc20Restricted,
        IStakingAuRa _stakingContract,
        uint256 _stakingEpoch,
        uint256 _rewardPointBlock
    ) internal returns(address[] memory receivers, uint256[] memory rewards, bool noop) {
        uint256 i;
        uint256 j;

        receivers = new address[](0);
        rewards = new uint256[](0);
        noop = true;

        if (block.number == _rewardPointBlock - 1) {
            boolStorage[IS_REWARDING] = true;
        } else if (block.number == _rewardPointBlock) {
            address[] memory validators = _validatorSetContract.getValidators();
            uint256[] memory ratio = new uint256[](validators.length);

            uint256 totalReward;
            bool isRewarding = false;

            totalReward = uintStorage[BRIDGE_TOKEN_FEE];

            if (!_erc20Restricted) {
                // Accumulated bridge fee plus token inflation
                uint256 inflationPercent;
                if (_stakingEpoch <= 24) {
                    inflationPercent = 32;
                } else if (_stakingEpoch <= 48) {
                    inflationPercent = 16;
                } else if (_stakingEpoch <= 72) {
                    inflationPercent = 8;
                } else {
                    inflationPercent = 4;
                }
                totalReward += snapshotTotalStakeAmount() * inflationPercent / 4800;
            }

            if (
                totalReward != 0 && _erc20TokenContract != address(0) ||
                uintStorage[BRIDGE_NATIVE_FEE] != 0 ||
                _erc20Restricted
            ) {
                j = 0;
                for (i = 0; i < validators.length; i++) {
                    ratio[i] = uintStorage[keccak256(abi.encode(
                        BLOCKS_CREATED, _stakingEpoch, validators[i]
                    ))];
                    j += ratio[i];
                    validators[i] = _validatorSetContract.stakingByMiningAddress(validators[i]);
                }
                if (j != 0) {
                    for (i = 0; i < validators.length; i++) {
                        ratio[i] = REWARD_PERCENT_MULTIPLIER * ratio[i] / j;
                    }
                }
            }
            if (totalReward != 0) {
                uintStorage[BRIDGE_TOKEN_FEE] = 0;

                totalReward += uintStorage[TOKEN_REWARD_UNDISTRIBUTED];

                if (_erc20TokenContract != address(0)) {
                    for (i = 0; i < validators.length; i++) {
                        uintStorage[keccak256(abi.encode(
                            EPOCH_POOL_TOKEN_REWARD, _stakingEpoch, validators[i]
                        ))] = totalReward * ratio[i] / REWARD_PERCENT_MULTIPLIER;
                    }
                    isRewarding = true;
                }

                uintStorage[TOKEN_REWARD_UNDISTRIBUTED] = totalReward;
            }

            totalReward = uintStorage[BRIDGE_NATIVE_FEE];

            if (_erc20Restricted) {
                // Accumulated bridge fee plus 2.5% per year coin inflation
                totalReward += _stakingContract.stakingEpochDuration() * 1 ether;
            }

            if (totalReward != 0) {
                uintStorage[BRIDGE_NATIVE_FEE] = 0;

                totalReward += uintStorage[NATIVE_REWARD_UNDISTRIBUTED];

                for (i = 0; i < validators.length; i++) {
                    uintStorage[keccak256(abi.encode(
                        EPOCH_POOL_NATIVE_REWARD, _stakingEpoch, validators[i]
                    ))] = totalReward * ratio[i] / REWARD_PERCENT_MULTIPLIER;
                }
                isRewarding = true;

                uintStorage[NATIVE_REWARD_UNDISTRIBUTED] = totalReward;
            }

            if (isRewarding) {
                for (i = 0; i < validators.length; i++) {
                    _enqueueValidator(validators[i]);
                }
                if (validators.length == 0) {
                    boolStorage[IS_REWARDING] = false;
                }
            } else {
                boolStorage[IS_REWARDING] = false;
            }

            noop = false;
        } else if (block.number > _rewardPointBlock) {
            address stakingAddress = _dequeueValidator();

            if (stakingAddress == address(0)) {
                return (receivers, rewards, true);
            }

            if (_validatorsQueueSize() == 0) {
                boolStorage[IS_REWARDING] = false;
            }

            if (_validatorSetContract.isValidatorBanned(_validatorSetContract.miningByStakingAddress(stakingAddress))) {
                return (receivers, rewards, true);
            }

            address[] storage stakers = addressArrayStorage[keccak256(abi.encode(SNAPSHOT_STAKERS, stakingAddress))];
            uint256[] memory range = new uint256[](3); // array instead of local vars because the stack is too deep
            range[0] = (_validatorsQueueSize() + 1) % DELEGATORS_ALIQUOT; // offset
            range[1] = range[0] * stakers.length / DELEGATORS_ALIQUOT; // from
            range[2] = (range[0] + 1) * stakers.length / DELEGATORS_ALIQUOT; // to

            if (range[0] == 0) {
                range[2] += stakers.length % DELEGATORS_ALIQUOT;
            } else {
                range[1] += stakers.length % DELEGATORS_ALIQUOT;
            }

            if (range[1] >= range[2]) {
                return (receivers, rewards, true);
            }

            uint256[] storage rewardPercents = uintArrayStorage[keccak256(abi.encode(
                SNAPSHOT_REWARD_PERCENTS, stakingAddress
            ))];
            uint256 accrued;
            uint256 poolReward;

            receivers = new address[](range[2] - range[1]);
            rewards = new uint256[](receivers.length);

            poolReward = uintStorage[keccak256(abi.encode(
                EPOCH_POOL_TOKEN_REWARD, _stakingEpoch, stakingAddress
            ))];
            if (poolReward != 0) {
                accrued = 0;
                for (i = range[1]; i < range[2]; i++) {
                    j = i - range[1];
                    receivers[j] = stakers[i];
                    rewards[j] = poolReward * rewardPercents[i] / REWARD_PERCENT_MULTIPLIER;
                    accrued += rewards[j];
                }
                IERC20Minting(_erc20TokenContract).mintReward(receivers, rewards);
                _subTokenRewardUndistributed(accrued);
                noop = false;
            }

            poolReward = uintStorage[keccak256(abi.encode(
                EPOCH_POOL_NATIVE_REWARD, _stakingEpoch, stakingAddress
            ))];
            if (poolReward != 0) {
                accrued = 0;
                for (i = range[1]; i < range[2]; i++) {
                    j = i - range[1];
                    receivers[j] = stakers[i];
                    rewards[j] = poolReward * rewardPercents[i] / REWARD_PERCENT_MULTIPLIER;
                    accrued += rewards[j];
                }
                _subNativeRewardUndistributed(accrued);
                noop = false;
            } else {
                return (new address[](0), new uint256[](0), noop);
            }
        }
    }

    /// @dev Dequeues a validator enqueued for the snapshotting or rewarding process.
    /// Used by the `reward` and `_distributeRewards` functions.
    /// If the queue is empty, the function returns a zero address.
    function _dequeueValidator() internal returns(address validatorStakingAddress) {
        uint256 queueFirst = uintStorage[QUEUE_V_FIRST];
        uint256 queueLast = uintStorage[QUEUE_V_LAST];

        if (queueLast < queueFirst) {
            validatorStakingAddress = address(0);
        } else {
            bytes32 hash = keccak256(abi.encode(QUEUE_V_LIST, queueFirst));
            validatorStakingAddress = addressStorage[hash];
            delete addressStorage[hash];
            uintStorage[QUEUE_V_FIRST]++;
        }
    }

    /// @dev Enqueues the specified validator for the snapshotting or rewarding process.
    /// Used by the `reward` and `_distributeRewards` functions. See also DELEGATORS_ALIQUOT.
    /// @param _validatorStakingAddress The staking address of a validator to be enqueued.
    function _enqueueValidator(address _validatorStakingAddress) internal {
        uint256 queueLast = uintStorage[QUEUE_V_LAST];
        for (uint256 i = 0; i < DELEGATORS_ALIQUOT; i++) {
            addressStorage[keccak256(abi.encode(QUEUE_V_LIST, ++queueLast))] = _validatorStakingAddress;
        }
        uintStorage[QUEUE_V_LAST] = queueLast;
    }

    /// @dev Reduces an undistributed amount of native coins.
    /// This function is used by the `_distributeRewards` function.
    /// @param _minus The subtraction value.
    function _subNativeRewardUndistributed(uint256 _minus) internal {
        if (uintStorage[NATIVE_REWARD_UNDISTRIBUTED] < _minus) {
            uintStorage[NATIVE_REWARD_UNDISTRIBUTED] = 0;
        } else {
            uintStorage[NATIVE_REWARD_UNDISTRIBUTED] -= _minus;
        }
    }

    /// @dev Reduces an undistributed amount of staking tokens.
    /// This function is used by the `_distributeRewards` function.
    /// @param _minus The subtraction value.
    function _subTokenRewardUndistributed(uint256 _minus) internal {
        if (uintStorage[TOKEN_REWARD_UNDISTRIBUTED] < _minus) {
            uintStorage[TOKEN_REWARD_UNDISTRIBUTED] = 0;
        } else {
            uintStorage[TOKEN_REWARD_UNDISTRIBUTED] -= _minus;
        }
    }

    /// @dev Calculates the starting block number for the rewarding process
    /// at the end of the current staking epoch.
    /// Used by the `reward` and `_distributeRewards` functions.
    /// @param _stakingContract The address of the StakingAuRa contract.
    /// @param _validatorSetContract The address of the ValidatorSet contract.
    function _rewardPointBlock(
        IStakingAuRa _stakingContract,
        IValidatorSet _validatorSetContract
    ) internal view returns(uint256) {
        return _stakingContract.stakingEpochEndBlock() - _validatorSetContract.MAX_VALIDATORS()*DELEGATORS_ALIQUOT - 1;
    }

    /// @dev Returns the size of the validator queue used for the snapshotting and rewarding processes.
    /// See `_enqueueValidator` and `_dequeueValidator` functions.
    /// This function is used by the `reward` and `_distributeRewards` functions.
    function _validatorsQueueSize() internal view returns(uint256) {
        return uintStorage[QUEUE_V_LAST] + 1 - uintStorage[QUEUE_V_FIRST];
    }

}
