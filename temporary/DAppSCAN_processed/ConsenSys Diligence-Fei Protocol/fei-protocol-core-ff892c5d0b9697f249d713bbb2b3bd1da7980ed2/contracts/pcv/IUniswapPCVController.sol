// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/pcv/IPCVDeposit.sol

pragma solidity ^0.6.2;

/// @title a PCV Deposit interface
/// @author Fei Protocol
interface IPCVDeposit {

	// ----------- Events -----------
    event Deposit(address indexed _from, uint _amount);

    event Withdrawal(address indexed _caller, address indexed _to, uint _amount);

    // ----------- State changing api -----------

    /// @notice deposit tokens into the PCV allocation
    /// @param amount of tokens deposited
    function deposit(uint amount) external payable;

    // ----------- PCV Controller only state changing api -----------

    /// @notice withdraw tokens from the PCV allocation
    /// @param amount of tokens withdrawn
    /// @param to the address to send PCV to
    function withdraw(address to, uint amount) external;

    // ----------- Getters -----------
    
    /// @notice returns total value of PCV in the Deposit
    function totalValue() external view returns(uint);
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/token/IIncentive.sol

pragma solidity ^0.6.2;

/// @title incentive contract interface
/// @author Fei Protocol
/// @notice Called by FEI token contract when transferring with an incentivized address
/// @dev should be appointed as a Minter or Burner as needed
interface IIncentive {

	// ----------- Fei only state changing api -----------

	/// @notice apply incentives on transfer
	/// @param sender the sender address of the FEI
	/// @param receiver the receiver address of the FEI
	/// @param operator the operator (msg.sender) of the transfer
	/// @param amount the amount of FEI transferred
    function incentivize(
    	address sender, 
    	address receiver, 
    	address operator, 
    	uint amount
    ) external;
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/external/SafeMathCopy.sol

// SPDX-License-Identifier: MIT

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
library SafeMathCopy { // To avoid namespace collision between openzeppelin safemath and uniswap safemath
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
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
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
     *
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
     *
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
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
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
     *
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
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/external/Decimal.sol

/*
    Copyright 2019 dYdX Trading Inc.
    Copyright 2020 Empty Set Squad <emptysetsquad@protonmail.com>
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/**
 * @title Decimal
 * @author dYdX
 *
 * Library that defines a fixed-point number with 18 decimal places.
 */
library Decimal {
    using SafeMathCopy for uint256;

    // ============ Constants ============

    uint256 private constant BASE = 10**18;

    // ============ Structs ============


    struct D256 {
        uint256 value;
    }

    // ============ Static Functions ============

    function zero()
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: 0 });
    }

    function one()
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: BASE });
    }

    function from(
        uint256 a
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: a.mul(BASE) });
    }

    function ratio(
        uint256 a,
        uint256 b
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: getPartial(a, BASE, b) });
    }

    // ============ Self Functions ============

    function add(
        D256 memory self,
        uint256 b
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: self.value.add(b.mul(BASE)) });
    }

    function sub(
        D256 memory self,
        uint256 b
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: self.value.sub(b.mul(BASE)) });
    }

    function sub(
        D256 memory self,
        uint256 b,
        string memory reason
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: self.value.sub(b.mul(BASE), reason) });
    }

    function mul(
        D256 memory self,
        uint256 b
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: self.value.mul(b) });
    }

    function div(
        D256 memory self,
        uint256 b
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: self.value.div(b) });
    }

    function pow(
        D256 memory self,
        uint256 b
    )
    internal
    pure
    returns (D256 memory)
    {
        if (b == 0) {
            return from(1);
        }

        D256 memory temp = D256({ value: self.value });
        for (uint256 i = 1; i < b; i++) {
            temp = mul(temp, self);
        }

        return temp;
    }

    function add(
        D256 memory self,
        D256 memory b
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: self.value.add(b.value) });
    }

    function sub(
        D256 memory self,
        D256 memory b
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: self.value.sub(b.value) });
    }

    function sub(
        D256 memory self,
        D256 memory b,
        string memory reason
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: self.value.sub(b.value, reason) });
    }

    function mul(
        D256 memory self,
        D256 memory b
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: getPartial(self.value, b.value, BASE) });
    }

    function div(
        D256 memory self,
        D256 memory b
    )
    internal
    pure
    returns (D256 memory)
    {
        return D256({ value: getPartial(self.value, BASE, b.value) });
    }

    function equals(D256 memory self, D256 memory b) internal pure returns (bool) {
        return self.value == b.value;
    }

    function greaterThan(D256 memory self, D256 memory b) internal pure returns (bool) {
        return compareTo(self, b) == 2;
    }

    function lessThan(D256 memory self, D256 memory b) internal pure returns (bool) {
        return compareTo(self, b) == 0;
    }

    function greaterThanOrEqualTo(D256 memory self, D256 memory b) internal pure returns (bool) {
        return compareTo(self, b) > 0;
    }

    function lessThanOrEqualTo(D256 memory self, D256 memory b) internal pure returns (bool) {
        return compareTo(self, b) < 2;
    }

    function isZero(D256 memory self) internal pure returns (bool) {
        return self.value == 0;
    }

    function asUint256(D256 memory self) internal pure returns (uint256) {
        return self.value.div(BASE);
    }

    // ============ Core Methods ============

    function getPartial(
        uint256 target,
        uint256 numerator,
        uint256 denominator
    )
    private
    pure
    returns (uint256)
    {
        return target.mul(numerator).div(denominator);
    }

    function compareTo(
        D256 memory a,
        D256 memory b
    )
    private
    pure
    returns (uint256)
    {
        if (a.value == b.value) {
            return 1;
        }
        return a.value > b.value ? 2 : 0;
    }
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/token/IUniswapIncentive.sol

pragma solidity ^0.6.2;
pragma experimental ABIEncoderV2;


/// @title Uniswap trading incentive contract
/// @author Fei Protocol
/// @dev incentives are only appplied if the contract is appointed as a Minter or Burner, otherwise skipped
interface IUniswapIncentive is IIncentive {

	// ----------- Events -----------

    event TimeWeightUpdate(uint _weight, bool _active);

    event GrowthRateUpdate(uint _growthRate);

    event ExemptAddressUpdate(address indexed _account, bool _isExempt);

    event SellAllowedAddressUpdate(address indexed _account, bool _isSellAllowed);

	// ----------- Governor only state changing api -----------

	/// @notice set an address to be exempted from Uniswap trading incentives
	/// @param account the address to update
	/// @param isExempt a flag for whether to exempt or unexempt
 	function setExemptAddress(address account, bool isExempt) external;

	/// @notice set an address to be able to send tokens to Uniswap
	/// @param account the address to update
	/// @param isAllowed a flag for whether the account is allowed to sell or not
	function setSellAllowlisted(address account, bool isAllowed) external;

	/// @notice set the time weight growth function
	function setTimeWeightGrowth(uint32 growthRate) external;

	/// @notice sets all of the time weight parameters
	// @param blockNo the stored last block number of the time weight
	/// @param weight the stored last time weight
	/// @param growth the growth rate of the time weight per block
	/// @param active a flag signifying whether the time weight is currently growing or not
	function setTimeWeight(uint32 weight, uint32 growth, bool active) external;

	// ----------- Getters -----------

	/// @notice return true if burn incentive equals mint
	function isIncentiveParity() external view returns (bool);

	/// @notice returns true if account is marked as exempt
	function isExemptAddress(address account) external view returns (bool);

	/// @notice return true if the account is approved to sell to the Uniswap pool
	function isSellAllowlisted(address account) external view returns (bool);

	/// @notice the granularity of the time weight and growth rate
	// solhint-disable-next-line func-name-mixedcase
	function TIME_WEIGHT_GRANULARITY() external view returns(uint32);

	/// @notice the growth rate of the time weight per block
	function getGrowthRate() external view returns (uint32);

	/// @notice the time weight of the current block
	/// @dev factors in the stored block number and growth rate if active
	function getTimeWeight() external view returns (uint32);

	/// @notice returns true if time weight is active and growing at the growth rate
	function isTimeWeightActive() external view returns (bool);

	/// @notice get the incentive amount of a buy transfer
	/// @param amount the FEI size of the transfer
	/// @return incentive the FEI size of the mint incentive
	/// @return weight the time weight of thhe incentive
	/// @return initialDeviation the Decimal deviation from peg before a transfer
	/// @return finalDeviation the Decimal deviation from peg after a transfer
	/// @dev calculated based on a hypothetical buy, applies to any ERC20 FEI transfer from the pool
	function getBuyIncentive(uint amount) external view returns(
        uint incentive, 
        uint32 weight,
        Decimal.D256 memory initialDeviation,
        Decimal.D256 memory finalDeviation
    );

	/// @notice get the burn amount of a sell transfer
	/// @param amount the FEI size of the transfer
	/// @return penalty the FEI size of the burn incentive
	/// @return initialDeviation the Decimal deviation from peg before a transfer
	/// @return finalDeviation the Decimal deviation from peg after a transfer
	/// @dev calculated based on a hypothetical sell, applies to any ERC20 FEI transfer to the pool
	function getSellPenalty(uint amount) external view returns(
        uint penalty, 
        Decimal.D256 memory initialDeviation,
        Decimal.D256 memory finalDeviation
    );
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/pcv/IUniswapPCVController.sol

pragma solidity ^0.6.2;


/// @title a Uniswap PCV Controller interface
/// @author Fei Protocol
interface IUniswapPCVController {
    
    // ----------- Events -----------

    event Reweight(address indexed _caller);

	event PCVDepositUpdate(address indexed _pcvDeposit);

	event ReweightIncentiveUpdate(uint _amount);

	event ReweightMinDistanceUpdate(uint _basisPoints);

    // ----------- State changing API -----------

    /// @notice reweights the linked PCV Deposit to the peg price. Needs to be reweight eligible
	function reweight() external;

    // ----------- Governor only state changing API -----------

    /// @notice reweights regardless of eligibility
    function forceReweight() external;

    /// @notice sets the target PCV Deposit address
	function setPCVDeposit(address _pcvDeposit) external;

    /// @notice sets the reweight incentive amount
	function setReweightIncentive(uint amount) external;

    /// @notice sets the reweight min distance in basis points
	function setReweightMinDistance(uint basisPoints) external;

    // ----------- Getters -----------

    /// @notice returns the linked pcv deposit contract
	function pcvDeposit() external returns(IPCVDeposit);

    /// @notice returns the linked Uniswap incentive contract
    function incentiveContract() external returns(IUniswapIncentive);

    /// @notice gets the FEI reward incentive for reweighting
    function reweightIncentiveAmount() external returns(uint);

    /// @notice signal whether the reweight is available. Must have incentive parity and minimum distance from peg
	function reweightEligible() external view returns(bool);
}
