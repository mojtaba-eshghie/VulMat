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

// File: ../sc_datasets/DAppSCAN/Hacken-Tenderize/tender-core-5b3b625d09e0bc02529946d9f2128af0c08c1a31/contracts/test/MockStaking.sol

// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>

// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract MockStaking {
    IERC20 token;

    uint256 public staked;
    uint256 secondaryRewards;

    struct UnstakeLock {
        uint256 amount;
        address account;
    }

    mapping(uint256 => UnstakeLock) public unstakeLocks;
    uint256 public nextUnstakeLockID;

    mapping(bytes4 => bool) reverts;

    modifier reverted(bytes4 _sel) {
        require(!reverts[_sel]);
        _;
    }

    constructor(IERC20 _token) {
        token = _token;
    }

    function setStaked(uint256 _staked) public {
        staked = _staked;
    }

    function setSecondaryRewards(uint256 _secondaryRewards) public {
        secondaryRewards = _secondaryRewards;
    }

    function setReverts(bytes4 _sel, bool yn) public {
        reverts[_sel] = yn;
    }

    function changePendingUndelegation(uint256 _unstakeLockID, uint256 _newAmount) external {
        unstakeLocks[_unstakeLockID].amount = _newAmount;
    }
}

// File: ../sc_datasets/DAppSCAN/Hacken-Tenderize/tender-core-5b3b625d09e0bc02529946d9f2128af0c08c1a31/contracts/test/MaticMock.sol

pragma solidity 0.8.4;


contract MaticMock is MockStaking {
    uint256 public constant validatorId = 1;
    uint256 public constant exchangeRate = 100;

    constructor(IERC20 _token) MockStaking(_token) {}

    function owner() external view returns (address) {
        return msg.sender;
    }

    function restake() public {
        return;
    }

    function buyVoucher(uint256 _amount, uint256 _minSharesToMint) external reverted(this.buyVoucher.selector) {
        require(token.transferFrom(msg.sender, address(this), _amount));
        staked += _amount;
    }

    function sellVoucher_new(uint256 _claimAmount, uint256 _maximumSharesToBurn)
        external
        reverted(this.sellVoucher_new.selector)
    {
        staked -= _claimAmount;
        unstakeLocks[nextUnstakeLockID] = UnstakeLock({ amount: _claimAmount, account: msg.sender });
        nextUnstakeLockID++;
    }

    function unstakeClaimTokens_new(uint256 _unbondNonce) external reverted(this.unstakeClaimTokens_new.selector) {
        token.transfer(unstakeLocks[_unbondNonce].account, unstakeLocks[_unbondNonce].amount);
    }

    function balanceOf(address _from) external view returns (uint256) {
        return staked;
    }
}
