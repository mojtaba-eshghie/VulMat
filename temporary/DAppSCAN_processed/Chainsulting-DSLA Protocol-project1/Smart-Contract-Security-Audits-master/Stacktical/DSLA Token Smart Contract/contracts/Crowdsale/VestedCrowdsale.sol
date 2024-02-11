// File: openzeppelin-solidity/contracts/math/SafeMath.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

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
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b > a) return (false, 0);
        return (true, a - b);
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a % b);
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
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
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
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
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
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
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
        require(b > 0, "SafeMath: modulo by zero");
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
        require(b <= a, errorMessage);
        return a - b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryDiv}.
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
        require(b > 0, errorMessage);
        return a / b;
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
        require(b > 0, errorMessage);
        return a % b;
    }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-DSLA Protocol-project1/Smart-Contract-Security-Audits-master/Stacktical/DSLA Token Smart Contract/contracts/Crowdsale/VestedCrowdsale.sol

pragma solidity 0.4.24;

/** @title VestedCrowdsale
  * @dev Extension of Crowdsale to allow a vested distribution of tokens
  * Users have to individually claim their tokens
  */
contract VestedCrowdsale {
    using SafeMath for uint256;

    mapping (address => uint256) public withdrawn;
    mapping (address => uint256) public contributions;
    mapping (address => uint256) public contributionsRound;
    uint256 public vestedTokens;

    /**
      * @dev Gives how much a user is allowed to withdraw at the current moment
      * @param _beneficiary The address of the user asking how much he's allowed
      * to withdraw
      * @return Amount _beneficiary is allowed to withdraw
      */
    function getWithdrawableAmount(address _beneficiary) public view returns(uint256) {
        uint256 step = _getVestingStep(_beneficiary);
        uint256 valueByStep = _getValueByStep(_beneficiary);
        uint256 result = step.mul(valueByStep).sub(withdrawn[_beneficiary]);

        return result;
    }

    /**
      * @dev Gives the step of the vesting (starts from 0 to steps)
      * @param _beneficiary The address of the user asking how much he's allowed
      * to withdraw
      * @return The vesting step for _beneficiary
      */
    function _getVestingStep(address _beneficiary) internal view returns(uint8) {
        require(contributions[_beneficiary] != 0);
        require(contributionsRound[_beneficiary] > 0 && contributionsRound[_beneficiary] < 4);

        uint256 march31 = 1554019200;
        uint256 april30 = 1556611200;
        uint256 may31 = 1559289600;
        uint256 june30 = 1561881600;
        uint256 july31 = 1564560000;
        uint256 sept30 = 1569830400;
        uint256 contributionRound = contributionsRound[_beneficiary];

        // vesting for private sale contributors
        if (contributionRound == 1) {
            if (block.timestamp < march31) {
                return 0;
            }
            if (block.timestamp < june30) {
                return 1;
            }
            if (block.timestamp < sept30) {
                return 2;
            }

            return 3;
        }
        // vesting for pre ico contributors
        if (contributionRound == 2) {
            if (block.timestamp < april30) {
                return 0;
            }
            if (block.timestamp < july31) {
                return 1;
            }

            return 2;
        }
        // vesting for ico contributors
        if (contributionRound == 3) {
            if (block.timestamp < may31) {
                return 0;
            }

            return 1;
        }
    }

    /**
      * @dev Gives the amount a user is allowed to withdraw by step
      * @param _beneficiary The address of the user asking how much he's allowed
      * to withdraw
      * @return How much a user is allowed to withdraw by step
      */
    function _getValueByStep(address _beneficiary) internal view returns(uint256) {
        require(contributions[_beneficiary] != 0);
        require(contributionsRound[_beneficiary] > 0 && contributionsRound[_beneficiary] < 4);

        uint256 contributionRound = contributionsRound[_beneficiary];
        uint256 amount;
        uint256 rate;

        if (contributionRound == 1) {
            rate = 416700;
            amount = contributions[_beneficiary].mul(rate).mul(25).div(100);
            return amount;
        } else if (contributionRound == 2) {
            rate = 312500;
            amount = contributions[_beneficiary].mul(rate).mul(25).div(100);
            return amount;
        }

        rate = 250000;
        amount = contributions[_beneficiary].mul(rate).mul(25).div(100);
        return amount;
    }
}
