// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IRandom.sol

pragma solidity 0.5.9;


interface IRandom {
    function getCurrentSeed() external view returns(uint256);
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

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/abstracts/RandomBase.sol

pragma solidity 0.5.9;




/// @dev The base contract for the RandomAuRa and RandomHBBFT contracts.
contract RandomBase is OwnedEternalStorage, IRandom {
    using SafeMath for uint256;

    // ============================================== Modifiers =======================================================

    /// @dev Ensures the `initialize` function was called before.
    modifier onlyInitialized {
        require(isInitialized());
        _;
    }

    /// @dev Ensures the caller is the ValidatorSet contract address
    /// (EternalStorageProxy proxy contract for ValidatorSet).
    //SWC-Code With No Effects: L24-L27
    modifier onlyValidatorSetContract() {
        require(msg.sender == address(validatorSetContract()));
        _;
    }

    // =============================================== Getters ========================================================

    /// @dev Returns the current random seed accumulated during RANDAO or another process (depending on
    /// implementation). This getter can only be called by the `ValidatorSet` contract.
    function getCurrentSeed() external onlyValidatorSetContract view returns(uint256) {
        return _getCurrentSeed();
    }

    /// @dev Returns a boolean flag indicating if the `initialize` function has been called.
    function isInitialized() public view returns(bool) {
        return addressStorage[VALIDATOR_SET_CONTRACT] != address(0);
    }

    /// @dev Returns the address of the `ValidatorSet` contract.
    function validatorSetContract() public view returns(IValidatorSet) {
        return IValidatorSet(addressStorage[VALIDATOR_SET_CONTRACT]);
    }

    // =============================================== Private ========================================================

    bytes32 internal constant CURRENT_SEED = keccak256("currentSeed");
    bytes32 internal constant VALIDATOR_SET_CONTRACT = keccak256("validatorSetContract");

    /// @dev Initializes the network parameters. Used by the `initialize` function of a child contract.
    /// @param _validatorSet The address of the `ValidatorSet` contract.
    function _initialize(address _validatorSet) internal {
        require(!isInitialized());
        require(_validatorSet != address(0));
        addressStorage[VALIDATOR_SET_CONTRACT] = _validatorSet;
    }

    /// @dev Updates the current random seed.
    /// @param _seed A new random seed.
    function _setCurrentSeed(uint256 _seed) internal {
        uintStorage[CURRENT_SEED] = _seed;
    }

    /// @dev Reads the current random seed from the state.
    function _getCurrentSeed() internal view returns(uint256) {
        return uintStorage[CURRENT_SEED];
    }

}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IRandomAuRa.sol

pragma solidity 0.5.9;


interface IRandomAuRa {
    function initialize(uint256, address) external;
    function onFinishCollectRound() external;
    function commitHashCallable(address, bytes32) external view returns(bool);
    function revealSecretCallable(address, uint256) external view returns(bool);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IValidatorSetAuRa.sol

pragma solidity 0.5.9;


interface IValidatorSetAuRa {
    function removeMaliciousValidator(address) external;
    function reportMaliciousCallable(address, address, uint256) external view returns(bool, bool);
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

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/RandomAuRa.sol

pragma solidity 0.5.9;





/// @dev Generates and stores random numbers in a RANDAO manner (and controls when they are revealed by AuRa
/// validators) and accumulates a random seed. The random seed is used to form a new validator set by the
/// `ValidatorSet._newValidatorSet` function.
contract RandomAuRa is RandomBase, IRandomAuRa {

    // ============================================== Modifiers =======================================================

    /// @dev Ensures the caller is the BlockRewardAuRa contract address
    /// (EternalStorageProxy proxy contract for BlockRewardAuRa).
    modifier onlyBlockReward() {
        require(msg.sender == validatorSetContract().blockRewardContract());
        _;
    }

    // =============================================== Setters ========================================================

    /// @dev Called by the validator's node to store a hash and a cipher of the validator's secret on each collection
    /// round. The validator's node must use its mining address to call this function.
    /// This function can only be called once per collection round (during the `commits phase`).
    /// @param _secretHash The Keccak-256 hash of the validator's secret.
    /// @param _cipher The cipher of the validator's secret. Can be used by the node to restore the lost secret after
    /// the node is restarted (see the `getCipher` getter).
    function commitHash(bytes32 _secretHash, bytes calldata _cipher) external onlyInitialized {
        address miningAddress = msg.sender;

        require(commitHashCallable(miningAddress, _secretHash));
        require(_getCoinbase() == miningAddress); // make sure validator node is live

        uint256 collectRound = currentCollectRound();

        _setCommit(collectRound, miningAddress, _secretHash);
        _setCipher(collectRound, miningAddress, _cipher);
        _addCommittedValidator(collectRound, miningAddress);
    }

    /// @dev Called by the validator's node to XOR its secret with the current random seed.
    /// The validator's node must use its mining address to call this function.
    /// This function can only be called once per collection round (during the `reveals phase`).
    /// @param _secret The validator's secret.
    function revealSecret(uint256 _secret) external onlyInitialized {
        address miningAddress = msg.sender;

        require(revealSecretCallable(miningAddress, _secret));
        require(_getCoinbase() == miningAddress); // make sure validator node is live

        _setCurrentSeed(_getCurrentSeed() ^ _secret);
        _setSentReveal(currentCollectRound(), miningAddress);
    }

    /// @dev Initializes the contract at network startup.
    /// Must be called by the constructor of the `InitializerAuRa` contract.
    /// @param _collectRoundLength The length of a collection round in blocks.
    /// @param _validatorSet The address of the `ValidatorSet` contract.
    function initialize(
        uint256 _collectRoundLength, // in blocks
        address _validatorSet
    ) external {
        require(_collectRoundLength % 2 == 0);
        require(_collectRoundLength > 0);
        require(collectRoundLength() == 0);
        uintStorage[COLLECT_ROUND_LENGTH] = _collectRoundLength;
        super._initialize(_validatorSet);
    }

    /// @dev Checks whether the current validators at the end of each collection round revealed their secrets,
    /// and removes malicious validators if needed.
    /// This function does nothing if the current block is not the last block of the current collection round.
    /// Can only be called by the `BlockRewardAuRa` contract (its `reward` function).
    function onFinishCollectRound() external onlyBlockReward {
        if (_getCurrentBlockNumber() % collectRoundLength() != collectRoundLength() - 1) return;

        // This is the last block of the current collection round

        address[] memory validators;
        address validator;
        uint256 i;

        address stakingContract = validatorSetContract().stakingContract();

        uint256 stakingEpoch = IStaking(stakingContract).stakingEpoch();
        uint256 applyBlock = validatorSetContract().validatorSetApplyBlock();
        uint256 endBlock = IStakingAuRa(stakingContract).stakingEpochEndBlock();
        uint256 currentRound = currentCollectRound();

        if (applyBlock != 0 && _getCurrentBlockNumber() > applyBlock + collectRoundLength() * 2) {
            // Check whether each validator didn't reveal their secret
            // during the current collection round
            validators = validatorSetContract().getValidators();
            for (i = 0; i < validators.length; i++) {
                validator = validators[i];
                if (!sentReveal(currentRound, validator)) {
                    _incrementRevealSkips(stakingEpoch, validator);
                }
            }
        }

        // If this is the last collection round in the current staking epoch.
        if (_getCurrentBlockNumber() == endBlock || _getCurrentBlockNumber() + collectRoundLength() > endBlock) {
            uint256 maxRevealSkipsAllowed =
                IStakingAuRa(stakingContract).stakeWithdrawDisallowPeriod() / collectRoundLength();

            if (maxRevealSkipsAllowed > 0) {
                maxRevealSkipsAllowed--;
            }

            // Check each validator to see if they didn't reveal
            // their secret during the last full `reveals phase`
            // or if they missed the required number of reveals per staking epoch.
            validators = validatorSetContract().getValidators();
            for (i = 0; i < validators.length; i++) {
                validator = validators[i];
                if (
                    !sentReveal(currentRound, validator) ||
                    revealSkips(stakingEpoch, validator) > maxRevealSkipsAllowed
                ) {
                    // Remove the validator as malicious
                    IValidatorSetAuRa(address(validatorSetContract())).removeMaliciousValidator(validator);
                }
            }
        }

        // Clear unnecessary info about previous collection round.
        _clearOldCiphers(currentRound);
    }

    // =============================================== Getters ========================================================

    /// @dev Returns the length of the collection round (in blocks).
    function collectRoundLength() public view returns(uint256) {
        return uintStorage[COLLECT_ROUND_LENGTH];
    }

    /// @dev Returns the length of the commits/reveals phase which is always half of the collection round length.
    function commitPhaseLength() public view returns(uint256) {
        return collectRoundLength() / 2;
    }

    /// @dev Returns the serial number of the current collection round.
    function currentCollectRound() public view returns(uint256) {
        return _getCurrentBlockNumber() / collectRoundLength();
    }

    /// @dev Returns the cipher of the validator's secret for the specified collection round and the specified validator
    /// stored by the validator through the `commitHash` function.
    /// @param _collectRound The serial number of the collection round for which the cipher should be retrieved.
    /// @param _miningAddress The mining address of validator.
    function getCipher(uint256 _collectRound, address _miningAddress) public view returns(bytes memory) {
        return bytesStorage[keccak256(abi.encode(CIPHERS, _collectRound, _miningAddress))];
    }

    /// @dev Returns the Keccak-256 hash of the validator's secret for the specified collection round and the specified
    /// validator stored by the validator through the `commitHash` function.
    /// @param _collectRound The serial number of the collection round for which the hash should be retrieved.
    /// @param _miningAddress The mining address of validator.
    function getCommit(uint256 _collectRound, address _miningAddress) public view returns(bytes32) {
        return bytes32Storage[keccak256(abi.encode(COMMITS, _collectRound, _miningAddress))];
    }

    /// @dev Returns a boolean flag indicating whether the specified validator has committed their secret's hash for the
    /// specified collection round.
    /// @param _collectRound The serial number of the collection round for which the checkup should be done.
    /// @param _miningAddress The mining address of the validator.
    function isCommitted(uint256 _collectRound, address _miningAddress) public view returns(bool) {
        return getCommit(_collectRound, _miningAddress) != bytes32(0);
    }

    /// @dev Returns a boolean flag indicating whether the current phase of the current collection round
    /// is a `commits phase`. Used by the validator's node to determine if it should commit the hash of
    /// the secret during the current collection round.
    function isCommitPhase() public view returns(bool) {
        return (_getCurrentBlockNumber() % collectRoundLength()) < commitPhaseLength();
    }

    /// @dev Returns a boolean flag indicating whether the current phase of the current collection round
    /// is a `reveals phase`. Used by the validator's node to determine if it should reveal the secret during
    /// the current collection round.
    function isRevealPhase() public view returns(bool) {
        return !isCommitPhase();
    }

    /// @dev Returns a boolean flag of whether the `commitHash` function can be called at the current block
    /// by the specified validator. Used by the `commitHash` function and the `TxPermission` contract.
    /// @param _miningAddress The mining address of the validator which tries to call the `commitHash` function.
    /// @param _secretHash The Keccak-256 hash of validator's secret passed to the `commitHash` function.
    function commitHashCallable(address _miningAddress, bytes32 _secretHash) public view returns(bool) {
        if (!isCommitPhase()) return false; // must only be called in `commits phase`

        if (_secretHash == bytes32(0)) return false;

        if (!validatorSetContract().isValidator(_miningAddress)) return false;

        if (isCommitted(currentCollectRound(), _miningAddress)) return false; // cannot commit more than once

        return true;
    }

    /// @dev Returns a boolean flag of whether the `revealSecret` function can be called at the current block
    /// by the specified validator. Used by the `revealSecret` function and the `TxPermission` contract.
    /// @param _miningAddress The mining address of validator which tries to call the `revealSecret` function.
    /// @param _secret The validator's secret passed to the `revealSecret` function.
    function revealSecretCallable(address _miningAddress, uint256 _secret) public view returns(bool) {
        if (!isRevealPhase()) return false; // must only be called in `reveals phase`

        bytes32 secretHash = keccak256(abi.encodePacked(_secret));

        if (secretHash == bytes32(0)) return false;

        if (!validatorSetContract().isValidator(_miningAddress)) return false;

        uint256 collectRound = currentCollectRound();

        if (sentReveal(collectRound, _miningAddress)) {
            return false; // cannot reveal more than once during the same collectRound
        }

        if (secretHash != getCommit(collectRound, _miningAddress)) {
            return false; // the hash must be commited
        }

        return true;
    }

    /// @dev Returns the number of reveal skips made by the specified validator during the specified staking epoch.
    /// @param _stakingEpoch The serial number of the staking epoch for which the number of skips should be returned.
    /// @param _miningAddress The mining address of the validator for which the number of skips should be returned.
    function revealSkips(uint256 _stakingEpoch, address _miningAddress) public view returns(uint256) {
        return uintStorage[keccak256(abi.encode(REVEAL_SKIPS, _stakingEpoch, _miningAddress))];
    }

    /// @dev Returns a boolean flag of whether the specified validator has revealed their secret for the
    /// specified collection round.
    /// @param _collectRound The serial number of the collection round for which the checkup should be done.
    /// @param _miningAddress The mining address of the validator.
    function sentReveal(uint256 _collectRound, address _miningAddress) public view returns(bool) {
        return boolStorage[keccak256(abi.encode(SENT_REVEAL, _collectRound, _miningAddress))];
    }

    // =============================================== Private ========================================================

    bytes32 internal constant COLLECT_ROUND_LENGTH = keccak256("collectRoundLength");
    bytes32 internal constant CIPHERS = "ciphers";
    bytes32 internal constant COMMITS = "commits";
    bytes32 internal constant COMMITTED_VALIDATORS = "committedValidators";
    bytes32 internal constant REVEAL_SKIPS = "revealSkips";
    bytes32 internal constant SENT_REVEAL = "sentReveal";

    /// @dev Adds the specified validator to the array of validators that committed their
    /// hashes during the specified collection round. Used by the `commitHash` function.
    /// @param _collectRound The serial number of the collection round.
    /// @param _miningAddress The validator's mining address to be added.
    function _addCommittedValidator(uint256 _collectRound, address _miningAddress) private {
        addressArrayStorage[keccak256(abi.encode(COMMITTED_VALIDATORS, _collectRound))].push(_miningAddress);
    }

    /// @dev Removes the ciphers of all committed validators for the specified collection round.
    /// @param _collectRound The serial number of the collection round.
    function _clearOldCiphers(uint256 _collectRound) private {
        if (_collectRound == 0) {
            return;
        }

        uint256 collectRound = _collectRound - 1;
        address[] storage miningAddresses =
            addressArrayStorage[keccak256(abi.encode(COMMITTED_VALIDATORS, collectRound))];

        for (uint256 i = 0; i < miningAddresses.length; i++) {
            delete bytesStorage[keccak256(abi.encode(CIPHERS, collectRound, miningAddresses[i]))];
        }
    }

    /// @dev Returns the current `coinbase` address. Needed mostly for unit tests.
    function _getCoinbase() internal view returns(address) {
        return block.coinbase;
    }

    /// @dev Returns the current block number. Needed mostly for unit tests.
    function _getCurrentBlockNumber() internal view returns(uint256) {
        return block.number;
    }

    /// @dev Increments the reveal skips counter for the specified validator and staking epoch.
    /// Used by the `onFinishCollectRound` function.
    /// @param _stakingEpoch The serial number of the staking epoch.
    /// @param _miningAddress The validator's mining address.
    function _incrementRevealSkips(uint256 _stakingEpoch, address _miningAddress) private {
        uintStorage[keccak256(abi.encode(REVEAL_SKIPS, _stakingEpoch, _miningAddress))]++;
    }

    /// @dev Stores the cipher of the secret for the specified validator and collection round.
    /// Used by the `commitHash` function.
    /// @param _collectRound The serial number of the collection round.
    /// @param _miningAddress The validator's mining address.
    /// @param _cipher The cipher's bytes sequence to be stored.
    function _setCipher(uint256 _collectRound, address _miningAddress, bytes memory _cipher) private {
        bytesStorage[keccak256(abi.encode(CIPHERS, _collectRound, _miningAddress))] = _cipher;
    }

    /// @dev Stores the Keccak-256 hash of the secret for the specified validator and collection round.
    /// Used by the `commitHash` function.
    /// @param _collectRound The serial number of the collection round.
    /// @param _miningAddress The validator's mining address.
    /// @param _secretHash The hash to be stored.
    function _setCommit(uint256 _collectRound, address _miningAddress, bytes32 _secretHash) private {
        bytes32Storage[keccak256(abi.encode(COMMITS, _collectRound, _miningAddress))] = _secretHash;
    }

    /// @dev Stores the boolean flag of whether the specified validator revealed their secret
    /// during the specified collection round.
    /// @param _collectRound The serial number of the collection round.
    /// @param _miningAddress The validator's mining address.
    function _setSentReveal(uint256 _collectRound, address _miningAddress) private {
        boolStorage[keccak256(abi.encode(SENT_REVEAL, _collectRound, _miningAddress))] = true;
    }
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/test/mockContracts/RandomAuRaMock.sol

pragma solidity 0.5.9;

contract RandomAuRaMock is RandomAuRa {

    // =============================================== Setters ========================================================

    function setCoinbase(address _coinbase) public {
        addressStorage[keccak256("coinbase")] = _coinbase;
    }

    function setCurrentBlockNumber(uint256 _blockNumber) public {
        uintStorage[keccak256("currentBlockNumber")] = _blockNumber;
    }

    function showCurrentSeed() public view returns(uint256) {
        return _getCurrentSeed();
    }

    // =============================================== Private ========================================================

    function _getCoinbase() internal view returns(address) {
        address coinbase = addressStorage[keccak256("coinbase")];
        return coinbase != address(0) ? coinbase : block.coinbase;
    }

    function _getCurrentBlockNumber() internal view returns(uint256) {
        return uintStorage[keccak256("currentBlockNumber")];
    }

}
