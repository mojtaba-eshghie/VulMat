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

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/interfaces/ISwapFactoryLike.sol

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

pragma solidity 0.6.6;

interface ISwapFactoryLike {
  function feeTo() external view returns (address);

  function feeToSetter() external view returns (address);

  function feeToRate() external view returns (uint256);

  function initCodeHash() external view returns (bytes32);

  function pairFeeToRate(address) external view returns (uint256);

  function pairFees(address) external view returns (uint256);

  function getPair(address tokenA, address tokenB) external view returns (address pair);

  function allPairs(uint256) external view returns (address pair);

  function allPairsLength() external view returns (uint256);

  function createPair(address tokenA, address tokenB) external returns (address pair);

  function setFeeTo(address) external;

  function setFeeToSetter(address) external;

  function addPair(address) external returns (bool);

  function delPair(address) external returns (bool);

  function getSupportListLength() external view returns (uint256);

  function isSupportPair(address pair) external view returns (bool);

  function getSupportPair(uint256 index) external view returns (address);

  function setFeeRateNumerator(uint256) external;

  function setPairFees(address pair, uint256 fee) external;

  function setDefaultFeeToRate(uint256) external;

  function setPairFeeToRate(address pair, uint256 rate) external;

  function getPairFees(address) external view returns (uint256);

  function getPairRate(address) external view returns (uint256);

  function sortTokens(address tokenA, address tokenB) external pure returns (address token0, address token1);

  function pairFor(address tokenA, address tokenB) external view returns (address pair);

  function getReserves(address tokenA, address tokenB) external view returns (uint256 reserveA, uint256 reserveB);

  function quote(
    uint256 amountA,
    uint256 reserveA,
    uint256 reserveB
  ) external pure returns (uint256 amountB);

  function getAmountOut(
    uint256 amountIn,
    uint256 reserveIn,
    uint256 reserveOut,
    address token0,
    address token1
  ) external view returns (uint256 amountOut);

  function getAmountIn(
    uint256 amountOut,
    uint256 reserveIn,
    uint256 reserveOut,
    address token0,
    address token1
  ) external view returns (uint256 amountIn);

  function getAmountsOut(uint256 amountIn, address[] calldata path) external view returns (uint256[] memory amounts);

  function getAmountsIn(uint256 amountOut, address[] calldata path) external view returns (uint256[] memory amounts);
}

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/interfaces/ISwapPairLike.sol

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

pragma solidity 0.6.6;

interface ISwapPairLike {
  event Approval(address indexed owner, address indexed spender, uint256 value);
  event Transfer(address indexed from, address indexed to, uint256 value);

  function name() external pure returns (string memory);

  function symbol() external pure returns (string memory);

  function decimals() external pure returns (uint8);

  function totalSupply() external view returns (uint256);

  function balanceOf(address owner) external view returns (uint256);

  function allowance(address owner, address spender) external view returns (uint256);

  function approve(address spender, uint256 value) external returns (bool);

  function transfer(address to, uint256 value) external returns (bool);

  function transferFrom(
    address from,
    address to,
    uint256 value
  ) external returns (bool);

  function DOMAIN_SEPARATOR() external view returns (bytes32);

  function PERMIT_TYPEHASH() external pure returns (bytes32);

  function nonces(address owner) external view returns (uint256);

  function permit(
    address owner,
    address spender,
    uint256 value,
    uint256 deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external;

  event Mint(address indexed sender, uint256 amount0, uint256 amount1);
  event Burn(address indexed sender, uint256 amount0, uint256 amount1, address indexed to);
  event Swap(
    address indexed sender,
    uint256 amount0In,
    uint256 amount1In,
    uint256 amount0Out,
    uint256 amount1Out,
    address indexed to
  );
  event Sync(uint112 reserve0, uint112 reserve1);

  function MINIMUM_LIQUIDITY() external pure returns (uint256);

  function factory() external view returns (address);

  function token0() external view returns (address);

  function token1() external view returns (address);

  function getReserves()
    external
    view
    returns (
      uint112 reserve0,
      uint112 reserve1,
      uint32 blockTimestampLast
    );

  function price0CumulativeLast() external view returns (uint256);

  function price1CumulativeLast() external view returns (uint256);

  function kLast() external view returns (uint256);

  function mint(address to) external returns (uint256 liquidity);

  function burn(address to) external returns (uint256 amount0, uint256 amount1);

  function swap(
    uint256 amount0Out,
    uint256 amount1Out,
    address to,
    bytes calldata data
  ) external;

  function skim(address to) external;

  function sync() external;

  function initialize(address, address) external;
}

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/interfaces/ISwapRouter01Like.sol

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

pragma solidity 0.6.6;

interface ISwapRouter01Like {
  function factory() external pure returns (address);

  function WETH() external pure returns (address);

  function addLiquidity(
    address tokenA,
    address tokenB,
    uint256 amountADesired,
    uint256 amountBDesired,
    uint256 amountAMin,
    uint256 amountBMin,
    address to,
    uint256 deadline
  )
    external
    returns (
      uint256 amountA,
      uint256 amountB,
      uint256 liquidity
    );

  function addLiquidityETH(
    address token,
    uint256 amountTokenDesired,
    uint256 amountTokenMin,
    uint256 amountETHMin,
    address to,
    uint256 deadline
  )
    external
    payable
    returns (
      uint256 amountToken,
      uint256 amountETH,
      uint256 liquidity
    );

  function removeLiquidity(
    address tokenA,
    address tokenB,
    uint256 liquidity,
    uint256 amountAMin,
    uint256 amountBMin,
    address to,
    uint256 deadline
  ) external returns (uint256 amountA, uint256 amountB);

  function removeLiquidityETH(
    address token,
    uint256 liquidity,
    uint256 amountTokenMin,
    uint256 amountETHMin,
    address to,
    uint256 deadline
  ) external returns (uint256 amountToken, uint256 amountETH);

  function removeLiquidityWithPermit(
    address tokenA,
    address tokenB,
    uint256 liquidity,
    uint256 amountAMin,
    uint256 amountBMin,
    address to,
    uint256 deadline,
    bool approveMax,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external returns (uint256 amountA, uint256 amountB);

  function removeLiquidityETHWithPermit(
    address token,
    uint256 liquidity,
    uint256 amountTokenMin,
    uint256 amountETHMin,
    address to,
    uint256 deadline,
    bool approveMax,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external returns (uint256 amountToken, uint256 amountETH);

  function swapExactTokensForTokens(
    uint256 amountIn,
    uint256 amountOutMin,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external returns (uint256[] memory amounts);

  function swapTokensForExactTokens(
    uint256 amountOut,
    uint256 amountInMax,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external returns (uint256[] memory amounts);

  function swapExactETHForTokens(
    uint256 amountOutMin,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external payable returns (uint256[] memory amounts);

  function swapTokensForExactETH(
    uint256 amountOut,
    uint256 amountInMax,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external returns (uint256[] memory amounts);

  function swapExactTokensForETH(
    uint256 amountIn,
    uint256 amountOutMin,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external returns (uint256[] memory amounts);

  function swapETHForExactTokens(
    uint256 amountOut,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external payable returns (uint256[] memory amounts);

  function quote(
    uint256 amountA,
    uint256 reserveA,
    uint256 reserveB
  ) external pure returns (uint256 amountB);

  function getAmountOut(
    uint256 amountIn,
    uint256 reserveIn,
    uint256 reserveOut
  ) external pure returns (uint256 amountOut);

  function getAmountIn(
    uint256 amountOut,
    uint256 reserveIn,
    uint256 reserveOut
  ) external pure returns (uint256 amountIn);

  function getAmountsOut(uint256 amountIn, address[] calldata path) external view returns (uint256[] memory amounts);

  function getAmountsIn(uint256 amountOut, address[] calldata path) external view returns (uint256[] memory amounts);
}

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/interfaces/ISwapRouter02Like.sol

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

pragma solidity 0.6.6;

interface ISwapRouter02Like is ISwapRouter01Like {
  function removeLiquidityETHSupportingFeeOnTransferTokens(
    address token,
    uint256 liquidity,
    uint256 amountTokenMin,
    uint256 amountETHMin,
    address to,
    uint256 deadline
  ) external returns (uint256 amountETH);

  function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
    address token,
    uint256 liquidity,
    uint256 amountTokenMin,
    uint256 amountETHMin,
    address to,
    uint256 deadline,
    bool approveMax,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external returns (uint256 amountETH);

  function swapExactTokensForTokensSupportingFeeOnTransferTokens(
    uint256 amountIn,
    uint256 amountOutMin,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external;

  function swapExactETHForTokensSupportingFeeOnTransferTokens(
    uint256 amountOutMin,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external payable;

  function swapExactTokensForETHSupportingFeeOnTransferTokens(
    uint256 amountIn,
    uint256 amountOutMin,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external;
}

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/interfaces/IStrategy.sol

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

pragma solidity 0.6.6;

interface IStrategy {
  /// @dev Execute worker strategy.
  /// @param user The original user that is interacting with the operator.
  /// @param debt The user's total debt, for better decision making context.
  /// @param data Extra calldata information passed along to this strategy.
  function execute(address user, uint256 debt, bytes calldata data) external;
}

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/interfaces/IWorker03.sol

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

pragma solidity 0.6.6;

/// @title Interface for Worker03. Same functions as Worker02 just use ISwapPairLike instead of IPancakePair
interface IWorker03 {
  /// @dev Work on a (potentially new) position. Optionally send token back to Vault.
  function work(
    uint256 id,
    address user,
    uint256 debt,
    bytes calldata data
  ) external;

  /// @dev Re-invest whatever the worker is working on.
  function reinvest() external;

  /// @dev Return the amount of wei to get back if we are to liquidate the position.
  function health(uint256 id) external view returns (uint256);

  /// @dev Liquidate the given position to token. Send all token back to its Vault.
  function liquidate(uint256 id) external;

  /// @dev SetStretegy that be able to executed by the worker.
  function setStrategyOk(address[] calldata strats, bool isOk) external;

  /// @dev Set address that can be reinvest
  function setReinvestorOk(address[] calldata reinvestor, bool isOk) external;

  /// @dev LP token holds by worker
  function lpToken() external view returns (ISwapPairLike);

  /// @dev Base Token that worker is working on
  function baseToken() external view returns (address);

  /// @dev Farming Token that worker is working on
  function farmingToken() external view returns (address);

  /// @dev Return the trading path that worker is using for convert BTOKEN->...->FTOKEN
  function getPath() external view returns (address[] memory);

  /// @dev Return the inverse of the path that worker is using for convert BTOKEN->...->FTOKEN
  function getReversedPath() external view returns (address[] memory);

  /// @dev Return the trading path that the worker is using to convert reward token to beneficial vault token
  function getRewardPath() external view returns (address[] memory);
}

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/interfaces/ISpookyMasterChef.sol

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

pragma solidity 0.6.6;

abstract contract ISpookyMasterChef {
  // Info of each user.
  struct UserInfo {
    uint256 amount; // How many LP tokens the user has provided.
    uint256 rewardDebt; // Reward debt. See explanation below.
  }

  // Info of each pool.
  struct PoolInfo {
    IERC20 lpToken; // Address of LP token contract.
    uint256 allocPoint; // How many allocation points assigned to this pool. BOOs to distribute per block.
    uint256 lastRewardBlock; // Last block number that BOOs distribution occurs.
    uint256 accBOOPerShare; // Accumulated BOOs per share, times 1e12. See below.
  }

  // the reward token like CAKE, in this case, it's called BOO
  address public boo;

  // Info of each user that stakes LP tokens.
  mapping(uint256 => PoolInfo) public poolInfo;
  mapping(uint256 => mapping(address => UserInfo)) public userInfo;

  // Deposit LP tokens to MasterChef for BOO allocation.
  function deposit(uint256 _pid, uint256 _amount) external virtual;

  // Withdraw LP tokens from MasterChef.
  function withdraw(uint256 _pid, uint256 _amount) external virtual;

  // Query pending BOO
  function pendingBOO(uint256 _pid, address _user) external virtual returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/interfaces/IVault.sol

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

pragma solidity 0.6.6;

interface IVault {
  /// @notice Return the total ERC20 entitled to the token holders. Be careful of unaccrued interests.
  function totalToken() external view returns (uint256);

  /// @notice Add more ERC20 to the bank. Hope to get some good returns.
  function deposit(uint256 amountToken) external payable;

  /// @notice Withdraw ERC20 from the bank by burning the share tokens.
  function withdraw(uint256 share) external;

  /// @notice Request funds from user through Vault
  function requestFunds(address targetedToken, uint256 amount) external;

  /// @notice Underlying token address
  function token() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/utils/SafeToken.sol

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

pragma solidity 0.6.6;

interface ERC20Interface {
  function balanceOf(address user) external view returns (uint256);
}

library SafeToken {
  function myBalance(address token) internal view returns (uint256) {
    return ERC20Interface(token).balanceOf(address(this));
  }

  function balanceOf(address token, address user) internal view returns (uint256) {
    return ERC20Interface(token).balanceOf(user);
  }

  function safeApprove(address token, address to, uint256 value) internal {
    // bytes4(keccak256(bytes('approve(address,uint256)')));
    (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
    require(success && (data.length == 0 || abi.decode(data, (bool))), "!safeApprove");
  }

  function safeTransfer(address token, address to, uint256 value) internal {
    // bytes4(keccak256(bytes('transfer(address,uint256)')));
    (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
    require(success && (data.length == 0 || abi.decode(data, (bool))), "!safeTransfer");
  }

  function safeTransferFrom(address token, address from, address to, uint256 value) internal {
    // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
    (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
    require(success && (data.length == 0 || abi.decode(data, (bool))), "!safeTransferFrom");
  }

  function safeTransferETH(address to, uint256 value) internal {
    // solhint-disable-next-line no-call-value
    (bool success, ) = to.call{value: value}(new bytes(0));
    require(success, "!safeTransferETH");
  }
}

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6/protocol/workers/spookyswap/SpookyWorker03.sol

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

pragma solidity 0.6.6;











/// @title SpookyWorker03 is a worker with reinvest-optimized and beneficial vault buyback functionalities
contract SpookyWorker03 is OwnableUpgradeSafe, ReentrancyGuardUpgradeSafe, IWorker03 {
  /// @notice Libraries
  using SafeToken for address;
  using SafeMath for uint256;

  /// @notice Events
  event Reinvest(address indexed caller, uint256 reward, uint256 bounty);
  event AddShare(uint256 indexed id, uint256 share);
  event RemoveShare(uint256 indexed id, uint256 share);
  event Liquidate(uint256 indexed id, uint256 wad);
  event SetTreasuryConfig(address indexed caller, address indexed account, uint256 bountyBps);
  event BeneficialVaultTokenBuyback(address indexed caller, IVault indexed beneficialVault, uint256 indexed buyback);
  event SetStrategyOK(address indexed caller, address indexed strategy, bool indexed isOk);
  event SetReinvestorOK(address indexed caller, address indexed reinvestor, bool indexed isOk);
  event SetCriticalStrategy(address indexed caller, IStrategy indexed addStrat, IStrategy indexed liqStrat);
  event SetMaxReinvestBountyBps(address indexed caller, uint256 indexed maxReinvestBountyBps);
  event SetRewardPath(address indexed caller, address[] newRewardPath);
  event SetBeneficialVaultConfig(
    address indexed caller,
    uint256 indexed beneficialVaultBountyBps,
    IVault indexed beneficialVault,
    address[] rewardPath
  );
  event SetReinvestConfig(
    address indexed caller,
    uint256 reinvestBountyBps,
    uint256 reinvestThreshold,
    address[] reinvestPath
  );

  /// @notice Immutable variables
  ISpookyMasterChef public spookyMasterChef;
  ISwapFactoryLike public factory;
  ISwapRouter02Like public router;
  ISwapPairLike public override lpToken;
  address public wNative;
  address public override baseToken;
  address public override farmingToken;
  address public boo;
  address public operator;
  uint256 public pid;

  /// @notice Mutable state variables
  // mapping between positionId and its share
  mapping(uint256 => uint256) public shares;
  mapping(address => bool) public okStrats;
  uint256 public totalShare;
  IStrategy public addStrat;
  IStrategy public liqStrat;
  uint256 public reinvestBountyBps;
  uint256 public maxReinvestBountyBps;
  mapping(address => bool) public okReinvestors;
  uint256 public fee;
  uint256 public feeDenom;

  uint256 public reinvestThreshold;
  address[] public reinvestPath;
  address public treasuryAccount;
  uint256 public treasuryBountyBps;
  IVault public beneficialVault;
  uint256 public beneficialVaultBountyBps;
  address[] public rewardPath;
  uint256 public buybackAmount;

  function initialize(
    address _operator,
    address _baseToken,
    ISpookyMasterChef _spookyMasterChef,
    ISwapRouter02Like _router,
    uint256 _pid,
    IStrategy _addStrat,
    IStrategy _liqStrat,
    uint256 _reinvestBountyBps,
    address _treasuryAccount,
    address[] calldata _reinvestPath,
    uint256 _reinvestThreshold
  ) external initializer {
    // 1. Initialized imported library
    OwnableUpgradeSafe.__Ownable_init();
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();

    // 2. Assign dependency contracts
    operator = _operator;
    wNative = _router.WETH();
    spookyMasterChef = _spookyMasterChef;
    router = _router;
    factory = ISwapFactoryLike(_router.factory());

    // 3. Assign tokens state variables
    baseToken = _baseToken;
    pid = _pid;
    (IERC20 _lpToken, , , ) = spookyMasterChef.poolInfo(_pid);
    lpToken = ISwapPairLike(address(_lpToken));
    address token0 = lpToken.token0();
    address token1 = lpToken.token1();
    farmingToken = token0 == baseToken ? token1 : token0;
    boo = address(spookyMasterChef.boo());

    // 4. Assign critical strategy contracts
    addStrat = _addStrat;
    liqStrat = _liqStrat;
    okStrats[address(addStrat)] = true;
    okStrats[address(liqStrat)] = true;

    // 5. Assign Re-invest parameters
    reinvestBountyBps = _reinvestBountyBps;
    reinvestThreshold = _reinvestThreshold;
    reinvestPath = _reinvestPath;
    treasuryAccount = _treasuryAccount;
    treasuryBountyBps = _reinvestBountyBps;
    maxReinvestBountyBps = 900;

    // 6. Set swap fees
    fee = 998;
    feeDenom = 1000;

    require(baseToken != boo, "baseToken must !boo");
    require(reinvestBountyBps <= maxReinvestBountyBps, "exceeded maxReinvestBountyBps");
    require(
      (farmingToken == lpToken.token0() || farmingToken == lpToken.token1()) &&
        (baseToken == lpToken.token0() || baseToken == lpToken.token1()),
      "bad baseToken or farmingToken"
    );
    require(reinvestPath.length >= 2, "_reinvestPath length must >= 2");
    require(reinvestPath[0] == boo && reinvestPath[reinvestPath.length - 1] == baseToken, "bad reinvest path");
  }

  /// @dev Require that the caller must be an EOA account to avoid flash loans.
  modifier onlyEOA() {
    require(msg.sender == tx.origin, "not eoa");
    _;
  }

  /// @dev Require that the caller must be the operator.
  modifier onlyOperator() {
    require(msg.sender == operator, "not operator");
    _;
  }

  //// @dev Require that the caller must be ok reinvestor.
  modifier onlyReinvestor() {
    require(okReinvestors[msg.sender], "not reinvestor");
    _;
  }

  /// @dev Return the entitied LP token balance for the given shares.
  /// @param share The number of shares to be converted to LP balance.
  function shareToBalance(uint256 share) public view returns (uint256) {
    if (totalShare == 0) return share; // When there's no share, 1 share = 1 balance.
    (uint256 totalBalance, ) = spookyMasterChef.userInfo(pid, address(this));
    return share.mul(totalBalance).div(totalShare);
  }

  /// @dev Return the number of shares to receive if staking the given LP tokens.
  /// @param balance the number of LP tokens to be converted to shares.
  function balanceToShare(uint256 balance) public view returns (uint256) {
    if (totalShare == 0) return balance; // When there's no share, 1 share = 1 balance.
    (uint256 totalBalance, ) = spookyMasterChef.userInfo(pid, address(this));
    return balance.mul(totalShare).div(totalBalance);
  }

  /// @dev Re-invest whatever this worker has earned back to staked LP tokens.
  function reinvest() external override onlyEOA onlyReinvestor nonReentrant {
    _reinvest(msg.sender, reinvestBountyBps, 0, 0);
    // in case of beneficial vault equals to operator vault, call buyback to transfer some buyback amount back to the vault
    // This can't be called within the _reinvest statement since _reinvest is called within the `work` as well
    _buyback();
  }

  /// @dev Internal method containing reinvest logic
  /// @param _treasuryAccount - The account that the reinvest bounty will be sent.
  /// @param _treasuryBountyBps - The bounty bps deducted from the reinvest reward.
  /// @param _callerBalance - The balance that is owned by the msg.sender within the execution scope.
  /// @param _reinvestThreshold - The threshold to be reinvested if reward pass over.
  // SWC-Transaction Order Dependence: L208
  function _reinvest(
    address _treasuryAccount,
    uint256 _treasuryBountyBps,
    uint256 _callerBalance,
    uint256 _reinvestThreshold
  ) internal {
    // 1. Withdraw all the rewards. Return if reward <= _reinvestThershold.
    spookyMasterChef.withdraw(pid, 0);
    uint256 reward = boo.balanceOf(address(this));
    if (reward <= _reinvestThreshold) return;

    // 2. Approve tokens
    boo.safeApprove(address(router), uint256(-1));
    address(lpToken).safeApprove(address(spookyMasterChef), uint256(-1));

    // 3. Send the reward bounty to the _treasuryAccount.
    uint256 bounty = reward.mul(_treasuryBountyBps) / 10000;
    if (bounty > 0) {
      uint256 beneficialVaultBounty = bounty.mul(beneficialVaultBountyBps) / 10000;
      if (beneficialVaultBounty > 0) _rewardToBeneficialVault(beneficialVaultBounty, _callerBalance);
      boo.safeTransfer(_treasuryAccount, bounty.sub(beneficialVaultBounty));
    }

    // 4. Convert all the remaining rewards to BTOKEN.
    router.swapExactTokensForTokens(reward.sub(bounty), 0, getReinvestPath(), address(this), now);

    // 5. Use add Token strategy to convert all BaseToken without both caller balance and buyback amount to LP tokens.
    baseToken.safeTransfer(address(addStrat), actualBaseTokenBalance().sub(_callerBalance));
    addStrat.execute(address(0), 0, abi.encode(0));

    // 6. Stake LPs for more rewards
    spookyMasterChef.deposit(pid, lpToken.balanceOf(address(this)));

    // 7. Reset approvals
    boo.safeApprove(address(router), 0);
    address(lpToken).safeApprove(address(spookyMasterChef), 0);

    emit Reinvest(_treasuryAccount, reward, bounty);
  }

  /// @dev Work on the given position. Must be called by the operator.
  /// @param id The position ID to work on.
  /// @param user The original user that is interacting with the operator.
  /// @param debt The amount of user debt to help the strategy make decisions.
  /// @param data The encoded data, consisting of strategy address and calldata.
  function work(
    uint256 id,
    address user,
    uint256 debt,
    bytes calldata data
  ) external override onlyOperator nonReentrant {
    // 1. If a treasury configs are not ready. Not reinvest.
    _reinvest(treasuryAccount, treasuryBountyBps, actualBaseTokenBalance(), reinvestThreshold);
    // 2. Convert this position back to LP tokens.
    _removeShare(id);
    // 3. Perform the worker strategy; sending LP tokens + BaseToken; expecting LP tokens + BaseToken.
    (address strat, bytes memory ext) = abi.decode(data, (address, bytes));
    require(okStrats[strat], "!approved strategy");
    address(lpToken).safeTransfer(strat, lpToken.balanceOf(address(this)));
    baseToken.safeTransfer(strat, actualBaseTokenBalance());
    IStrategy(strat).execute(user, debt, ext);
    // 4. Add LP tokens back to the farming pool.
    _addShare(id);
    // 5. Return any remaining BaseToken back to the operator.
    baseToken.safeTransfer(msg.sender, actualBaseTokenBalance());
  }

  /// @dev Return maximum output given the input amount and the status of Uniswap reserves.
  /// @param aIn The amount of asset to market sell.
  /// @param rIn the amount of asset in reserve for input.
  /// @param rOut The amount of asset in reserve for output.
  function getMktSellAmount(
    uint256 aIn,
    uint256 rIn,
    uint256 rOut
  ) public view returns (uint256) {
    if (aIn == 0) return 0;
    require(rIn > 0 && rOut > 0, "bad reserve values");
    uint256 aInWithFee = aIn.mul(fee);
    uint256 numerator = aInWithFee.mul(rOut);
    uint256 denominator = rIn.mul(feeDenom).add(aInWithFee);
    return numerator / denominator;
  }

  /// @dev Return the amount of BTOKEN to receive if we are to liquidate the given position.
  /// @param id The position ID to perform health check.
  function health(uint256 id) external view override returns (uint256) {
    // 1. Get the position's LP balance and LP total supply.
    uint256 lpBalance = shareToBalance(shares[id]);
    uint256 lpSupply = lpToken.totalSupply(); // Ignore pending mintFee as it is insignificant
    // 2. Get the pool's total supply of BaseToken and FarmingToken.
    (uint256 r0, uint256 r1, ) = lpToken.getReserves();
    (uint256 totalBaseToken, uint256 totalFarmingToken) = lpToken.token0() == baseToken ? (r0, r1) : (r1, r0);
    // 3. Convert the position's LP tokens to the underlying assets.
    uint256 userBaseToken = lpBalance.mul(totalBaseToken).div(lpSupply);
    uint256 userFarmingToken = lpBalance.mul(totalFarmingToken).div(lpSupply);
    // 4. Convert all FarmingToken to BaseToken and return total BaseToken.
    return
      getMktSellAmount(userFarmingToken, totalFarmingToken.sub(userFarmingToken), totalBaseToken.sub(userBaseToken))
        .add(userBaseToken);
  }

  /// @dev Liquidate the given position by converting it to BaseToken and return back to caller.
  /// @param id The position ID to perform liquidation
  function liquidate(uint256 id) external override onlyOperator nonReentrant {
    // 1. Convert the position back to LP tokens and use liquidate strategy.
    _removeShare(id);
    lpToken.transfer(address(liqStrat), lpToken.balanceOf(address(this)));
    liqStrat.execute(address(0), 0, abi.encode(0));
    // 2. Return all available BaseToken back to the operator.
    uint256 liquidatedAmount = actualBaseTokenBalance();
    baseToken.safeTransfer(msg.sender, liquidatedAmount);
    emit Liquidate(id, liquidatedAmount);
  }

  /// @dev Some portion of a bounty from reinvest will be sent to beneficialVault to increase the size of totalToken.
  /// @param _beneficialVaultBounty - The amount of BOO to be swapped to BTOKEN & send back to the Vault.
  /// @param _callerBalance - The balance that is owned by the msg.sender within the execution scope.
  function _rewardToBeneficialVault(uint256 _beneficialVaultBounty, uint256 _callerBalance) internal {
    /// 1. read base token from beneficialVault
    address beneficialVaultToken = beneficialVault.token();
    /// 2. swap reward token to beneficialVaultToken
    uint256[] memory amounts = router.swapExactTokensForTokens(
      _beneficialVaultBounty,
      0,
      rewardPath,
      address(this),
      now
    );
    /// 3.if beneficialvault token not equal to baseToken regardless of a caller balance, can directly transfer to beneficial vault
    /// otherwise, need to keep it as a buybackAmount,
    /// since beneficial vault is the same as the calling vault, it will think of this reward as a `back` amount to paydebt/ sending back to a position owner
    if (beneficialVaultToken != baseToken) {
      buybackAmount = 0;
      beneficialVaultToken.safeTransfer(address(beneficialVault), beneficialVaultToken.myBalance());
      emit BeneficialVaultTokenBuyback(msg.sender, beneficialVault, amounts[amounts.length - 1]);
    } else {
      buybackAmount = beneficialVaultToken.myBalance().sub(_callerBalance);
    }
  }

  /// @dev for transfering a buyback amount to the particular beneficial vault
  // this will be triggered when beneficialVaultToken equals to baseToken.
  function _buyback() internal {
    if (buybackAmount == 0) return;
    uint256 _buybackAmount = buybackAmount;
    buybackAmount = 0;
    beneficialVault.token().safeTransfer(address(beneficialVault), _buybackAmount);
    emit BeneficialVaultTokenBuyback(msg.sender, beneficialVault, _buybackAmount);
  }

  /// @dev since buybackAmount variable has been created to collect a buyback balance when during the reinvest within the work method,
  /// thus the actualBaseTokenBalance exists to differentiate an actual base token balance balance without taking buy back amount into account
  function actualBaseTokenBalance() internal view returns (uint256) {
    return baseToken.myBalance().sub(buybackAmount);
  }

  /// @dev Internal function to stake all outstanding LP tokens to the given position ID.
  function _addShare(uint256 id) internal {
    uint256 balance = lpToken.balanceOf(address(this));
    if (balance > 0) {
      // 1. Approve token to be spend by Spooky's MasterChef
      address(lpToken).safeApprove(address(spookyMasterChef), uint256(-1));
      // 2. Convert balance to share
      uint256 share = balanceToShare(balance);
      require(share > 0, "no zero share");
      // 3. Deposit balance to Spooky's MasterChef
      // and also force reward claim, to mimic the behaviour of Spooky's MasterChef
      spookyMasterChef.deposit(pid, balance);
      // 4. Update shares
      shares[id] = shares[id].add(share);
      totalShare = totalShare.add(share);
      // 5. Reset approve token
      address(lpToken).safeApprove(address(spookyMasterChef), 0);
      emit AddShare(id, share);
    }
  }

  /// @dev Internal function to remove shares of the ID and convert to outstanding LP tokens.
  function _removeShare(uint256 id) internal {
    uint256 share = shares[id];
    if (share > 0) {
      uint256 balance = shareToBalance(share);
      spookyMasterChef.withdraw(pid, balance);
      totalShare = totalShare.sub(share);
      shares[id] = 0;
      emit RemoveShare(id, share);
    }
  }

  /// @dev Return the path that the worker is working on.
  function getPath() external view override returns (address[] memory) {
    address[] memory path = new address[](2);
    path[0] = baseToken;
    path[1] = farmingToken;
    return path;
  }

  /// @dev Return the inverse path.
  function getReversedPath() external view override returns (address[] memory) {
    address[] memory reversePath = new address[](2);
    reversePath[0] = farmingToken;
    reversePath[1] = baseToken;
    return reversePath;
  }

  /// @dev Return the path that the work is using for convert reward token to beneficial vault token.
  function getRewardPath() external view override returns (address[] memory) {
    return rewardPath;
  }

  /// @dev Internal function to get reinvest path.
  /// Return route through WBNB if reinvestPath not set.
  function getReinvestPath() public view returns (address[] memory) {
    if (reinvestPath.length != 0) return reinvestPath;
    address[] memory path;
    if (baseToken == wNative) {
      path = new address[](2);
      path[0] = address(boo);
      path[1] = address(wNative);
    } else {
      path = new address[](3);
      path[0] = address(boo);
      path[1] = address(wNative);
      path[2] = address(baseToken);
    }
    return path;
  }

  /// @dev Set the reinvest configuration.
  /// @param _reinvestBountyBps - The bounty value to update.
  /// @param _reinvestThreshold - The threshold to update.
  /// @param _reinvestPath - The reinvest path to update.
  function setReinvestConfig(
    uint256 _reinvestBountyBps,
    uint256 _reinvestThreshold,
    address[] calldata _reinvestPath
  ) external onlyOwner {
    require(_reinvestBountyBps <= maxReinvestBountyBps, "exceeded maxReinvestBountyBps");
    require(_reinvestPath.length >= 2, "_reinvestPath length must >= 2");
    require(_reinvestPath[0] == boo && _reinvestPath[_reinvestPath.length - 1] == baseToken, "bad _reinvestPath");

    reinvestBountyBps = _reinvestBountyBps;
    reinvestThreshold = _reinvestThreshold;
    reinvestPath = _reinvestPath;

    emit SetReinvestConfig(msg.sender, _reinvestBountyBps, _reinvestThreshold, _reinvestPath);
  }

  /// @dev Set Max reinvest reward for set upper limit reinvest bounty.
  /// @param _maxReinvestBountyBps The max reinvest bounty value to update.
  function setMaxReinvestBountyBps(uint256 _maxReinvestBountyBps) external onlyOwner {
    require(_maxReinvestBountyBps >= reinvestBountyBps, "lower than reinvestBountyBps");
    require(_maxReinvestBountyBps <= 3000, "exceeded 30%");

    maxReinvestBountyBps = _maxReinvestBountyBps;

    emit SetMaxReinvestBountyBps(msg.sender, maxReinvestBountyBps);
  }

  /// @dev Set the given strategies' approval status.
  /// @param strats The strategy addresses.
  /// @param isOk Whether to approve or unapprove the given strategies.
  function setStrategyOk(address[] calldata strats, bool isOk) external override onlyOwner {
    uint256 len = strats.length;
    for (uint256 idx = 0; idx < len; idx++) {
      okStrats[strats[idx]] = isOk;
      emit SetStrategyOK(msg.sender, strats[idx], isOk);
    }
  }

  /// @dev Set the given address's to be reinvestor.
  /// @param reinvestors The reinvest bot addresses.
  /// @param isOk Whether to approve or unapprove the given strategies.
  function setReinvestorOk(address[] calldata reinvestors, bool isOk) external override onlyOwner {
    uint256 len = reinvestors.length;
    for (uint256 idx = 0; idx < len; idx++) {
      okReinvestors[reinvestors[idx]] = isOk;
      emit SetReinvestorOK(msg.sender, reinvestors[idx], isOk);
    }
  }

  /// @dev Set a new reward path. In case that the liquidity of the reward path is changed.
  /// @param _rewardPath The new reward path.
  function setRewardPath(address[] calldata _rewardPath) external onlyOwner {
    require(_rewardPath.length >= 2, "_rewardPath length must be >= 2");
    require(_rewardPath[0] == boo && _rewardPath[_rewardPath.length - 1] == beneficialVault.token(), "bad _rewardPath");

    rewardPath = _rewardPath;

    emit SetRewardPath(msg.sender, _rewardPath);
  }

  /// @dev Update critical strategy smart contracts. EMERGENCY ONLY. Bad strategies can steal funds.
  /// @param _addStrat The new add strategy contract.
  /// @param _liqStrat The new liquidate strategy contract.
  function setCriticalStrategies(IStrategy _addStrat, IStrategy _liqStrat) external onlyOwner {
    addStrat = _addStrat;
    liqStrat = _liqStrat;

    emit SetCriticalStrategy(msg.sender, addStrat, liqStrat);
  }

  /// @dev Set treasury configurations.
  /// @param _treasuryAccount - The treasury address to update
  /// @param _treasuryBountyBps - The treasury bounty to update
  function setTreasuryConfig(address _treasuryAccount, uint256 _treasuryBountyBps) external onlyOwner {
    require(_treasuryAccount != address(0), "bad _treasuryAccount");
    require(_treasuryBountyBps <= maxReinvestBountyBps, "exceeded maxReinvestBountyBps");

    treasuryAccount = _treasuryAccount;
    treasuryBountyBps = _treasuryBountyBps;

    emit SetTreasuryConfig(msg.sender, treasuryAccount, treasuryBountyBps);
  }

  /// @dev Set beneficial vault related data including beneficialVaultBountyBps, beneficialVaultAddress, and rewardPath
  /// @param _beneficialVaultBountyBps - The bounty value to update.
  /// @param _beneficialVault - beneficialVaultAddress
  /// @param _rewardPath - reward token path from rewardToken to beneficialVaultToken
  function setBeneficialVaultConfig(
    uint256 _beneficialVaultBountyBps,
    IVault _beneficialVault,
    address[] calldata _rewardPath
  ) external onlyOwner {
    require(_beneficialVaultBountyBps <= 10000, "exceeds 100%");
    require(_rewardPath.length >= 2, "_rewardPath length must >= 2");
    require(
      _rewardPath[0] == boo && _rewardPath[_rewardPath.length - 1] == _beneficialVault.token(),
      "bad _rewardPath"
    );

    _buyback();

    beneficialVaultBountyBps = _beneficialVaultBountyBps;
    beneficialVault = _beneficialVault;
    rewardPath = _rewardPath;

    emit SetBeneficialVaultConfig(msg.sender, _beneficialVaultBountyBps, _beneficialVault, _rewardPath);
  }
}
