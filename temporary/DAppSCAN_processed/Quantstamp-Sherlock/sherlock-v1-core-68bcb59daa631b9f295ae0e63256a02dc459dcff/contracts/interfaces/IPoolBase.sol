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

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sherlock/sherlock-v1-core-68bcb59daa631b9f295ae0e63256a02dc459dcff/contracts/interfaces/ILock.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.4;

/******************************************************************************\
* Author: Evert Kors <dev@sherlock.xyz> (https://twitter.com/evert0x)
* Sherlock Protocol: https://sherlock.xyz
/******************************************************************************/

/// @title Lock Token
/// @author Evert Kors
/// @notice Lock tokens represent a stake in Sherlock
interface ILock is IERC20 {
  /// @notice Returns the owner of this contract
  /// @return Owner address
  /// @dev Should be equal to the Sherlock address
  function getOwner() external view returns (address);

  /// @notice Returns token it represents
  /// @return Token address
  function underlying() external view returns (IERC20);

  /// @notice Mint `_amount` tokens for `_account`
  /// @param _account Account to receive tokens
  /// @param _amount Amount to be minted
  function mint(address _account, uint256 _amount) external;

  /// @notice Burn `_amount` tokens for `_account`
  /// @param _account Account to be burned
  /// @param _amount Amount to be burned
  function burn(address _account, uint256 _amount) external;
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

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

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.0;



/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(address from, address to, uint256 amount) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sherlock/sherlock-v1-core-68bcb59daa631b9f295ae0e63256a02dc459dcff/contracts/interfaces/IStrategy.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.4;

/******************************************************************************\
* Author: Evert Kors <dev@sherlock.xyz> (https://twitter.com/evert0x)
* Sherlock Protocol: https://sherlock.xyz
/******************************************************************************/

interface IStrategy {
  function want() external view returns (ERC20);

  function withdrawAll() external returns (uint256);

  function withdraw(uint256 _amount) external;

  function deposit() external;

  function balanceOf() external view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sherlock/sherlock-v1-core-68bcb59daa631b9f295ae0e63256a02dc459dcff/contracts/storage/PoolStorage.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.0;

/******************************************************************************\
* Author: Evert Kors <dev@sherlock.xyz> (https://twitter.com/evert0x)
* Sherlock Protocol: https://sherlock.xyz
/******************************************************************************/


// TokenStorage
library PoolStorage {
  string constant POOL_STORAGE_PREFIX = 'diamond.sherlock.pool.';

  struct Base {
    address govPool;
    //
    // Staking
    //
    bool stakes;
    ILock lockToken;
    uint32 activateCooldownFee;
    uint256 stakeBalance;
    mapping(address => UnstakeEntry[]) unstakeEntries;
    uint256 firstMoneyOut;
    uint256 unallocatedSherX;
    // How much sherX is distributed to stakers of this token
    uint16 sherXWeight;
    uint40 sherXLastAccrued;
    // Non-native variables
    mapping(address => uint256) sWithdrawn;
    uint256 sWeight;
    //
    // Protocol payments
    //
    bool premiums;
    mapping(bytes32 => uint256) protocolBalance;
    mapping(bytes32 => uint256) protocolPremium;
    uint256 totalPremiumPerBlock;
    uint40 totalPremiumLastPaid;
    // How much token (this) is available for sherX holders
    uint256 sherXUnderlying;
    mapping(bytes32 => bool) isProtocol;
    bytes32[] protocols;
    // strategy
    IStrategy strategy;
  }

  struct UnstakeEntry {
    uint40 blockInitiated;
    uint256 lock;
  }

  function ps(IERC20 _token) internal pure returns (Base storage psx) {
    bytes32 position = keccak256(abi.encode(POOL_STORAGE_PREFIX, _token));
    assembly {
      psx.slot := position
    }
  }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sherlock/sherlock-v1-core-68bcb59daa631b9f295ae0e63256a02dc459dcff/contracts/interfaces/IPoolBase.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.4;
pragma abicoder v2;

/******************************************************************************\
* Author: Evert Kors <dev@sherlock.xyz> (https://twitter.com/evert0x)
* Sherlock Protocol: https://sherlock.xyz
/******************************************************************************/

/// @title Sherlock Pool Controller
/// @author Evert Kors
/// @notice This contract is for every token pool
/// @dev Contract is meant to be included as a facet in the diamond
/// @dev Storage library is used
/// @dev Storage pointer is calculated based on last _token argument
interface IPoolBase {
  //
  // Events
  //

  //
  // View methods
  //

  /// @notice Returns the fee used on `_token` cooldown activation
  /// @param _token Token used
  /// @return Cooldown fee scaled by uint32(-1)
  function getCooldownFee(IERC20 _token) external view returns (uint32);

  /// @notice Returns SherX weight for `_token`
  /// @param _token Token used
  /// @return SherX weight scaled by uint16(-1)
  function getSherXWeight(IERC20 _token) external view returns (uint16);

  /// @notice Returns account responsible for `_token`
  /// @param _token Token used
  /// @return Account address
  function getGovPool(IERC20 _token) external view returns (address);

  /// @notice Returns boolean indicating if `_token` can be used for protocol payments
  /// @param _token Token used
  /// @return Premium boolean
  function isPremium(IERC20 _token) external view returns (bool);

  /// @notice Returns boolean indicating if `_token` can be used for staking
  /// @param _token Token used
  /// @return Staking boolean
  function isStake(IERC20 _token) external view returns (bool);

  /// @notice Returns current `_token` balance for `_protocol`
  /// @param _protocol Protocol identifier
  /// @param _token Token used
  /// @return Current balance
  function getProtocolBalance(bytes32 _protocol, IERC20 _token) external view returns (uint256);

  /// @notice Returns current `_token` premium for `_protocol`
  /// @param _protocol Protocol identifier
  /// @param _token Token used
  /// @return Current premium per block
  function getProtocolPremium(bytes32 _protocol, IERC20 _token) external view returns (uint256);

  /// @notice Returns linked lockToken for `_token`
  /// @param _token Token used
  /// @return Address of lockToken
  function getLockToken(IERC20 _token) external view returns (ILock);

  /// @notice Returns if `_protocol` is whitelisted for `_token`
  /// @param _protocol Protocol identifier
  /// @param _token Token used
  /// @return Boolean indicating whitelist status
  function isProtocol(bytes32 _protocol, IERC20 _token) external view returns (bool);

  /// @notice Returns array of whitelisted protcols
  /// @param _token Token used
  /// @return Array protocol identifiers
  function getProtocols(IERC20 _token) external view returns (bytes32[] memory);

  /// @notice Returns `_token` untake entry for `_staker` with id `_id`
  /// @param _staker Account that started unstake process
  /// @param _id ID of unstaking entry
  /// @param _token Token used
  /// @return Unstaking entry
  function getUnstakeEntry(
    address _staker,
    uint256 _id,
    IERC20 _token
  ) external view returns (PoolStorage.UnstakeEntry memory);

  /// @notice Return total debt in  `_token` whitelisted protocols accrued
  /// @param _token Token used
  /// @return Total accrued debt
  function getTotalAccruedDebt(IERC20 _token) external view returns (uint256);

  /// @notice Return current size of first money out pool
  /// @param _token Token used
  /// @return First money out size
  function getFirstMoneyOut(IERC20 _token) external view returns (uint256);

  /// @notice Return debt in  `_token` `_protocol` accrued
  /// @param _protocol Protocol identifier
  /// @param _token Token used
  /// @return Accrued debt
  function getAccruedDebt(bytes32 _protocol, IERC20 _token) external view returns (uint256);

  /// @notice Return total premium per block that whitelisted protocols are accrueing as debt
  /// @param _token Token used
  /// @return Total amount of premium
  function getTotalPremiumPerBlock(IERC20 _token) external view returns (uint256);

  /// @notice Returns block debt was last accrued.
  /// @param _token Token used
  /// @return Block number
  function getPremiumLastPaid(IERC20 _token) external view returns (uint40);

  /// @notice Return total amount of `_token` used as underlying for SHERX
  /// @param _token Token used
  /// @return Amount used as underlying
  function getSherXUnderlying(IERC20 _token) external view returns (uint256);

  /// @notice Return total amount of `_staker` unstaking entries for `_token`
  /// @param _staker Account used
  /// @param _token Token used
  /// @return Amount of entries
  function getUnstakeEntrySize(address _staker, IERC20 _token) external view returns (uint256);

  /// @notice Returns initial active unstaking enty for `_staker`
  /// @param _staker Account used
  /// @param _token Token used
  /// @return Initial ID of unstaking entry
  function getInitialUnstakeEntry(address _staker, IERC20 _token) external view returns (uint256);

  /// @notice Returns amount staked in `_token` that is not included in a yield strategy
  /// @param _token Token used
  /// @return Amount staked
  function getUnactivatedStakersPoolBalance(IERC20 _token) external view returns (uint256);

  /// @notice Returns amount staked in `_token` including yield strategy
  /// @param _token Token used
  /// @return Amount staked
  function getStakersPoolBalance(IERC20 _token) external view returns (uint256);

  /// @notice Returns `_staker` amount staked in `_token`
  /// @param _staker Account used
  /// @param _token Token used
  /// @return Amount staked
  function getStakerPoolBalance(address _staker, IERC20 _token) external view returns (uint256);

  /// @notice Returns unminted SHERX for `_token`
  /// @param _token Token used
  /// @return Unminted SHERX
  function getTotalUnmintedSherX(IERC20 _token) external view returns (uint256);

  /// @notice Returns stored amount of SHERX not allocated to stakers
  /// @param _token Token used
  /// @return Unallocated amount of SHERX
  function getUnallocatedSherXStored(IERC20 _token) external view returns (uint256);

  /// @notice Returns current amount of SHERX not allocated to stakers
  /// @param _token Token used
  /// @return Unallocated amount of SHERX
  function getUnallocatedSherXTotal(IERC20 _token) external view returns (uint256);

  /// @notice Returns current amount of SHERX not allocated to `_user`
  /// @param _user Staker in token
  /// @param _token Token used
  /// @return Unallocated amount of SHERX
  function getUnallocatedSherXFor(address _user, IERC20 _token) external view returns (uint256);

  /// @notice Returns SHERX distributed to `_token` stakers per block
  /// @param _token Token used
  /// @return Amount of SHERX distributed
  function getTotalSherXPerBlock(IERC20 _token) external view returns (uint256);

  /// @notice Returns SHERX distributed per block to sender for staking in `_token`
  /// @param _token Token used
  /// @return Amount of SHERX distributed
  function getSherXPerBlock(IERC20 _token) external view returns (uint256);

  /// @notice Returns SHERX distributed per block to `_user` for staking in `_token`
  /// @param _user Account used
  /// @param _token Token used
  /// @return Amount of SHERX distributed
  function getSherXPerBlock(address _user, IERC20 _token) external view returns (uint256);

  /// @notice Returns SHERX distributed per block when staking `_amount` of `_token`
  /// @param _amount Amount of tokens
  /// @param _token Token used
  /// @return SHERX to be distrubuted if staked
  function getSherXPerBlock(uint256 _amount, IERC20 _token) external view returns (uint256);

  /// @notice Returns block SHERX was last accrued to `_token`
  /// @param _token Token used
  /// @return Block last accrued
  function getSherXLastAccrued(IERC20 _token) external view returns (uint40);

  /// @notice Current exchange rate from lockToken to `_token`
  /// @param _token Token used
  /// @return Current exchange rate
  function LockToTokenXRate(IERC20 _token) external view returns (uint256);

  /// @notice Current exchange rate from lockToken to `_token` using `_amount`
  /// @param _amount Amount to be exchanged
  /// @param _token Token used
  /// @return Current exchange rate
  function LockToToken(uint256 _amount, IERC20 _token) external view returns (uint256);

  /// @notice Current exchange rate from `_token` to lockToken
  /// @param _token Token used
  /// @return Current exchange rate
  function TokenToLockXRate(IERC20 _token) external view returns (uint256);

  /// @notice Current exchange rate from `_token` to lockToken using `_amount`
  /// @param _amount Amount to be exchanged
  /// @param _token Token used
  /// @return Current exchange rate
  function TokenToLock(uint256 _amount, IERC20 _token) external view returns (uint256);

  //
  // State changing methods
  //

  /// @notice Set `_fee` used for activating cooldowns on `_token`
  /// @param _fee Fee scaled by uint32(-1)
  /// @param _token Token used
  function setCooldownFee(uint32 _fee, IERC20 _token) external;

  /// @notice Deposit `_amount` of `_token` on behalf of `_protocol`
  /// @param _protocol Protocol identifier
  /// @param _amount Amount of tokens
  /// @param _token Token used
  function depositProtocolBalance(
    bytes32 _protocol,
    uint256 _amount,
    IERC20 _token
  ) external;

  /// @notice Withdraw `_amount` of `_token` on behalf of `_protocol` to `_receiver`
  /// @param _protocol Protocol identifier
  /// @param _amount Amount of tokens
  /// @param _receiver Address receiving the amount
  /// @param _token Token used
  function withdrawProtocolBalance(
    bytes32 _protocol,
    uint256 _amount,
    address _receiver,
    IERC20 _token
  ) external;

  /// @notice Start unstaking flow for sender with `_amount` of lockTokens
  /// @param _amount Amount of lockTokens
  /// @param _token Token used
  /// @return ID of unstaking entry
  /// @dev e.g. _token is DAI, _amount is amount of lockDAI
  function activateCooldown(uint256 _amount, IERC20 _token) external returns (uint256);

  /// @notice Cancel unstaking `_token` with entry `_id` for sender
  /// @param _id ID of unstaking entry
  /// @param _token Token used
  function cancelCooldown(uint256 _id, IERC20 _token) external;

  /// @notice Returns lockTokens to _account if unstaking entry _id is expired
  /// @param _account Account that initiated unstaking flow
  /// @param _id ID of unstaking entry
  /// @param _token Token used
  function unstakeWindowExpiry(
    address _account,
    uint256 _id,
    IERC20 _token
  ) external;

  /// @notice Unstake _token for sender with entry _id, send to _receiver
  /// @param _id ID of unstaking entry
  /// @param _receiver Account receiving the tokens
  /// @param _token Token used
  /// @return amount of tokens unstaked
  function unstake(
    uint256 _id,
    address _receiver,
    IERC20 _token
  ) external returns (uint256 amount);

  /// @notice Pay off accrued debt of whitelisted protocols
  /// @param _token Token used
  function payOffDebtAll(IERC20 _token) external;

  /// @notice Remove `_protocol` from `_token` whitelist, send remaining balance to `_receiver`
  /// @param _protocol Protocol indetifier
  /// @param _index Entry of protocol in storage array
  /// @param _forceDebt If protocol has outstanding debt, pay off
  /// @param _receiver Receiver of remaining deposited balance
  /// @param _token Token used
  function cleanProtocol(
    bytes32 _protocol,
    uint256 _index,
    bool _forceDebt,
    address _receiver,
    IERC20 _token
  ) external;
}
