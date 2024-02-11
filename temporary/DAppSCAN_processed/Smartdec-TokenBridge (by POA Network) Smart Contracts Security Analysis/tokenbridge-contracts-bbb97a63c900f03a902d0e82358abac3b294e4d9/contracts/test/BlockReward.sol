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

// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/test/BlockReward.sol

pragma solidity 0.4.24;


contract BlockReward is IBlockReward {
    using SafeMath for uint256;

    address[] public validatorList;
    uint256 public mintedCoins = 0;
    uint256 public feeAmount = 0;
    mapping(bytes32 => uint256) internal uintStorage;
    bytes32 internal constant MINTED_TOTALLY_BY_BRIDGE = "mintedTotallyByBridge";
    address public token;

    function () external payable {
    }

    function bridgesAllowedLength() external view returns(uint256) {
        return 3;
    }

    function addExtraReceiver(uint256 _amount, address _receiver) external {
        require(_amount > 0);
        require(_receiver != address(0));
        mintedCoins = mintedCoins.add(_amount);
        this.addMintedTotallyByBridge(_amount, msg.sender);
        _receiver.transfer(_amount);
    }

    function mintedTotally() public view returns (uint256) {
        return mintedCoins;
    }

    function mintedTotallyByBridge(address _bridge) public view returns(uint256) {
        return uintStorage[
        keccak256(abi.encode(MINTED_TOTALLY_BY_BRIDGE, _bridge))
        ];
    }

    function addMintedTotallyByBridge(uint256 _amount, address _bridge) external {
        bytes32 hash = keccak256(abi.encode(MINTED_TOTALLY_BY_BRIDGE, _bridge));
        uintStorage[hash] = uintStorage[hash].add(_amount);
    }

    function setValidatorsRewards(address[] _initialValidators) external {
        validatorList = _initialValidators;
    }

    function setToken(address _token) external {
        token = _token;
    }

    function addBridgeNativeFeeReceivers(uint256 _amount) external {
        feeAmount = _amount;
        uint256 feePerValidator = _amount.div(validatorList.length);

        uint256 randomValidatorIndex;
        uint256 diff = _amount.sub(feePerValidator.mul(validatorList.length));
        if (diff > 0) {
            randomValidatorIndex = random(validatorList.length);
        }

        for (uint256 i = 0; i < validatorList.length; i++) {
            uint256 feeToDistribute = feePerValidator;
            if (diff > 0 && randomValidatorIndex == i) {
                feeToDistribute = feeToDistribute.add(diff);
            }
            this.addExtraReceiver(feeToDistribute, validatorList[i]);
        }
    }

    function addBridgeTokenFeeReceivers(uint256 _amount) external {
        address[] memory receivers = new address[](validatorList.length);
        uint256[] memory rewards = new uint256[](validatorList.length);
        feeAmount = _amount;
        uint256 feePerValidator = _amount.div(validatorList.length);

        uint256 randomValidatorIndex;
        uint256 diff = _amount.sub(feePerValidator.mul(validatorList.length));
        if (diff > 0) {
            randomValidatorIndex = random(validatorList.length);
        }

        for (uint256 i = 0; i < validatorList.length; i++) {
            uint256 feeToDistribute = feePerValidator;
            if (diff > 0 && randomValidatorIndex == i) {
                feeToDistribute = feeToDistribute.add(diff);
            }
            receivers[i] = validatorList[i];
            rewards[i] = feeToDistribute;
        }

        require(token.call(abi.encodeWithSignature("mintReward(address[],uint256[])", receivers, rewards)));
    }

    function random(uint256 _count) public view returns(uint256) {
        return uint256(blockhash(block.number.sub(1))) % _count;
    }
}
