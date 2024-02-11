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

// File: ../sc_datasets/DAppSCAN/Hacken-Tenderize/tender-core-5b3b625d09e0bc02529946d9f2128af0c08c1a31/contracts/test/GraphMock.sol

// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>

// SPDX-License-Identifier: MIT


pragma solidity 0.8.4;

contract GraphMock is MockStaking {
    uint32 constant MAX_PPM = 1000000;

    constructor(IERC20 _token) MockStaking(_token) {}

    // -- Delegation Data --

    /**
     * @dev Delegation pool information. One per indexer.
     */
    struct DelegationPool {
        uint32 cooldownBlocks; // Blocks to wait before updating parameters
        uint32 indexingRewardCut; // in PPM
        uint32 queryFeeCut; // in PPM
        uint256 updatedAtBlock; // Block when the pool was last updated
        uint256 tokens; // Total tokens as pool reserves
        uint256 shares; // Total shares minted in the pool
        // mapping(address => Delegation) delegators; // Mapping of delegator => Delegation
    }

    /**
     * @dev Individual delegation data of a delegator in a pool.
     */
    struct Delegation {
        uint256 shares; // Shares owned by a delegator in the pool
        uint256 tokensLocked; // Tokens locked for undelegation
        uint256 tokensLockedUntil; // Block when locked tokens can be withdrawn
    }

    function delegate(address _indexer, uint256 _tokens) external reverted(this.delegate.selector) returns (uint256) {
        require(token.transferFrom(msg.sender, address(this), _tokens));
        uint256 add = _tokens - ((_tokens * this.delegationTaxPercentage()) / MAX_PPM);
        staked += add;
        return add;
    }

    function undelegate(address _indexer, uint256 _shares)
        external
        reverted(this.undelegate.selector)
        returns (uint256)
    {
        unstakeLocks[nextUnstakeLockID] = UnstakeLock({ amount: _shares, account: msg.sender });
        staked -= _shares;
    }

    function withdrawDelegated(address _indexer, address _newIndexer)
        external
        reverted(this.withdrawDelegated.selector)
        returns (uint256)
    {
        token.transfer(unstakeLocks[nextUnstakeLockID].account, unstakeLocks[nextUnstakeLockID].amount);
    }

    function getDelegation(address _indexer, address _delegator) external view returns (Delegation memory) {
        return Delegation({ shares: staked, tokensLocked: 0, tokensLockedUntil: 0 });
    }

    function delegationPools(address _indexer) external view returns (DelegationPool memory) {
        return
            DelegationPool({
                tokens: staked,
                cooldownBlocks: 0,
                indexingRewardCut: 0,
                queryFeeCut: 0,
                updatedAtBlock: 0,
                shares: staked
            });
    }

    function getWithdraweableDelegatedTokens(Delegation memory _delegation) external view returns (uint256) {}

    function thawingPeriod() external view returns (uint256) {}

    function delegationTaxPercentage() external view returns (uint32) {
        return 5000;
    }
}
