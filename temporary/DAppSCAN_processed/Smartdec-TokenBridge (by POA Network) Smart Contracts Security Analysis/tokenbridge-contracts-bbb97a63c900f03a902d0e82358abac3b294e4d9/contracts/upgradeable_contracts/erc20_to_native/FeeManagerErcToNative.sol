// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/IBlockReward.sol

pragma solidity 0.4.24;


interface IBlockReward {
    function addExtraReceiver(uint256 _amount, address _receiver) external;
    function mintedTotally() public view returns (uint256);
    function mintedTotallyByBridge(address _bridge) public view returns(uint256);
    function bridgesAllowedLength() external view returns(uint256);
    function addBridgeTokenFeeReceivers(uint256 _amount) external;
    function addBridgeNativeFeeReceivers(uint256 _amount) external;
}

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeable_contracts/Sacrifice.sol

pragma solidity 0.4.24;


contract Sacrifice {
    constructor(address _recipient) public payable {
        selfdestruct(_recipient);
    }
}

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

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/libraries/SafeMath.sol

pragma solidity 0.4.24;


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  /**
  * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/IRewardableValidators.sol

pragma solidity 0.4.24;


interface IRewardableValidators {
    function isValidator(address _validator) public view returns(bool);
    function requiredSignatures() public view returns(uint256);
    function owner() public view returns(address);
    function validatorList() public view returns (address[]);
    function getValidatorRewardAddress(address _validator) public view returns(address);
    function validatorCount() public view returns (uint256);
    function getNextValidator(address _address) public view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeable_contracts/FeeTypes.sol

pragma solidity 0.4.24;


contract FeeTypes {
    bytes32 internal constant HOME_FEE = keccak256(abi.encodePacked("home-fee"));
    bytes32 internal constant FOREIGN_FEE = keccak256(abi.encodePacked("foreign-fee"));
}

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeable_contracts/BaseFeeManager.sol

pragma solidity 0.4.24;




contract BaseFeeManager is EternalStorage, FeeTypes {
    using SafeMath for uint256;

    event HomeFeeUpdated(uint256 fee);
    event ForeignFeeUpdated(uint256 fee);

    function calculateFee(uint256 _value, bool _recover, bytes32 _feeType) public view returns(uint256) {
        uint256 fee = _feeType == HOME_FEE ? getHomeFee() : getForeignFee();
        uint256 eth = 1 ether;
        if (!_recover) {
            return _value.mul(fee).div(eth);
        }
        return _value.mul(fee).div(eth.sub(fee));
    }

    function setHomeFee(uint256 _fee) external {
        uintStorage[keccak256(abi.encodePacked("homeFee"))] = _fee;
        emit HomeFeeUpdated(_fee);
    }

    function getHomeFee() public view returns(uint256) {
        return uintStorage[keccak256(abi.encodePacked("homeFee"))];
    }

    function setForeignFee(uint256 _fee) external {
        uintStorage[keccak256(abi.encodePacked("foreignFee"))] = _fee;
        emit ForeignFeeUpdated(_fee);
    }

    function getForeignFee() public view returns(uint256) {
        return uintStorage[keccak256(abi.encodePacked("foreignFee"))];
    }

    function distributeFeeFromAffirmation(uint256 _fee) external;

    function distributeFeeFromSignatures(uint256 _fee) external;

    function getFeeManagerMode() public pure returns(bytes4);
    // SWC-Assert Violation: L48-L50
    function random(uint256 _count) public view returns(uint256) {
        return uint256(blockhash(block.number.sub(1))) % _count;
    }
}

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeable_contracts/ValidatorsFeeManager.sol

pragma solidity 0.4.24;


contract ValidatorsFeeManager is BaseFeeManager {

    bytes32 public constant REWARD_FOR_TRANSFERRING_FROM_HOME = keccak256(abi.encodePacked("reward-transferring-from-home"));

    bytes32 public constant REWARD_FOR_TRANSFERRING_FROM_FOREIGN = keccak256(abi.encodePacked("reward-transferring-from-foreign"));

    function distributeFeeFromAffirmation(uint256 _fee) external {
        distributeFeeProportionally(_fee, REWARD_FOR_TRANSFERRING_FROM_FOREIGN);
    }

    function distributeFeeFromSignatures(uint256 _fee) external {
        distributeFeeProportionally(_fee, REWARD_FOR_TRANSFERRING_FROM_HOME);
    }

    function rewardableValidatorContract() internal view returns(IRewardableValidators) {
        return IRewardableValidators(addressStorage[keccak256(abi.encodePacked("validatorContract"))]);
    }

    function distributeFeeProportionally(uint256 _fee, bytes32 _direction) internal {
        IRewardableValidators validators = rewardableValidatorContract();
        address F_ADDR = 0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF;
        uint256 numOfValidators = validators.validatorCount();

        uint256 feePerValidator = _fee.div(numOfValidators);

        uint256 randomValidatorIndex;
        uint256 diff = _fee.sub(feePerValidator.mul(numOfValidators));
        if (diff > 0) {
            randomValidatorIndex = random(numOfValidators);
        }

        address nextValidator = validators.getNextValidator(F_ADDR);
        require((nextValidator != F_ADDR) && (nextValidator != address(0)));

        uint256 i = 0;
        while (nextValidator != F_ADDR) {
            uint256 feeToDistribute = feePerValidator;
            if (diff > 0 && randomValidatorIndex == i) {
                feeToDistribute = feeToDistribute.add(diff);
            }

            address rewardAddress = validators.getValidatorRewardAddress(nextValidator);
            onFeeDistribution(rewardAddress, feeToDistribute, _direction);

            nextValidator = validators.getNextValidator(nextValidator);
            require(nextValidator != address(0));
            i = i + 1;
        }
    }

    function onFeeDistribution(address _rewardAddress, uint256 _fee, bytes32 _direction) internal {
        if (_direction == REWARD_FOR_TRANSFERRING_FROM_FOREIGN) {
            onAffirmationFeeDistribution(_rewardAddress, _fee);
        } else {
            onSignatureFeeDistribution(_rewardAddress, _fee);
        }
    }

    function onAffirmationFeeDistribution(address _rewardAddress, uint256 _fee) internal;

    function onSignatureFeeDistribution(address _rewardAddress, uint256 _fee) internal;
}

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeable_contracts/erc20_to_native/FeeManagerErcToNative.sol

pragma solidity 0.4.24;



contract FeeManagerErcToNative is ValidatorsFeeManager {

    function getFeeManagerMode() public pure returns(bytes4) {
        return bytes4(keccak256(abi.encodePacked("manages-both-directions")));
    }

    function blockRewardContract() internal view returns(IBlockReward) {
        return IBlockReward(addressStorage[keccak256(abi.encodePacked("blockRewardContract"))]);
    }

    function onAffirmationFeeDistribution(address _rewardAddress, uint256 _fee) internal {
        IBlockReward blockReward = blockRewardContract();
        blockReward.addExtraReceiver(_fee, _rewardAddress);
    }

    function onSignatureFeeDistribution(address _rewardAddress, uint256 _fee) internal {
        if (!_rewardAddress.send(_fee)) {
            (new Sacrifice).value(_fee)(_rewardAddress);
        }
    }

    function getAmountToBurn(uint256 _value) public view returns(uint256) {
        uint256 fee = calculateFee(_value, false, HOME_FEE);
        return _value.sub(fee);
    }
}
