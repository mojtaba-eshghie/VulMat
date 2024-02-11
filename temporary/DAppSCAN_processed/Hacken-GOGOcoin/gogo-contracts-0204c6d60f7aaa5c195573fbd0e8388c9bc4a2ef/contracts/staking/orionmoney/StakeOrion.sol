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

// File: ../sc_datasets/DAppSCAN/Hacken-GOGOcoin/gogo-contracts-0204c6d60f7aaa5c195573fbd0e8388c9bc4a2ef/contracts/staking/orionmoney/ISaver.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

interface ISaver {
    function balanceOf(IERC20 token, address user)
        external
        view
        returns (
            uint256 original_amount,
            uint256 orioned_amount,
            uint256 current_amount
        );

    function getDepositLimit() external view returns (uint256);

    function getLocalDepositLimit() external view returns (uint256);

    function deposit(IERC20 token, uint256 amount) external;

    function depositLocal(IERC20 token, uint256 amount) external;

    function canDepositLocal(IERC20 token, uint256 amount)
        external
        view
        returns (bool);

    function getWithdrawLimit() external view returns (uint256);

    function getLocalWithdrawLimit() external view returns (uint256);

    function withdraw(IERC20 token, uint256 requested_amount) external;

    function withdrawLocal(IERC20 token, uint256 requested_amount) external;

    function canWithdrawLocal(IERC20 token, uint256 amount)
        external
        view
        returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Hacken-GOGOcoin/gogo-contracts-0204c6d60f7aaa5c195573fbd0e8388c9bc4a2ef/contracts/staking/orionmoney/StakeOrion.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface SOManager {
    function feeReceiver() external view returns (address);

    function rewardFee() external view returns (uint256);

    function owner() external view returns (address);
}

contract StakeOrion {
    uint256 MAX_INT = 2**256 - 1;

    IERC20 public stakingToken;
    ISaver public orion;
    address public creator;
    address public manager;
    uint256 public multiplier;
    bool public pending = false;
    uint256 public pendingAmount;
    uint256 public pendingFee;

    constructor(
        address _stakingToken,
        uint256 _decimals,
        address _orion,
        address _creator
    ) {
        stakingToken = IERC20(_stakingToken);
        multiplier = 10**_decimals;
        orion = ISaver(_orion);
        creator = _creator;
        manager = msg.sender;
    }

    modifier onlyCreator() {
        require(msg.sender == creator, "restricted to contract creator");
        _;
    }

    modifier onlyManager() {
        require(msg.sender == manager, "restricted to factory contract");
        _;
    }

    modifier onlyOwner() {
        require(
            msg.sender == SOManager(manager).owner(),
            "restricted to creator of the factory contract"
        );
        _;
    }

    function deposit(uint256 amount) external onlyManager returns (uint256) {
        stakingToken.approve(address(orion), amount);

        if (orion.canDepositLocal(stakingToken, amount)) {
            if (
                orion.getLocalDepositLimit() == MAX_INT ||
                // to prevent overflow by multiply max_int (returned by getLocalDepositLimit) with decimals in next line
                amount <= (orion.getLocalDepositLimit() * multiplier)
            ) {
                _depositLocal(amount);
            } else {
                _depositExt(amount);
            }
        } else {
            _depositExt(amount);
        }

        return amount;
    }

    function _depositLocal(uint256 amount) internal {
        orion.depositLocal(stakingToken, amount);
        emit Deposited(creator, address(stakingToken), amount);
    }

    function _depositExt(uint256 amount) internal {
        if (amount <= orion.getDepositLimit() * multiplier) {
            orion.deposit(stakingToken, amount);
            emit Deposited(creator, address(stakingToken), amount);
        } else {
            revert("not able to deposit");
        }
    }

    // if returned value > 0: amount is pending and has to be withdrawn later
    function withdraw(uint256 amount) external onlyManager returns (uint256) {
        return _withdraw(amount);
    }

    function _interest() internal view returns (uint256) {
        (uint256 balance, , uint256 current) = orion.balanceOf(
            stakingToken,
            address(this)
        );
        if (current <= balance) return 0;
        return current - balance;
    }

    // if returned value > 0: amount is pending and has to be withdrawn later
    function getReward() external onlyManager returns (uint256) {
        uint256 interest = _interest();
        uint256 fee = _fee(interest);

        if (
            orion.canWithdrawLocal(stakingToken, interest) &&
            interest <= orion.getLocalWithdrawLimit() * multiplier
        ) {
            _withdrawLocal(interest);
            stakingToken.transfer(creator, interest - fee);
            emit Withdrawn(
                creator,
                address(stakingToken),
                interest - fee,
                false
            );
            emit RewardPaid(creator, address(stakingToken), interest - fee);
            if (fee > 0) {
                address feeReceiver = SOManager(manager).feeReceiver();
                stakingToken.transfer(feeReceiver, fee);
                emit FeesCollected(feeReceiver, address(stakingToken), fee);
            }
        } else {
            pendingFee = fee;
            pendingAmount = _withdrawExt(interest) - pendingFee;
            emit Withdrawn(creator, address(stakingToken), pendingAmount, true);
            emit RewardPaid(creator, address(stakingToken), pendingAmount);
        }

        return pendingAmount;
    }

    function _withdraw(uint256 amount) internal returns (uint256) {
        uint256 fee = 0;
        uint256 toWithdraw = amount;

        uint256 interest;

        if (amount == getStakedBalance()) {
            (, , uint256 current) = orion.balanceOf(
                stakingToken,
                address(this)
            );
            interest = _interest();
            fee = _fee(interest);
            toWithdraw = current;
        }
        if (
            orion.canWithdrawLocal(stakingToken, toWithdraw) &&
            toWithdraw <= orion.getLocalWithdrawLimit() * multiplier
        ) {
            _withdrawLocal(toWithdraw);
            stakingToken.transfer(creator, toWithdraw - fee);
            emit Withdrawn(
                creator,
                address(stakingToken),
                toWithdraw - fee,
                false
            );
            emit RewardPaid(creator, address(stakingToken), interest - fee);
            if (fee > 0) {
                address feeReceiver = SOManager(manager).feeReceiver();
                stakingToken.transfer(feeReceiver, fee);
                emit FeesCollected(feeReceiver, address(stakingToken), fee);
            }
        } else {
            pendingFee = fee;
            pendingAmount = _withdrawExt(toWithdraw) - pendingFee;
            emit Withdrawn(creator, address(stakingToken), pendingAmount, true);
            emit RewardPaid(creator, address(stakingToken), interest - fee);
        }
        return pendingAmount;
    }

    function _withdrawExt(uint256 amount) internal returns (uint256) {
        if (amount <= (orion.getWithdrawLimit() * multiplier) && !pending) {
            orion.withdraw(stakingToken, amount);
            pending = true;
            return amount;
        } else {
            revert("not able to withdraw");
        }
    }

    function _withdrawLocal(uint256 amount) internal {
        orion.withdrawLocal(stakingToken, amount);
    }

    function withdrawPending() external {
        require(
            stakingToken.balanceOf((address(this))) > 0,
            "no pending amount"
        );
        require(
            msg.sender == manager || msg.sender == creator,
            "sender is not allowed to withdraw"
        );

        pending = false;
        if (pendingFee > 0) {
            address feeReceiver = SOManager(manager).feeReceiver();
            stakingToken.transfer(feeReceiver, pendingFee);
            emit FeesCollected(feeReceiver, address(stakingToken), pendingFee);
            pendingFee = 0;
        }
        pendingAmount = 0;
        uint256 leftAmount = stakingToken.balanceOf(address(this));
        stakingToken.transfer(creator, leftAmount);
        emit PendingWithdrawn(creator, address(stakingToken), leftAmount);
    }

    /* ========== VIEWS ========== */

    function _fee(uint256 reward) internal view returns (uint256) {
        uint256 rewardFee = SOManager(manager).rewardFee();
        if (reward == 0 || rewardFee == 0) return 0;
        return (reward * rewardFee) / 100;
    }

    function getContractBalance() external view returns (uint256) {
        uint256 balance = stakingToken.balanceOf(address(this));
        if (balance < pendingFee) {
            return 0;
        }
        return stakingToken.balanceOf(address(this)) - pendingFee;
    }

    function getStakedBalance() public view returns (uint256) {
        uint256 balance;
        (balance, , ) = orion.balanceOf(stakingToken, address(this));
        return balance;
    }

    function earned() public view returns (uint256) {
        uint256 interest = _interest();
        return interest - _fee(interest);
    }

    /* ========== ADMIN ========== */

    function recoverERC20(address tokenAddress, uint256 tokenAmount)
        external
        onlyOwner
    {
        require(
            tokenAddress != address(stakingToken),
            "cannot withdraw the staking token"
        );
        IERC20(tokenAddress).transfer(SOManager(manager).owner(), tokenAmount);
        emit Recovered(tokenAddress, tokenAmount);
    }

    /* ========== EVENTS ========== */

    event Deposited(address indexed user, address asset, uint256 amount);
    event Withdrawn(
        address indexed user,
        address asset,
        uint256 amount,
        bool asyncType
    );
    event PendingWithdrawn(address indexed user, address asset, uint256 amount);
    event FeesCollected(
        address indexed feeReceiver,
        address asset,
        uint256 amount
    );
    event RewardPaid(address indexed user, address asset, uint256 reward);
    event Recovered(address token, uint256 amount);
}
