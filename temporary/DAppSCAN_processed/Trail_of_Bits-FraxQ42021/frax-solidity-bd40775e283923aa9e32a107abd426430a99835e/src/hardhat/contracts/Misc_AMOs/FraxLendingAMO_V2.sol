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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/FXS/IFxs.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;

interface IFxs {
  function DEFAULT_ADMIN_ROLE() external view returns(bytes32);
  function FRAXStablecoinAdd() external view returns(address);
  function FXS_DAO_min() external view returns(uint256);
  function allowance(address owner, address spender) external view returns(uint256);
  function approve(address spender, uint256 amount) external returns(bool);
  function balanceOf(address account) external view returns(uint256);
  function burn(uint256 amount) external;
  function burnFrom(address account, uint256 amount) external;
  function checkpoints(address, uint32) external view returns(uint32 fromBlock, uint96 votes);
  function decimals() external view returns(uint8);
  function decreaseAllowance(address spender, uint256 subtractedValue) external returns(bool);
  function genesis_supply() external view returns(uint256);
  function getCurrentVotes(address account) external view returns(uint96);
  function getPriorVotes(address account, uint256 blockNumber) external view returns(uint96);
  function getRoleAdmin(bytes32 role) external view returns(bytes32);
  function getRoleMember(bytes32 role, uint256 index) external view returns(address);
  function getRoleMemberCount(bytes32 role) external view returns(uint256);
  function grantRole(bytes32 role, address account) external;
  function hasRole(bytes32 role, address account) external view returns(bool);
  function increaseAllowance(address spender, uint256 addedValue) external returns(bool);
  function mint(address to, uint256 amount) external;
  function name() external view returns(string memory);
  function numCheckpoints(address) external view returns(uint32);
  function oracle_address() external view returns(address);
  function owner_address() external view returns(address);
  function pool_burn_from(address b_address, uint256 b_amount) external;
  function pool_mint(address m_address, uint256 m_amount) external;
  function renounceRole(bytes32 role, address account) external;
  function revokeRole(bytes32 role, address account) external;
  function setFRAXAddress(address frax_contract_address) external;
  function setFXSMinDAO(uint256 min_FXS) external;
  function setOracle(address new_oracle) external;
  function setOwner(address _owner_address) external;
  function setTimelock(address new_timelock) external;
  function symbol() external view returns(string memory);
  function timelock_address() external view returns(address);
  function toggleVotes() external;
  function totalSupply() external view returns(uint256);
  function trackingVotes() external view returns(bool);
  function transfer(address recipient, uint256 amount) external returns(bool);
  function transferFrom(address sender, address recipient, uint256 amount) external returns(bool);
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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Uniswap/Interfaces/IUniswapV2Factory.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Math/Babylonian.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;

// computes square roots using the babylonian method
// https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method
library Babylonian {
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
        // else z = 0
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Math/FixedPoint.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;

// a library for handling binary fixed point numbers (https://en.wikipedia.org/wiki/Q_(number_format))
library FixedPoint {
    // range: [0, 2**112 - 1]
    // resolution: 1 / 2**112
    struct uq112x112 {
        uint224 _x;
    }

    // range: [0, 2**144 - 1]
    // resolution: 1 / 2**112
    struct uq144x112 {
        uint _x;
    }

    uint8 private constant RESOLUTION = 112;
    uint private constant Q112 = uint(1) << RESOLUTION;
    uint private constant Q224 = Q112 << RESOLUTION;

    // encode a uint112 as a UQ112x112
    function encode(uint112 x) internal pure returns (uq112x112 memory) {
        return uq112x112(uint224(x) << RESOLUTION);
    }

    // encodes a uint144 as a UQ144x112
    function encode144(uint144 x) internal pure returns (uq144x112 memory) {
        return uq144x112(uint256(x) << RESOLUTION);
    }

    // divide a UQ112x112 by a uint112, returning a UQ112x112
    function div(uq112x112 memory self, uint112 x) internal pure returns (uq112x112 memory) {
        require(x != 0, 'FixedPoint: DIV_BY_ZERO');
        return uq112x112(self._x / uint224(x));
    }

    // multiply a UQ112x112 by a uint, returning a UQ144x112
    // reverts on overflow
    function mul(uq112x112 memory self, uint y) internal pure returns (uq144x112 memory) {
        uint z;
        require(y == 0 || (z = uint(self._x) * y) / y == uint(self._x), "FixedPoint: MULTIPLICATION_OVERFLOW");
        return uq144x112(z);
    }

    // returns a UQ112x112 which represents the ratio of the numerator to the denominator
    // equivalent to encode(numerator).div(denominator)
    function fraction(uint112 numerator, uint112 denominator) internal pure returns (uq112x112 memory) {
        require(denominator > 0, "FixedPoint: DIV_BY_ZERO");
        return uq112x112((uint224(numerator) << RESOLUTION) / denominator);
    }

    // decode a UQ112x112 into a uint112 by truncating after the radix point
    function decode(uq112x112 memory self) internal pure returns (uint112) {
        return uint112(self._x >> RESOLUTION);
    }

    // decode a UQ144x112 into a uint144 by truncating after the radix point
    function decode144(uq144x112 memory self) internal pure returns (uint144) {
        return uint144(self._x >> RESOLUTION);
    }

    // take the reciprocal of a UQ112x112
    function reciprocal(uq112x112 memory self) internal pure returns (uq112x112 memory) {
        require(self._x != 0, 'FixedPoint: ZERO_RECIPROCAL');
        return uq112x112(uint224(Q224 / self._x));
    }

    // square root of a UQ112x112
    function sqrt(uq112x112 memory self) internal pure returns (uq112x112 memory) {
        return uq112x112(uint224(Babylonian.sqrt(uint256(self._x)) << 56));
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Uniswap/UniswapV2OracleLibrary.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;


// library with helper methods for oracles that are concerned with computing average prices
library UniswapV2OracleLibrary {
    using FixedPoint for *;

    // helper function that returns the current block timestamp within the range of uint32, i.e. [0, 2**32 - 1]
    function currentBlockTimestamp() internal view returns (uint32) {
        return uint32(block.timestamp % 2 ** 32);
    }

    // produces the cumulative price using counterfactuals to save gas and avoid a call to sync.
    function currentCumulativePrices(
        address pair
    ) internal view returns (uint price0Cumulative, uint price1Cumulative, uint32 blockTimestamp) {
        blockTimestamp = currentBlockTimestamp();
        price0Cumulative = IUniswapV2Pair(pair).price0CumulativeLast();
        price1Cumulative = IUniswapV2Pair(pair).price1CumulativeLast();

        // if time has elapsed since the last update on the pair, mock the accumulated price values
        (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast) = IUniswapV2Pair(pair).getReserves();
        if (blockTimestampLast != blockTimestamp) {
            // subtraction overflow is desired
            uint32 timeElapsed = blockTimestamp - blockTimestampLast;
            // addition overflow is desired
            // counterfactual
            price0Cumulative += uint(FixedPoint.fraction(reserve1, reserve0)._x) * timeElapsed;
            // counterfactual
            price1Cumulative += uint(FixedPoint.fraction(reserve0, reserve1)._x) * timeElapsed;
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Uniswap/UniswapV2Library.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;


library UniswapV2Library {
    using SafeMath for uint;

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'UniswapV2Library: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UniswapV2Library: ZERO_ADDRESS');
    }

    // Less efficient than the CREATE2 method below
    function pairFor(address factory, address tokenA, address tokenB) internal view returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = IUniswapV2Factory(factory).getPair(token0, token1);
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairForCreate2(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(uint160(bytes20(keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f' // init code hash
            ))))); // this matches the CREATE2 in UniswapV2Factory.createPair
    }

    // fetches and sorts the reserves for a pair
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
        (address token0,) = sortTokens(tokenA, tokenB);
        (uint reserve0, uint reserve1,) = IUniswapV2Pair(pairFor(factory, tokenA, tokenB)).getReserves();
        (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, 'UniswapV2Library: INSUFFICIENT_AMOUNT');
        require(reserveA > 0 && reserveB > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) internal pure returns (uint amountOut) {
        require(amountIn > 0, 'UniswapV2Library: INSUFFICIENT_INPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint amountInWithFee = amountIn.mul(997);
        uint numerator = amountInWithFee.mul(reserveOut);
        uint denominator = reserveIn.mul(1000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) internal pure returns (uint amountIn) {
        require(amountOut > 0, 'UniswapV2Library: INSUFFICIENT_OUTPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint numerator = reserveIn.mul(amountOut).mul(1000);
        uint denominator = reserveOut.sub(amountOut).mul(997);
        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    function getAmountsOut(address factory, uint amountIn, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[0] = amountIn;
        for (uint i = 0; i < path.length - 1; i++) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i], path[i + 1]);
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    function getAmountsIn(address factory, uint amountOut, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint i = path.length - 1; i > 0; i--) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i - 1], path[i]);
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
}

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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Oracle/UniswapPairOracle.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;





// Fixed window oracle that recomputes the average price for the entire period once every period
// Note that the price average is only guaranteed to be over at least 1 period, but may be over a longer period
contract UniswapPairOracle is Owned {
    using FixedPoint for *;
    
    address timelock_address;

    uint public PERIOD = 3600; // 1 hour TWAP (time-weighted average price)
    uint public CONSULT_LENIENCY = 120; // Used for being able to consult past the period end
    bool public ALLOW_STALE_CONSULTS = false; // If false, consult() will fail if the TWAP is stale

    IUniswapV2Pair public immutable pair;
    address public immutable token0;
    address public immutable token1;

    uint    public price0CumulativeLast;
    uint    public price1CumulativeLast;
    uint32  public blockTimestampLast;
    FixedPoint.uq112x112 public price0Average;
    FixedPoint.uq112x112 public price1Average;


    modifier onlyByOwnGov() {
        require(msg.sender == owner || msg.sender == timelock_address, "You are not an owner or the governance timelock");
        _;
    }

    constructor (
        address factory, 
        address tokenA, 
        address tokenB, 
        address _owner_address, 
        address _timelock_address
    ) public Owned(_owner_address) {
        IUniswapV2Pair _pair = IUniswapV2Pair(UniswapV2Library.pairFor(factory, tokenA, tokenB));
        pair = _pair;
        token0 = _pair.token0();
        token1 = _pair.token1();
        price0CumulativeLast = _pair.price0CumulativeLast(); // Fetch the current accumulated price value (1 / 0)
        price1CumulativeLast = _pair.price1CumulativeLast(); // Fetch the current accumulated price value (0 / 1)
        uint112 reserve0;
        uint112 reserve1;
        (reserve0, reserve1, blockTimestampLast) = _pair.getReserves();
        require(reserve0 != 0 && reserve1 != 0, 'UniswapPairOracle: NO_RESERVES'); // Ensure that there's liquidity in the pair

        timelock_address = _timelock_address;
    }

    function setTimelock(address _timelock_address) external onlyByOwnGov {
        timelock_address = _timelock_address;
    }

    function setPeriod(uint _period) external onlyByOwnGov {
        PERIOD = _period;
    }

    function setConsultLeniency(uint _consult_leniency) external onlyByOwnGov {
        CONSULT_LENIENCY = _consult_leniency;
    }

    function setAllowStaleConsults(bool _allow_stale_consults) external onlyByOwnGov {
        ALLOW_STALE_CONSULTS = _allow_stale_consults;
    }

    // Check if update() can be called instead of wasting gas calling it
    function canUpdate() public view returns (bool) {
        uint32 blockTimestamp = UniswapV2OracleLibrary.currentBlockTimestamp();
        uint32 timeElapsed = blockTimestamp - blockTimestampLast; // Overflow is desired
        return (timeElapsed >= PERIOD);
    }

    function update() external {
        (uint price0Cumulative, uint price1Cumulative, uint32 blockTimestamp) =
            UniswapV2OracleLibrary.currentCumulativePrices(address(pair));
        uint32 timeElapsed = blockTimestamp - blockTimestampLast; // Overflow is desired

        // Ensure that at least one full period has passed since the last update
        require(timeElapsed >= PERIOD, 'UniswapPairOracle: PERIOD_NOT_ELAPSED');

        // Overflow is desired, casting never truncates
        // Cumulative price is in (uq112x112 price * seconds) units so we simply wrap it after division by time elapsed
        price0Average = FixedPoint.uq112x112(uint224((price0Cumulative - price0CumulativeLast) / timeElapsed));
        price1Average = FixedPoint.uq112x112(uint224((price1Cumulative - price1CumulativeLast) / timeElapsed));

        price0CumulativeLast = price0Cumulative;
        price1CumulativeLast = price1Cumulative;
        blockTimestampLast = blockTimestamp;
    }

    // Note this will always return 0 before update has been called successfully for the first time.
    function consult(address token, uint amountIn) public view returns (uint amountOut) {
        uint32 blockTimestamp = UniswapV2OracleLibrary.currentBlockTimestamp();
        uint32 timeElapsed = blockTimestamp - blockTimestampLast; // Overflow is desired

        // Ensure that the price is not stale
        require((timeElapsed < (PERIOD + CONSULT_LENIENCY)) || ALLOW_STALE_CONSULTS, 'UniswapPairOracle: PRICE_IS_STALE_NEED_TO_CALL_UPDATE');

        if (token == token0) {
            amountOut = price0Average.mul(amountIn).decode144();
        } else {
            require(token == token1, 'UniswapPairOracle: INVALID_TOKEN');
            amountOut = price1Average.mul(amountIn).decode144();
        }
    }
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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/cream/ICREAM_crFRAX.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;

// Original at https://etherscan.io/address/0xb092b4601850E23903A42EaCBc9D8A0EeC26A4d5
// Some functions were omitted for brevity. See the contract for details

interface ICREAM_crFRAX is IERC20  {
    function getAccountSnapshot(address account) external view returns (uint, uint, uint, uint);
    function borrowRatePerBlock() external view returns (uint);
    function supplyRatePerBlock() external view returns (uint);
    function totalBorrowsCurrent() external view returns (uint);
    function borrowBalanceCurrent(address account) external view returns (uint);
    function borrowBalanceStored(address account) external view returns (uint);
    function exchangeRateCurrent() external view returns (uint);
    function exchangeRateStored() external view returns (uint);
    function getCash() external view returns (uint);
    function accrueInterest() external returns (uint);
    function seize(address liquidator, address borrower, uint seizeTokens) external returns (uint);

    function mint(uint mintAmount) external returns (uint);
    function redeem(uint redeemTokens) external returns (uint);
    function redeemUnderlying(uint redeemAmount) external returns (uint);
}

// pragma solidity ^0.5.16;

// import "./ComptrollerInterface.sol";
// import "./CTokenInterfaces.sol";
// import "./ErrorReporter.sol";
// import "./Exponential.sol";
// import "./EIP20Interface.sol";
// import "./EIP20NonStandardInterface.sol";
// import "./InterestRateModel.sol";

// /**
//  * @title Compound's CToken Contract
//  * @notice Abstract base for CTokens
//  * @author Compound
//  */
// contract CToken is CTokenInterface, Exponential, TokenErrorReporter {
//     /**
//      * @notice Initialize the money market
//      * @param comptroller_ The address of the Comptroller
//      * @param interestRateModel_ The address of the interest rate model
//      * @param initialExchangeRateMantissa_ The initial exchange rate, scaled by 1e18
//      * @param name_ EIP-20 name of this token
//      * @param symbol_ EIP-20 symbol of this token
//      * @param decimals_ EIP-20 decimal precision of this token
//      */
//     function initialize(ComptrollerInterface comptroller_,
//                         InterestRateModel interestRateModel_,
//                         uint initialExchangeRateMantissa_,
//                         string memory name_,
//                         string memory symbol_,
//                         uint8 decimals_) public {
//         require(msg.sender == admin, "only admin may initialize the market");
//         require(accrualBlockNumber == 0 && borrowIndex == 0, "market may only be initialized once");

//         // Set initial exchange rate
//         initialExchangeRateMantissa = initialExchangeRateMantissa_;
//         require(initialExchangeRateMantissa > 0, "initial exchange rate must be greater than zero.");

//         // Set the comptroller
//         uint err = _setComptroller(comptroller_);
//         require(err == uint(Error.NO_ERROR), "setting comptroller failed");

//         // Initialize block number and borrow index (block number mocks depend on comptroller being set)
//         accrualBlockNumber = getBlockNumber();
//         borrowIndex = mantissaOne;

//         // Set the interest rate model (depends on block number / borrow index)
//         err = _setInterestRateModelFresh(interestRateModel_);
//         require(err == uint(Error.NO_ERROR), "setting interest rate model failed");

//         name = name_;
//         symbol = symbol_;
//         decimals = decimals_;

//         // The counter starts true to prevent changing it from zero to non-zero (i.e. smaller cost/refund)
//         _notEntered = true;
//     }

//     /**
//      * @notice Transfer `tokens` tokens from `src` to `dst` by `spender`
//      * @dev Called by both `transfer` and `transferFrom` internally
//      * @param spender The address of the account performing the transfer
//      * @param src The address of the source account
//      * @param dst The address of the destination account
//      * @param tokens The number of tokens to transfer
//      * @return Whether or not the transfer succeeded
//      */
//     function transferTokens(address spender, address src, address dst, uint tokens) internal returns (uint) {
//         /* Fail if transfer not allowed */
//         uint allowed = comptroller.transferAllowed(address(this), src, dst, tokens);
//         if (allowed != 0) {
//             return failOpaque(Error.COMPTROLLER_REJECTION, FailureInfo.TRANSFER_COMPTROLLER_REJECTION, allowed);
//         }

//         /* Do not allow self-transfers */
//         if (src == dst) {
//             return fail(Error.BAD_INPUT, FailureInfo.TRANSFER_NOT_ALLOWED);
//         }

//         /* Get the allowance, infinite for the account owner */
//         uint startingAllowance = 0;
//         if (spender == src) {
//             startingAllowance = type(uint).max;
//         } else {
//             startingAllowance = transferAllowances[src][spender];
//         }

//         /* Do the calculations, checking for {under,over}flow */
//         MathError mathErr;
//         uint allowanceNew;
//         uint srcTokensNew;
//         uint dstTokensNew;

//         (mathErr, allowanceNew) = subUInt(startingAllowance, tokens);
//         if (mathErr != MathError.NO_ERROR) {
//             return fail(Error.MATH_ERROR, FailureInfo.TRANSFER_NOT_ALLOWED);
//         }

//         (mathErr, srcTokensNew) = subUInt(accountTokens[src], tokens);
//         if (mathErr != MathError.NO_ERROR) {
//             return fail(Error.MATH_ERROR, FailureInfo.TRANSFER_NOT_ENOUGH);
//         }

//         (mathErr, dstTokensNew) = addUInt(accountTokens[dst], tokens);
//         if (mathErr != MathError.NO_ERROR) {
//             return fail(Error.MATH_ERROR, FailureInfo.TRANSFER_TOO_MUCH);
//         }

//         /////////////////////////
//         // EFFECTS & INTERACTIONS
//         // (No safe failures beyond this point)

//         accountTokens[src] = srcTokensNew;
//         accountTokens[dst] = dstTokensNew;

//         /* Eat some of the allowance (if necessary) */
//         if (startingAllowance != type(uint).max) {
//             transferAllowances[src][spender] = allowanceNew;
//         }

//         /* We emit a Transfer event */
//         emit Transfer(src, dst, tokens);

//         comptroller.transferVerify(address(this), src, dst, tokens);

//         return uint(Error.NO_ERROR);
//     }

//     /**
//      * @notice Transfer `amount` tokens from `msg.sender` to `dst`
//      * @param dst The address of the destination account
//      * @param amount The number of tokens to transfer
//      * @return Whether or not the transfer succeeded
//      */
//     function transfer(address dst, uint256 amount) external nonReentrant returns (bool) {
//         return transferTokens(msg.sender, msg.sender, dst, amount) == uint(Error.NO_ERROR);
//     }

//     /**
//      * @notice Transfer `amount` tokens from `src` to `dst`
//      * @param src The address of the source account
//      * @param dst The address of the destination account
//      * @param amount The number of tokens to transfer
//      * @return Whether or not the transfer succeeded
//      */
//     function transferFrom(address src, address dst, uint256 amount) external nonReentrant returns (bool) {
//         return transferTokens(msg.sender, src, dst, amount) == uint(Error.NO_ERROR);
//     }

//     /**
//      * @notice Approve `spender` to transfer up to `amount` from `src`
//      * @dev This will overwrite the approval amount for `spender`
//      *  and is subject to issues noted [here](https://eips.ethereum.org/EIPS/eip-20#approve)
//      * @param spender The address of the account which may transfer tokens
//      * @param amount The number of tokens that are approved (-1 means infinite)
//      * @return Whether or not the approval succeeded
//      */
//     function approve(address spender, uint256 amount) external returns (bool) {
//         address src = msg.sender;
//         transferAllowances[src][spender] = amount;
//         emit Approval(src, spender, amount);
//         return true;
//     }

//     /**
//      * @notice Get the current allowance from `owner` for `spender`
//      * @param owner The address of the account which owns the tokens to be spent
//      * @param spender The address of the account which may transfer tokens
//      * @return The number of tokens allowed to be spent (-1 means infinite)
//      */
//     function allowance(address owner, address spender) external view returns (uint256) {
//         return transferAllowances[owner][spender];
//     }

//     /**
//      * @notice Get the token balance of the `owner`
//      * @param owner The address of the account to query
//      * @return The number of tokens owned by `owner`
//      */
//     function balanceOf(address owner) external view returns (uint256) {
//         return accountTokens[owner];
//     }

//     /**
//      * @notice Get the underlying balance of the `owner`
//      * @dev This also accrues interest in a transaction
//      * @param owner The address of the account to query
//      * @return The amount of underlying owned by `owner`
//      */
//     function balanceOfUnderlying(address owner) external returns (uint) {
//         Exp memory exchangeRate = Exp({mantissa: exchangeRateCurrent()});
//         (MathError mErr, uint balance) = mulScalarTruncate(exchangeRate, accountTokens[owner]);
//         require(mErr == MathError.NO_ERROR, "balance could not be calculated");
//         return balance;
//     }

//     /**
//      * @notice Get a snapshot of the account's balances, and the cached exchange rate
//      * @dev This is used by comptroller to more efficiently perform liquidity checks.
//      * @param account Address of the account to snapshot
//      * @return (possible error, token balance, borrow balance, exchange rate mantissa)
//      */
//     function getAccountSnapshot(address account) external view returns (uint, uint, uint, uint) {
//         uint cTokenBalance = accountTokens[account];
//         uint borrowBalance;
//         uint exchangeRateMantissa;

//         MathError mErr;

//         (mErr, borrowBalance) = borrowBalanceStoredInternal(account);
//         if (mErr != MathError.NO_ERROR) {
//             return (uint(Error.MATH_ERROR), 0, 0, 0);
//         }

//         (mErr, exchangeRateMantissa) = exchangeRateStoredInternal();
//         if (mErr != MathError.NO_ERROR) {
//             return (uint(Error.MATH_ERROR), 0, 0, 0);
//         }

//         return (uint(Error.NO_ERROR), cTokenBalance, borrowBalance, exchangeRateMantissa);
//     }

//     /**
//      * @dev Function to simply retrieve block number
//      *  This exists mainly for inheriting test contracts to stub this result.
//      */
//     function getBlockNumber() internal view returns (uint) {
//         return block.number;
//     }

//     /**
//      * @notice Returns the current per-block borrow interest rate for this cToken
//      * @return The borrow interest rate per block, scaled by 1e18
//      */
//     function borrowRatePerBlock() external view returns (uint) {
//         return interestRateModel.getBorrowRate(getCashPrior(), totalBorrows, totalReserves);
//     }

//     /**
//      * @notice Returns the current per-block supply interest rate for this cToken
//      * @return The supply interest rate per block, scaled by 1e18
//      */
//     function supplyRatePerBlock() external view returns (uint) {
//         return interestRateModel.getSupplyRate(getCashPrior(), totalBorrows, totalReserves, reserveFactorMantissa);
//     }

//     /**
//      * @notice Returns the current total borrows plus accrued interest
//      * @return The total borrows with interest
//      */
//     function totalBorrowsCurrent() external nonReentrant returns (uint) {
//         require(accrueInterest() == uint(Error.NO_ERROR), "accrue interest failed");
//         return totalBorrows;
//     }

//     /**
//      * @notice Accrue interest to updated borrowIndex and then calculate account's borrow balance using the updated borrowIndex
//      * @param account The address whose balance should be calculated after updating borrowIndex
//      * @return The calculated balance
//      */
//     function borrowBalanceCurrent(address account) external nonReentrant returns (uint) {
//         require(accrueInterest() == uint(Error.NO_ERROR), "accrue interest failed");
//         return borrowBalanceStored(account);
//     }

//     /**
//      * @notice Return the borrow balance of account based on stored data
//      * @param account The address whose balance should be calculated
//      * @return The calculated balance
//      */
//     function borrowBalanceStored(address account) public view returns (uint) {
//         (MathError err, uint result) = borrowBalanceStoredInternal(account);
//         require(err == MathError.NO_ERROR, "borrowBalanceStored: borrowBalanceStoredInternal failed");
//         return result;
//     }

//     /**
//      * @notice Return the borrow balance of account based on stored data
//      * @param account The address whose balance should be calculated
//      * @return (error code, the calculated balance or 0 if error code is non-zero)
//      */
//     function borrowBalanceStoredInternal(address account) internal view returns (MathError, uint) {
//         /* Note: we do not assert that the market is up to date */
//         MathError mathErr;
//         uint principalTimesIndex;
//         uint result;

//         /* Get borrowBalance and borrowIndex */
//         BorrowSnapshot storage borrowSnapshot = accountBorrows[account];

//         /* If borrowBalance = 0 then borrowIndex is likely also 0.
//          * Rather than failing the calculation with a division by 0, we immediately return 0 in this case.
//          */
//         if (borrowSnapshot.principal == 0) {
//             return (MathError.NO_ERROR, 0);
//         }

//         /* Calculate new borrow balance using the interest index:
//          *  recentBorrowBalance = borrower.borrowBalance * market.borrowIndex / borrower.borrowIndex
//          */
//         (mathErr, principalTimesIndex) = mulUInt(borrowSnapshot.principal, borrowIndex);
//         if (mathErr != MathError.NO_ERROR) {
//             return (mathErr, 0);
//         }

//         (mathErr, result) = divUInt(principalTimesIndex, borrowSnapshot.interestIndex);
//         if (mathErr != MathError.NO_ERROR) {
//             return (mathErr, 0);
//         }

//         return (MathError.NO_ERROR, result);
//     }

//     /**
//      * @notice Accrue interest then return the up-to-date exchange rate
//      * @return Calculated exchange rate scaled by 1e18
//      */
//     function exchangeRateCurrent() public nonReentrant returns (uint) {
//         require(accrueInterest() == uint(Error.NO_ERROR), "accrue interest failed");
//         return exchangeRateStored();
//     }

//     /**
//      * @notice Calculates the exchange rate from the underlying to the CToken
//      * @dev This function does not accrue interest before calculating the exchange rate
//      * @return Calculated exchange rate scaled by 1e18
//      */
//     function exchangeRateStored() public view returns (uint) {
//         (MathError err, uint result) = exchangeRateStoredInternal();
//         require(err == MathError.NO_ERROR, "exchangeRateStored: exchangeRateStoredInternal failed");
//         return result;
//     }

//     /**
//      * @notice Calculates the exchange rate from the underlying to the CToken
//      * @dev This function does not accrue interest before calculating the exchange rate
//      * @return (error code, calculated exchange rate scaled by 1e18)
//      */
//     function exchangeRateStoredInternal() internal view returns (MathError, uint) {
//         uint _totalSupply = totalSupply;
//         if (_totalSupply == 0) {
//             /*
//              * If there are no tokens minted:
//              *  exchangeRate = initialExchangeRate
//              */
//             return (MathError.NO_ERROR, initialExchangeRateMantissa);
//         } else {
//             /*
//              * Otherwise:
//              *  exchangeRate = (totalCash + totalBorrows - totalReserves) / totalSupply
//              */
//             uint totalCash = getCashPrior();
//             uint cashPlusBorrowsMinusReserves;
//             Exp memory exchangeRate;
//             MathError mathErr;

//             (mathErr, cashPlusBorrowsMinusReserves) = addThenSubUInt(totalCash, totalBorrows, totalReserves);
//             if (mathErr != MathError.NO_ERROR) {
//                 return (mathErr, 0);
//             }

//             (mathErr, exchangeRate) = getExp(cashPlusBorrowsMinusReserves, _totalSupply);
//             if (mathErr != MathError.NO_ERROR) {
//                 return (mathErr, 0);
//             }

//             return (MathError.NO_ERROR, exchangeRate.mantissa);
//         }
//     }

//     /**
//      * @notice Get cash balance of this cToken in the underlying asset
//      * @return The quantity of underlying asset owned by this contract
//      */
//     function getCash() external view returns (uint) {
//         return getCashPrior();
//     }

//     /**
//      * @notice Applies accrued interest to total borrows and reserves
//      * @dev This calculates interest accrued from the last checkpointed block
//      *   up to the current block and writes new checkpoint to storage.
//      */
//     function accrueInterest() public returns (uint) {
//         /* Remember the initial block number */
//         uint currentBlockNumber = getBlockNumber();
//         uint accrualBlockNumberPrior = accrualBlockNumber;

//         /* Short-circuit accumulating 0 interest */
//         if (accrualBlockNumberPrior == currentBlockNumber) {
//             return uint(Error.NO_ERROR);
//         }

//         /* Read the previous values out of storage */
//         uint cashPrior = getCashPrior();
//         uint borrowsPrior = totalBorrows;
//         uint reservesPrior = totalReserves;
//         uint borrowIndexPrior = borrowIndex;

//         /* Calculate the current borrow interest rate */
//         uint borrowRateMantissa = interestRateModel.getBorrowRate(cashPrior, borrowsPrior, reservesPrior);
//         require(borrowRateMantissa <= borrowRateMaxMantissa, "borrow rate is absurdly high");

//         /* Calculate the number of blocks elapsed since the last accrual */
//         (MathError mathErr, uint blockDelta) = subUInt(currentBlockNumber, accrualBlockNumberPrior);
//         require(mathErr == MathError.NO_ERROR, "could not calculate block delta");

//         /*
//          * Calculate the interest accumulated into borrows and reserves and the new index:
//          *  simpleInterestFactor = borrowRate * blockDelta
//          *  interestAccumulated = simpleInterestFactor * totalBorrows
//          *  totalBorrowsNew = interestAccumulated + totalBorrows
//          *  totalReservesNew = interestAccumulated * reserveFactor + totalReserves
//          *  borrowIndexNew = simpleInterestFactor * borrowIndex + borrowIndex
//          */

//         Exp memory simpleInterestFactor;
//         uint interestAccumulated;
//         uint totalBorrowsNew;
//         uint totalReservesNew;
//         uint borrowIndexNew;

//         (mathErr, simpleInterestFactor) = mulScalar(Exp({mantissa: borrowRateMantissa}), blockDelta);
//         if (mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.ACCRUE_INTEREST_SIMPLE_INTEREST_FACTOR_CALCULATION_FAILED, uint(mathErr));
//         }

//         (mathErr, interestAccumulated) = mulScalarTruncate(simpleInterestFactor, borrowsPrior);
//         if (mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.ACCRUE_INTEREST_ACCUMULATED_INTEREST_CALCULATION_FAILED, uint(mathErr));
//         }

//         (mathErr, totalBorrowsNew) = addUInt(interestAccumulated, borrowsPrior);
//         if (mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.ACCRUE_INTEREST_NEW_TOTAL_BORROWS_CALCULATION_FAILED, uint(mathErr));
//         }

//         (mathErr, totalReservesNew) = mulScalarTruncateAddUInt(Exp({mantissa: reserveFactorMantissa}), interestAccumulated, reservesPrior);
//         if (mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.ACCRUE_INTEREST_NEW_TOTAL_RESERVES_CALCULATION_FAILED, uint(mathErr));
//         }

//         (mathErr, borrowIndexNew) = mulScalarTruncateAddUInt(simpleInterestFactor, borrowIndexPrior, borrowIndexPrior);
//         if (mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.ACCRUE_INTEREST_NEW_BORROW_INDEX_CALCULATION_FAILED, uint(mathErr));
//         }

//         /////////////////////////
//         // EFFECTS & INTERACTIONS
//         // (No safe failures beyond this point)

//         /* We write the previously calculated values into storage */
//         accrualBlockNumber = currentBlockNumber;
//         borrowIndex = borrowIndexNew;
//         totalBorrows = totalBorrowsNew;
//         totalReserves = totalReservesNew;

//         /* We emit an AccrueInterest event */
//         emit AccrueInterest(cashPrior, interestAccumulated, borrowIndexNew, totalBorrowsNew);

//         return uint(Error.NO_ERROR);
//     }

//     /**
//      * @notice Sender supplies assets into the market and receives cTokens in exchange
//      * @dev Accrues interest whether or not the operation succeeds, unless reverted
//      * @param mintAmount The amount of the underlying asset to supply
//      * @return (uint, uint) An error code (0=success, otherwise a failure, see ErrorReporter.sol), and the actual mint amount.
//      */
//     function mintInternal(uint mintAmount) internal nonReentrant returns (uint, uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but we still want to log the fact that an attempted borrow failed
//             return (fail(Error(error), FailureInfo.MINT_ACCRUE_INTEREST_FAILED), 0);
//         }
//         // mintFresh emits the actual Mint event if successful and logs on errors, so we don't need to
//         return mintFresh(msg.sender, mintAmount);
//     }

//     struct MintLocalVars {
//         Error err;
//         MathError mathErr;
//         uint exchangeRateMantissa;
//         uint mintTokens;
//         uint totalSupplyNew;
//         uint accountTokensNew;
//         uint actualMintAmount;
//     }

//     /**
//      * @notice User supplies assets into the market and receives cTokens in exchange
//      * @dev Assumes interest has already been accrued up to the current block
//      * @param minter The address of the account which is supplying the assets
//      * @param mintAmount The amount of the underlying asset to supply
//      * @return (uint, uint) An error code (0=success, otherwise a failure, see ErrorReporter.sol), and the actual mint amount.
//      */
//     function mintFresh(address minter, uint mintAmount) internal returns (uint, uint) {
//         /* Fail if mint not allowed */
//         uint allowed = comptroller.mintAllowed(address(this), minter, mintAmount);
//         if (allowed != 0) {
//             return (failOpaque(Error.COMPTROLLER_REJECTION, FailureInfo.MINT_COMPTROLLER_REJECTION, allowed), 0);
//         }

//         /* Verify market's block number equals current block number */
//         if (accrualBlockNumber != getBlockNumber()) {
//             return (fail(Error.MARKET_NOT_FRESH, FailureInfo.MINT_FRESHNESS_CHECK), 0);
//         }

//         MintLocalVars memory vars;

//         (vars.mathErr, vars.exchangeRateMantissa) = exchangeRateStoredInternal();
//         if (vars.mathErr != MathError.NO_ERROR) {
//             return (failOpaque(Error.MATH_ERROR, FailureInfo.MINT_EXCHANGE_RATE_READ_FAILED, uint(vars.mathErr)), 0);
//         }

//         /////////////////////////
//         // EFFECTS & INTERACTIONS
//         // (No safe failures beyond this point)

//         /*
//          *  We call `doTransferIn` for the minter and the mintAmount.
//          *  Note: The cToken must handle variations between ERC-20 and ETH underlying.
//          *  `doTransferIn` reverts if anything goes wrong, since we can't be sure if
//          *  side-effects occurred. The function returns the amount actually transferred,
//          *  in case of a fee. On success, the cToken holds an additional `actualMintAmount`
//          *  of cash.
//          */
//         vars.actualMintAmount = doTransferIn(minter, mintAmount);

//         /*
//          * We get the current exchange rate and calculate the number of cTokens to be minted:
//          *  mintTokens = actualMintAmount / exchangeRate
//          */

//         (vars.mathErr, vars.mintTokens) = divScalarByExpTruncate(vars.actualMintAmount, Exp({mantissa: vars.exchangeRateMantissa}));
//         require(vars.mathErr == MathError.NO_ERROR, "MINT_EXCHANGE_CALCULATION_FAILED");

//         /*
//          * We calculate the new total supply of cTokens and minter token balance, checking for overflow:
//          *  totalSupplyNew = totalSupply + mintTokens
//          *  accountTokensNew = accountTokens[minter] + mintTokens
//          */
//         (vars.mathErr, vars.totalSupplyNew) = addUInt(totalSupply, vars.mintTokens);
//         require(vars.mathErr == MathError.NO_ERROR, "MINT_NEW_TOTAL_SUPPLY_CALCULATION_FAILED");

//         (vars.mathErr, vars.accountTokensNew) = addUInt(accountTokens[minter], vars.mintTokens);
//         require(vars.mathErr == MathError.NO_ERROR, "MINT_NEW_ACCOUNT_BALANCE_CALCULATION_FAILED");

//         /* We write previously calculated values into storage */
//         totalSupply = vars.totalSupplyNew;
//         accountTokens[minter] = vars.accountTokensNew;

//         /* We emit a Mint event, and a Transfer event */
//         emit Mint(minter, vars.actualMintAmount, vars.mintTokens);
//         emit Transfer(address(this), minter, vars.mintTokens);

//         /* We call the defense hook */
//         comptroller.mintVerify(address(this), minter, vars.actualMintAmount, vars.mintTokens);

//         return (uint(Error.NO_ERROR), vars.actualMintAmount);
//     }

//     /**
//      * @notice Sender redeems cTokens in exchange for the underlying asset
//      * @dev Accrues interest whether or not the operation succeeds, unless reverted
//      * @param redeemTokens The number of cTokens to redeem into underlying
//      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//      */
//     function redeemInternal(uint redeemTokens) internal nonReentrant returns (uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but we still want to log the fact that an attempted redeem failed
//             return fail(Error(error), FailureInfo.REDEEM_ACCRUE_INTEREST_FAILED);
//         }
//         // redeemFresh emits redeem-specific logs on errors, so we don't need to
//         return redeemFresh(msg.sender, redeemTokens, 0);
//     }

//     /**
//      * @notice Sender redeems cTokens in exchange for a specified amount of underlying asset
//      * @dev Accrues interest whether or not the operation succeeds, unless reverted
//      * @param redeemAmount The amount of underlying to receive from redeeming cTokens
//      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//      */
//     function redeemUnderlyingInternal(uint redeemAmount) internal nonReentrant returns (uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but we still want to log the fact that an attempted redeem failed
//             return fail(Error(error), FailureInfo.REDEEM_ACCRUE_INTEREST_FAILED);
//         }
//         // redeemFresh emits redeem-specific logs on errors, so we don't need to
//         return redeemFresh(msg.sender, 0, redeemAmount);
//     }

//     struct RedeemLocalVars {
//         Error err;
//         MathError mathErr;
//         uint exchangeRateMantissa;
//         uint redeemTokens;
//         uint redeemAmount;
//         uint totalSupplyNew;
//         uint accountTokensNew;
//     }

//     /**
//      * @notice User redeems cTokens in exchange for the underlying asset
//      * @dev Assumes interest has already been accrued up to the current block
//      * @param redeemer The address of the account which is redeeming the tokens
//      * @param redeemTokensIn The number of cTokens to redeem into underlying (only one of redeemTokensIn or redeemAmountIn may be non-zero)
//      * @param redeemAmountIn The number of underlying tokens to receive from redeeming cTokens (only one of redeemTokensIn or redeemAmountIn may be non-zero)
//      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//      */
//     function redeemFresh(address payable redeemer, uint redeemTokensIn, uint redeemAmountIn) internal returns (uint) {
//         require(redeemTokensIn == 0 || redeemAmountIn == 0, "one of redeemTokensIn or redeemAmountIn must be zero");

//         RedeemLocalVars memory vars;

//         /* exchangeRate = invoke Exchange Rate Stored() */
//         (vars.mathErr, vars.exchangeRateMantissa) = exchangeRateStoredInternal();
//         if (vars.mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.REDEEM_EXCHANGE_RATE_READ_FAILED, uint(vars.mathErr));
//         }

//         /* If redeemTokensIn > 0: */
//         if (redeemTokensIn > 0) {
//             /*
//              * We calculate the exchange rate and the amount of underlying to be redeemed:
//              *  redeemTokens = redeemTokensIn
//              *  redeemAmount = redeemTokensIn x exchangeRateCurrent
//              */
//             vars.redeemTokens = redeemTokensIn;

//             (vars.mathErr, vars.redeemAmount) = mulScalarTruncate(Exp({mantissa: vars.exchangeRateMantissa}), redeemTokensIn);
//             if (vars.mathErr != MathError.NO_ERROR) {
//                 return failOpaque(Error.MATH_ERROR, FailureInfo.REDEEM_EXCHANGE_TOKENS_CALCULATION_FAILED, uint(vars.mathErr));
//             }
//         } else {
//             /*
//              * We get the current exchange rate and calculate the amount to be redeemed:
//              *  redeemTokens = redeemAmountIn / exchangeRate
//              *  redeemAmount = redeemAmountIn
//              */

//             (vars.mathErr, vars.redeemTokens) = divScalarByExpTruncate(redeemAmountIn, Exp({mantissa: vars.exchangeRateMantissa}));
//             if (vars.mathErr != MathError.NO_ERROR) {
//                 return failOpaque(Error.MATH_ERROR, FailureInfo.REDEEM_EXCHANGE_AMOUNT_CALCULATION_FAILED, uint(vars.mathErr));
//             }

//             vars.redeemAmount = redeemAmountIn;
//         }

//         /* Fail if redeem not allowed */
//         uint allowed = comptroller.redeemAllowed(address(this), redeemer, vars.redeemTokens);
//         if (allowed != 0) {
//             return failOpaque(Error.COMPTROLLER_REJECTION, FailureInfo.REDEEM_COMPTROLLER_REJECTION, allowed);
//         }

//         /* Verify market's block number equals current block number */
//         if (accrualBlockNumber != getBlockNumber()) {
//             return fail(Error.MARKET_NOT_FRESH, FailureInfo.REDEEM_FRESHNESS_CHECK);
//         }

//         /*
//          * We calculate the new total supply and redeemer balance, checking for underflow:
//          *  totalSupplyNew = totalSupply - redeemTokens
//          *  accountTokensNew = accountTokens[redeemer] - redeemTokens
//          */
//         (vars.mathErr, vars.totalSupplyNew) = subUInt(totalSupply, vars.redeemTokens);
//         if (vars.mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.REDEEM_NEW_TOTAL_SUPPLY_CALCULATION_FAILED, uint(vars.mathErr));
//         }

//         (vars.mathErr, vars.accountTokensNew) = subUInt(accountTokens[redeemer], vars.redeemTokens);
//         if (vars.mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.REDEEM_NEW_ACCOUNT_BALANCE_CALCULATION_FAILED, uint(vars.mathErr));
//         }

//         /* Fail gracefully if protocol has insufficient cash */
//         if (getCashPrior() < vars.redeemAmount) {
//             return fail(Error.TOKEN_INSUFFICIENT_CASH, FailureInfo.REDEEM_TRANSFER_OUT_NOT_POSSIBLE);
//         }

//         /////////////////////////
//         // EFFECTS & INTERACTIONS
//         // (No safe failures beyond this point)

//         /*
//          * We invoke doTransferOut for the redeemer and the redeemAmount.
//          *  Note: The cToken must handle variations between ERC-20 and ETH underlying.
//          *  On success, the cToken has redeemAmount less of cash.
//          *  doTransferOut reverts if anything goes wrong, since we can't be sure if side effects occurred.
//          */
//         doTransferOut(redeemer, vars.redeemAmount);

//         /* We write previously calculated values into storage */
//         totalSupply = vars.totalSupplyNew;
//         accountTokens[redeemer] = vars.accountTokensNew;

//         /* We emit a Transfer event, and a Redeem event */
//         emit Transfer(redeemer, address(this), vars.redeemTokens);
//         emit Redeem(redeemer, vars.redeemAmount, vars.redeemTokens);

//         /* We call the defense hook */
//         comptroller.redeemVerify(address(this), redeemer, vars.redeemAmount, vars.redeemTokens);

//         return uint(Error.NO_ERROR);
//     }

//     /**
//       * @notice Sender borrows assets from the protocol to their own address
//       * @param borrowAmount The amount of the underlying asset to borrow
//       * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//       */
//     function borrowInternal(uint borrowAmount) internal nonReentrant returns (uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but we still want to log the fact that an attempted borrow failed
//             return fail(Error(error), FailureInfo.BORROW_ACCRUE_INTEREST_FAILED);
//         }
//         // borrowFresh emits borrow-specific logs on errors, so we don't need to
//         return borrowFresh(msg.sender, borrowAmount);
//     }

//     struct BorrowLocalVars {
//         MathError mathErr;
//         uint accountBorrows;
//         uint accountBorrowsNew;
//         uint totalBorrowsNew;
//     }

//     /**
//       * @notice Users borrow assets from the protocol to their own address
//       * @param borrowAmount The amount of the underlying asset to borrow
//       * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//       */
//     function borrowFresh(address payable borrower, uint borrowAmount) internal returns (uint) {
//         /* Fail if borrow not allowed */
//         uint allowed = comptroller.borrowAllowed(address(this), borrower, borrowAmount);
//         if (allowed != 0) {
//             return failOpaque(Error.COMPTROLLER_REJECTION, FailureInfo.BORROW_COMPTROLLER_REJECTION, allowed);
//         }

//         /* Verify market's block number equals current block number */
//         if (accrualBlockNumber != getBlockNumber()) {
//             return fail(Error.MARKET_NOT_FRESH, FailureInfo.BORROW_FRESHNESS_CHECK);
//         }

//         /* Fail gracefully if protocol has insufficient underlying cash */
//         if (getCashPrior() < borrowAmount) {
//             return fail(Error.TOKEN_INSUFFICIENT_CASH, FailureInfo.BORROW_CASH_NOT_AVAILABLE);
//         }

//         BorrowLocalVars memory vars;

//         /*
//          * We calculate the new borrower and total borrow balances, failing on overflow:
//          *  accountBorrowsNew = accountBorrows + borrowAmount
//          *  totalBorrowsNew = totalBorrows + borrowAmount
//          */
//         (vars.mathErr, vars.accountBorrows) = borrowBalanceStoredInternal(borrower);
//         if (vars.mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.BORROW_ACCUMULATED_BALANCE_CALCULATION_FAILED, uint(vars.mathErr));
//         }

//         (vars.mathErr, vars.accountBorrowsNew) = addUInt(vars.accountBorrows, borrowAmount);
//         if (vars.mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.BORROW_NEW_ACCOUNT_BORROW_BALANCE_CALCULATION_FAILED, uint(vars.mathErr));
//         }

//         (vars.mathErr, vars.totalBorrowsNew) = addUInt(totalBorrows, borrowAmount);
//         if (vars.mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.BORROW_NEW_TOTAL_BALANCE_CALCULATION_FAILED, uint(vars.mathErr));
//         }

//         /////////////////////////
//         // EFFECTS & INTERACTIONS
//         // (No safe failures beyond this point)

//         /*
//          * We invoke doTransferOut for the borrower and the borrowAmount.
//          *  Note: The cToken must handle variations between ERC-20 and ETH underlying.
//          *  On success, the cToken borrowAmount less of cash.
//          *  doTransferOut reverts if anything goes wrong, since we can't be sure if side effects occurred.
//          */
//         doTransferOut(borrower, borrowAmount);

//         /* We write the previously calculated values into storage */
//         accountBorrows[borrower].principal = vars.accountBorrowsNew;
//         accountBorrows[borrower].interestIndex = borrowIndex;
//         totalBorrows = vars.totalBorrowsNew;

//         /* We emit a Borrow event */
//         emit Borrow(borrower, borrowAmount, vars.accountBorrowsNew, vars.totalBorrowsNew);

//         /* We call the defense hook */
//         comptroller.borrowVerify(address(this), borrower, borrowAmount);

//         return uint(Error.NO_ERROR);
//     }

//     /**
//      * @notice Sender repays their own borrow
//      * @param repayAmount The amount to repay
//      * @return (uint, uint) An error code (0=success, otherwise a failure, see ErrorReporter.sol), and the actual repayment amount.
//      */
//     function repayBorrowInternal(uint repayAmount) internal nonReentrant returns (uint, uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but we still want to log the fact that an attempted borrow failed
//             return (fail(Error(error), FailureInfo.REPAY_BORROW_ACCRUE_INTEREST_FAILED), 0);
//         }
//         // repayBorrowFresh emits repay-borrow-specific logs on errors, so we don't need to
//         return repayBorrowFresh(msg.sender, msg.sender, repayAmount);
//     }

//     /**
//      * @notice Sender repays a borrow belonging to borrower
//      * @param borrower the account with the debt being payed off
//      * @param repayAmount The amount to repay
//      * @return (uint, uint) An error code (0=success, otherwise a failure, see ErrorReporter.sol), and the actual repayment amount.
//      */
//     function repayBorrowBehalfInternal(address borrower, uint repayAmount) internal nonReentrant returns (uint, uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but we still want to log the fact that an attempted borrow failed
//             return (fail(Error(error), FailureInfo.REPAY_BEHALF_ACCRUE_INTEREST_FAILED), 0);
//         }
//         // repayBorrowFresh emits repay-borrow-specific logs on errors, so we don't need to
//         return repayBorrowFresh(msg.sender, borrower, repayAmount);
//     }

//     struct RepayBorrowLocalVars {
//         Error err;
//         MathError mathErr;
//         uint repayAmount;
//         uint borrowerIndex;
//         uint accountBorrows;
//         uint accountBorrowsNew;
//         uint totalBorrowsNew;
//         uint actualRepayAmount;
//     }

//     /**
//      * @notice Borrows are repaid by another user (possibly the borrower).
//      * @param payer the account paying off the borrow
//      * @param borrower the account with the debt being payed off
//      * @param repayAmount the amount of undelrying tokens being returned
//      * @return (uint, uint) An error code (0=success, otherwise a failure, see ErrorReporter.sol), and the actual repayment amount.
//      */
//     function repayBorrowFresh(address payer, address borrower, uint repayAmount) internal returns (uint, uint) {
//         /* Fail if repayBorrow not allowed */
//         uint allowed = comptroller.repayBorrowAllowed(address(this), payer, borrower, repayAmount);
//         if (allowed != 0) {
//             return (failOpaque(Error.COMPTROLLER_REJECTION, FailureInfo.REPAY_BORROW_COMPTROLLER_REJECTION, allowed), 0);
//         }

//         /* Verify market's block number equals current block number */
//         if (accrualBlockNumber != getBlockNumber()) {
//             return (fail(Error.MARKET_NOT_FRESH, FailureInfo.REPAY_BORROW_FRESHNESS_CHECK), 0);
//         }

//         RepayBorrowLocalVars memory vars;

//         /* We remember the original borrowerIndex for verification purposes */
//         vars.borrowerIndex = accountBorrows[borrower].interestIndex;

//         /* We fetch the amount the borrower owes, with accumulated interest */
//         (vars.mathErr, vars.accountBorrows) = borrowBalanceStoredInternal(borrower);
//         if (vars.mathErr != MathError.NO_ERROR) {
//             return (failOpaque(Error.MATH_ERROR, FailureInfo.REPAY_BORROW_ACCUMULATED_BALANCE_CALCULATION_FAILED, uint(vars.mathErr)), 0);
//         }

//         /* If repayAmount == -1, repayAmount = accountBorrows */
//         if (repayAmount == type(uint).max) {
//             vars.repayAmount = vars.accountBorrows;
//         } else {
//             vars.repayAmount = repayAmount;
//         }

//         /////////////////////////
//         // EFFECTS & INTERACTIONS
//         // (No safe failures beyond this point)

//         /*
//          * We call doTransferIn for the payer and the repayAmount
//          *  Note: The cToken must handle variations between ERC-20 and ETH underlying.
//          *  On success, the cToken holds an additional repayAmount of cash.
//          *  doTransferIn reverts if anything goes wrong, since we can't be sure if side effects occurred.
//          *   it returns the amount actually transferred, in case of a fee.
//          */
//         vars.actualRepayAmount = doTransferIn(payer, vars.repayAmount);

//         /*
//          * We calculate the new borrower and total borrow balances, failing on underflow:
//          *  accountBorrowsNew = accountBorrows - actualRepayAmount
//          *  totalBorrowsNew = totalBorrows - actualRepayAmount
//          */
//         (vars.mathErr, vars.accountBorrowsNew) = subUInt(vars.accountBorrows, vars.actualRepayAmount);
//         require(vars.mathErr == MathError.NO_ERROR, "REPAY_BORROW_NEW_ACCOUNT_BORROW_BALANCE_CALCULATION_FAILED");

//         (vars.mathErr, vars.totalBorrowsNew) = subUInt(totalBorrows, vars.actualRepayAmount);
//         require(vars.mathErr == MathError.NO_ERROR, "REPAY_BORROW_NEW_TOTAL_BALANCE_CALCULATION_FAILED");

//         /* We write the previously calculated values into storage */
//         accountBorrows[borrower].principal = vars.accountBorrowsNew;
//         accountBorrows[borrower].interestIndex = borrowIndex;
//         totalBorrows = vars.totalBorrowsNew;

//         /* We emit a RepayBorrow event */
//         emit RepayBorrow(payer, borrower, vars.actualRepayAmount, vars.accountBorrowsNew, vars.totalBorrowsNew);

//         /* We call the defense hook */
//         comptroller.repayBorrowVerify(address(this), payer, borrower, vars.actualRepayAmount, vars.borrowerIndex);

//         return (uint(Error.NO_ERROR), vars.actualRepayAmount);
//     }

//     /**
//      * @notice The sender liquidates the borrowers collateral.
//      *  The collateral seized is transferred to the liquidator.
//      * @param borrower The borrower of this cToken to be liquidated
//      * @param cTokenCollateral The market in which to seize collateral from the borrower
//      * @param repayAmount The amount of the underlying borrowed asset to repay
//      * @return (uint, uint) An error code (0=success, otherwise a failure, see ErrorReporter.sol), and the actual repayment amount.
//      */
//     function liquidateBorrowInternal(address borrower, uint repayAmount, CTokenInterface cTokenCollateral) internal nonReentrant returns (uint, uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but we still want to log the fact that an attempted liquidation failed
//             return (fail(Error(error), FailureInfo.LIQUIDATE_ACCRUE_BORROW_INTEREST_FAILED), 0);
//         }

//         error = cTokenCollateral.accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but we still want to log the fact that an attempted liquidation failed
//             return (fail(Error(error), FailureInfo.LIQUIDATE_ACCRUE_COLLATERAL_INTEREST_FAILED), 0);
//         }

//         // liquidateBorrowFresh emits borrow-specific logs on errors, so we don't need to
//         return liquidateBorrowFresh(msg.sender, borrower, repayAmount, cTokenCollateral);
//     }

//     /**
//      * @notice The liquidator liquidates the borrowers collateral.
//      *  The collateral seized is transferred to the liquidator.
//      * @param borrower The borrower of this cToken to be liquidated
//      * @param liquidator The address repaying the borrow and seizing collateral
//      * @param cTokenCollateral The market in which to seize collateral from the borrower
//      * @param repayAmount The amount of the underlying borrowed asset to repay
//      * @return (uint, uint) An error code (0=success, otherwise a failure, see ErrorReporter.sol), and the actual repayment amount.
//      */
//     function liquidateBorrowFresh(address liquidator, address borrower, uint repayAmount, CTokenInterface cTokenCollateral) internal returns (uint, uint) {
//         /* Fail if liquidate not allowed */
//         uint allowed = comptroller.liquidateBorrowAllowed(address(this), address(cTokenCollateral), liquidator, borrower, repayAmount);
//         if (allowed != 0) {
//             return (failOpaque(Error.COMPTROLLER_REJECTION, FailureInfo.LIQUIDATE_COMPTROLLER_REJECTION, allowed), 0);
//         }

//         /* Verify market's block number equals current block number */
//         if (accrualBlockNumber != getBlockNumber()) {
//             return (fail(Error.MARKET_NOT_FRESH, FailureInfo.LIQUIDATE_FRESHNESS_CHECK), 0);
//         }

//         /* Verify cTokenCollateral market's block number equals current block number */
//         if (cTokenCollateral.accrualBlockNumber() != getBlockNumber()) {
//             return (fail(Error.MARKET_NOT_FRESH, FailureInfo.LIQUIDATE_COLLATERAL_FRESHNESS_CHECK), 0);
//         }

//         /* Fail if borrower = liquidator */
//         if (borrower == liquidator) {
//             return (fail(Error.INVALID_ACCOUNT_PAIR, FailureInfo.LIQUIDATE_LIQUIDATOR_IS_BORROWER), 0);
//         }

//         /* Fail if repayAmount = 0 */
//         if (repayAmount == 0) {
//             return (fail(Error.INVALID_CLOSE_AMOUNT_REQUESTED, FailureInfo.LIQUIDATE_CLOSE_AMOUNT_IS_ZERO), 0);
//         }

//         /* Fail if repayAmount = -1 */
//         if (repayAmount == type(uint).max) {
//             return (fail(Error.INVALID_CLOSE_AMOUNT_REQUESTED, FailureInfo.LIQUIDATE_CLOSE_AMOUNT_IS_UINT_MAX), 0);
//         }


//         /* Fail if repayBorrow fails */
//         (uint repayBorrowError, uint actualRepayAmount) = repayBorrowFresh(liquidator, borrower, repayAmount);
//         if (repayBorrowError != uint(Error.NO_ERROR)) {
//             return (fail(Error(repayBorrowError), FailureInfo.LIQUIDATE_REPAY_BORROW_FRESH_FAILED), 0);
//         }

//         /////////////////////////
//         // EFFECTS & INTERACTIONS
//         // (No safe failures beyond this point)

//         /* We calculate the number of collateral tokens that will be seized */
//         (uint amountSeizeError, uint seizeTokens) = comptroller.liquidateCalculateSeizeTokens(address(this), address(cTokenCollateral), actualRepayAmount);
//         require(amountSeizeError == uint(Error.NO_ERROR), "LIQUIDATE_COMPTROLLER_CALCULATE_AMOUNT_SEIZE_FAILED");

//         /* Revert if borrower collateral token balance < seizeTokens */
//         require(cTokenCollateral.balanceOf(borrower) >= seizeTokens, "LIQUIDATE_SEIZE_TOO_MUCH");

//         // If this is also the collateral, run seizeInternal to avoid re-entrancy, otherwise make an external call
//         uint seizeError;
//         if (address(cTokenCollateral) == address(this)) {
//             seizeError = seizeInternal(address(this), liquidator, borrower, seizeTokens);
//         } else {
//             seizeError = cTokenCollateral.seize(liquidator, borrower, seizeTokens);
//         }

//         /* Revert if seize tokens fails (since we cannot be sure of side effects) */
//         require(seizeError == uint(Error.NO_ERROR), "token seizure failed");

//         /* We emit a LiquidateBorrow event */
//         emit LiquidateBorrow(liquidator, borrower, actualRepayAmount, address(cTokenCollateral), seizeTokens);

//         /* We call the defense hook */
//         comptroller.liquidateBorrowVerify(address(this), address(cTokenCollateral), liquidator, borrower, actualRepayAmount, seizeTokens);

//         return (uint(Error.NO_ERROR), actualRepayAmount);
//     }

//     /**
//      * @notice Transfers collateral tokens (this market) to the liquidator.
//      * @dev Will fail unless called by another cToken during the process of liquidation.
//      *  Its absolutely critical to use msg.sender as the borrowed cToken and not a parameter.
//      * @param liquidator The account receiving seized collateral
//      * @param borrower The account having collateral seized
//      * @param seizeTokens The number of cTokens to seize
//      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//      */
//     function seize(address liquidator, address borrower, uint seizeTokens) external nonReentrant returns (uint) {
//         return seizeInternal(msg.sender, liquidator, borrower, seizeTokens);
//     }

//     /**
//      * @notice Transfers collateral tokens (this market) to the liquidator.
//      * @dev Called only during an in-kind liquidation, or by liquidateBorrow during the liquidation of another CToken.
//      *  Its absolutely critical to use msg.sender as the seizer cToken and not a parameter.
//      * @param seizerToken The contract seizing the collateral (i.e. borrowed cToken)
//      * @param liquidator The account receiving seized collateral
//      * @param borrower The account having collateral seized
//      * @param seizeTokens The number of cTokens to seize
//      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//      */
//     function seizeInternal(address seizerToken, address liquidator, address borrower, uint seizeTokens) internal returns (uint) {
//         /* Fail if seize not allowed */
//         uint allowed = comptroller.seizeAllowed(address(this), seizerToken, liquidator, borrower, seizeTokens);
//         if (allowed != 0) {
//             return failOpaque(Error.COMPTROLLER_REJECTION, FailureInfo.LIQUIDATE_SEIZE_COMPTROLLER_REJECTION, allowed);
//         }

//         /* Fail if borrower = liquidator */
//         if (borrower == liquidator) {
//             return fail(Error.INVALID_ACCOUNT_PAIR, FailureInfo.LIQUIDATE_SEIZE_LIQUIDATOR_IS_BORROWER);
//         }

//         MathError mathErr;
//         uint borrowerTokensNew;
//         uint liquidatorTokensNew;

//         /*
//          * We calculate the new borrower and liquidator token balances, failing on underflow/overflow:
//          *  borrowerTokensNew = accountTokens[borrower] - seizeTokens
//          *  liquidatorTokensNew = accountTokens[liquidator] + seizeTokens
//          */
//         (mathErr, borrowerTokensNew) = subUInt(accountTokens[borrower], seizeTokens);
//         if (mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.LIQUIDATE_SEIZE_BALANCE_DECREMENT_FAILED, uint(mathErr));
//         }

//         (mathErr, liquidatorTokensNew) = addUInt(accountTokens[liquidator], seizeTokens);
//         if (mathErr != MathError.NO_ERROR) {
//             return failOpaque(Error.MATH_ERROR, FailureInfo.LIQUIDATE_SEIZE_BALANCE_INCREMENT_FAILED, uint(mathErr));
//         }

//         /////////////////////////
//         // EFFECTS & INTERACTIONS
//         // (No safe failures beyond this point)

//         /* We write the previously calculated values into storage */
//         accountTokens[borrower] = borrowerTokensNew;
//         accountTokens[liquidator] = liquidatorTokensNew;

//         /* Emit a Transfer event */
//         emit Transfer(borrower, liquidator, seizeTokens);

//         /* We call the defense hook */
//         comptroller.seizeVerify(address(this), seizerToken, liquidator, borrower, seizeTokens);

//         return uint(Error.NO_ERROR);
//     }


//     /*** Admin Functions ***/

//     /**
//       * @notice Begins transfer of admin rights. The newPendingAdmin must call `_acceptAdmin` to finalize the transfer.
//       * @dev Admin function to begin change of admin. The newPendingAdmin must call `_acceptAdmin` to finalize the transfer.
//       * @param newPendingAdmin New pending admin.
//       * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//       */
//     function _setPendingAdmin(address payable newPendingAdmin) external returns (uint) {
//         // Check caller = admin
//         if (msg.sender != admin) {
//             return fail(Error.UNAUTHORIZED, FailureInfo.SET_PENDING_ADMIN_OWNER_CHECK);
//         }

//         // Save current value, if any, for inclusion in log
//         address oldPendingAdmin = pendingAdmin;

//         // Store pendingAdmin with value newPendingAdmin
//         pendingAdmin = newPendingAdmin;

//         // Emit NewPendingAdmin(oldPendingAdmin, newPendingAdmin)
//         emit NewPendingAdmin(oldPendingAdmin, newPendingAdmin);

//         return uint(Error.NO_ERROR);
//     }

//     /**
//       * @notice Accepts transfer of admin rights. msg.sender must be pendingAdmin
//       * @dev Admin function for pending admin to accept role and update admin
//       * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//       */
//     function _acceptAdmin() external returns (uint) {
//         // Check caller is pendingAdmin and pendingAdmin ≠ address(0)
//         if (msg.sender != pendingAdmin || msg.sender == address(0)) {
//             return fail(Error.UNAUTHORIZED, FailureInfo.ACCEPT_ADMIN_PENDING_ADMIN_CHECK);
//         }

//         // Save current values for inclusion in log
//         address oldAdmin = admin;
//         address oldPendingAdmin = pendingAdmin;

//         // Store admin with value pendingAdmin
//         admin = pendingAdmin;

//         // Clear the pending value
//         pendingAdmin = address(0);

//         emit NewAdmin(oldAdmin, admin);
//         emit NewPendingAdmin(oldPendingAdmin, pendingAdmin);

//         return uint(Error.NO_ERROR);
//     }

//     /**
//       * @notice Sets a new comptroller for the market
//       * @dev Admin function to set a new comptroller
//       * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//       */
//     function _setComptroller(ComptrollerInterface newComptroller) public returns (uint) {
//         // Check caller is admin
//         if (msg.sender != admin) {
//             return fail(Error.UNAUTHORIZED, FailureInfo.SET_COMPTROLLER_OWNER_CHECK);
//         }

//         ComptrollerInterface oldComptroller = comptroller;
//         // Ensure invoke comptroller.isComptroller() returns true
//         require(newComptroller.isComptroller(), "marker method returned false");

//         // Set market's comptroller to newComptroller
//         comptroller = newComptroller;

//         // Emit NewComptroller(oldComptroller, newComptroller)
//         emit NewComptroller(oldComptroller, newComptroller);

//         return uint(Error.NO_ERROR);
//     }

//     /**
//       * @notice accrues interest and sets a new reserve factor for the protocol using _setReserveFactorFresh
//       * @dev Admin function to accrue interest and set a new reserve factor
//       * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//       */
//     function _setReserveFactor(uint newReserveFactorMantissa) external nonReentrant returns (uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but on top of that we want to log the fact that an attempted reserve factor change failed.
//             return fail(Error(error), FailureInfo.SET_RESERVE_FACTOR_ACCRUE_INTEREST_FAILED);
//         }
//         // _setReserveFactorFresh emits reserve-factor-specific logs on errors, so we don't need to.
//         return _setReserveFactorFresh(newReserveFactorMantissa);
//     }

//     /**
//       * @notice Sets a new reserve factor for the protocol (*requires fresh interest accrual)
//       * @dev Admin function to set a new reserve factor
//       * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//       */
//     function _setReserveFactorFresh(uint newReserveFactorMantissa) internal returns (uint) {
//         // Check caller is admin
//         if (msg.sender != admin) {
//             return fail(Error.UNAUTHORIZED, FailureInfo.SET_RESERVE_FACTOR_ADMIN_CHECK);
//         }

//         // Verify market's block number equals current block number
//         if (accrualBlockNumber != getBlockNumber()) {
//             return fail(Error.MARKET_NOT_FRESH, FailureInfo.SET_RESERVE_FACTOR_FRESH_CHECK);
//         }

//         // Check newReserveFactor ≤ maxReserveFactor
//         if (newReserveFactorMantissa > reserveFactorMaxMantissa) {
//             return fail(Error.BAD_INPUT, FailureInfo.SET_RESERVE_FACTOR_BOUNDS_CHECK);
//         }

//         uint oldReserveFactorMantissa = reserveFactorMantissa;
//         reserveFactorMantissa = newReserveFactorMantissa;

//         emit NewReserveFactor(oldReserveFactorMantissa, newReserveFactorMantissa);

//         return uint(Error.NO_ERROR);
//     }

//     /**
//      * @notice Accrues interest and reduces reserves by transferring from msg.sender
//      * @param addAmount Amount of addition to reserves
//      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//      */
//     function _addReservesInternal(uint addAmount) internal nonReentrant returns (uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but on top of that we want to log the fact that an attempted reduce reserves failed.
//             return fail(Error(error), FailureInfo.ADD_RESERVES_ACCRUE_INTEREST_FAILED);
//         }

//         // _addReservesFresh emits reserve-addition-specific logs on errors, so we don't need to.
//         (error, ) = _addReservesFresh(addAmount);
//         return error;
//     }

//     /**
//      * @notice Add reserves by transferring from caller
//      * @dev Requires fresh interest accrual
//      * @param addAmount Amount of addition to reserves
//      * @return (uint, uint) An error code (0=success, otherwise a failure (see ErrorReporter.sol for details)) and the actual amount added, net token fees
//      */
//     function _addReservesFresh(uint addAmount) internal returns (uint, uint) {
//         // totalReserves + actualAddAmount
//         uint totalReservesNew;
//         uint actualAddAmount;

//         // We fail gracefully unless market's block number equals current block number
//         if (accrualBlockNumber != getBlockNumber()) {
//             return (fail(Error.MARKET_NOT_FRESH, FailureInfo.ADD_RESERVES_FRESH_CHECK), actualAddAmount);
//         }

//         /////////////////////////
//         // EFFECTS & INTERACTIONS
//         // (No safe failures beyond this point)

//         /*
//          * We call doTransferIn for the caller and the addAmount
//          *  Note: The cToken must handle variations between ERC-20 and ETH underlying.
//          *  On success, the cToken holds an additional addAmount of cash.
//          *  doTransferIn reverts if anything goes wrong, since we can't be sure if side effects occurred.
//          *  it returns the amount actually transferred, in case of a fee.
//          */

//         actualAddAmount = doTransferIn(msg.sender, addAmount);

//         totalReservesNew = totalReserves + actualAddAmount;

//         /* Revert on overflow */
//         require(totalReservesNew >= totalReserves, "add reserves unexpected overflow");

//         // Store reserves[n+1] = reserves[n] + actualAddAmount
//         totalReserves = totalReservesNew;

//         /* Emit NewReserves(admin, actualAddAmount, reserves[n+1]) */
//         emit ReservesAdded(msg.sender, actualAddAmount, totalReservesNew);

//         /* Return (NO_ERROR, actualAddAmount) */
//         return (uint(Error.NO_ERROR), actualAddAmount);
//     }


//     /**
//      * @notice Accrues interest and reduces reserves by transferring to admin
//      * @param reduceAmount Amount of reduction to reserves
//      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//      */
//     function _reduceReserves(uint reduceAmount) external nonReentrant returns (uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but on top of that we want to log the fact that an attempted reduce reserves failed.
//             return fail(Error(error), FailureInfo.REDUCE_RESERVES_ACCRUE_INTEREST_FAILED);
//         }
//         // _reduceReservesFresh emits reserve-reduction-specific logs on errors, so we don't need to.
//         return _reduceReservesFresh(reduceAmount);
//     }

//     /**
//      * @notice Reduces reserves by transferring to admin
//      * @dev Requires fresh interest accrual
//      * @param reduceAmount Amount of reduction to reserves
//      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//      */
//     function _reduceReservesFresh(uint reduceAmount) internal returns (uint) {
//         // totalReserves - reduceAmount
//         uint totalReservesNew;

//         // Check caller is admin
//         if (msg.sender != admin) {
//             return fail(Error.UNAUTHORIZED, FailureInfo.REDUCE_RESERVES_ADMIN_CHECK);
//         }

//         // We fail gracefully unless market's block number equals current block number
//         if (accrualBlockNumber != getBlockNumber()) {
//             return fail(Error.MARKET_NOT_FRESH, FailureInfo.REDUCE_RESERVES_FRESH_CHECK);
//         }

//         // Fail gracefully if protocol has insufficient underlying cash
//         if (getCashPrior() < reduceAmount) {
//             return fail(Error.TOKEN_INSUFFICIENT_CASH, FailureInfo.REDUCE_RESERVES_CASH_NOT_AVAILABLE);
//         }

//         // Check reduceAmount ≤ reserves[n] (totalReserves)
//         if (reduceAmount > totalReserves) {
//             return fail(Error.BAD_INPUT, FailureInfo.REDUCE_RESERVES_VALIDATION);
//         }

//         /////////////////////////
//         // EFFECTS & INTERACTIONS
//         // (No safe failures beyond this point)

//         totalReservesNew = totalReserves - reduceAmount;
//         // We checked reduceAmount <= totalReserves above, so this should never revert.
//         require(totalReservesNew <= totalReserves, "reduce reserves unexpected underflow");

//         // Store reserves[n+1] = reserves[n] - reduceAmount
//         totalReserves = totalReservesNew;

//         // doTransferOut reverts if anything goes wrong, since we can't be sure if side effects occurred.
//         doTransferOut(admin, reduceAmount);

//         emit ReservesReduced(admin, reduceAmount, totalReservesNew);

//         return uint(Error.NO_ERROR);
//     }

//     /**
//      * @notice accrues interest and updates the interest rate model using _setInterestRateModelFresh
//      * @dev Admin function to accrue interest and update the interest rate model
//      * @param newInterestRateModel the new interest rate model to use
//      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//      */
//     function _setInterestRateModel(InterestRateModel newInterestRateModel) public returns (uint) {
//         uint error = accrueInterest();
//         if (error != uint(Error.NO_ERROR)) {
//             // accrueInterest emits logs on errors, but on top of that we want to log the fact that an attempted change of interest rate model failed
//             return fail(Error(error), FailureInfo.SET_INTEREST_RATE_MODEL_ACCRUE_INTEREST_FAILED);
//         }
//         // _setInterestRateModelFresh emits interest-rate-model-update-specific logs on errors, so we don't need to.
//         return _setInterestRateModelFresh(newInterestRateModel);
//     }

//     /**
//      * @notice updates the interest rate model (*requires fresh interest accrual)
//      * @dev Admin function to update the interest rate model
//      * @param newInterestRateModel the new interest rate model to use
//      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
//      */
//     function _setInterestRateModelFresh(InterestRateModel newInterestRateModel) internal returns (uint) {

//         // Used to store old model for use in the event that is emitted on success
//         InterestRateModel oldInterestRateModel;

//         // Check caller is admin
//         if (msg.sender != admin) {
//             return fail(Error.UNAUTHORIZED, FailureInfo.SET_INTEREST_RATE_MODEL_OWNER_CHECK);
//         }

//         // We fail gracefully unless market's block number equals current block number
//         if (accrualBlockNumber != getBlockNumber()) {
//             return fail(Error.MARKET_NOT_FRESH, FailureInfo.SET_INTEREST_RATE_MODEL_FRESH_CHECK);
//         }

//         // Track the market's current interest rate model
//         oldInterestRateModel = interestRateModel;

//         // Ensure invoke newInterestRateModel.isInterestRateModel() returns true
//         require(newInterestRateModel.isInterestRateModel(), "marker method returned false");

//         // Set the interest rate model to newInterestRateModel
//         interestRateModel = newInterestRateModel;

//         // Emit NewMarketInterestRateModel(oldInterestRateModel, newInterestRateModel)
//         emit NewMarketInterestRateModel(oldInterestRateModel, newInterestRateModel);

//         return uint(Error.NO_ERROR);
//     }

//     /*** Safe Token ***/

//     /**
//      * @notice Gets balance of this contract in terms of the underlying
//      * @dev This excludes the value of the current message, if any
//      * @return The quantity of underlying owned by this contract
//      */
//     function getCashPrior() internal view returns (uint);

//     /**
//      * @dev Performs a transfer in, reverting upon failure. Returns the amount actually transferred to the protocol, in case of a fee.
//      *  This may revert due to insufficient balance or insufficient allowance.
//      */
//     function doTransferIn(address from, uint amount) internal returns (uint);

//     /**
//      * @dev Performs a transfer out, ideally returning an explanatory error code upon failure tather than reverting.
//      *  If caller has not called checked protocol's balance, may revert due to insufficient cash held in the contract.
//      *  If caller has checked protocol's balance, and verified it is >= amount, this should not revert in normal conditions.
//      */
//     function doTransferOut(address payable to, uint amount) internal;


//     /*** Reentrancy Guard ***/

//     /**
//      * @dev Prevents a contract from calling itself, directly or indirectly.
//      */
//     modifier nonReentrant() {
//         require(_notEntered, "re-entered");
//         _notEntered = false;
//         _;
//         _notEntered = true; // get a gas-refund post-Istanbul
//     }
// }

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxQ42021/frax-solidity-bd40775e283923aa9e32a107abd426430a99835e/src/hardhat/contracts/Misc_AMOs/FraxLendingAMO_V2.sol

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
// ========================== FraxLendingAMO_V2 ==========================
// ====================================================================
// Frax Finance: https://github.com/FraxFinance

// Primary Author(s)
// Travis Moore: https://github.com/FortisFortuna

// Reviewer(s) / Contributor(s)
// Jason Huan: https://github.com/jasonhuan
// Sam Kazemian: https://github.com/samkazemian










contract FraxLendingAMO_V2 is Owned {
    using SafeMath for uint256;
    // SafeMath automatically included in Solidity >= 8.0.0

    /* ========== STATE VARIABLES ========== */

    ERC20 private collateral_token;
    IFxs private FXS = IFxs(0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0);
    IFrax private FRAX = IFrax(0x853d955aCEf822Db058eb8505911ED77F175b99e);
    IFraxAMOMinter private amo_minter;
    
    // Cream
    ICREAM_crFRAX private crFRAX = ICREAM_crFRAX(0xb092b4601850E23903A42EaCBc9D8A0EeC26A4d5);

    address public timelock_address;
    address public custodian_address;

    uint256 public immutable missing_decimals;
    uint256 private constant PRICE_PRECISION = 1e6;

    /* ========== CONSTRUCTOR ========== */
    
    constructor (
        address _owner_address,
        address _amo_minter_address
    ) Owned(_owner_address) {
        collateral_token = ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
        amo_minter = IFraxAMOMinter(_amo_minter_address);
        missing_decimals = uint(18).sub(collateral_token.decimals());
        
        // Get the custodian and timelock addresses from the minter
        custodian_address = amo_minter.custodian_address();
        timelock_address = amo_minter.timelock_address();
    }

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

    /* ========== VIEWS ========== */

    function showAllocations() public view returns (uint256[3] memory allocations) {
        // IMPORTANT
        // Should ONLY be used externally, because it may fail if any one of the functions below fail

        // All numbers given are in FRAX unless otherwise stated
        allocations[0] = FRAX.balanceOf(address(this)); // Unallocated FRAX
        allocations[1] = (crFRAX.balanceOf(address(this)).mul(crFRAX.exchangeRateStored()).div(1e18)); // Cream

        uint256 sum_frax = allocations[0];
        sum_frax = sum_frax.add(allocations[1]);
        allocations[2] = sum_frax; // Total FRAX possessed in various forms
    }

    function dollarBalances() public view returns (uint256 frax_val_e18, uint256 collat_val_e18) {
        frax_val_e18 = showAllocations()[2];
        collat_val_e18 = (frax_val_e18).mul(FRAX.global_collateral_ratio()).div(PRICE_PRECISION);
    }

    // Backwards compatibility
    function mintedBalance() public view returns (int256) {
        return amo_minter.frax_mint_balances(address(this));
    }

    /* ========== Burns and givebacks ========== */
   
    // Burn unneeded or excess FRAX. Goes through the minter
    function burnFRAX(uint256 frax_amount) public onlyByOwnGovCust {
        FRAX.approve(address(amo_minter), frax_amount);
        amo_minter.burnFraxFromAMO(frax_amount);
    }
   
    /* ==================== CREAM ==================== */

    // E18
    function creamDeposit_FRAX(uint256 FRAX_amount) public onlyByOwnGovCust {
        FRAX.approve(address(crFRAX), FRAX_amount);
        require(crFRAX.mint(FRAX_amount) == 0, 'Mint failed');
    }

    // E18
    function creamWithdraw_FRAX(uint256 FRAX_amount) public onlyByOwnGovCust {
        require(crFRAX.redeemUnderlying(FRAX_amount) == 0, 'RedeemUnderlying failed');
    }

    // E8
    function creamWithdraw_crFRAX(uint256 crFRAX_amount) public onlyByOwnGovCust {
        require(crFRAX.redeem(crFRAX_amount) == 0, 'Redeem failed');
    }

    /* ========== RESTRICTED GOVERNANCE FUNCTIONS ========== */

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
