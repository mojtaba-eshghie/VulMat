// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Math/SafeMath.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;

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
     *
     * _Available since v2.4.0._
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
     *
     * _Available since v2.4.0._
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
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Common/Context.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;

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
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/ERC20/IERC20.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;


/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {ERC20Detailed}.
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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Utils/Address.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11 <0.9.0;

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
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
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

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/ERC20/ERC20.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;




/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20Mintable}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
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
 
contract ERC20 is Context, IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    /**
     * @dev Sets the values for {name} and {symbol}, initializes {decimals} with
     * a default value of 18.
     *
     * To select a different value for {decimals}, use {_setupDecimals}.
     *
     * All three of these values are immutable: they can only be set once during
     * construction.
     */
    constructor (string memory __name, string memory __symbol) public {
        _name = __name;
        _symbol = __symbol;
        _decimals = 18;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless {_setupDecimals} is
     * called.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
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
     * Requirements:
     *
     * - `spender` cannot be the zero address.approve(address spender, uint256 amount)
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for `sender`'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
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
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
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
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, deducting from the caller's
     * allowance.
     *
     * See {ERC20-_burn} and {ERC20-allowance}.
     *
     * Requirements:
     *
     * - the caller must have allowance for `accounts`'s tokens of at least
     * `amount`.
     */
    function burnFrom(address account, uint256 amount) public virtual {
        uint256 decreasedAllowance = allowance(account, _msgSender()).sub(amount, "ERC20: burn amount exceeds allowance");

        _approve(account, _msgSender(), decreasedAllowance);
        _burn(account, amount);
    }


    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
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
     * @dev Destroys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     *
     * See {_burn} and {_approve}.
     */
    function _burnFrom(address account, uint256 amount) internal virtual {
        _burn(account, amount);
        _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "ERC20: burn amount exceeds allowance"));
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of `from`'s tokens
     * will be to transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of `from`'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:using-hooks.adoc[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/ERC20/Variants/Comp.sol

// SPDX-License-Identifier: MIT
/**
 *Submitted for verification at Etherscan.io on 2020-03-04
*/
pragma solidity >=0.6.11;

contract Comp {
    // EIP-20 token name for this token
    string public constant name = "Compound";

    // EIP-20 token symbol for this token
    string public constant symbol = "COMP";

    // EIP-20 token decimals for this token
    uint8 public constant decimals = 18;

    // Total number of tokens in circulation
    uint public constant totalSupply = 10000000e18; // 10 million Comp

    // Allowance amounts on behalf of others
    mapping (address => mapping (address => uint96)) internal allowances;

    // Official record of token balances for each account
    mapping (address => uint96) internal balances;

    // A record of each accounts delegate
    mapping (address => address) public delegates;

    // A checkpoint for marking number of votes from a given block
    struct Checkpoint {
        uint32 fromBlock;
        uint96 votes;
    }

    // A record of votes checkpoints for each account, by index
    mapping (address => mapping (uint32 => Checkpoint)) public checkpoints;

    // The number of checkpoints for each account
    mapping (address => uint32) public numCheckpoints;

    // The EIP-712 typehash for the contract's domain
    bytes32 public constant DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,uint256 chainId,address verifyingContract)");

    // The EIP-712 typehash for the delegation struct used by the contract
    bytes32 public constant DELEGATION_TYPEHASH = keccak256("Delegation(address delegatee,uint256 nonce,uint256 expiry)");

    // A record of states for signing / validating signatures
    mapping (address => uint) public nonces;

    // An event thats emitted when an account changes its delegate
    event DelegateChanged(address indexed delegator, address indexed fromDelegate, address indexed toDelegate);

    // An event thats emitted when a delegate account's vote balance changes
    event DelegateVotesChanged(address indexed delegate, uint previousBalance, uint newBalance);

    // The standard EIP-20 transfer event
    event Transfer(address indexed from, address indexed to, uint256 amount);

    // The standard EIP-20 approval event
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    /**
     * @notice Construct a new Comp token
     * @param account The initial account to grant all the tokens
     */
    constructor (address account) public {
        balances[account] = uint96(totalSupply);
        emit Transfer(address(0), account, totalSupply);
    }

    /**
     * @notice Get the number of tokens `spender` is approved to spend on behalf of `account`
     * @param account The address of the account holding the funds
     * @param spender The address of the account spending the funds
     * @return The number of tokens approved
     */
    function allowance(address account, address spender) external view returns (uint) {
        return allowances[account][spender];
    }

    /**
     * @notice Approve `spender` to transfer up to `amount` from `src`
     * @dev This will overwrite the approval amount for `spender`
     *  and is subject to issues noted [here](https://eips.ethereum.org/EIPS/eip-20#approve)
     * @param spender The address of the account which may transfer tokens
     * @param rawAmount The number of tokens that are approved (2^256-1 means infinite)
     * @return Whether or not the approval succeeded
     */
    function approve(address spender, uint rawAmount) external returns (bool) {
        uint96 amount;
        if (rawAmount == type(uint).max) {
            amount = type(uint96).max;
        } else {
            amount = safe96(rawAmount, "Comp::approve: amount exceeds 96 bits");
        }

        allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * @notice Get the number of tokens held by the `account`
     * @param account The address of the account to get the balance of
     * @return The number of tokens held
     */
    function balanceOf(address account) external view returns (uint) {
        return balances[account];
    }

    /**
     * @notice Transfer `amount` tokens from `msg.sender` to `dst`
     * @param dst The address of the destination account
     * @param rawAmount The number of tokens to transfer
     * @return Whether or not the transfer succeeded
     */
    function transfer(address dst, uint rawAmount) external returns (bool) {
        uint96 amount = safe96(rawAmount, "Comp::transfer: amount exceeds 96 bits");
        _transferTokens(msg.sender, dst, amount);
        return true;
    }

    /**
     * @notice Transfer `amount` tokens from `src` to `dst`
     * @param src The address of the source account
     * @param dst The address of the destination account
     * @param rawAmount The number of tokens to transfer
     * @return Whether or not the transfer succeeded
     */
    function transferFrom(address src, address dst, uint rawAmount) external returns (bool) {
        address spender = msg.sender;
        uint96 spenderAllowance = allowances[src][spender];
        uint96 amount = safe96(rawAmount, "Comp::approve: amount exceeds 96 bits");

        if (spender != src && spenderAllowance != type(uint96).max) {
            uint96 newAllowance = sub96(spenderAllowance, amount, "Comp::transferFrom: transfer amount exceeds spender allowance");
            allowances[src][spender] = newAllowance;

            emit Approval(src, spender, newAllowance);
        }

        _transferTokens(src, dst, amount);
        return true;
    }

    /**
     * @notice Delegate votes from `msg.sender` to `delegatee`
     * @param delegatee The address to delegate votes to
     */
    function delegate(address delegatee) public {
        return _delegate(msg.sender, delegatee);
    }

    /**
     * @notice Delegates votes from signatory to `delegatee`
     * @param delegatee The address to delegate votes to
     * @param nonce The contract state required to match the signature
     * @param expiry The time at which to expire the signature
     * @param v The recovery byte of the signature
     * @param r Half of the ECDSA signature pair
     * @param s Half of the ECDSA signature pair
     */
    function delegateBySig(address delegatee, uint nonce, uint expiry, uint8 v, bytes32 r, bytes32 s) public {
        bytes32 domainSeparator = keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name)), getChainId(), address(this)));
        bytes32 structHash = keccak256(abi.encode(DELEGATION_TYPEHASH, delegatee, nonce, expiry));
        bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
        address signatory = ecrecover(digest, v, r, s);
        require(signatory != address(0), "Comp::delegateBySig: invalid signature");
        require(nonce == nonces[signatory]++, "Comp::delegateBySig: invalid nonce");
        require(block.timestamp <= expiry, "Comp::delegateBySig: signature expired");
        return _delegate(signatory, delegatee);
    }

    /**
     * @notice Gets the current votes balance for `account`
     * @param account The address to get votes balance
     * @return The number of current votes for `account`
     */
    function getCurrentVotes(address account) external view returns (uint96) {
        uint32 nCheckpoints = numCheckpoints[account];
        return nCheckpoints > 0 ? checkpoints[account][nCheckpoints - 1].votes : 0;
    }

    /**
     * @notice Determine the prior number of votes for an account as of a block number
     * @dev Block number must be a finalized block or else this function will revert to prevent misinformation.
     * @param account The address of the account to check
     * @param blockNumber The block number to get the vote balance at
     * @return The number of votes the account had as of the given block
     */
    function getPriorVotes(address account, uint blockNumber) public view returns (uint96) {
        require(blockNumber < block.number, "Comp::getPriorVotes: not yet determined");

        uint32 nCheckpoints = numCheckpoints[account];
        if (nCheckpoints == 0) {
            return 0;
        }

        // First check most recent balance
        if (checkpoints[account][nCheckpoints - 1].fromBlock <= blockNumber) {
            return checkpoints[account][nCheckpoints - 1].votes;
        }

        // Next check implicit zero balance
        if (checkpoints[account][0].fromBlock > blockNumber) {
            return 0;
        }

        uint32 lower = 0;
        uint32 upper = nCheckpoints - 1;
        while (upper > lower) {
            uint32 center = upper - (upper - lower) / 2; // ceil, avoiding overflow
            Checkpoint memory cp = checkpoints[account][center];
            if (cp.fromBlock == blockNumber) {
                return cp.votes;
            } else if (cp.fromBlock < blockNumber) {
                lower = center;
            } else {
                upper = center - 1;
            }
        }
        return checkpoints[account][lower].votes;
    }

    function _delegate(address delegator, address delegatee) internal {
        address currentDelegate = delegates[delegator];
        uint96 delegatorBalance = balances[delegator];
        delegates[delegator] = delegatee;

        emit DelegateChanged(delegator, currentDelegate, delegatee);

        _moveDelegates(currentDelegate, delegatee, delegatorBalance);
    }

    function _transferTokens(address src, address dst, uint96 amount) internal {
        require(src != address(0), "Comp::_transferTokens: cannot transfer from the zero address");
        require(dst != address(0), "Comp::_transferTokens: cannot transfer to the zero address");

        balances[src] = sub96(balances[src], amount, "Comp::_transferTokens: transfer amount exceeds balance");
        balances[dst] = add96(balances[dst], amount, "Comp::_transferTokens: transfer amount overflows");
        emit Transfer(src, dst, amount);

        _moveDelegates(delegates[src], delegates[dst], amount);
    }

    function _moveDelegates(address srcRep, address dstRep, uint96 amount) internal {
        if (srcRep != dstRep && amount > 0) {
            if (srcRep != address(0)) {
                uint32 srcRepNum = numCheckpoints[srcRep];
                uint96 srcRepOld = srcRepNum > 0 ? checkpoints[srcRep][srcRepNum - 1].votes : 0;
                uint96 srcRepNew = sub96(srcRepOld, amount, "Comp::_moveVotes: vote amount underflows");
                _writeCheckpoint(srcRep, srcRepNum, srcRepOld, srcRepNew);
            }

            if (dstRep != address(0)) {
                uint32 dstRepNum = numCheckpoints[dstRep];
                uint96 dstRepOld = dstRepNum > 0 ? checkpoints[dstRep][dstRepNum - 1].votes : 0;
                uint96 dstRepNew = add96(dstRepOld, amount, "Comp::_moveVotes: vote amount overflows");
                _writeCheckpoint(dstRep, dstRepNum, dstRepOld, dstRepNew);
            }
        }
    }

    function _writeCheckpoint(address delegatee, uint32 nCheckpoints, uint96 oldVotes, uint96 newVotes) internal {
      uint32 blockNumber = safe32(block.number, "Comp::_writeCheckpoint: block number exceeds 32 bits");

      if (nCheckpoints > 0 && checkpoints[delegatee][nCheckpoints - 1].fromBlock == blockNumber) {
          checkpoints[delegatee][nCheckpoints - 1].votes = newVotes;
      } else {
          checkpoints[delegatee][nCheckpoints] = Checkpoint(blockNumber, newVotes);
          numCheckpoints[delegatee] = nCheckpoints + 1;
      }

      emit DelegateVotesChanged(delegatee, oldVotes, newVotes);
    }

    function safe32(uint n, string memory errorMessage) internal pure returns (uint32) {
        require(n < 2**32, errorMessage);
        return uint32(n);
    }

    function safe96(uint n, string memory errorMessage) internal pure returns (uint96) {
        require(n < 2**96, errorMessage);
        return uint96(n);
    }

    function add96(uint96 a, uint96 b, string memory errorMessage) internal pure returns (uint96) {
        uint96 c = a + b;
        require(c >= a, errorMessage);
        return c;
    }

    function sub96(uint96 a, uint96 b, string memory errorMessage) internal pure returns (uint96) {
        require(b <= a, errorMessage);
        return a - b;
    }

    function getChainId() internal view returns (uint) {
        uint256 chainId;
        assembly { chainId := chainid() }
        return chainId;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Frax/IFrax.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;

interface IFrax {
  function COLLATERAL_RATIO_PAUSER() external view returns (bytes32);
  function DEFAULT_ADMIN_ADDRESS() external view returns (address);
  function DEFAULT_ADMIN_ROLE() external view returns (bytes32);
  function addPool(address pool_address ) external;
  function allowance(address owner, address spender ) external view returns (uint256);
  function approve(address spender, uint256 amount ) external returns (bool);
  function balanceOf(address account ) external view returns (uint256);
  function burn(uint256 amount ) external;
  function burnFrom(address account, uint256 amount ) external;
  function collateral_ratio_paused() external view returns (bool);
  function controller_address() external view returns (address);
  function creator_address() external view returns (address);
  function decimals() external view returns (uint8);
  function decreaseAllowance(address spender, uint256 subtractedValue ) external returns (bool);
  function eth_usd_consumer_address() external view returns (address);
  function eth_usd_price() external view returns (uint256);
  function frax_eth_oracle_address() external view returns (address);
  function frax_info() external view returns (uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256);
  function frax_pools(address ) external view returns (bool);
  function frax_pools_array(uint256 ) external view returns (address);
  function frax_price() external view returns (uint256);
  function frax_step() external view returns (uint256);
  function fxs_address() external view returns (address);
  function fxs_eth_oracle_address() external view returns (address);
  function fxs_price() external view returns (uint256);
  function genesis_supply() external view returns (uint256);
  function getRoleAdmin(bytes32 role ) external view returns (bytes32);
  function getRoleMember(bytes32 role, uint256 index ) external view returns (address);
  function getRoleMemberCount(bytes32 role ) external view returns (uint256);
  function globalCollateralValue() external view returns (uint256);
  function global_collateral_ratio() external view returns (uint256);
  function grantRole(bytes32 role, address account ) external;
  function hasRole(bytes32 role, address account ) external view returns (bool);
  function increaseAllowance(address spender, uint256 addedValue ) external returns (bool);
  function last_call_time() external view returns (uint256);
  function minting_fee() external view returns (uint256);
  function name() external view returns (string memory);
  function owner_address() external view returns (address);
  function pool_burn_from(address b_address, uint256 b_amount ) external;
  function pool_mint(address m_address, uint256 m_amount ) external;
  function price_band() external view returns (uint256);
  function price_target() external view returns (uint256);
  function redemption_fee() external view returns (uint256);
  function refreshCollateralRatio() external;
  function refresh_cooldown() external view returns (uint256);
  function removePool(address pool_address ) external;
  function renounceRole(bytes32 role, address account ) external;
  function revokeRole(bytes32 role, address account ) external;
  function setController(address _controller_address ) external;
  function setETHUSDOracle(address _eth_usd_consumer_address ) external;
  function setFRAXEthOracle(address _frax_oracle_addr, address _weth_address ) external;
  function setFXSAddress(address _fxs_address ) external;
  function setFXSEthOracle(address _fxs_oracle_addr, address _weth_address ) external;
  function setFraxStep(uint256 _new_step ) external;
  function setMintingFee(uint256 min_fee ) external;
  function setOwner(address _owner_address ) external;
  function setPriceBand(uint256 _price_band ) external;
  function setPriceTarget(uint256 _new_price_target ) external;
  function setRedemptionFee(uint256 red_fee ) external;
  function setRefreshCooldown(uint256 _new_cooldown ) external;
  function setTimelock(address new_timelock ) external;
  function symbol() external view returns (string memory);
  function timelock_address() external view returns (address);
  function toggleCollateralRatio() external;
  function totalSupply() external view returns (uint256);
  function transfer(address recipient, uint256 amount ) external returns (bool);
  function transferFrom(address sender, address recipient, uint256 amount ) external returns (bool);
  function weth_address() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Frax/IFraxAMOMinter.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;

// MAY need to be updated
interface IFraxAMOMinter {
  function FRAX() external view returns(address);
  function FXS() external view returns(address);
  function acceptOwnership() external;
  function addAMO(address amo_address, bool sync_too) external;
  function allAMOAddresses() external view returns(address[] memory);
  function allAMOsLength() external view returns(uint256);
  function amos(address) external view returns(bool);
  function amos_array(uint256) external view returns(address);
  function burnFraxFromAMO(uint256 frax_amount) external;
  function burnFxsFromAMO(uint256 fxs_amount) external;
  function col_idx() external view returns(uint256);
  function collatDollarBalance() external view returns(uint256);
  function collatDollarBalanceStored() external view returns(uint256);
  function collat_borrow_cap() external view returns(int256);
  function collat_borrowed_balances(address) external view returns(int256);
  function collat_borrowed_sum() external view returns(int256);
  function collateral_address() external view returns(address);
  function collateral_token() external view returns(address);
  function correction_offsets_amos(address, uint256) external view returns(int256);
  function custodian_address() external view returns(address);
  function dollarBalances() external view returns(uint256 frax_val_e18, uint256 collat_val_e18);
  // function execute(address _to, uint256 _value, bytes _data) external returns(bool, bytes);
  function fraxDollarBalanceStored() external view returns(uint256);
  function fraxTrackedAMO(address amo_address) external view returns(int256);
  function fraxTrackedGlobal() external view returns(int256);
  function frax_mint_balances(address) external view returns(int256);
  function frax_mint_cap() external view returns(int256);
  function frax_mint_sum() external view returns(int256);
  function fxs_mint_balances(address) external view returns(int256);
  function fxs_mint_cap() external view returns(int256);
  function fxs_mint_sum() external view returns(int256);
  function giveCollatToAMO(address destination_amo, uint256 collat_amount) external;
  function min_cr() external view returns(uint256);
  function mintFraxForAMO(address destination_amo, uint256 frax_amount) external;
  function mintFxsForAMO(address destination_amo, uint256 fxs_amount) external;
  function missing_decimals() external view returns(uint256);
  function nominateNewOwner(address _owner) external;
  function nominatedOwner() external view returns(address);
  function oldPoolCollectAndGive(address destination_amo) external;
  function oldPoolRedeem(uint256 frax_amount) external;
  function old_pool() external view returns(address);
  function owner() external view returns(address);
  function pool() external view returns(address);
  function receiveCollatFromAMO(uint256 usdc_amount) external;
  function recoverERC20(address tokenAddress, uint256 tokenAmount) external;
  function removeAMO(address amo_address, bool sync_too) external;
  function setAMOCorrectionOffsets(address amo_address, int256 frax_e18_correction, int256 collat_e18_correction) external;
  function setCollatBorrowCap(uint256 _collat_borrow_cap) external;
  function setCustodian(address _custodian_address) external;
  function setFraxMintCap(uint256 _frax_mint_cap) external;
  function setFraxPool(address _pool_address) external;
  function setFxsMintCap(uint256 _fxs_mint_cap) external;
  function setMinimumCollateralRatio(uint256 _min_cr) external;
  function setTimelock(address new_timelock) external;
  function syncDollarBalances() external;
  function timelock_address() external view returns(address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/olympus/IOlympusERC20Token.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;

// OHM
interface IOlympusERC20Token {
  function DOMAIN_SEPARATOR() external view returns (bytes32);
  function PERMIT_TYPEHASH() external view returns (bytes32);
  function _burnFrom(address account_, uint256 amount_) external;
  function addTWAPSource(address newTWAPSourceDexPool_) external;
  function allowance(address owner, address spender) external view returns (uint256);
  function approve(address spender, uint256 amount) external returns (bool);
  function balanceOf(address account) external view returns (uint256);
  function burn(uint256 amount) external;
  function burnFrom(address account_, uint256 amount_) external;
  function changeTWAPEpochPeriod(uint256 newTWAPEpochPeriod_) external;
  function changeTWAPOracle(address newTWAPOracle_) external;
  function decimals() external view returns (uint8);
  function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
  function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
  function mint(address account_, uint256 amount_) external;
  function name() external view returns (string memory);
  function nonces(address owner) external view returns (uint256);
  function owner() external view returns (address);
  function permit(address owner, address spender, uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;
  function removeTWAPSource(address twapSourceToRemove_) external;
  function renounceOwnership() external;
  function setVault(address vault_) external returns (bool);
  function symbol() external view returns (string memory);
  function totalSupply() external view returns (uint256);
  function transfer(address recipient, uint256 amount) external returns (bool);
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
  function transferOwnership(address newOwner_) external;
  function twapEpochPeriod() external view returns (uint256);
  function twapOracle() external view returns (address);
  function vault() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/olympus/IsOlympus.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;

// sOHM
interface IsOlympus {
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function INDEX() external view returns (uint256);
    function PERMIT_TYPEHASH() external view returns (bytes32);
    function allowance(address owner_, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function balanceForGons(uint256 gons) external view returns (uint256);
    function balanceOf(address who) external view returns (uint256);
    function circulatingSupply() external view returns (uint256);
    function decimals() external view returns (uint8);
    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
    function gonsForBalance(uint256 amount) external view returns (uint256);
    function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
    function index() external view returns (uint256);
    function initialize(address stakingContract_) external returns (bool);
    function initializer() external view returns (address);
    function manager() external view returns (address);
    function name() external view returns (string memory);
    function nonces(address owner) external view returns (uint256);
    function permit(address owner, address spender, uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;
    function pullManagement() external;
    function pushManagement(address newOwner_) external;
    function rebase(uint256 profit_, uint256 epoch_) external returns (uint256);
    function rebases(uint256) external view returns (uint256 epoch, uint256 rebase, uint256 totalStakedBefore, uint256 totalStakedAfter, uint256 amountRebased, uint256 index, uint256 blockNumberOccured);
    function renounceManagement() external;
    function setIndex(uint256 _INDEX) external returns (bool);
    function stakingContract() external view returns (address);
    function symbol() external view returns (string memory);
    function totalSupply() external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}


// sOHM
// OLD VERSION
// interface IsOlympus {
//   function DOMAIN_SEPARATOR() external view returns (bytes32);
//   function PERMIT_TYPEHASH() external view returns (bytes32);
//   function allowance(address owner_, address spender) external view returns (uint256);
//   function approve(address spender, uint256 value) external returns (bool);
//   function balanceOf(address who) external view returns (uint256);
//   function circulatingSupply() external view returns (uint256);
//   function decimals() external view returns (uint8);
//   function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
//   function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
//   function monetaryPolicy() external view returns (address);
//   function name() external view returns (string memory);
//   function nonces(address owner) external view returns (uint256);
//   function owner() external view returns (address);
//   function permit(address owner, address spender, uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;
//   function rebase(uint256 olyProfit) external returns (uint256);
//   function renounceOwnership() external;
//   function setMonetaryPolicy(address monetaryPolicy_) external;
//   function setStakingContract(address newStakingContract_) external;
//   function stakingContract() external view returns (address);
//   function symbol() external view returns (string memory);
//   function totalSupply() external view returns (uint256);
//   function transfer(address to, uint256 value) external returns (bool);
//   function transferFrom(address from, address to, uint256 value) external returns (bool);
//   function transferOwnership(address newOwner_) external;
// }

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/olympus/IStakingHelper.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;

interface IStakingHelper {
  function OHM() external view returns (address);
  function stake(uint256 _amount) external;
  function staking() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/olympus/IOlympusStaking.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;

// https://etherscan.io/address/0xfd31c7d00ca47653c6ce64af53c1571f9c36566a#code

// OlympusStaking
interface IOlympusStaking {
  function OHM() external view returns (address);
  function claim(address _recipient) external;
  function contractBalance() external view returns (uint256);
  function distributor() external view returns (address);
  function epoch() external view returns (uint256 length, uint256 number, uint256 endBlock, uint256 distribute);
  function forfeit() external;
  function giveLockBonus(uint256 _amount) external;
  function index() external view returns (uint256);
  function locker() external view returns (address);
  function manager() external view returns (address);
  function pullManagement() external;
  function pushManagement(address newOwner_) external;
  function rebase() external;
  function renounceManagement() external;
  function returnLockBonus(uint256 _amount) external;
  function sOHM() external view returns (address);
  function setContract(uint8 _contract, address _address) external;
  function setWarmup(uint256 _warmupPeriod) external;
  function stake(uint256 _amount, address _recipient) external returns (bool);
  function toggleDepositLock() external;
  function totalBonus() external view returns (uint256);
  function unstake(uint256 _amount, bool _trigger) external;
  function warmupContract() external view returns (address);
  function warmupInfo(address) external view returns (uint256 deposit, uint256 gons, uint256 expiry, bool lock);
  function warmupPeriod() external view returns (uint256);
}



// library SafeMath {
//     /**
//      * @dev Returns the addition of two unsigned integers, reverting on
//      * overflow.
//      *
//      * Counterpart to Solidity's `+` operator.
//      *
//      * Requirements:
//      *
//      * - Addition cannot overflow.
//      */
//     function add(uint256 a, uint256 b) internal pure returns (uint256) {
//         uint256 c = a + b;
//         require(c >= a, "SafeMath: addition overflow");

//         return c;
//     }

//     /**
//      * @dev Returns the subtraction of two unsigned integers, reverting on
//      * overflow (when the result is negative).
//      *
//      * Counterpart to Solidity's `-` operator.
//      *
//      * Requirements:
//      *
//      * - Subtraction cannot overflow.
//      */
//     function sub(uint256 a, uint256 b) internal pure returns (uint256) {
//         return sub(a, b, "SafeMath: subtraction overflow");
//     }

//     /**
//      * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
//      * overflow (when the result is negative).
//      *
//      * Counterpart to Solidity's `-` operator.
//      *
//      * Requirements:
//      *
//      * - Subtraction cannot overflow.
//      */
//     function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
//         require(b <= a, errorMessage);
//         uint256 c = a - b;

//         return c;
//     }

//     /**
//      * @dev Returns the multiplication of two unsigned integers, reverting on
//      * overflow.
//      *
//      * Counterpart to Solidity's `*` operator.
//      *
//      * Requirements:
//      *
//      * - Multiplication cannot overflow.
//      */
//     function mul(uint256 a, uint256 b) internal pure returns (uint256) {
//         // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
//         // benefit is lost if 'b' is also tested.
//         // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
//         if (a == 0) {
//             return 0;
//         }

//         uint256 c = a * b;
//         require(c / a == b, "SafeMath: multiplication overflow");

//         return c;
//     }

//     /**
//      * @dev Returns the integer division of two unsigned integers. Reverts on
//      * division by zero. The result is rounded towards zero.
//      *
//      * Counterpart to Solidity's `/` operator. Note: this function uses a
//      * `revert` opcode (which leaves remaining gas untouched) while Solidity
//      * uses an invalid opcode to revert (consuming all remaining gas).
//      *
//      * Requirements:
//      *
//      * - The divisor cannot be zero.
//      */
//     function div(uint256 a, uint256 b) internal pure returns (uint256) {
//         return div(a, b, "SafeMath: division by zero");
//     }

//     /**
//      * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
//      * division by zero. The result is rounded towards zero.
//      *
//      * Counterpart to Solidity's `/` operator. Note: this function uses a
//      * `revert` opcode (which leaves remaining gas untouched) while Solidity
//      * uses an invalid opcode to revert (consuming all remaining gas).
//      *
//      * Requirements:
//      *
//      * - The divisor cannot be zero.
//      */
//     function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
//         require(b > 0, errorMessage);
//         uint256 c = a / b;
//         assert(a == b * c + a % b); // There is no case in which this doesn't hold

//         return c;
//     }
// }

// interface IERC20 {
//     function decimals() external view returns (uint8);
//   /**
//    * @dev Returns the amount of tokens in existence.
//    */
//   function totalSupply() external view returns (uint256);

//   /**
//    * @dev Returns the amount of tokens owned by `account`.
//    */
//   function balanceOf(address account) external view returns (uint256);

//   /**
//    * @dev Moves `amount` tokens from the caller's account to `recipient`.
//    *
//    * Returns a boolean value indicating whether the operation succeeded.
//    *
//    * Emits a {Transfer} event.
//    */
//   function transfer(address recipient, uint256 amount) external returns (bool);

//   /**
//    * @dev Returns the remaining number of tokens that `spender` will be
//    * allowed to spend on behalf of `owner` through {transferFrom}. This is
//    * zero by default.
//    *
//    * This value changes when {approve} or {transferFrom} are called.
//    */
//   function allowance(address owner, address spender) external view returns (uint256);

//   /**
//    * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
//    *
//    * Returns a boolean value indicating whether the operation succeeded.
//    *
//    * IMPORTANT: Beware that changing an allowance with this method brings the risk
//    * that someone may use both the old and the new allowance by unfortunate
//    * transaction ordering. One possible solution to mitigate this race
//    * condition is to first reduce the spender's allowance to 0 and set the
//    * desired value afterwards:
//    * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
//    *
//    * Emits an {Approval} event.
//    */
//   function approve(address spender, uint256 amount) external returns (bool);

//   /**
//    * @dev Moves `amount` tokens from `sender` to `recipient` using the
//    * allowance mechanism. `amount` is then deducted from the caller's
//    * allowance.
//    *
//    * Returns a boolean value indicating whether the operation succeeded.
//    *
//    * Emits a {Transfer} event.
//    */
//   function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

//   /**
//    * @dev Emitted when `value` tokens are moved from one account (`from`) to
//    * another (`to`).
//    *
//    * Note that `value` may be zero.
//    */
//   event Transfer(address indexed from, address indexed to, uint256 value);

//   /**
//    * @dev Emitted when the allowance of a `spender` for an `owner` is set by
//    * a call to {approve}. `value` is the new allowance.
//    */
//   event Approval(address indexed owner, address indexed spender, uint256 value);
// }

// library Address {
//     /**
//      * @dev Returns true if `account` is a contract.
//      *
//      * [IMPORTANT]
//      * ====
//      * It is unsafe to assume that an address for which this function returns
//      * false is an externally-owned account (EOA) and not a contract.
//      *
//      * Among others, `isContract` will return false for the following
//      * types of addresses:
//      *
//      *  - an externally-owned account
//      *  - a contract in construction
//      *  - an address where a contract will be created
//      *  - an address where a contract lived, but was destroyed
//      * ====
//      */
//     function isContract(address account) internal view returns (bool) {
//         // This method relies in extcodesize, which returns 0 for contracts in
//         // construction, since the code is only stored at the end of the
//         // constructor execution.

//         uint256 size;
//         // solhint-disable-next-line no-inline-assembly
//         assembly { size := extcodesize(account) }
//         return size > 0;
//     }

//     /**
//      * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
//      * `recipient`, forwarding all available gas and reverting on errors.
//      *
//      * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
//      * of certain opcodes, possibly making contracts go over the 2300 gas limit
//      * imposed by `transfer`, making them unable to receive funds via
//      * `transfer`. {sendValue} removes this limitation.
//      *
//      * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
//      *
//      * IMPORTANT: because control is transferred to `recipient`, care must be
//      * taken to not create reentrancy vulnerabilities. Consider using
//      * {ReentrancyGuard} or the
//      * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
//      */
//     function sendValue(address payable recipient, uint256 amount) internal {
//         require(address(this).balance >= amount, "Address: insufficient balance");

//         // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
//         (bool success, ) = recipient.call{ value: amount }("");
//         require(success, "Address: unable to send value, recipient may have reverted");
//     }

//     /**
//      * @dev Performs a Solidity function call using a low level `call`. A
//      * plain`call` is an unsafe replacement for a function call: use this
//      * function instead.
//      *
//      * If `target` reverts with a revert reason, it is bubbled up by this
//      * function (like regular Solidity function calls).
//      *
//      * Returns the raw returned data. To convert to the expected return value,
//      * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
//      *
//      * Requirements:
//      *
//      * - `target` must be a contract.
//      * - calling `target` with `data` must not revert.
//      *
//      * _Available since v3.1._
//      */
//     function functionCall(address target, bytes memory data) internal returns (bytes memory) {
//       return functionCall(target, data, "Address: low-level call failed");
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
//      * `errorMessage` as a fallback revert reason when `target` reverts.
//      *
//      * _Available since v3.1._
//      */
//     function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
//         return _functionCallWithValue(target, data, 0, errorMessage);
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
//      * but also transferring `value` wei to `target`.
//      *
//      * Requirements:
//      *
//      * - the calling contract must have an ETH balance of at least `value`.
//      * - the called Solidity function must be `payable`.
//      *
//      * _Available since v3.1._
//      */
//     function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
//         return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
//     }

//     /**
//      * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
//      * with `errorMessage` as a fallback revert reason when `target` reverts.
//      *
//      * _Available since v3.1._
//      */
//     function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
//         require(address(this).balance >= value, "Address: insufficient balance for call");
//         require(isContract(target), "Address: call to non-contract");

//         // solhint-disable-next-line avoid-low-level-calls
//         (bool success, bytes memory returndata) = target.call{ value: value }(data);
//         return _verifyCallResult(success, returndata, errorMessage);
//     }

//     function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
//         require(isContract(target), "Address: call to non-contract");

//         // solhint-disable-next-line avoid-low-level-calls
//         (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
//         if (success) {
//             return returndata;
//         } else {
//             // Look for revert reason and bubble it up if present
//             if (returndata.length > 0) {
//                 // The easiest way to bubble the revert reason is using memory via assembly

//                 // solhint-disable-next-line no-inline-assembly
//                 assembly {
//                     let returndata_size := mload(returndata)
//                     revert(add(32, returndata), returndata_size)
//                 }
//             } else {
//                 revert(errorMessage);
//             }
//         }
//     }

//   /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
//      * but performing a static call.
//      *
//      * _Available since v3.3._
//      */
//     function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
//         return functionStaticCall(target, data, "Address: low-level static call failed");
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
//      * but performing a static call.
//      *
//      * _Available since v3.3._
//      */
//     function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
//         require(isContract(target), "Address: static call to non-contract");

//         // solhint-disable-next-line avoid-low-level-calls
//         (bool success, bytes memory returndata) = target.staticcall(data);
//         return _verifyCallResult(success, returndata, errorMessage);
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
//      * but performing a delegate call.
//      *
//      * _Available since v3.3._
//      */
//     function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
//         return functionDelegateCall(target, data, "Address: low-level delegate call failed");
//     }

//     /**
//      * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
//      * but performing a delegate call.
//      *
//      * _Available since v3.3._
//      */
//     function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
//         require(isContract(target), "Address: delegate call to non-contract");

//         // solhint-disable-next-line avoid-low-level-calls
//         (bool success, bytes memory returndata) = target.delegatecall(data);
//         return _verifyCallResult(success, returndata, errorMessage);
//     }

//     function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
//         if (success) {
//             return returndata;
//         } else {
//             // Look for revert reason and bubble it up if present
//             if (returndata.length > 0) {
//                 // The easiest way to bubble the revert reason is using memory via assembly

//                 // solhint-disable-next-line no-inline-assembly
//                 assembly {
//                     let returndata_size := mload(returndata)
//                     revert(add(32, returndata), returndata_size)
//                 }
//             } else {
//                 revert(errorMessage);
//             }
//         }
//     }

//     function addressToString(address _address) internal pure returns(string memory) {
//         bytes32 _bytes = bytes32(uint256(_address));
//         bytes memory HEX = "0123456789abcdef";
//         bytes memory _addr = new bytes(42);

//         _addr[0] = '0';
//         _addr[1] = 'x';

//         for(uint256 i = 0; i < 20; i++) {
//             _addr[2+i*2] = HEX[uint8(_bytes[i + 12] >> 4)];
//             _addr[3+i*2] = HEX[uint8(_bytes[i + 12] & 0x0f)];
//         }

//         return string(_addr);

//     }
// }

// library SafeERC20 {
//     using SafeMath for uint256;
//     using Address for address;

//     function safeTransfer(IERC20 token, address to, uint256 value) internal {
//         _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
//     }

//     function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
//         _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
//     }

//     /**
//      * @dev Deprecated. This function has issues similar to the ones found in
//      * {IERC20-approve}, and its usage is discouraged.
//      *
//      * Whenever possible, use {safeIncreaseAllowance} and
//      * {safeDecreaseAllowance} instead.
//      */
//     function safeApprove(IERC20 token, address spender, uint256 value) internal {
//         // safeApprove should only be called when setting an initial allowance,
//         // or when resetting it to zero. To increase and decrease it, use
//         // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
//         // solhint-disable-next-line max-line-length
//         require((value == 0) || (token.allowance(address(this), spender) == 0),
//             "SafeERC20: approve from non-zero to non-zero allowance"
//         );
//         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
//     }

//     function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
//         uint256 newAllowance = token.allowance(address(this), spender).add(value);
//         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
//     }

//     function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
//         uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
//         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
//     }

//     /**
//      * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
//      * on the return value: the return value is optional (but if data is returned, it must not be false).
//      * @param token The token targeted by the call.
//      * @param data The call data (encoded using abi.encode or one of its variants).
//      */
//     function _callOptionalReturn(IERC20 token, bytes memory data) private {
//         // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
//         // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
//         // the target address contains contract code and also asserts for success in the low-level call.

//         bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
//         if (returndata.length > 0) { // Return data is optional
//             // solhint-disable-next-line max-line-length
//             require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
//         }
//     }
// }

// interface IOwnable {
//   function manager() external view returns (address);

//   function renounceManagement() external;
  
//   function pushManagement( address newOwner_ ) external;
  
//   function pullManagement() external;
// }

// contract Ownable is IOwnable {

//     address internal _owner;
//     address internal _newOwner;

//     event OwnershipPushed(address indexed previousOwner, address indexed newOwner);
//     event OwnershipPulled(address indexed previousOwner, address indexed newOwner);

//     constructor () {
//         _owner = msg.sender;
//         emit OwnershipPushed( address(0), _owner );
//     }

//     function manager() public view override returns (address) {
//         return _owner;
//     }

//     modifier onlyManager() {
//         require( _owner == msg.sender, "Ownable: caller is not the owner" );
//         _;
//     }

//     function renounceManagement() public virtual override onlyManager() {
//         emit OwnershipPushed( _owner, address(0) );
//         _owner = address(0);
//     }

//     function pushManagement( address newOwner_ ) public virtual override onlyManager() {
//         require( newOwner_ != address(0), "Ownable: new owner is the zero address");
//         emit OwnershipPushed( _owner, newOwner_ );
//         _newOwner = newOwner_;
//     }
    
//     function pullManagement() public virtual override {
//         require( msg.sender == _newOwner, "Ownable: must be new owner to pull");
//         emit OwnershipPulled( _owner, _newOwner );
//         _owner = _newOwner;
//     }
// }

// interface IsOHM {
//     function rebase( uint256 ohmProfit_, uint epoch_) external returns (uint256);

//     function circulatingSupply() external view returns (uint256);

//     function balanceOf(address who) external view returns (uint256);

//     function gonsForBalance( uint amount ) external view returns ( uint );

//     function balanceForGons( uint gons ) external view returns ( uint );
    
//     function index() external view returns ( uint );
// }

// interface IWarmup {
//     function retrieve( address staker_, uint amount_ ) external;
// }

// interface IDistributor {
//     function distribute() external returns ( bool );
// }

// contract OlympusStaking is Ownable {

//     using SafeMath for uint256;
//     using SafeERC20 for IERC20;

//     address public immutable OHM;
//     address public immutable sOHM;

//     struct Epoch {
//         uint length;
//         uint number;
//         uint endBlock;
//         uint distribute;
//     }
//     Epoch public epoch;

//     address public distributor;
    
//     address public locker;
//     uint public totalBonus;
    
//     address public warmupContract;
//     uint public warmupPeriod;
    
//     constructor ( 
//         address _OHM, 
//         address _sOHM, 
//         uint _epochLength,
//         uint _firstEpochNumber,
//         uint _firstEpochBlock
//     ) {
//         require( _OHM != address(0) );
//         OHM = _OHM;
//         require( _sOHM != address(0) );
//         sOHM = _sOHM;
        
//         epoch = Epoch({
//             length: _epochLength,
//             number: _firstEpochNumber,
//             endBlock: _firstEpochBlock,
//             distribute: 0
//         });
//     }

//     struct Claim {
//         uint deposit;
//         uint gons;
//         uint expiry;
//         bool lock; // prevents malicious delays
//     }
//     mapping( address => Claim ) public warmupInfo;

//     /**
//         @notice stake OHM to enter warmup
//         @param _amount uint
//         @return bool
//      */
//     function stake( uint _amount, address _recipient ) external returns ( bool ) {
//         rebase();
        
//         IERC20( OHM ).safeTransferFrom( msg.sender, address(this), _amount );

//         Claim memory info = warmupInfo[ _recipient ];
//         require( !info.lock, "Deposits for account are locked" );

//         warmupInfo[ _recipient ] = Claim ({
//             deposit: info.deposit.add( _amount ),
//             gons: info.gons.add( IsOHM( sOHM ).gonsForBalance( _amount ) ),
//             expiry: epoch.number.add( warmupPeriod ),
//             lock: false
//         });
        
//         IERC20( sOHM ).safeTransfer( warmupContract, _amount );
//         return true;
//     }

//     /**
//         @notice retrieve sOHM from warmup
//         @param _recipient address
//      */
//     function claim ( address _recipient ) public {
//         Claim memory info = warmupInfo[ _recipient ];
//         if ( epoch.number >= info.expiry && info.expiry != 0 ) {
//             delete warmupInfo[ _recipient ];
//             IWarmup( warmupContract ).retrieve( _recipient, IsOHM( sOHM ).balanceForGons( info.gons ) );
//         }
//     }

//     /**
//         @notice forfeit sOHM in warmup and retrieve OHM
//      */
//     function forfeit() external {
//         Claim memory info = warmupInfo[ msg.sender ];
//         delete warmupInfo[ msg.sender ];

//         IWarmup( warmupContract ).retrieve( address(this), IsOHM( sOHM ).balanceForGons( info.gons ) );
//         IERC20( OHM ).safeTransfer( msg.sender, info.deposit );
//     }

//     /**
//         @notice prevent new deposits to address (protection from malicious activity)
//      */
//     function toggleDepositLock() external {
//         warmupInfo[ msg.sender ].lock = !warmupInfo[ msg.sender ].lock;
//     }

//     /**
//         @notice redeem sOHM for OHM
//         @param _amount uint
//         @param _trigger bool
//      */
//     function unstake( uint _amount, bool _trigger ) external {
//         if ( _trigger ) {
//             rebase();
//         }
//         IERC20( sOHM ).safeTransferFrom( msg.sender, address(this), _amount );
//         IERC20( OHM ).safeTransfer( msg.sender, _amount );
//     }

//     /**
//         @notice returns the sOHM index, which tracks rebase growth
//         @return uint
//      */
//     function index() public view returns ( uint ) {
//         return IsOHM( sOHM ).index();
//     }

//     /**
//         @notice trigger rebase if epoch over
//      */
//     function rebase() public {
//         if( epoch.endBlock <= block.number ) {

//             IsOHM( sOHM ).rebase( epoch.distribute, epoch.number );

//             epoch.endBlock = epoch.endBlock.add( epoch.length );
//             epoch.number++;
            
//             if ( distributor != address(0) ) {
//                 IDistributor( distributor ).distribute();
//             }

//             uint balance = contractBalance();
//             uint staked = IsOHM( sOHM ).circulatingSupply();

//             if( balance <= staked ) {
//                 epoch.distribute = 0;
//             } else {
//                 epoch.distribute = balance.sub( staked );
//             }
//         }
//     }

//     /**
//         @notice returns contract OHM holdings, including bonuses provided
//         @return uint
//      */
//     function contractBalance() public view returns ( uint ) {
//         return IERC20( OHM ).balanceOf( address(this) ).add( totalBonus );
//     }

//     /**
//         @notice provide bonus to locked staking contract
//         @param _amount uint
//      */
//     function giveLockBonus( uint _amount ) external {
//         require( msg.sender == locker );
//         totalBonus = totalBonus.add( _amount );
//         IERC20( sOHM ).safeTransfer( locker, _amount );
//     }

//     /**
//         @notice reclaim bonus from locked staking contract
//         @param _amount uint
//      */
//     function returnLockBonus( uint _amount ) external {
//         require( msg.sender == locker );
//         totalBonus = totalBonus.sub( _amount );
//         IERC20( sOHM ).safeTransferFrom( locker, address(this), _amount );
//     }

//     enum CONTRACTS { DISTRIBUTOR, WARMUP, LOCKER }

//     /**
//         @notice sets the contract address for LP staking
//         @param _contract address
//      */
//     function setContract( CONTRACTS _contract, address _address ) external onlyManager() {
//         if( _contract == CONTRACTS.DISTRIBUTOR ) { // 0
//             distributor = _address;
//         } else if ( _contract == CONTRACTS.WARMUP ) { // 1
//             require( warmupContract == address( 0 ), "Warmup cannot be set more than once" );
//             warmupContract = _address;
//         } else if ( _contract == CONTRACTS.LOCKER ) { // 2
//             require( locker == address(0), "Locker cannot be set more than once" );
//             locker = _address;
//         }
//     }
    
//     /**
//      * @notice set warmup period for new stakers
//      * @param _warmupPeriod uint
//      */
//     function setWarmup( uint _warmupPeriod ) external onlyManager() {
//         warmupPeriod = _warmupPeriod;
//     }
// }

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/olympus/IOlympusBondDepository.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;

interface IOlympusBondDepository {
  function DAO() external view returns (address);
  function OHM() external view returns (address);
  function adjustment() external view returns (bool add, uint256 rate, uint256 target, uint256 buffer, uint256 lastBlock);
  function bondCalculator() external view returns (address);
  function bondInfo(address) external view returns (uint256 payout, uint256 vesting, uint256 lastBlock, uint256 pricePaid);
  function bondPrice() external view returns (uint256 price_);
  function bondPriceInUSD() external view returns (uint256 price_);
  function currentDebt() external view returns (uint256);
  function debtDecay() external view returns (uint256 decay_);
  function debtRatio() external view returns (uint256 debtRatio_);
  function deposit(uint256 _amount, uint256 _maxPrice, address _depositor) external returns (uint256);
  function initializeBondTerms(uint256 _controlVariable, uint256 _vestingTerm, uint256 _minimumPrice, uint256 _maxPayout, uint256 _fee, uint256 _maxDebt, uint256 _initialDebt) external;
  function isLiquidityBond() external view returns (bool);
  function lastDecay() external view returns (uint256);
  function maxPayout() external view returns (uint256);
  function payoutFor(uint256 _value) external view returns (uint256);
  function pendingPayoutFor(address _depositor) external view returns (uint256 pendingPayout_);
  function percentVestedFor(address _depositor) external view returns (uint256 percentVested_);
  function policy() external view returns (address);
  function principle() external view returns (address);
  function pullManagement() external;
  function pushManagement(address newOwner_) external;
  function recoverLostToken(address _token) external returns (bool);
  function redeem(address _recipient, bool _stake) external returns (uint256);
  function renounceManagement() external;
  function setAdjustment(bool _addition, uint256 _increment, uint256 _target, uint256 _buffer) external;
  function setBondTerms(uint8 _parameter, uint256 _input) external;
  function setStaking(address _staking, bool _helper) external;
  function staking() external view returns (address);
  function stakingHelper() external view returns (address);
  function standardizedDebtRatio() external view returns (uint256);
  function terms() external view returns (uint256 controlVariable, uint256 vestingTerm, uint256 minimumPrice, uint256 maxPayout, uint256 fee, uint256 maxDebt);
  function totalDebt() external view returns (uint256);
  function treasury() external view returns (address);
  function useHelper() external view returns (bool);
}



// interface IOwnable {
//   function policy() external view returns (address);

//   function renounceManagement() external;
  
//   function pushManagement( address newOwner_ ) external;
  
//   function pullManagement() external;
// }

// contract Ownable is IOwnable {

//     address internal _owner;
//     address internal _newOwner;

//     event OwnershipPushed(address indexed previousOwner, address indexed newOwner);
//     event OwnershipPulled(address indexed previousOwner, address indexed newOwner);

//     constructor () {
//         _owner = msg.sender;
//         emit OwnershipPushed( address(0), _owner );
//     }

//     function policy() public view override returns (address) {
//         return _owner;
//     }

//     modifier onlyPolicy() {
//         require( _owner == msg.sender, "Ownable: caller is not the owner" );
//         _;
//     }

//     function renounceManagement() public virtual override onlyPolicy() {
//         emit OwnershipPushed( _owner, address(0) );
//         _owner = address(0);
//     }

//     function pushManagement( address newOwner_ ) public virtual override onlyPolicy() {
//         require( newOwner_ != address(0), "Ownable: new owner is the zero address");
//         emit OwnershipPushed( _owner, newOwner_ );
//         _newOwner = newOwner_;
//     }
    
//     function pullManagement() public virtual override {
//         require( msg.sender == _newOwner, "Ownable: must be new owner to pull");
//         emit OwnershipPulled( _owner, _newOwner );
//         _owner = _newOwner;
//     }
// }

// library SafeMath {

//     function add(uint256 a, uint256 b) internal pure returns (uint256) {
//         uint256 c = a + b;
//         require(c >= a, "SafeMath: addition overflow");

//         return c;
//     }

//     function sub(uint256 a, uint256 b) internal pure returns (uint256) {
//         return sub(a, b, "SafeMath: subtraction overflow");
//     }

//     function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
//         require(b <= a, errorMessage);
//         uint256 c = a - b;

//         return c;
//     }

//     function mul(uint256 a, uint256 b) internal pure returns (uint256) {
//         if (a == 0) {
//             return 0;
//         }

//         uint256 c = a * b;
//         require(c / a == b, "SafeMath: multiplication overflow");

//         return c;
//     }

//     function div(uint256 a, uint256 b) internal pure returns (uint256) {
//         return div(a, b, "SafeMath: division by zero");
//     }

//     function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
//         require(b > 0, errorMessage);
//         uint256 c = a / b;
//         return c;
//     }

//     function mod(uint256 a, uint256 b) internal pure returns (uint256) {
//         return mod(a, b, "SafeMath: modulo by zero");
//     }

//     function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
//         require(b != 0, errorMessage);
//         return a % b;
//     }

//     function sqrrt(uint256 a) internal pure returns (uint c) {
//         if (a > 3) {
//             c = a;
//             uint b = add( div( a, 2), 1 );
//             while (b < c) {
//                 c = b;
//                 b = div( add( div( a, b ), b), 2 );
//             }
//         } else if (a != 0) {
//             c = 1;
//         }
//     }
// }

// library Address {

//     function isContract(address account) internal view returns (bool) {

//         uint256 size;
//         // solhint-disable-next-line no-inline-assembly
//         assembly { size := extcodesize(account) }
//         return size > 0;
//     }

//     function sendValue(address payable recipient, uint256 amount) internal {
//         require(address(this).balance >= amount, "Address: insufficient balance");

//         // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
//         (bool success, ) = recipient.call{ value: amount }("");
//         require(success, "Address: unable to send value, recipient may have reverted");
//     }

//     function functionCall(address target, bytes memory data) internal returns (bytes memory) {
//       return functionCall(target, data, "Address: low-level call failed");
//     }

//     function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
//         return _functionCallWithValue(target, data, 0, errorMessage);
//     }

//     function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
//         return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
//     }

//     function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
//         require(address(this).balance >= value, "Address: insufficient balance for call");
//         require(isContract(target), "Address: call to non-contract");

//         // solhint-disable-next-line avoid-low-level-calls
//         (bool success, bytes memory returndata) = target.call{ value: value }(data);
//         return _verifyCallResult(success, returndata, errorMessage);
//     }

//     function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
//         require(isContract(target), "Address: call to non-contract");

//         // solhint-disable-next-line avoid-low-level-calls
//         (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
//         if (success) {
//             return returndata;
//         } else {
//             // Look for revert reason and bubble it up if present
//             if (returndata.length > 0) {
//                 // The easiest way to bubble the revert reason is using memory via assembly

//                 // solhint-disable-next-line no-inline-assembly
//                 assembly {
//                     let returndata_size := mload(returndata)
//                     revert(add(32, returndata), returndata_size)
//                 }
//             } else {
//                 revert(errorMessage);
//             }
//         }
//     }

//     function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
//         return functionStaticCall(target, data, "Address: low-level static call failed");
//     }

//     function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
//         require(isContract(target), "Address: static call to non-contract");

//         // solhint-disable-next-line avoid-low-level-calls
//         (bool success, bytes memory returndata) = target.staticcall(data);
//         return _verifyCallResult(success, returndata, errorMessage);
//     }

//     function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
//         return functionDelegateCall(target, data, "Address: low-level delegate call failed");
//     }

//     function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
//         require(isContract(target), "Address: delegate call to non-contract");

//         // solhint-disable-next-line avoid-low-level-calls
//         (bool success, bytes memory returndata) = target.delegatecall(data);
//         return _verifyCallResult(success, returndata, errorMessage);
//     }

//     function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
//         if (success) {
//             return returndata;
//         } else {
//             if (returndata.length > 0) {

//                 assembly {
//                     let returndata_size := mload(returndata)
//                     revert(add(32, returndata), returndata_size)
//                 }
//             } else {
//                 revert(errorMessage);
//             }
//         }
//     }

//     function addressToString(address _address) internal pure returns(string memory) {
//         bytes32 _bytes = bytes32(uint256(_address));
//         bytes memory HEX = "0123456789abcdef";
//         bytes memory _addr = new bytes(42);

//         _addr[0] = '0';
//         _addr[1] = 'x';

//         for(uint256 i = 0; i < 20; i++) {
//             _addr[2+i*2] = HEX[uint8(_bytes[i + 12] >> 4)];
//             _addr[3+i*2] = HEX[uint8(_bytes[i + 12] & 0x0f)];
//         }

//         return string(_addr);

//     }
// }

// interface IERC20 {
//     function decimals() external view returns (uint8);

//     function totalSupply() external view returns (uint256);

//     function balanceOf(address account) external view returns (uint256);

//     function transfer(address recipient, uint256 amount) external returns (bool);

//     function allowance(address owner, address spender) external view returns (uint256);

//     function approve(address spender, uint256 amount) external returns (bool);

//     function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

//     event Transfer(address indexed from, address indexed to, uint256 value);

//     event Approval(address indexed owner, address indexed spender, uint256 value);
// }

// abstract contract ERC20 is IERC20 {

//     using SafeMath for uint256;

//     // TODO comment actual hash value.
//     bytes32 constant private ERC20TOKEN_ERC1820_INTERFACE_ID = keccak256( "ERC20Token" );
    
//     mapping (address => uint256) internal _balances;

//     mapping (address => mapping (address => uint256)) internal _allowances;

//     uint256 internal _totalSupply;

//     string internal _name;
    
//     string internal _symbol;
    
//     uint8 internal _decimals;

//     constructor (string memory name_, string memory symbol_, uint8 decimals_) {
//         _name = name_;
//         _symbol = symbol_;
//         _decimals = decimals_;
//     }

//     function name() public view returns (string memory) {
//         return _name;
//     }

//     function symbol() public view returns (string memory) {
//         return _symbol;
//     }

//     function decimals() public view override returns (uint8) {
//         return _decimals;
//     }

//     function totalSupply() public view override returns (uint256) {
//         return _totalSupply;
//     }

//     function balanceOf(address account) public view virtual override returns (uint256) {
//         return _balances[account];
//     }

//     function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
//         _transfer(msg.sender, recipient, amount);
//         return true;
//     }

//     function allowance(address owner, address spender) public view virtual override returns (uint256) {
//         return _allowances[owner][spender];
//     }

//     function approve(address spender, uint256 amount) public virtual override returns (bool) {
//         _approve(msg.sender, spender, amount);
//         return true;
//     }

//     function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
//         _transfer(sender, recipient, amount);
//         _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount, "ERC20: transfer amount exceeds allowance"));
//         return true;
//     }

//     function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
//         _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
//         return true;
//     }

//     function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
//         _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
//         return true;
//     }

//     function _transfer(address sender, address recipient, uint256 amount) internal virtual {
//         require(sender != address(0), "ERC20: transfer from the zero address");
//         require(recipient != address(0), "ERC20: transfer to the zero address");

//         _beforeTokenTransfer(sender, recipient, amount);

//         _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
//         _balances[recipient] = _balances[recipient].add(amount);
//         emit Transfer(sender, recipient, amount);
//     }

//     function _mint(address account_, uint256 ammount_) internal virtual {
//         require(account_ != address(0), "ERC20: mint to the zero address");
//         _beforeTokenTransfer(address( this ), account_, ammount_);
//         _totalSupply = _totalSupply.add(ammount_);
//         _balances[account_] = _balances[account_].add(ammount_);
//         emit Transfer(address( this ), account_, ammount_);
//     }

//     function _burn(address account, uint256 amount) internal virtual {
//         require(account != address(0), "ERC20: burn from the zero address");

//         _beforeTokenTransfer(account, address(0), amount);

//         _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
//         _totalSupply = _totalSupply.sub(amount);
//         emit Transfer(account, address(0), amount);
//     }

//     function _approve(address owner, address spender, uint256 amount) internal virtual {
//         require(owner != address(0), "ERC20: approve from the zero address");
//         require(spender != address(0), "ERC20: approve to the zero address");

//         _allowances[owner][spender] = amount;
//         emit Approval(owner, spender, amount);
//     }

//   function _beforeTokenTransfer( address from_, address to_, uint256 amount_ ) internal virtual { }
// }

// interface IERC2612Permit {

//     function permit(
//         address owner,
//         address spender,
//         uint256 amount,
//         uint256 deadline,
//         uint8 v,
//         bytes32 r,
//         bytes32 s
//     ) external;

//     function nonces(address owner) external view returns (uint256);
// }

// library Counters {
//     using SafeMath for uint256;

//     struct Counter {

//         uint256 _value; // default: 0
//     }

//     function current(Counter storage counter) internal view returns (uint256) {
//         return counter._value;
//     }

//     function increment(Counter storage counter) internal {
//         counter._value += 1;
//     }

//     function decrement(Counter storage counter) internal {
//         counter._value = counter._value.sub(1);
//     }
// }

// abstract contract ERC20Permit is ERC20, IERC2612Permit {
//     using Counters for Counters.Counter;

//     mapping(address => Counters.Counter) private _nonces;

//     // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
//     bytes32 public constant PERMIT_TYPEHASH = 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;

//     bytes32 public DOMAIN_SEPARATOR;

//     constructor () {
//         uint256 chainID;
//         assembly {
//             chainID := chainid()
//         }

//         DOMAIN_SEPARATOR = keccak256(
//             abi.encode(
//                 keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
//                 keccak256(bytes(name())),
//                 keccak256(bytes("1")), // Version
//                 chainID,
//                 address(this)
//             )
//         );
//     }

//     function permit(
//         address owner,
//         address spender,
//         uint256 amount,
//         uint256 deadline,
//         uint8 v,
//         bytes32 r,
//         bytes32 s
//     ) public virtual override {
//         require(block.timestamp <= deadline, "Permit: expired deadline");

//         bytes32 hashStruct =
//             keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, amount, _nonces[owner].current(), deadline));

//         bytes32 _hash = keccak256(abi.encodePacked(uint16(0x1901), DOMAIN_SEPARATOR, hashStruct));

//         address signer = ecrecover(_hash, v, r, s);
//         require(signer != address(0) && signer == owner, "ZeroSwapPermit: Invalid signature");

//         _nonces[owner].increment();
//         _approve(owner, spender, amount);
//     }

//     function nonces(address owner) public view override returns (uint256) {
//         return _nonces[owner].current();
//     }
// }

// library SafeERC20 {
//     using SafeMath for uint256;
//     using Address for address;

//     function safeTransfer(IERC20 token, address to, uint256 value) internal {
//         _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
//     }

//     function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
//         _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
//     }

//     function safeApprove(IERC20 token, address spender, uint256 value) internal {

//         require((value == 0) || (token.allowance(address(this), spender) == 0),
//             "SafeERC20: approve from non-zero to non-zero allowance"
//         );
//         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
//     }

//     function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
//         uint256 newAllowance = token.allowance(address(this), spender).add(value);
//         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
//     }

//     function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
//         uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
//         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
//     }

//     function _callOptionalReturn(IERC20 token, bytes memory data) private {

//         bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
//         if (returndata.length > 0) { // Return data is optional
//             // solhint-disable-next-line max-line-length
//             require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
//         }
//     }
// }

// library FullMath {
//     function fullMul(uint256 x, uint256 y) private pure returns (uint256 l, uint256 h) {
//         uint256 mm = mulmod(x, y, uint256(-1));
//         l = x * y;
//         h = mm - l;
//         if (mm < l) h -= 1;
//     }

//     function fullDiv(
//         uint256 l,
//         uint256 h,
//         uint256 d
//     ) private pure returns (uint256) {
//         uint256 pow2 = d & -d;
//         d /= pow2;
//         l /= pow2;
//         l += h * ((-pow2) / pow2 + 1);
//         uint256 r = 1;
//         r *= 2 - d * r;
//         r *= 2 - d * r;
//         r *= 2 - d * r;
//         r *= 2 - d * r;
//         r *= 2 - d * r;
//         r *= 2 - d * r;
//         r *= 2 - d * r;
//         r *= 2 - d * r;
//         return l * r;
//     }

//     function mulDiv(
//         uint256 x,
//         uint256 y,
//         uint256 d
//     ) internal pure returns (uint256) {
//         (uint256 l, uint256 h) = fullMul(x, y);
//         uint256 mm = mulmod(x, y, d);
//         if (mm > l) h -= 1;
//         l -= mm;
//         require(h < d, 'FullMath::mulDiv: overflow');
//         return fullDiv(l, h, d);
//     }
// }

// library FixedPoint {

//     struct uq112x112 {
//         uint224 _x;
//     }

//     struct uq144x112 {
//         uint256 _x;
//     }

//     uint8 private constant RESOLUTION = 112;
//     uint256 private constant Q112 = 0x10000000000000000000000000000;
//     uint256 private constant Q224 = 0x100000000000000000000000000000000000000000000000000000000;
//     uint256 private constant LOWER_MASK = 0xffffffffffffffffffffffffffff; // decimal of UQ*x112 (lower 112 bits)

//     function decode(uq112x112 memory self) internal pure returns (uint112) {
//         return uint112(self._x >> RESOLUTION);
//     }

//     function decode112with18(uq112x112 memory self) internal pure returns (uint) {

//         return uint(self._x) / 5192296858534827;
//     }

//     function fraction(uint256 numerator, uint256 denominator) internal pure returns (uq112x112 memory) {
//         require(denominator > 0, 'FixedPoint::fraction: division by zero');
//         if (numerator == 0) return FixedPoint.uq112x112(0);

//         if (numerator <= uint144(-1)) {
//             uint256 result = (numerator << RESOLUTION) / denominator;
//             require(result <= uint224(-1), 'FixedPoint::fraction: overflow');
//             return uq112x112(uint224(result));
//         } else {
//             uint256 result = FullMath.mulDiv(numerator, Q112, denominator);
//             require(result <= uint224(-1), 'FixedPoint::fraction: overflow');
//             return uq112x112(uint224(result));
//         }
//     }
// }

// interface ITreasury {
//     function deposit( uint _amount, address _token, uint _profit ) external returns ( bool );
//     function valueOf( address _token, uint _amount ) external view returns ( uint value_ );
// }

// interface IBondCalculator {
//     function valuation( address _LP, uint _amount ) external view returns ( uint );
//     function markdown( address _LP ) external view returns ( uint );
// }

// interface IStaking {
//     function stake( uint _amount, address _recipient ) external returns ( bool );
// }

// interface IStakingHelper {
//     function stake( uint _amount, address _recipient ) external;
// }

// contract OlympusBondDepository is Ownable {

//     using FixedPoint for *;
//     using SafeERC20 for IERC20;
//     using SafeMath for uint;




//     /* ======== EVENTS ======== */

//     event BondCreated( uint deposit, uint indexed payout, uint indexed expires, uint indexed priceInUSD );
//     event BondRedeemed( address indexed recipient, uint payout, uint remaining );
//     event BondPriceChanged( uint indexed priceInUSD, uint indexed internalPrice, uint indexed debtRatio );
//     event ControlVariableAdjustment( uint initialBCV, uint newBCV, uint adjustment, bool addition );




//     /* ======== STATE VARIABLES ======== */

//     address public immutable OHM; // token given as payment for bond
//     address public immutable principle; // token used to create bond
//     address public immutable treasury; // mints OHM when receives principle
//     address public immutable DAO; // receives profit share from bond

//     bool public immutable isLiquidityBond; // LP and Reserve bonds are treated slightly different
//     address public immutable bondCalculator; // calculates value of LP tokens

//     address public staking; // to auto-stake payout
//     address public stakingHelper; // to stake and claim if no staking warmup
//     bool public useHelper;

//     Terms public terms; // stores terms for new bonds
//     Adjust public adjustment; // stores adjustment to BCV data

//     mapping( address => Bond ) public bondInfo; // stores bond information for depositors

//     uint public totalDebt; // total value of outstanding bonds; used for pricing
//     uint public lastDecay; // reference block for debt decay




//     /* ======== STRUCTS ======== */

//     // Info for creating new bonds
//     struct Terms {
//         uint controlVariable; // scaling variable for price
//         uint vestingTerm; // in blocks
//         uint minimumPrice; // vs principle value
//         uint maxPayout; // in thousandths of a %. i.e. 500 = 0.5%
//         uint fee; // as % of bond payout, in hundreths. ( 500 = 5% = 0.05 for every 1 paid)
//         uint maxDebt; // 9 decimal debt ratio, max % total supply created as debt
//     }

//     // Info for bond holder
//     struct Bond {
//         uint payout; // OHM remaining to be paid
//         uint vesting; // Blocks left to vest
//         uint lastBlock; // Last interaction
//         uint pricePaid; // In DAI, for front end viewing
//     }

//     // Info for incremental adjustments to control variable 
//     struct Adjust {
//         bool add; // addition or subtraction
//         uint rate; // increment
//         uint target; // BCV when adjustment finished
//         uint buffer; // minimum length (in blocks) between adjustments
//         uint lastBlock; // block when last adjustment made
//     }




//     /* ======== INITIALIZATION ======== */

//     constructor ( 
//         address _OHM,
//         address _principle,
//         address _treasury, 
//         address _DAO, 
//         address _bondCalculator
//     ) {
//         require( _OHM != address(0) );
//         OHM = _OHM;
//         require( _principle != address(0) );
//         principle = _principle;
//         require( _treasury != address(0) );
//         treasury = _treasury;
//         require( _DAO != address(0) );
//         DAO = _DAO;
//         // bondCalculator should be address(0) if not LP bond
//         bondCalculator = _bondCalculator;
//         isLiquidityBond = ( _bondCalculator != address(0) );
//     }

//     /**
//      *  @notice initializes bond parameters
//      *  @param _controlVariable uint
//      *  @param _vestingTerm uint
//      *  @param _minimumPrice uint
//      *  @param _maxPayout uint
//      *  @param _fee uint
//      *  @param _maxDebt uint
//      *  @param _initialDebt uint
//      */
//     function initializeBondTerms( 
//         uint _controlVariable, 
//         uint _vestingTerm,
//         uint _minimumPrice,
//         uint _maxPayout,
//         uint _fee,
//         uint _maxDebt,
//         uint _initialDebt
//     ) external onlyPolicy() {
//         require( terms.controlVariable == 0, "Bonds must be initialized from 0" );
//         terms = Terms ({
//             controlVariable: _controlVariable,
//             vestingTerm: _vestingTerm,
//             minimumPrice: _minimumPrice,
//             maxPayout: _maxPayout,
//             fee: _fee,
//             maxDebt: _maxDebt
//         });
//         totalDebt = _initialDebt;
//         lastDecay = block.number;
//     }



    
//     /* ======== POLICY FUNCTIONS ======== */

//     enum PARAMETER { VESTING, PAYOUT, FEE, DEBT }
//     /**
//      *  @notice set parameters for new bonds
//      *  @param _parameter PARAMETER
//      *  @param _input uint
//      */
//     function setBondTerms ( PARAMETER _parameter, uint _input ) external onlyPolicy() {
//         if ( _parameter == PARAMETER.VESTING ) { // 0
//             require( _input >= 10000, "Vesting must be longer than 36 hours" );
//             terms.vestingTerm = _input;
//         } else if ( _parameter == PARAMETER.PAYOUT ) { // 1
//             require( _input <= 1000, "Payout cannot be above 1 percent" );
//             terms.maxPayout = _input;
//         } else if ( _parameter == PARAMETER.FEE ) { // 2
//             require( _input <= 10000, "DAO fee cannot exceed payout" );
//             terms.fee = _input;
//         } else if ( _parameter == PARAMETER.DEBT ) { // 3
//             terms.maxDebt = _input;
//         }
//     }

//     /**
//      *  @notice set control variable adjustment
//      *  @param _addition bool
//      *  @param _increment uint
//      *  @param _target uint
//      *  @param _buffer uint
//      */
//     function setAdjustment ( 
//         bool _addition,
//         uint _increment, 
//         uint _target,
//         uint _buffer 
//     ) external onlyPolicy() {
//         require( _increment <= terms.controlVariable.mul( 25 ).div( 1000 ), "Increment too large" );

//         adjustment = Adjust({
//             add: _addition,
//             rate: _increment,
//             target: _target,
//             buffer: _buffer,
//             lastBlock: block.number
//         });
//     }

//     /**
//      *  @notice set contract for auto stake
//      *  @param _staking address
//      *  @param _helper bool
//      */
//     function setStaking( address _staking, bool _helper ) external onlyPolicy() {
//         require( _staking != address(0) );
//         if ( _helper ) {
//             useHelper = true;
//             stakingHelper = _staking;
//         } else {
//             useHelper = false;
//             staking = _staking;
//         }
//     }


    

//     /* ======== USER FUNCTIONS ======== */

//     /**
//      *  @notice deposit bond
//      *  @param _amount uint
//      *  @param _maxPrice uint
//      *  @param _depositor address
//      *  @return uint
//      */
//     function deposit( 
//         uint _amount, 
//         uint _maxPrice,
//         address _depositor
//     ) external returns ( uint ) {
//         require( _depositor != address(0), "Invalid address" );

//         decayDebt();
//         require( totalDebt <= terms.maxDebt, "Max capacity reached" );
        
//         uint priceInUSD = bondPriceInUSD(); // Stored in bond info
//         uint nativePrice = _bondPrice();

//         require( _maxPrice >= nativePrice, "Slippage limit: more than max price" ); // slippage protection

//         uint value = ITreasury( treasury ).valueOf( principle, _amount );
//         uint payout = payoutFor( value ); // payout to bonder is computed

//         require( payout >= 10000000, "Bond too small" ); // must be > 0.01 OHM ( underflow protection )
//         require( payout <= maxPayout(), "Bond too large"); // size protection because there is no slippage

//         // profits are calculated
//         uint fee = payout.mul( terms.fee ).div( 10000 );
//         uint profit = value.sub( payout ).sub( fee );

//         /**
//             principle is transferred in
//             approved and
//             deposited into the treasury, returning (_amount - profit) OHM
//          */
//         IERC20( principle ).safeTransferFrom( msg.sender, address(this), _amount );
//         IERC20( principle ).approve( address( treasury ), _amount );
//         ITreasury( treasury ).deposit( _amount, principle, profit );
        
//         if ( fee != 0 ) { // fee is transferred to dao 
//             IERC20( OHM ).safeTransfer( DAO, fee ); 
//         }
        
//         // total debt is increased
//         totalDebt = totalDebt.add( value ); 
                
//         // depositor info is stored
//         bondInfo[ _depositor ] = Bond({ 
//             payout: bondInfo[ _depositor ].payout.add( payout ),
//             vesting: terms.vestingTerm,
//             lastBlock: block.number,
//             pricePaid: priceInUSD
//         });

//         // indexed events are emitted
//         emit BondCreated( _amount, payout, block.number.add( terms.vestingTerm ), priceInUSD );
//         emit BondPriceChanged( bondPriceInUSD(), _bondPrice(), debtRatio() );

//         adjust(); // control variable is adjusted
//         return payout; 
//     }

//     /** 
//      *  @notice redeem bond for user
//      *  @param _recipient address
//      *  @param _stake bool
//      *  @return uint
//      */ 
//     function redeem( address _recipient, bool _stake ) external returns ( uint ) {        
//         Bond memory info = bondInfo[ _recipient ];
//         uint percentVested = percentVestedFor( _recipient ); // (blocks since last interaction / vesting term remaining)

//         if ( percentVested >= 10000 ) { // if fully vested
//             delete bondInfo[ _recipient ]; // delete user info
//             emit BondRedeemed( _recipient, info.payout, 0 ); // emit bond data
//             return stakeOrSend( _recipient, _stake, info.payout ); // pay user everything due

//         } else { // if unfinished
//             // calculate payout vested
//             uint payout = info.payout.mul( percentVested ).div( 10000 );

//             // store updated deposit info
//             bondInfo[ _recipient ] = Bond({
//                 payout: info.payout.sub( payout ),
//                 vesting: info.vesting.sub( block.number.sub( info.lastBlock ) ),
//                 lastBlock: block.number,
//                 pricePaid: info.pricePaid
//             });

//             emit BondRedeemed( _recipient, payout, bondInfo[ _recipient ].payout );
//             return stakeOrSend( _recipient, _stake, payout );
//         }
//     }



    
//     /* ======== INTERNAL HELPER FUNCTIONS ======== */

//     /**
//      *  @notice allow user to stake payout automatically
//      *  @param _stake bool
//      *  @param _amount uint
//      *  @return uint
//      */
//     function stakeOrSend( address _recipient, bool _stake, uint _amount ) internal returns ( uint ) {
//         if ( !_stake ) { // if user does not want to stake
//             IERC20( OHM ).transfer( _recipient, _amount ); // send payout
//         } else { // if user wants to stake
//             if ( useHelper ) { // use if staking warmup is 0
//                 IERC20( OHM ).approve( stakingHelper, _amount );
//                 IStakingHelper( stakingHelper ).stake( _amount, _recipient );
//             } else {
//                 IERC20( OHM ).approve( staking, _amount );
//                 IStaking( staking ).stake( _amount, _recipient );
//             }
//         }
//         return _amount;
//     }

//     /**
//      *  @notice makes incremental adjustment to control variable
//      */
//     function adjust() internal {
//         uint blockCanAdjust = adjustment.lastBlock.add( adjustment.buffer );
//         if( adjustment.rate != 0 && block.number >= blockCanAdjust ) {
//             uint initial = terms.controlVariable;
//             if ( adjustment.add ) {
//                 terms.controlVariable = terms.controlVariable.add( adjustment.rate );
//                 if ( terms.controlVariable >= adjustment.target ) {
//                     adjustment.rate = 0;
//                 }
//             } else {
//                 terms.controlVariable = terms.controlVariable.sub( adjustment.rate );
//                 if ( terms.controlVariable <= adjustment.target ) {
//                     adjustment.rate = 0;
//                 }
//             }
//             adjustment.lastBlock = block.number;
//             emit ControlVariableAdjustment( initial, terms.controlVariable, adjustment.rate, adjustment.add );
//         }
//     }

//     /**
//      *  @notice reduce total debt
//      */
//     function decayDebt() internal {
//         totalDebt = totalDebt.sub( debtDecay() );
//         lastDecay = block.number;
//     }




//     /* ======== VIEW FUNCTIONS ======== */

//     /**
//      *  @notice determine maximum bond size
//      *  @return uint
//      */
//     function maxPayout() public view returns ( uint ) {
//         return IERC20( OHM ).totalSupply().mul( terms.maxPayout ).div( 100000 );
//     }

//     /**
//      *  @notice calculate interest due for new bond
//      *  @param _value uint
//      *  @return uint
//      */
//     function payoutFor( uint _value ) public view returns ( uint ) {
//         return FixedPoint.fraction( _value, bondPrice() ).decode112with18().div( 1e16 );
//     }


//     /**
//      *  @notice calculate current bond premium
//      *  @return price_ uint
//      */
//     function bondPrice() public view returns ( uint price_ ) {        
//         price_ = terms.controlVariable.mul( debtRatio() ).add( 1000000000 ).div( 1e7 );
//         if ( price_ < terms.minimumPrice ) {
//             price_ = terms.minimumPrice;
//         }
//     }

//     /**
//      *  @notice calculate current bond price and remove floor if above
//      *  @return price_ uint
//      */
//     function _bondPrice() internal returns ( uint price_ ) {
//         price_ = terms.controlVariable.mul( debtRatio() ).add( 1000000000 ).div( 1e7 );
//         if ( price_ < terms.minimumPrice ) {
//             price_ = terms.minimumPrice;        
//         } else if ( terms.minimumPrice != 0 ) {
//             terms.minimumPrice = 0;
//         }
//     }

//     /**
//      *  @notice converts bond price to DAI value
//      *  @return price_ uint
//      */
//     function bondPriceInUSD() public view returns ( uint price_ ) {
//         if( isLiquidityBond ) {
//             price_ = bondPrice().mul( IBondCalculator( bondCalculator ).markdown( principle ) ).div( 100 );
//         } else {
//             price_ = bondPrice().mul( 10 ** IERC20( principle ).decimals() ).div( 100 );
//         }
//     }


//     /**
//      *  @notice calculate current ratio of debt to OHM supply
//      *  @return debtRatio_ uint
//      */
//     function debtRatio() public view returns ( uint debtRatio_ ) {   
//         uint supply = IERC20( OHM ).totalSupply();
//         debtRatio_ = FixedPoint.fraction( 
//             currentDebt().mul( 1e9 ), 
//             supply
//         ).decode112with18().div( 1e18 );
//     }

//     /**
//      *  @notice debt ratio in same terms for reserve or liquidity bonds
//      *  @return uint
//      */
//     function standardizedDebtRatio() external view returns ( uint ) {
//         if ( isLiquidityBond ) {
//             return debtRatio().mul( IBondCalculator( bondCalculator ).markdown( principle ) ).div( 1e9 );
//         } else {
//             return debtRatio();
//         }
//     }

//     /**
//      *  @notice calculate debt factoring in decay
//      *  @return uint
//      */
//     function currentDebt() public view returns ( uint ) {
//         return totalDebt.sub( debtDecay() );
//     }

//     /**
//      *  @notice amount to decay total debt by
//      *  @return decay_ uint
//      */
//     function debtDecay() public view returns ( uint decay_ ) {
//         uint blocksSinceLast = block.number.sub( lastDecay );
//         decay_ = totalDebt.mul( blocksSinceLast ).div( terms.vestingTerm );
//         if ( decay_ > totalDebt ) {
//             decay_ = totalDebt;
//         }
//     }


//     /**
//      *  @notice calculate how far into vesting a depositor is
//      *  @param _depositor address
//      *  @return percentVested_ uint
//      */
//     function percentVestedFor( address _depositor ) public view returns ( uint percentVested_ ) {
//         Bond memory bond = bondInfo[ _depositor ];
//         uint blocksSinceLast = block.number.sub( bond.lastBlock );
//         uint vesting = bond.vesting;

//         if ( vesting > 0 ) {
//             percentVested_ = blocksSinceLast.mul( 10000 ).div( vesting );
//         } else {
//             percentVested_ = 0;
//         }
//     }

//     /**
//      *  @notice calculate amount of OHM available for claim by depositor
//      *  @param _depositor address
//      *  @return pendingPayout_ uint
//      */
//     function pendingPayoutFor( address _depositor ) external view returns ( uint pendingPayout_ ) {
//         uint percentVested = percentVestedFor( _depositor );
//         uint payout = bondInfo[ _depositor ].payout;

//         if ( percentVested >= 10000 ) {
//             pendingPayout_ = payout;
//         } else {
//             pendingPayout_ = payout.mul( percentVested ).div( 10000 );
//         }
//     }




//     /* ======= AUXILLIARY ======= */

//     /**
//      *  @notice allow anyone to send lost tokens (excluding principle or OHM) to the DAO
//      *  @return bool
//      */
//     function recoverLostToken( address _token ) external returns ( bool ) {
//         require( _token != OHM );
//         require( _token != principle );
//         IERC20( _token ).safeTransfer( DAO, IERC20( _token ).balanceOf( address(this) ) );
//         return true;
//     }
// }

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Staking/Owned.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;

// https://docs.synthetix.io/contracts/Owned
contract Owned {
    address public owner;
    address public nominatedOwner;

    constructor (address _owner) public {
        require(_owner != address(0), "Owner address cannot be 0");
        owner = _owner;
        emit OwnerChanged(address(0), _owner);
    }

    function nominateNewOwner(address _owner) external onlyOwner {
        nominatedOwner = _owner;
        emit OwnerNominated(_owner);
    }

    function acceptOwnership() external {
        require(msg.sender == nominatedOwner, "You must be nominated before you can accept ownership");
        emit OwnerChanged(owner, nominatedOwner);
        owner = nominatedOwner;
        nominatedOwner = address(0);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner may perform this action");
        _;
    }

    event OwnerNominated(address newOwner);
    event OwnerChanged(address oldOwner, address newOwner);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Uniswap/TransferHelper.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;

// helper methods for interacting with ERC20 tokens and sending ETH that do not consistently return true/false
library TransferHelper {
    function safeApprove(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: APPROVE_FAILED');
    }

    function safeTransfer(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');
    }

    function safeTransferFrom(address token, address from, address to, uint value) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FROM_FAILED');
    }

    function safeTransferETH(address to, uint value) internal {
        (bool success,) = to.call{value:value}(new bytes(0));
        require(success, 'TransferHelper: ETH_TRANSFER_FAILED');
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Uniswap/Interfaces/IUniswapV2Router01.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;

interface IUniswapV2Router01 {
    function factory() external returns (address);
    function WETH() external returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Uniswap/Interfaces/IUniswapV2Router02.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Uniswap/Interfaces/IUniswapV2Pair.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;












    
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Proxy/Initializable.sol

// SPDX-License-Identifier: MIT

// solhint-disable-next-line compiler-version
pragma solidity >=0.6.0 <0.9.0;

/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since a proxied contract can't have a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * TIP: To avoid leaving the proxy in an uninitialized state, the initializer function should be called as early as
 * possible by providing the encoded function call as the `_data` argument to {ERC1967Proxy-constructor}.
 *
 * CAUTION: When used with inheritance, manual care must be taken to not invoke a parent initializer twice, or to ensure
 * that all initializers are idempotent. This is not verified automatically as constructors are by Solidity.
 */
abstract contract Initializable {

    /**
     * @dev Indicates that the contract has been initialized.
     */
    bool private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Modifier to protect an initializer function from being invoked twice.
     */
    modifier initializer() {
        require(_initializing || !_initialized, "Initializable: contract is already initialized");

        bool isTopLevelCall = !_initializing;
        if (isTopLevelCall) {
            _initializing = true;
            _initialized = true;
        }

        _;

        if (isTopLevelCall) {
            _initializing = false;
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/OHM_AMO_V3.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

// ====================================================================
// |     ______                   _______                             |
// |    / _____________ __  __   / ____(_____  ____ _____  ________   |
// |   / /_  / ___/ __ `| |/_/  / /_  / / __ \/ __ `/ __ \/ ___/ _ \  |
// |  / __/ / /  / /_/ _>  <   / __/ / / / / / /_/ / / / / /__/  __/  |
// | /_/   /_/   \__,_/_/|_|  /_/   /_/_/ /_/\__,_/_/ /_/\___/\___/   |
// |                                                                  |
// ====================================================================
// ============================ OHM_AMO_V3 ============================
// ====================================================================
// Frax Finance: https://github.com/FraxFinance

// Primary Author(s)
// Travis Moore: https://github.com/FortisFortuna

// Reviewer(s) / Contributor(s)
// Jason Huan: https://github.com/jasonhuan
// Sam Kazemian: https://github.com/samkazemian
















// The AMO needs to have 
// 1) Mint FRAX -> Bond (coming next week) -> Collect OHM rewards
// 2) Stake OHM and be able to collect rewards and also withdraw the staked OHM
// 3) Collect OHM rewards and send to custodian
// 4) Sell OHM for FRAX

contract OHM_AMO_V3 is Owned {
    using SafeMath for uint256;
    // SafeMath automatically included in Solidity >= 8.0.0

    /* ========== STATE VARIABLES ========== */

    // FRAX related
    IFrax private FRAX = IFrax(0x853d955aCEf822Db058eb8505911ED77F175b99e);
    IFraxAMOMinter private amo_minter;
    address public timelock_address;
    address public custodian_address;

    // Uniswap related
    IUniswapV2Router02 private UniRouterV2;
    IUniswapV2Pair private UNI_OHM_FRAX_PAIR;
    address payable public UNISWAP_ROUTER_ADDRESS;

    // OHM related
    IOlympusERC20Token private OHM;
    IsOlympus private sOHM;
    IStakingHelper private stakingHelper;
    IOlympusStaking private olympusStaking;
    IOlympusBondDepository private bondDepository;

    // Precision
    uint256 private missing_decimals_collat;
    uint256 private missing_decimals_ohm;
    uint256 private PRICE_PRECISION;
    
    /* ========== MODIFIERS ========== */

    modifier onlyByOwnGov() {
        require(msg.sender == timelock_address || msg.sender == owner, "Not owner or timelock");
        _;
    }

    modifier onlyByOwnGovCust() {
        require(msg.sender == timelock_address || msg.sender == owner || msg.sender == custodian_address, "Not owner, tlck, or custd");
        _;
    }

    modifier onlyByMinter() {
        require(msg.sender == address(amo_minter), "Not minter");
        _;
    }

    /* ========== CONSTRUCTOR ========== */
    
    constructor (
        address _owner_address,
        address _amo_minter_address
    ) Owned(_owner_address) {
        owner = _owner_address;
        FRAX = IFrax(0x853d955aCEf822Db058eb8505911ED77F175b99e);
        amo_minter = IFraxAMOMinter(_amo_minter_address);

        // Assignments (must be done in initializer, so assignment gets stored in proxy address's storage instead of implementation address's storage)
        // Olympus
        OHM = IOlympusERC20Token(0x383518188C0C6d7730D91b2c03a03C837814a899);
        sOHM = IsOlympus(0x04F2694C8fcee23e8Fd0dfEA1d4f5Bb8c352111F);
        stakingHelper = IStakingHelper(0xC8C436271f9A6F10a5B80c8b8eD7D0E8f37a612d);
        olympusStaking = IOlympusStaking(0xFd31c7d00Ca47653c6Ce64Af53c1571f9C36566a);
        bondDepository = IOlympusBondDepository(0x8510c8c2B6891E04864fa196693D44E6B6ec2514);

        // Uniswap
        UNISWAP_ROUTER_ADDRESS = payable(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        UniRouterV2 = IUniswapV2Router02(UNISWAP_ROUTER_ADDRESS);
        UNI_OHM_FRAX_PAIR = IUniswapV2Pair(0x2dcE0dDa1C2f98e0F171DE8333c3c6Fe1BbF4877);

        PRICE_PRECISION = 1e6;
        missing_decimals_collat = 12;
        missing_decimals_ohm = 9;

        // Get the custodian and timelock addresses from the minter
        custodian_address = amo_minter.custodian_address();
        timelock_address = amo_minter.timelock_address();
    }

    /* ========== VIEWS ========== */

    function showAllocations() public view returns (uint256[5] memory allocations) {
        // All numbers given are in FRAX unless otherwise stated
        // Call once to save gas
        (uint256 spot_price_ohm_raw, ) = spotPriceOHM();

        allocations[0] = FRAX.balanceOf(address(this)); // Unallocated FRAX
        allocations[1] = OHM.balanceOf(address(this)).mul(spot_price_ohm_raw); // OHM
        allocations[2] = sOHM.balanceOf(address(this)).mul(spot_price_ohm_raw); // sOHM
        allocations[3] = (bondDepository.pendingPayoutFor(address(this))).mul(spot_price_ohm_raw); // Claimable OHM from bonding
    
        uint256 sum_tally = 0;
        for (uint i = 0; i < 4; i++){ 
            if (allocations[i] > 0){
                sum_tally = sum_tally.add(allocations[i]);
            }
        }

        allocations[4] = sum_tally; // Total Staked
    }

    function showSOHMRewards() external view returns (uint256) {
        return sOHM.balanceOf(address(this));
    }

    function spotPriceOHM() public view returns (uint256 frax_per_ohm_raw, uint256 frax_per_ohm) {
        (uint256 reserve0, uint256 reserve1, ) = (UNI_OHM_FRAX_PAIR.getReserves());

        // OHM = token0, FRAX = token1
        frax_per_ohm_raw = reserve1.div(reserve0);
        frax_per_ohm = reserve1.mul(PRICE_PRECISION).div(reserve0.mul(10 ** missing_decimals_ohm));
    }

    function dollarBalances() public view returns (uint256 frax_val_e18, uint256 collat_val_e18) {
        frax_val_e18 = showAllocations()[4];
        collat_val_e18 = (frax_val_e18).mul(FRAX.global_collateral_ratio()).div(PRICE_PRECISION);
    }

    // Backwards compatibility
    function mintedBalance() public view returns (int256) {
        return amo_minter.frax_mint_balances(address(this));
    }

    // Backwards compatibility
    function accumulatedProfit() public view returns (int256) {
        return int256(showAllocations()[4]) - mintedBalance();
    }
    
    /* ========== Burns and givebacks ========== */

    // Burn unneeded or excess FRAX. Goes through the minter
    function burnFRAX(uint256 frax_amount) public onlyByOwnGovCust {
        FRAX.approve(address(amo_minter), frax_amount);
        amo_minter.burnFraxFromAMO(frax_amount);
    }

    /* ========== Olympus: Bonding ========== */

    function bondFRAX(uint256 frax_amount) public onlyByOwnGovCust {
        FRAX.approve(address(bondDepository), frax_amount);
        bondDepository.deposit(frax_amount, bondDepository.bondPrice(), address(this));
    }

    function redeemBondedFRAX(bool stake) public onlyByOwnGovCust {
        bondDepository.redeem(address(this), stake);
    }

    function bondInfo() public view returns (uint256 pendingPayout, uint256 percentVested) {
        pendingPayout = bondDepository.pendingPayoutFor(address(this));
        percentVested = bondDepository.percentVestedFor(address(this));
    }

    /* ========== Olympus: Staking ========== */

    // OHM -> sOHM. E9
    // Calls stake and claim together
    function stakeOHM_WithHelper(uint256 ohm_amount) public onlyByOwnGovCust {
        OHM.approve(address(stakingHelper), ohm_amount);
        stakingHelper.stake(ohm_amount);
    }

    // OHM -> sOHM. E9
    // Stake only, no claim
    function stakeOHM_NoHelper(uint256 ohm_amount) public onlyByOwnGovCust {
        OHM.approve(address(olympusStaking), ohm_amount);
        olympusStaking.stake(ohm_amount, address(this));
    }

    // Claim the OHM
    function claimOHM() public onlyByOwnGovCust {
        olympusStaking.claim(address(this));
    }

    // sOHM -> OHM. E9
    // The contract is set up with a warmup period, where user has to stake for some number of epochs before they can 
    // get the sOHM. If they unstake before then they only get the deposit.
    // They earn during warmup period though just can't get rewards before it.
    function unstakeOHM(uint256 sohm_amount, bool rebase) public onlyByOwnGovCust {
        sOHM.approve(address(olympusStaking), sohm_amount);
        olympusStaking.unstake(sohm_amount, rebase);
    }

    // Forfeit takes back the OHM before the warmup is over
    function forfeitOHM() public onlyByOwnGovCust {
        olympusStaking.forfeit();
    }

    // toggleDepositLock() prevents new stakes from being added to the address
    // Anyone can stake for you and it delays the warmup so if someone were to do so maliciously 
    // you'd just toggle that until warmup is done.
    function toggleDepositLock() public onlyByOwnGovCust {
        olympusStaking.toggleDepositLock();
    }

    /* ========== Swaps ========== */

    // FRAX -> OHM. E18 and E9
    function swapFRAXforOHM(uint256 frax_amount, uint256 min_ohm_out) external onlyByOwnGovCust returns (uint256 ohm_spent, uint256 frax_received) {
        // Approve the FRAX for the router
        FRAX.approve(UNISWAP_ROUTER_ADDRESS, frax_amount);

        address[] memory FRAX_OHM_PATH = new address[](2);
        FRAX_OHM_PATH[0] = address(FRAX);
        FRAX_OHM_PATH[1] = address(OHM);

        // Buy some FRAX with OHM
        (uint[] memory amounts) = UniRouterV2.swapExactTokensForTokens(
            frax_amount,
            min_ohm_out,
            FRAX_OHM_PATH,
            address(this),
            block.timestamp + 604800 // Expiration: 7 days from now
        );
        return (amounts[0], amounts[1]);
    }

    // OHM -> FRAX. E9 and E18
    function swapOHMforFRAX(uint256 ohm_amount, uint256 min_frax_out) external onlyByOwnGovCust returns (uint256 ohm_spent, uint256 frax_received) {
        // Approve the OHM for the router
        OHM.approve(UNISWAP_ROUTER_ADDRESS, ohm_amount);

        address[] memory OHM_FRAX_PATH = new address[](2);
        OHM_FRAX_PATH[0] = address(OHM);
        OHM_FRAX_PATH[1] = address(FRAX);

        // Buy some FRAX with OHM
        (uint[] memory amounts) = UniRouterV2.swapExactTokensForTokens(
            ohm_amount,
            min_frax_out,
            OHM_FRAX_PATH,
            address(this),
            block.timestamp + 604800 // Expiration: 7 days from now
        );
        return (amounts[0], amounts[1]);
    }

    /* ========== Rewards ========== */

    function withdrawRewards() public onlyByOwnGovCust {
        OHM.transfer(msg.sender, OHM.balanceOf(address(this)));
    }

    /* ========== RESTRICTED FUNCTIONS ========== */

    function setAMOMinter(address _amo_minter_address) external onlyByOwnGov {
        amo_minter = IFraxAMOMinter(_amo_minter_address);

        // Get the custodian and timelock addresses from the minter
        custodian_address = amo_minter.custodian_address();
        timelock_address = amo_minter.timelock_address();

        // Make sure the new addresses are not address(0)
        require(custodian_address != address(0) && timelock_address != address(0), "Invalid custodian or timelock");
    }

    function recoverERC20(address tokenAddress, uint256 tokenAmount) external onlyByOwnGov {
        TransferHelper.safeTransfer(address(tokenAddress), msg.sender, tokenAmount);
    }

    // Generic proxy
    function execute(
        address _to,
        uint256 _value,
        bytes calldata _data
    ) external onlyByOwnGov returns (bool, bytes memory) {
        (bool success, bytes memory result) = _to.call{value:_value}(_data);
        return (success, result);
    }
}
