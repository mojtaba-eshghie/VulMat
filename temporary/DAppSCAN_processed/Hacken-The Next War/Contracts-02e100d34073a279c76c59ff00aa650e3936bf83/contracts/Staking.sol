// File: @openzeppelin/contracts/utils/Context.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (access/Ownable.sol)

pragma solidity ^0.8.0;

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
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts/utils/math/SafeMath.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (utils/math/SafeMath.sol)

pragma solidity ^0.8.0;

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
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

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

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
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Hacken-The Next War/Contracts-02e100d34073a279c76c59ff00aa650e3936bf83/contracts/Staking.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;



contract Staking is Ownable {

    /// @notice Info of each MC user.
    /// `amount` LP token amount the user has provided.
    /// `rewardDebt` The amount of TNG entitled to the user.
    struct UserInfo {
        uint256 totalAmount;
        uint256 rewardDebt;
        uint256 lastClaimTime;
        uint256 stakeRecords;
    }

    // Store all user stake records
    struct UserStakeInfo {
        uint256 amount;
        uint256 stakedTime;
        uint256 unstakedTime;
        uint256 unlockTime;
    }

    // Info of each user that stakes.
    mapping (address => UserInfo) public userInfo;
    // Info of each user staking records
    mapping (uint256 => mapping (address => UserStakeInfo)) public userStakeInfo;

    IERC20 public tngToken;
    IERC20 public lpToken;
    uint256 public accTngPerShare;
    uint256 public lastRewardTime = block.timestamp;
    uint256 public lockTime;    // lock time in seconds
    uint256 public tngPerSecond = 578700000000000000;   //Initial rewards per seconds = 50000/86400
    uint256 public lpTokenDeposited;
    uint256 public pendingTngRewards;
    uint256 public emergencyWithdrawalFee = 10; // Early withdrawal will incur 10% fee, fee will be stored in contract

    uint256 private constant ACC_TNG_PRECISION = 1e12;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 sid, uint256 amount);
    event EmergencyWithdraw(address indexed user, uint256 sid, uint256 amount);
    event Harvest(address indexed user, uint256 amount);
    event SetTngPerSecond(uint256 tngPerSecond);
    event SetLockTime(uint256 epoch);
    event SetEmergencyWithdrawalFee(uint256 _emergencyWithdrawalFee);

    constructor(IERC20 _tngToken, IERC20 _lpToken, uint256 _lockTime) {
        tngToken = _tngToken;
        lpToken = _lpToken;
        lockTime = _lockTime;
    }

    function deposit(uint256 _amount) external {
        // Refresh rewards
        updatePool();

        UserInfo storage user = userInfo[msg.sender];
        UserStakeInfo storage stakeInfo = userStakeInfo[user.stakeRecords][msg.sender];
        require(lpToken.balanceOf(msg.sender) >= _amount, "Insufficient tokens");

        // set user info
        user.totalAmount += _amount;
        user.rewardDebt = user.rewardDebt + (_amount * accTngPerShare / ACC_TNG_PRECISION);
        user.stakeRecords++;

        // set staking info
        stakeInfo.amount = _amount;
        stakeInfo.stakedTime = block.timestamp;
        stakeInfo.unlockTime = block.timestamp + lockTime;

        // Tracking
        lpTokenDeposited = lpTokenDeposited + _amount;

        // Transfer token into the contract
        bool status = lpToken.transferFrom(msg.sender, address(this), _amount);
        require(status, "Deposit failed");

        emit Deposit(msg.sender, _amount);
    }

    function harvest() external {
        // Refresh rewards
        updatePool();

        UserInfo storage user = userInfo[msg.sender];
        uint256 accumulatedTng = user.totalAmount * accTngPerShare / ACC_TNG_PRECISION;
        uint256 _pendingTng = accumulatedTng - user.rewardDebt;
        require(_pendingTng > 0, "No pending rewards");
        require(tngToken.balanceOf(address(this)) >= _pendingTng, "Insufficient TNG tokens in contract");

        // user info
        user.rewardDebt = accumulatedTng;
        user.lastClaimTime = block.timestamp;

        // Transfer pending rewards if there is any
        payTngReward(_pendingTng, msg.sender);

        emit Harvest(msg.sender, _pendingTng);
    }

    /// @notice Withdraw LP tokens from MC and harvest proceeds for transaction sender to `to`.
    /// @param _sid The index of the staking record
    function withdraw(uint256 _sid) external {
        // Refresh rewards
        updatePool();

        UserInfo storage user = userInfo[msg.sender];
        UserStakeInfo storage stakeInfo = userStakeInfo[_sid][msg.sender];

        uint256 _amount = stakeInfo.amount;
        require(_amount > 0, "No stakes found");
        require(block.timestamp >= stakeInfo.unlockTime, "Lock period not ended");
        require(lpToken.balanceOf(address(this)) >= _amount, "Insufficient tokens in contract, please contact admin");

        uint256 accumulatedTng = user.totalAmount * accTngPerShare / ACC_TNG_PRECISION;
        uint256 _pendingTng = accumulatedTng - user.rewardDebt;

        // user info
        user.rewardDebt = accumulatedTng - (_amount * accTngPerShare / ACC_TNG_PRECISION);
        user.totalAmount -= _amount;

        // Stake info
        stakeInfo.amount = 0;
        stakeInfo.unstakedTime = block.timestamp;

        // Tracking
        lpTokenDeposited -= _amount;

        // Transfer tokens to user
        bool status = lpToken.transfer(msg.sender, _amount);
        require(status, "Failed to withdraw");

        // Transfer pending rewards if there is any
        if (_pendingTng != 0) {
            user.lastClaimTime = block.timestamp;
            payTngReward(_pendingTng, msg.sender);
        }

        emit Withdraw(msg.sender, _sid, _amount);
    }

    function emergencyWithdraw(uint256 _sid) external {
        UserInfo storage user = userInfo[msg.sender];
        UserStakeInfo storage stakeInfo = userStakeInfo[_sid][msg.sender];

        uint256 _amount = stakeInfo.amount;
        require(_amount > 0, "No stakes found");

        // user info
        user.totalAmount -= _amount;

        // Stake info
        stakeInfo.amount = 0;
        stakeInfo.unstakedTime = block.timestamp;

        // Tracking
        lpTokenDeposited -= _amount;

        // Early emergency withdrawal will incur penalty
        if(block.timestamp < stakeInfo.unlockTime) {
            _amount = _amount * (100 - emergencyWithdrawalFee) / 100;
        }

        // Transfer tokens to user
        bool status = lpToken.transfer(msg.sender, _amount);
        require(status, "Failed to withdraw");

        emit EmergencyWithdraw(msg.sender, _sid, _amount);
    }

    function pendingTng(address _user) external view returns (uint256 pending) {
        UserInfo storage user = userInfo[_user];
        uint256 _accTngPerShare = accTngPerShare;

        if (block.timestamp > lastRewardTime && lpTokenDeposited != 0) {
            uint256 time = block.timestamp - lastRewardTime;
            uint256 tngReward = getTngRewardForTime(time);
            
            _accTngPerShare = accTngPerShare + (tngReward * ACC_TNG_PRECISION / lpTokenDeposited);
        }
        pending = (user.totalAmount * _accTngPerShare / ACC_TNG_PRECISION) - user.rewardDebt;
    }

    function updatePool() public {
 
        if (block.timestamp > lastRewardTime) {

            if (lpTokenDeposited > 0) {
                uint256 time = block.timestamp - lastRewardTime;
                uint256 tngReward = getTngRewardForTime(time);

                trackPendingTngReward(tngReward);
                accTngPerShare = accTngPerShare + (tngReward * ACC_TNG_PRECISION / lpTokenDeposited);
            }

            lastRewardTime = block.timestamp;
        }
    }

    function payTngReward(uint256 _pendingTng, address _to) internal {
        pendingTngRewards = pendingTngRewards - _pendingTng;

        bool status = tngToken.transfer(_to, _pendingTng);
        require(status, "Failed to harvest");
    }

    function getTngRewardForTime(uint256 _time) public view returns (uint256) {
        uint256 tngReward = _time * tngPerSecond;

        return tngReward;
    }

    function trackPendingTngReward(uint256 _amount) internal {
        pendingTngRewards = pendingTngRewards + _amount;
    }

    function setLockTime(uint256 _epoch) external onlyOwner {
        lockTime = _epoch;

        emit SetLockTime(_epoch);
    }

    function setTngPerSecond(uint256 _tngPerSecond) external onlyOwner {
        tngPerSecond = _tngPerSecond;

        emit SetTngPerSecond(_tngPerSecond);
    }
    
    function setEmergencyWithdrawalFee(uint256 _emergencyWithdrawalFee) external onlyOwner {
        require(_emergencyWithdrawalFee <= 20, "Exceeded allowed threshold");
        emergencyWithdrawalFee = _emergencyWithdrawalFee;

        emit SetEmergencyWithdrawalFee(_emergencyWithdrawalFee);
    }
}
