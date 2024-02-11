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

// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_alpaca_v1.0_signed/bsc-alpaca-contract-cb13e32fe5a4ba6f63b0235bd4624715592e4abe/contracts/6/protocol/interfaces/IPriceOracle.sol

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

interface PriceOracle {
  /// @dev Return the wad price of token0/token1, multiplied by 1e18
  /// NOTE: (if you have 1 token0 how much you can sell it for token1)
  function getPrice(address token0, address token1) external view returns (uint256 price, uint256 lastUpdate);
}

// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_alpaca_v1.0_signed/bsc-alpaca-contract-cb13e32fe5a4ba6f63b0235bd4624715592e4abe/contracts/6/protocol/OracleMedianizer.sol

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
pragma experimental ABIEncoderV2;


contract OracleMedianizer is OwnableUpgradeSafe, PriceOracle {
  using SafeMath for uint256;

  // Mapping from token0, token1 to number of sources
  mapping(address => mapping(address => uint256)) public primarySourceCount;
  // Mapping from token0, token1 to (mapping from index to oracle source)
  mapping(address => mapping(address => mapping(uint256 => PriceOracle))) public primarySources;
  // Mapping from token0, token1 to max price deviation (multiplied by 1e18)
  mapping(address => mapping(address => uint256)) public maxPriceDeviations;
  // Mapping from token0, token1 to max price stale (seconds)
  mapping(address => mapping(address => uint256)) public maxPriceStales;
  // min price deviation
  uint256 public constant MIN_PRICE_DEVIATION = 1e18;
  // max price deviation
  uint256 public constant MAX_PRICE_DEVIATION = 1.5e18;

  event SetPrimarySources(
    address indexed token0,
    address indexed token1,
    uint256 maxPriceDeviation,
    uint256 maxPriceStale,
    PriceOracle[] oracles
  );

  function initialize() external initializer {
    OwnableUpgradeSafe.__Ownable_init();
  }

  /// @dev Set oracle primary sources for the token pair
  /// @param token0 Token0 address to set oracle sources
  /// @param token1 Token1 address to set oracle sources
  /// @param maxPriceDeviation Max price deviation (in 1e18) for token pair
  /// @param maxPriceStale Max price stale (in seconds) for token pair
  /// @param sources Oracle sources for the token pair
  function setPrimarySources(
    address token0,
    address token1,
    uint256 maxPriceDeviation,
    uint256 maxPriceStale,
    PriceOracle[] calldata sources
  ) external onlyOwner {
    _setPrimarySources(token0, token1, maxPriceDeviation, maxPriceStale, sources);
  }

  /// @dev Set oracle primary sources for multiple token pairs
  /// @param token0s List of token0 addresses to set oracle sources
  /// @param token1s List of token1 addresses to set oracle sources
  /// @param maxPriceDeviationList List of max price deviations (in 1e18) for token pairs
  /// @param maxPriceStaleList List of Max price stale (in seconds) for token pair
  /// @param allSources List of oracle sources for token pairs
  function setMultiPrimarySources(
    address[] calldata token0s,
    address[] calldata token1s,
    uint256[] calldata maxPriceDeviationList,
    uint256[] calldata maxPriceStaleList,
    PriceOracle[][] calldata allSources
  ) external onlyOwner {
    require(
      token0s.length == token1s.length &&
        token0s.length == allSources.length &&
        token0s.length == maxPriceDeviationList.length &&
        token0s.length == maxPriceStaleList.length,
      "OracleMedianizer::setMultiPrimarySources:: inconsistent length"
    );
    for (uint256 idx = 0; idx < token0s.length; idx++) {
      _setPrimarySources(
        token0s[idx],
        token1s[idx],
        maxPriceDeviationList[idx],
        maxPriceStaleList[idx],
        allSources[idx]
      );
    }
  }

  /// @dev Set oracle primary sources for token pair
  /// @param token0 Token0 to set oracle sources
  /// @param token1 Token1 to set oracle sources
  /// @param maxPriceDeviation Max price deviation (in 1e18) for token pair
  /// @param maxPriceStale Max price stale (in seconds) for token pair
  /// @param sources Oracle sources for the token pair
  function _setPrimarySources(
    address token0,
    address token1,
    uint256 maxPriceDeviation,
    uint256 maxPriceStale,
    PriceOracle[] memory sources
  ) internal {
    require(
      maxPriceDeviation >= MIN_PRICE_DEVIATION && maxPriceDeviation <= MAX_PRICE_DEVIATION,
      "OracleMedianizer::setPrimarySources:: bad max deviation value"
    );
    require(sources.length <= 3, "OracleMedianizer::setPrimarySources:: sources length exceed 3");
    primarySourceCount[token0][token1] = sources.length;
    primarySourceCount[token1][token0] = sources.length;
    maxPriceDeviations[token0][token1] = maxPriceDeviation;
    maxPriceDeviations[token1][token0] = maxPriceDeviation;
    maxPriceStales[token0][token1] = maxPriceStale;
    maxPriceStales[token1][token0] = maxPriceStale;
    for (uint256 idx = 0; idx < sources.length; idx++) {
      primarySources[token0][token1][idx] = sources[idx];
      primarySources[token1][token0][idx] = sources[idx];
    }
    emit SetPrimarySources(token0, token1, maxPriceDeviation, maxPriceStale, sources);
  }

  /// @dev Return token0/token1 price
  /// @param token0 Token0 to get price of
  /// @param token1 Token1 to get price of
  /// NOTE: Support at most 3 oracle sources per token
  function _getPrice(address token0, address token1) internal view returns (uint256) {
    uint256 candidateSourceCount = primarySourceCount[token0][token1];
    require(candidateSourceCount > 0, "OracleMedianizer::getPrice:: no primary source");
    uint256[] memory prices = new uint256[](candidateSourceCount);
    // Get valid oracle sources
    uint256 validSourceCount = 0;
    for (uint256 idx = 0; idx < candidateSourceCount; idx++) {
      try primarySources[token0][token1][idx].getPrice(token0, token1) returns (uint256 price, uint256 lastUpdate) {
        if (lastUpdate >= now - maxPriceStales[token0][token1]) {
          prices[validSourceCount++] = price;
        }
      } catch {}
    }
    require(validSourceCount > 0, "OracleMedianizer::getPrice:: no valid source");
    // Sort prices (asc)
    for (uint256 i = 0; i < validSourceCount - 1; i++) {
      for (uint256 j = 0; j < validSourceCount - i - 1; j++) {
        if (prices[j] > prices[j + 1]) {
          (prices[j], prices[j + 1]) = (prices[j + 1], prices[j]);
        }
      }
    }
    uint256 maxPriceDeviation = maxPriceDeviations[token0][token1];
    // Algo:
    // - 1 valid source --> return price
    // - 2 valid sources
    //     --> if the prices within deviation threshold, return average
    //     --> else revert
    // - 3 valid sources --> check deviation threshold of each pair
    //     --> if all within threshold, return median
    //     --> if one pair within threshold, return average of the pair
    if (validSourceCount == 1) return prices[0]; // if 1 valid source, return
    if (validSourceCount == 2) {
      require(
        prices[1].mul(1e18) / prices[0] <= maxPriceDeviation,
        "OracleMedianizer::getPrice:: too much deviation 2 valid sources"
      );
      return prices[0].add(prices[1]) / 2; // if 2 valid sources, return average
    }
    bool midP0P1Ok = prices[1].mul(1e18) / prices[0] <= maxPriceDeviation;
    bool midP1P2Ok = prices[2].mul(1e18) / prices[1] <= maxPriceDeviation;
    if (midP0P1Ok && midP1P2Ok) return prices[1]; // if 3 valid sources, and each pair is within thresh, return median
    if (midP0P1Ok) return prices[0].add(prices[1]) / 2; // return average of pair within thresh
    if (midP1P2Ok) return prices[1].add(prices[2]) / 2; // return average of pair within thresh
    revert("OracleMedianizer::getPrice:: too much deviation 3 valid sources");
  }

  /// @dev Return the price of token0/token1, multiplied by 1e18
  function getPrice(address token0, address token1) external view override returns (uint256, uint256) {
    return (_getPrice(token0, token1), block.timestamp);
  }
}
