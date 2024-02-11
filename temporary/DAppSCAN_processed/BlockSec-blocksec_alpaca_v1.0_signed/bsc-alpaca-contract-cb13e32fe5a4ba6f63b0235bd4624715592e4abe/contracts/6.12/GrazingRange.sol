// File: @openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol

pragma solidity ^0.6.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol

pragma solidity ^0.6.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts-ethereum-package/contracts/utils/Address.sol

pragma solidity ^0.6.2;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}

// File: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/SafeERC20.sol

pragma solidity ^0.6.0;



/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves.

        // A Solidity high level call has three parts:
        //  1. The target address is checked to verify it contains contract code
        //  2. The call itself is made, and success asserted
        //  3. The return value is decoded, which in turn checks the size of the returned data.
        // solhint-disable-next-line max-line-length
        require(address(token).isContract(), "SafeERC20: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// File: @openzeppelin/contracts-ethereum-package/contracts/Initializable.sol

pragma solidity >=0.4.24 <0.7.0;


/**
 * @title Initializable
 *
 * @dev Helper contract to support initializer functions. To use it, replace
 * the constructor with a function that has the `initializer` modifier.
 * WARNING: Unlike constructors, initializer functions must be manually
 * invoked. This applies both to deploying an Initializable contract, as well
 * as extending an Initializable contract via inheritance.
 * WARNING: When used with inheritance, manual care must be taken to not invoke
 * a parent initializer twice, or ensure that all initializers are idempotent,
 * because this is not dealt with automatically as with constructors.
 */
contract Initializable {

  /**
   * @dev Indicates that the contract has been initialized.
   */
  bool private initialized;

  /**
   * @dev Indicates that the contract is in the process of being initialized.
   */
  bool private initializing;

  /**
   * @dev Modifier to use in the initializer function of a contract.
   */
  modifier initializer() {
    require(initializing || isConstructor() || !initialized, "Contract instance has already been initialized");

    bool isTopLevelCall = !initializing;
    if (isTopLevelCall) {
      initializing = true;
      initialized = true;
    }

    _;

    if (isTopLevelCall) {
      initializing = false;
    }
  }

  /// @dev Returns true if and only if the function is running in the constructor
  function isConstructor() private view returns (bool) {
    // extcodesize checks the size of the code stored in an address, and
    // address returns the current address. Since the code is still not
    // deployed when running a constructor, any checks on its code size will
    // yield zero, making it an effective way to detect if a contract is
    // under construction or not.
    address self = address(this);
    uint256 cs;
    assembly { cs := extcodesize(self) }
    return cs == 0;
  }

  // Reserved storage space to allow for layout changes in the future.
  uint256[50] private ______gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/utils/ReentrancyGuard.sol

pragma solidity ^0.6.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
contract ReentrancyGuardUpgradeSafe is Initializable {
    bool private _notEntered;


    function __ReentrancyGuard_init() internal initializer {
        __ReentrancyGuard_init_unchained();
    }

    function __ReentrancyGuard_init_unchained() internal initializer {


        // Storing an initial non-zero value makes deployment a bit more
        // expensive, but in exchange the refund on every call to nonReentrant
        // will be lower in amount. Since refunds are capped to a percetange of
        // the total transaction's gas, it is best to keep them low in cases
        // like this one, to increase the likelihood of the full refund coming
        // into effect.
        _notEntered = true;

    }


    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_notEntered, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _notEntered = false;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _notEntered = true;
    }

    uint256[49] private __gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol

pragma solidity ^0.6.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract ContextUpgradeSafe is Initializable {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.

    function __Context_init() internal initializer {
        __Context_init_unchained();
    }

    function __Context_init_unchained() internal initializer {


    }


    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }

    uint256[50] private __gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol

pragma solidity ^0.6.0;


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract OwnableUpgradeSafe is Initializable, ContextUpgradeSafe {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */

    function __Ownable_init() internal initializer {
        __Context_init_unchained();
        __Ownable_init_unchained();
    }

    function __Ownable_init_unchained() internal initializer {


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
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    uint256[49] private __gap;
}

// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_alpaca_v1.0_signed/bsc-alpaca-contract-cb13e32fe5a4ba6f63b0235bd4624715592e4abe/contracts/6.12/GrazingRange.sol

// SPDX-License-Identifier: MIT
/**
  ∩~~~~∩ 
  ξ ･×･ ξ 
  ξ　~　ξ 
  ξ　　 ξ 
  ξ　　 “~～~～〇 
  ξ　　　　　　 ξ 
  ξ ξ ξ~～~ξ ξ ξ 
　 ξ_ξξ_ξ　ξ_ξξ_ξ
Alpaca Fin Corporation
*/

pragma solidity 0.6.12;






/// @title Grazing Range allows users to stake ibALPACA to receive various rewards
contract GrazingRange is OwnableUpgradeSafe, ReentrancyGuardUpgradeSafe {
  using SafeMath for uint256;
  using SafeERC20 for IERC20;

  /// @dev Info of each user.
  struct UserInfo {
    uint256 amount; // How many Staking tokens the user has provided.
    uint256 rewardDebt; // Reward debt. See explanation below.
  }

  /// @dev Info of each reward distribution campaign.
  struct CampaignInfo {
    IERC20 stakingToken; // Address of Staking token contract.
    IERC20 rewardToken; // Address of Reward token contract
    uint256 startBlock; // start block of the campaign
    uint256 lastRewardBlock; // Last block number that Reward Token distribution occurs.
    uint256 accRewardPerShare; // Accumulated Reward Token per share, times 1e20. See below.
    uint256 totalStaked; // total staked amount each campaign's stake token, typically, each campaign has the same stake token, so need to track it separatedly
    uint256 totalRewards;
  }

  /// @dev Reward info
  struct RewardInfo {
    uint256 endBlock;
    uint256 rewardPerBlock;
  }

  /// @dev this is mostly used for extending reward period
  /// @notice Reward info is a set of {endBlock, rewardPerBlock}
  /// indexed by campaigh ID
  mapping(uint256 => RewardInfo[]) public campaignRewardInfo;

  /// @dev Info of each campaign. mapped from campaigh ID
  CampaignInfo[] public campaignInfo;
  /// @dev Info of each user that stakes Staking tokens.
  mapping(uint256 => mapping(address => UserInfo)) public userInfo;

  /// @notice limit length of reward info
  /// how many phases are allowed
  uint256 public rewardInfoLimit;
  /// @dev reward holder account
  address public rewardHolder;

  event Deposit(address indexed user, uint256 amount, uint256 campaign);
  event Withdraw(address indexed user, uint256 amount, uint256 campaign);
  event EmergencyWithdraw(address indexed user, uint256 amount, uint256 campaign);
  event AddCampaignInfo(uint256 indexed campaignID, IERC20 stakingToken, IERC20 rewardToken, uint256 startBlock);
  event AddRewardInfo(uint256 indexed campaignID, uint256 indexed phase, uint256 endBlock, uint256 rewardPerBlock);
  event SetRewardInfoLimit(uint256 rewardInfoLimit);
  event SetRewardHolder(address rewardHolder);

  function initialize(address _rewardHolder) external initializer {
    OwnableUpgradeSafe.__Ownable_init();
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();
    rewardInfoLimit = 52; // 52 weeks, 1 year
    rewardHolder = _rewardHolder;
  }

  function upgradePrecision() external {
    require(msg.sender == 0x5379F32C8D5F663EACb61eeF63F722950294f452, "!proxy admin");
    uint256 length = campaignInfo.length;
    for (uint256 pid = 0; pid < length; ++pid) {
      campaignInfo[pid].accRewardPerShare = campaignInfo[pid].accRewardPerShare.mul(1e8);
    }
  }

  /// @notice function for setting a reward holder who is responsible for adding a reward info
  function setRewardHolder(address _rewardHolder) external onlyOwner {
    rewardHolder = _rewardHolder;
    emit SetRewardHolder(_rewardHolder);
  }

  /// @notice set new reward info limit
  function setRewardInfoLimit(uint256 _updatedRewardInfoLimit) external onlyOwner {
    rewardInfoLimit = _updatedRewardInfoLimit;
    emit SetRewardInfoLimit(rewardInfoLimit);
  }

  /// @notice reward campaign, one campaign represents a pair of staking and reward token, last reward Block and acc reward Per Share
  function addCampaignInfo(
    IERC20 _stakingToken,
    IERC20 _rewardToken,
    uint256 _startBlock
  ) external onlyOwner {
    campaignInfo.push(
      CampaignInfo({
        stakingToken: _stakingToken,
        rewardToken: _rewardToken,
        startBlock: _startBlock,
        lastRewardBlock: _startBlock,
        accRewardPerShare: 0,
        totalStaked: 0,
        totalRewards: 0
      })
    );
    emit AddCampaignInfo(campaignInfo.length - 1, _stakingToken, _rewardToken, _startBlock);
  }

  /// @notice if the new reward info is added, the reward & its end block will be extended by the newly pushed reward info.
  function addRewardInfo(
    uint256 _campaignID,
    uint256 _endBlock,
    uint256 _rewardPerBlock
  ) external onlyOwner {
    RewardInfo[] storage rewardInfo = campaignRewardInfo[_campaignID];
    CampaignInfo storage campaign = campaignInfo[_campaignID];
    require(rewardInfo.length < rewardInfoLimit, "GrazingRange::addRewardInfo::reward info length exceeds the limit");
    require(
      rewardInfo.length == 0 || rewardInfo[rewardInfo.length - 1].endBlock >= block.number,
      "GrazingRange::addRewardInfo::reward period ended"
    );
    require(
      rewardInfo.length == 0 || rewardInfo[rewardInfo.length - 1].endBlock < _endBlock,
      "GrazingRange::addRewardInfo::bad new endblock"
    );
    uint256 startBlock = rewardInfo.length == 0 ? campaign.startBlock : rewardInfo[rewardInfo.length - 1].endBlock;
    uint256 blockRange = _endBlock.sub(startBlock);
    uint256 totalRewards = _rewardPerBlock.mul(blockRange);
    campaign.rewardToken.safeTransferFrom(rewardHolder, address(this), totalRewards);
    campaign.totalRewards = campaign.totalRewards.add(totalRewards);
    rewardInfo.push(RewardInfo({ endBlock: _endBlock, rewardPerBlock: _rewardPerBlock }));
    emit AddRewardInfo(_campaignID, rewardInfo.length - 1, _endBlock, _rewardPerBlock);
  }

  function rewardInfoLen(uint256 _campaignID) external view returns (uint256) {
    return campaignRewardInfo[_campaignID].length;
  }

  function campaignInfoLen() external view returns (uint256) {
    return campaignInfo.length;
  }

  /// @notice this will return end block based on the current block number.
  function currentEndBlock(uint256 _campaignID) external view returns (uint256) {
    return _endBlockOf(_campaignID, block.number);
  }

  function _endBlockOf(uint256 _campaignID, uint256 _blockNumber) internal view returns (uint256) {
    RewardInfo[] memory rewardInfo = campaignRewardInfo[_campaignID];
    uint256 len = rewardInfo.length;
    if (len == 0) {
      return 0;
    }
    for (uint256 i = 0; i < len; ++i) {
      if (_blockNumber <= rewardInfo[i].endBlock) return rewardInfo[i].endBlock;
    }
    /// @dev when couldn't find any reward info, it means that _blockNumber exceed endblock
    /// so return the latest reward info.
    return rewardInfo[len - 1].endBlock;
  }

  /// @notice this will return reward per block based on the current block number.
  function currentRewardPerBlock(uint256 _campaignID) external view returns (uint256) {
    return _rewardPerBlockOf(_campaignID, block.number);
  }

  function _rewardPerBlockOf(uint256 _campaignID, uint256 _blockNumber) internal view returns (uint256) {
    RewardInfo[] memory rewardInfo = campaignRewardInfo[_campaignID];
    uint256 len = rewardInfo.length;
    if (len == 0) {
      return 0;
    }
    for (uint256 i = 0; i < len; ++i) {
      if (_blockNumber <= rewardInfo[i].endBlock) return rewardInfo[i].rewardPerBlock;
    }
    /// @dev when couldn't find any reward info, it means that timestamp exceed endblock
    /// so return 0
    return 0;
  }

  /// @notice Return reward multiplier over the given _from to _to block.
  function getMultiplier(
    uint256 _from,
    uint256 _to,
    uint256 _endBlock
  ) public pure returns (uint256) {
    if ((_from >= _endBlock) || (_from > _to)) {
      return 0;
    }
    if (_to <= _endBlock) {
      return _to.sub(_from);
    }
    return _endBlock.sub(_from);
  }

  /// @notice View function to see pending Reward on frontend.
  function pendingReward(uint256 _campaignID, address _user) external view returns (uint256) {
    return _pendingReward(_campaignID, userInfo[_campaignID][_user].amount, userInfo[_campaignID][_user].rewardDebt);
  }

  function _pendingReward(
    uint256 _campaignID,
    uint256 _amount,
    uint256 _rewardDebt
  ) internal view returns (uint256) {
    CampaignInfo memory campaign = campaignInfo[_campaignID];
    RewardInfo[] memory rewardInfo = campaignRewardInfo[_campaignID];
    uint256 accRewardPerShare = campaign.accRewardPerShare;
    if (block.number > campaign.lastRewardBlock && campaign.totalStaked != 0) {
      uint256 cursor = campaign.lastRewardBlock;
      for (uint256 i = 0; i < rewardInfo.length; ++i) {
        uint256 multiplier = getMultiplier(cursor, block.number, rewardInfo[i].endBlock);
        if (multiplier == 0) continue;
        cursor = rewardInfo[i].endBlock;
        accRewardPerShare = accRewardPerShare.add(
          multiplier.mul(rewardInfo[i].rewardPerBlock).mul(1e20).div(campaign.totalStaked)
        );
      }
    }
    return _amount.mul(accRewardPerShare).div(1e20).sub(_rewardDebt);
  }

  function updateCampaign(uint256 _campaignID) external nonReentrant {
    _updateCampaign(_campaignID);
  }

  /// @notice Update reward variables of the given campaign to be up-to-date.
  function _updateCampaign(uint256 _campaignID) internal {
    CampaignInfo storage campaign = campaignInfo[_campaignID];
    RewardInfo[] memory rewardInfo = campaignRewardInfo[_campaignID];
    if (block.number <= campaign.lastRewardBlock) {
      return;
    }
    if (campaign.totalStaked == 0) {
      // if there is no total supply, return and use the campaign's start block as the last reward block
      // so that ALL reward will be distributed.
      // however, if the first deposit is out of reward period, last reward block will be its block number
      // in order to keep the multiplier = 0
      if (block.number > _endBlockOf(_campaignID, block.number)) {
        campaign.lastRewardBlock = block.number;
      }
      return;
    }
    /// @dev for each reward info
    for (uint256 i = 0; i < rewardInfo.length; ++i) {
      // @dev get multiplier based on current Block and rewardInfo's end block
      // multiplier will be a range of either (current block - campaign.lastRewardBlock)
      // or (reward info's endblock - campaign.lastRewardBlock) or 0
      uint256 multiplier = getMultiplier(campaign.lastRewardBlock, block.number, rewardInfo[i].endBlock);
      if (multiplier == 0) continue;
      // @dev if currentBlock exceed end block, use end block as the last reward block
      // so that for the next iteration, previous endBlock will be used as the last reward block
      if (block.number > rewardInfo[i].endBlock) {
        campaign.lastRewardBlock = rewardInfo[i].endBlock;
      } else {
        campaign.lastRewardBlock = block.number;
      }
      campaign.accRewardPerShare = campaign.accRewardPerShare.add(
        multiplier.mul(rewardInfo[i].rewardPerBlock).mul(1e20).div(campaign.totalStaked)
      );
    }
  }

  /// @notice Update reward variables for all campaigns. gas spending is HIGH in this method call, BE CAREFUL
  function massUpdateCampaigns() external nonReentrant {
    uint256 length = campaignInfo.length;
    for (uint256 pid = 0; pid < length; ++pid) {
      _updateCampaign(pid);
    }
  }

  /// @notice Stake Staking tokens to GrazingRange
  function deposit(uint256 _campaignID, uint256 _amount) external nonReentrant {
    CampaignInfo storage campaign = campaignInfo[_campaignID];
    UserInfo storage user = userInfo[_campaignID][msg.sender];
    _updateCampaign(_campaignID);
    if (user.amount > 0) {
      uint256 pending = user.amount.mul(campaign.accRewardPerShare).div(1e20).sub(user.rewardDebt);
      if (pending > 0) {
        campaign.rewardToken.safeTransfer(address(msg.sender), pending);
      }
    }
    if (_amount > 0) {
      campaign.stakingToken.safeTransferFrom(address(msg.sender), address(this), _amount);
      user.amount = user.amount.add(_amount);
      campaign.totalStaked = campaign.totalStaked.add(_amount);
    }
    user.rewardDebt = user.amount.mul(campaign.accRewardPerShare).div(1e20);
    emit Deposit(msg.sender, _amount, _campaignID);
  }

  /// @notice Withdraw Staking tokens from STAKING.
  function withdraw(uint256 _campaignID, uint256 _amount) external nonReentrant {
    _withdraw(_campaignID, _amount);
  }

  /// @notice internal method for withdraw (withdraw and harvest method depend on this method)
  function _withdraw(uint256 _campaignID, uint256 _amount) internal {
    CampaignInfo storage campaign = campaignInfo[_campaignID];
    UserInfo storage user = userInfo[_campaignID][msg.sender];
    require(user.amount >= _amount, "GrazingRange::withdraw::bad withdraw amount");
    _updateCampaign(_campaignID);
    uint256 pending = user.amount.mul(campaign.accRewardPerShare).div(1e20).sub(user.rewardDebt);
    if (pending > 0) {
      campaign.rewardToken.safeTransfer(address(msg.sender), pending);
    }
    if (_amount > 0) {
      user.amount = user.amount.sub(_amount);
      campaign.stakingToken.safeTransfer(address(msg.sender), _amount);
      campaign.totalStaked = campaign.totalStaked.sub(_amount);
    }
    user.rewardDebt = user.amount.mul(campaign.accRewardPerShare).div(1e20);

    emit Withdraw(msg.sender, _amount, _campaignID);
  }

  /// @notice method for harvest campaigns (used when the user want to claim their reward token based on specified campaigns)
  function harvest(uint256[] calldata _campaignIDs) external nonReentrant {
    for (uint256 i = 0; i < _campaignIDs.length; ++i) {
      _withdraw(_campaignIDs[i], 0);
    }
  }

  /// @notice Withdraw without caring about rewards. EMERGENCY ONLY.
  function emergencyWithdraw(uint256 _campaignID) external nonReentrant {
    CampaignInfo storage campaign = campaignInfo[_campaignID];
    UserInfo storage user = userInfo[_campaignID][msg.sender];
    uint256 _amount = user.amount;
    campaign.totalStaked = campaign.totalStaked.sub(_amount);
    user.amount = 0;
    user.rewardDebt = 0;
    campaign.stakingToken.safeTransfer(address(msg.sender), _amount);
    emit EmergencyWithdraw(msg.sender, _amount, _campaignID);
  }

  /// @notice Withdraw reward. EMERGENCY ONLY.
  function emergencyRewardWithdraw(
    uint256 _campaignID,
    uint256 _amount,
    address _beneficiary
  ) external onlyOwner nonReentrant {
    CampaignInfo storage campaign = campaignInfo[_campaignID];
    uint256 currentStakingPendingReward = _pendingReward(_campaignID, campaign.totalStaked, 0);
    require(
      currentStakingPendingReward.add(_amount) <= campaign.totalRewards,
      "GrazingRange::emergencyRewardWithdraw::not enough reward token"
    );
    campaign.totalRewards = campaign.totalRewards.sub(_amount);
    campaign.rewardToken.safeTransfer(_beneficiary, _amount);
  }
}
