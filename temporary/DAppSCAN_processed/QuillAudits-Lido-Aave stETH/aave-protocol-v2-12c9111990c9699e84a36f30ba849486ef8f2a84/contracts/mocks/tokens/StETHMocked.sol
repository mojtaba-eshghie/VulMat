// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Aave stETH/aave-protocol-v2-12c9111990c9699e84a36f30ba849486ef8f2a84/contracts/dependencies/openzeppelin/contracts/SafeMath.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

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
    require(c >= a, 'SafeMath: addition overflow');

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
    return sub(a, b, 'SafeMath: subtraction overflow');
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
  function sub(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
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
    require(c / a == b, 'SafeMath: multiplication overflow');

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
    return div(a, b, 'SafeMath: division by zero');
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
  function div(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
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
    return mod(a, b, 'SafeMath: modulo by zero');
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
  function mod(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
    require(b != 0, errorMessage);
    return a % b;
  }
}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Aave stETH/aave-protocol-v2-12c9111990c9699e84a36f30ba849486ef8f2a84/contracts/dependencies/openzeppelin/contracts/SignedSafeMath.sol

// SPDX-License-Identifier: MIT
// SWC-Outdated Compiler Version: L1 -L93
pragma solidity 0.6.12;

/**
 * @title SignedSafeMath
 * @dev Signed math operations with safety checks that revert on error.
 */
library SignedSafeMath {
  int256 private constant _INT256_MIN = -2**255;

  /**
   * @dev Returns the multiplication of two signed integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `*` operator.
   *
   * Requirements:
   *
   * - Multiplication cannot overflow.
   */
  function mul(int256 a, int256 b) internal pure returns (int256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
    if (a == 0) {
      return 0;
    }

    require(!(a == -1 && b == _INT256_MIN), 'SignedSafeMath: multiplication overflow');

    int256 c = a * b;
    require(c / a == b, 'SignedSafeMath: multiplication overflow');

    return c;
  }

  /**
   * @dev Returns the integer division of two signed integers. Reverts on
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
  function div(int256 a, int256 b) internal pure returns (int256) {
    require(b != 0, 'SignedSafeMath: division by zero');
    require(!(b == -1 && a == _INT256_MIN), 'SignedSafeMath: division overflow');

    int256 c = a / b;

    return c;
  }

  /**
   * @dev Returns the subtraction of two signed integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   *
   * - Subtraction cannot overflow.
   */
  function sub(int256 a, int256 b) internal pure returns (int256) {
    int256 c = a - b;
    require((b >= 0 && c <= a) || (b < 0 && c > a), 'SignedSafeMath: subtraction overflow');

    return c;
  }

  /**
   * @dev Returns the addition of two signed integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `+` operator.
   *
   * Requirements:
   *
   * - Addition cannot overflow.
   */
  function add(int256 a, int256 b) internal pure returns (int256) {
    int256 c = a + b;
    require((b >= 0 && c >= a) || (b < 0 && c < a), 'SignedSafeMath: addition overflow');

    return c;
  }
}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Aave stETH/aave-protocol-v2-12c9111990c9699e84a36f30ba849486ef8f2a84/contracts/dependencies/uFragments/UInt256Lib.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

/**
 * @title Various utilities useful for uint256.
 */
library UInt256Lib {
  uint256 private constant MAX_INT256 = ~(uint256(1) << 255);

  /**
   * @dev Safely converts a uint256 to an int256.
   */
  function toInt256Safe(uint256 a) internal pure returns (int256) {
    require(a <= MAX_INT256);
    return int256(a);
  }
}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Aave stETH/aave-protocol-v2-12c9111990c9699e84a36f30ba849486ef8f2a84/contracts/mocks/tokens/StETHMocked.sol

// SPDX-FileCopyrightText: 2020 Lido <info@lido.fi>
// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.6.12;



contract StETHMocked {
  using SafeMath for uint256;
  using UInt256Lib for uint256;
  using SignedSafeMath for int256;

  string public symbol = 'stETH';
  uint256 public decimals = 18;

  uint256 private _totalSupply;
  uint256 private _totalShares;
  mapping(address => uint256) _shares;

  function _getPooledEthByShares(uint256 _sharesAmount) internal view returns (uint256) {
    return _sharesAmount.mul(_totalSupply).div(_totalShares);
  }

  function _getSharesByPooledEth(uint256 _pooledEthAmount) internal view returns (uint256) {
    return _pooledEthAmount.mul(_totalShares).div(_totalSupply);
  }

  function totalSupply() external view returns (uint256) {
    return _totalSupply;
  }

  /**
   * @notice Increases shares of a given address by the specified amount.
   *
   * @param _to Receiver of new shares
   * @param _sharesAmount Amount of shares to mint
   * @return The total amount of all holders' shares after new shares are minted
   */
  function _mintShares(address _to, uint256 _sharesAmount) internal returns (uint256) {
    _shares[_to] = _shares[_to].add(_sharesAmount);
    _totalShares = _totalShares.add(_sharesAmount);

    return _totalShares;
  }

  function mint(address _to, uint256 amount) external returns (uint256) {
    uint256 newTotalSupply = _totalSupply.add(amount);
    if (_totalSupply != 0) {
      amount = _getSharesByPooledEth(amount);
    }
    _totalSupply = newTotalSupply;

    return _mintShares(_to, amount);
  }

  function rebase(int256 addingAmount) external returns (uint256) {
    int256 currentTotalSupply = _totalSupply.toInt256Safe();

    if (currentTotalSupply != 0) {
      currentTotalSupply = currentTotalSupply.add(addingAmount);
      require(currentTotalSupply > 0);
      _totalSupply = uint256(currentTotalSupply);
    }

    return _totalSupply;
  }

  function getTotalShares() external view returns (uint256) {
    return _totalShares;
  }

  function balanceOf(address owner) external view returns (uint256) {
    uint256 _sharesOf = _shares[owner];
    if (_sharesOf == 0) {
      return 0;
    }
    return _getPooledEthByShares(_sharesOf);
  }

  function getPooledEthByShares(uint256 _sharesAmount) external view returns (uint256) {
    return _getPooledEthByShares(_sharesAmount);
  }

  function getSharesByPooledEth(uint256 _pooledEthAmount) external view returns (uint256) {
    return _getSharesByPooledEth(_pooledEthAmount);
  }

  function approve(address _to, uint256 amount) public returns (bool) {
    return true;
  }

  function allowance(address _owner, address _spender) public returns (uint256) {
    return _shares[_owner];
  }

  function _transfer(
    address _from,
    address _to,
    uint256 _value
  ) internal returns (bool) {
    if (_totalSupply == 0) {
      return false;
    }
    uint256 _valueShares = _getSharesByPooledEth(_value);
    require(_shares[_from] >= _valueShares);

    _shares[_from] = _shares[_from].sub(_valueShares);
    _shares[_to] = _shares[_to].add(_valueShares);

    return true;
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    return _transfer(msg.sender, _to, _value);
  }

  function transferFrom(
    address _from,
    address _to,
    uint256 _value
  ) public returns (bool) {
    return _transfer(_from, _to, _value);
  }
}
