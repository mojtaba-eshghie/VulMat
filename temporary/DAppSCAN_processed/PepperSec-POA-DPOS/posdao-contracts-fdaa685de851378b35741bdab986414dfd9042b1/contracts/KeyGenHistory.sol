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

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/KeyGenHistory.sol

pragma solidity 0.5.9;




contract KeyGenHistory is OwnedEternalStorage {
    using SafeMath for uint256;

    // ================================================ Events ========================================================

    event PartWritten(
        address indexed validator,
        bytes part,
        uint256 indexed stakingEpoch,
        uint256 indexed changeRequestCount
    );

    event AckWritten(
        address indexed validator,
        bytes ack,
        uint256 indexed stakingEpoch,
        uint256 indexed changeRequestCount
    );

    // ============================================== Modifiers =======================================================

    modifier onlyValidator() {
        require(validatorSet().isValidator(msg.sender));
        _;
    }

    // =============================================== Setters ========================================================

    function setValidatorSetContract(IValidatorSet _validatorSet) public onlyOwner {
        require(address(validatorSet()) == address(0));
        require(address(_validatorSet) != address(0));
        addressStorage[VALIDATOR_SET] = address(_validatorSet);
    }

    // Note: since this is non-system transaction, the calling validator
    // should have enough balance to call this function.
    function writePart(bytes memory _part) public onlyValidator {
        IValidatorSet validatorSetContract = validatorSet();
        IStaking stakingContract = IStaking(validatorSetContract.stakingContract());

        uint256 stakingEpoch = stakingContract.stakingEpoch();
        uint256 changeRequestCount = validatorSetContract.changeRequestCount();

        require(!validatorWrotePart(changeRequestCount, msg.sender));

        _setValidatorWrotePart(changeRequestCount, msg.sender);

        emit PartWritten(msg.sender, _part, stakingEpoch, changeRequestCount);
    }

    // Note: since this is non-system transaction, the calling validator
    // should have enough balance to call this function.
    function writeAck(bytes memory _ack) public onlyValidator {
        IValidatorSet validatorSetContract = validatorSet();
        IStaking stakingContract = IStaking(validatorSetContract.stakingContract());

        uint256 stakingEpoch = stakingContract.stakingEpoch();
        uint256 changeRequestCount = validatorSetContract.changeRequestCount();

        emit AckWritten(msg.sender, _ack, stakingEpoch, changeRequestCount);
    }

    // =============================================== Getters ========================================================

    function validatorSet() public view returns(IValidatorSet) {
        return IValidatorSet(addressStorage[VALIDATOR_SET]);
    }

    function validatorWrotePart(uint256 _changeRequestCount, address _validator) public view returns(bool) {
        return boolStorage[
            keccak256(abi.encode(VALIDATOR_WROTE_PART, _changeRequestCount, _validator))
        ];
    }

    // =============================================== Private ========================================================

    bytes32 internal constant VALIDATOR_SET = keccak256("validatorSet");
    bytes32 internal constant VALIDATOR_WROTE_PART = "validatorWrotePart";

    function _setValidatorWrotePart(uint256 _changeRequestCount, address _validator) internal {
        boolStorage[
            keccak256(abi.encode(VALIDATOR_WROTE_PART, _changeRequestCount, _validator))
        ] = true;
    }
}
