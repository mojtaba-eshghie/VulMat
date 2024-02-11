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

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/oracle/IOracle.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/// @title generic oracle interface for Fei Protocol
/// @author Fei Protocol
interface IOracle {
	
    // ----------- Events -----------

	event KillSwitchUpdate(bool _killSwitch);

	event Update(uint _peg);

    // ----------- State changing API -----------

    /// @notice updates the oracle price
    /// @return true if oracle is updated and false if unchanged
    function update() external returns (bool);

    // ----------- Governor only state changing API -----------

    /// @notice sets the kill switch on the oracle feed
    /// @param _killSwitch the new value for the kill switch
    function setKillSwitch(bool _killSwitch) external;

    // ----------- Getters -----------

    /// @notice read the oracle price
    /// @return oracle price
    /// @return true if price is valid
    /// @dev price is to be denominated in USD per X where X can be ETH, etc.
    function read() external view returns (Decimal.D256 memory, bool);

    /// @notice the kill switch for the oracle feed
    /// @return true if kill switch engaged
    /// @dev if kill switch is true, read will return invalid
    function killSwitch() external view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/refs/IOracleRef.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


/// @title A oracle Reference contract
/// @author Fei Protocol
/// @notice defines some utilities around interacting with the referenced oracle
interface IOracleRef {

	// ----------- Events -----------

	event OracleUpdate(address indexed _oracle);

	// ----------- State changing API -----------

	/// @notice updates the referenced oracle
	/// @return true if the update is effective
	function updateOracle() external returns(bool);

	// ----------- Governor only state changing API -----------

	/// @notice sets the referenced oracle
	/// @param _oracle the new oracle to reference
	function setOracle(address _oracle) external;

	// ----------- Getters -----------

	/// @notice the oracle reference by the contract
	/// @return the IOracle implementation address
	function oracle() external view returns(IOracle);

	/// @notice the peg price of the referenced oracle
	/// @return the peg as a Decimal
	/// @dev the peg is defined as FEI per X with X being ETH, dollars, etc
	function peg() external view returns(Decimal.D256 memory);

	/// @notice invert a peg price
	/// @param price the peg price to invert
	/// @return the inverted peg as a Decimal
	/// @dev the inverted peg would be X per FEI
	function invert(Decimal.D256 calldata price) external pure returns(Decimal.D256 memory);
}

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

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/token/IFei.sol

pragma solidity ^0.6.2;

/// @title FEI stablecoin interface
/// @author Fei Protocol
interface IFei is IERC20 {

	// ----------- Events -----------

    event Minting(address indexed _to, address indexed _minter, uint _amount);

    event Burning(address indexed _to, address indexed _burner, uint _amount);

    event IncentiveContractUpdate(address indexed _incentivized, address indexed _incentiveContract);

    // ----------- State changing api -----------

    /// @notice burn FEI tokens from caller
    /// @param amount the amount to burn
    function burn(uint amount) external;

    // ----------- Burner only state changing api -----------

    /// @notice burn FEI tokens from specified account
    /// @param account the account to burn from
    /// @param amount the amount to burn
    function burnFrom(address account, uint amount) external;

    // ----------- Minter only state changing api -----------

    /// @notice mint FEI tokens
    /// @param account the account to mint to
    /// @param amount the amount to mint
    function mint(address account, uint amount) external;

    // ----------- Governor only state changing api -----------

    /// @param account the account to incentivize
    /// @param incentive the associated incentive contract
    function setIncentiveContract(address account, address incentive) external;

    // ----------- Getters -----------

    /// @notice get associated incentive contract
    /// @param account the address to check
    /// @return the associated incentive contract, 0 address if N/A
    function incentiveContract(address account) external view returns(address);
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/core/IPermissions.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


/// @title Access control module for Core
/// @author Fei Protocol
interface IPermissions {
    // Governor only state changing api

    /// @notice creates a new role to be maintained
    /// @param role the new role id
    /// @param adminRole the admin role id for `role`
    /// @dev can also be used to update admin of existing role
	function createRole(bytes32 role, bytes32 adminRole) external;

    /// @notice grants minter role to address
    /// @param minter new minter
	function grantMinter(address minter) external;

    /// @notice grants burner role to address
    /// @param burner new burner
	function grantBurner(address burner) external;

    /// @notice grants controller role to address
    /// @param pcvController new controller
	function grantPCVController(address pcvController) external;

    /// @notice grants governor role to address
    /// @param governor new governor
	function grantGovernor(address governor) external;

    /// @notice grants revoker role to address
    /// @param revoker new revoker
	function grantRevoker(address revoker) external;

    /// @notice revokes minter role from address
    /// @param minter ex minter
    function revokeMinter(address minter) external;

    /// @notice revokes burner role from address
    /// @param burner ex burner
    function revokeBurner(address burner) external;

    /// @notice revokes pcvController role from address
    /// @param pcvController ex pcvController
    function revokePCVController(address pcvController) external;

    /// @notice revokes governor role from address
    /// @param governor ex governor
    function revokeGovernor(address governor) external;

    /// @notice revokes revoker role from address
    /// @param revoker ex revoker
    function revokeRevoker(address revoker) external;

    // Revoker only state changing api

    /// @notice revokes a role from address
    /// @param role the role to revoke
    /// @param account the address to revoke the role from
    function revokeOverride(bytes32 role, address account) external;

    // Getters

    /// @notice checks if address is a burner
    /// @param _address address to check
    /// @return true _address is a burner
	function isBurner(address _address) external view returns (bool);

    /// @notice checks if address is a minter
    /// @param _address address to check
    /// @return true _address is a minter
	function isMinter(address _address) external view returns (bool);

    /// @notice checks if address is a governor
    /// @param _address address to check
    /// @return true _address is a governor
	function isGovernor(address _address) external view returns (bool);

    /// @notice checks if address is a revoker
    /// @param _address address to check
    /// @return true _address is a revoker
    function isRevoker(address _address) external view returns (bool);

    /// @notice checks if address is a controller
    /// @param _address address to check
    /// @return true _address is a controller
	function isPCVController(address _address) external view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/core/ICore.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;



/// @title Source of truth for Fei Protocol
/// @author Fei Protocol
/// @notice maintains roles, access control, fei, tribe, genesisGroup, and the TRIBE treasury
interface ICore is IPermissions {

	// ----------- Events -----------

    event FeiUpdate(address indexed _fei);
    event TribeAllocation(address indexed _to, uint _amount);
    event GenesisPeriodComplete(uint _timestamp);

    // ----------- Governor only state changing api -----------

    /// @notice sets Fei address to a new address
    /// @param token new fei address
    function setFei(address token) external;

    /// @notice sets Genesis Group address
    /// @param _genesisGroup new genesis group address
    function setGenesisGroup(address _genesisGroup) external;

    /// @notice sends TRIBE tokens from treasury to an address
    /// @param to the address to send TRIBE to
    /// @param amount the amount of TRIBE to send
    function allocateTribe(address to, uint amount) external;

    // ----------- Genesis Group only state changing api -----------

    /// @notice marks the end of the genesis period
    /// @dev can only be called once
	function completeGenesisGroup() external;

    // ----------- Getters -----------

    /// @notice the address of the FEI contract
    /// @return fei contract
	function fei() external view returns (IFei);

    /// @notice the address of the TRIBE contract
    /// @return tribe contract
	function tribe() external view returns (IERC20);

    /// @notice the address of the GenesisGroup contract
    /// @return genesis group contract
    function genesisGroup() external view returns(address);

    /// @notice determines whether in genesis period or not
    /// @return true if in genesis period
	function hasGenesisGroupCompleted() external view returns(bool);
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/refs/ICoreRef.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;



/// @title A Core Reference contract
/// @author Fei Protocol
/// @notice defines some modifiers and utilities around interacting with Core
interface ICoreRef {

	// ----------- Events -----------

    event CoreUpdate(address indexed _core);

    // ----------- Governor only state changing api -----------

    /// @notice set new Core reference address
    /// @param core the new core address
    function setCore(address core) external;

    // ----------- Getters -----------

    /// @notice address of the Core contract referenced
    /// @return ICore implementation address
	function core() external view returns (ICore);

    /// @notice address of the Fei contract referenced by Core
    /// @return IFei implementation address
    function fei() external view returns (IFei);

    /// @notice address of the Tribe contract referenced by Core
    /// @return IERC20 implementation address
    function tribe() external view returns (IERC20);

    /// @notice fei balance of contract
    /// @return fei amount held
	function feiBalance() external view returns(uint);

    /// @notice tribe balance of contract
    /// @return tribe amount held
    function tribeBalance() external view returns(uint);
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/refs/CoreRef.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/// @title Abstract implementation of ICoreRef
/// @author Fei Protocol
abstract contract CoreRef is ICoreRef {
	ICore private _core;

	/// @notice CoreRef constructor
	/// @param core Fei Core to reference
	constructor(address core) public {
		_core = ICore(core);
	}

	modifier ifMinterSelf() {
		if (_core.isMinter(address(this))) {
			_;
		}
	}

	modifier ifBurnerSelf() {
		if (_core.isBurner(address(this))) {
			_;
		}
	}

	modifier onlyMinter() {
		require(_core.isMinter(msg.sender), "CoreRef: Caller is not a minter");
		_;
	}

	modifier onlyBurner() {
		require(_core.isBurner(msg.sender), "CoreRef: Caller is not a burner");
		_;
	}

	modifier onlyPCVController() {
		require(_core.isPCVController(msg.sender), "CoreRef: Caller is not a PCV controller");
		_;
	}

	modifier onlyGovernor() {
		require(_core.isGovernor(msg.sender), "CoreRef: Caller is not a governor");
		_;
	}

	modifier onlyFei() {
		require(msg.sender == address(fei()), "CoreRef: Caller is not FEI");
		_;
	}

	modifier onlyGenesisGroup() {
		require(msg.sender == _core.genesisGroup(), "CoreRef: Caller is not GenesisGroup");
		_;
	}

	modifier postGenesis() {
		require(_core.hasGenesisGroupCompleted(), "CoreRef: Still in Genesis Period");
		_;
	}

	function setCore(address core) external override onlyGovernor {
		_core = ICore(core);
		emit CoreUpdate(core);
	}
 
	function core() public view override returns(ICore) {
		return _core;
	}

	function fei() public view override returns(IFei) {
		return _core.fei();
	}

	function tribe() public view override returns(IERC20) {
		return _core.tribe();
	}

	function feiBalance() public view override returns (uint) {
		return fei().balanceOf(address(this));
	}

	function tribeBalance() public view override returns (uint) {
		return tribe().balanceOf(address(this));
	}

    function _burnFeiHeld() internal {
    	fei().burn(feiBalance());
    }

    function _mintFei(uint amount) internal {
		fei().mint(address(this), amount);
	}
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/refs/OracleRef.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


/// @title Abstract implementation of IOracleRef
/// @author Fei Protocol
abstract contract OracleRef is IOracleRef, CoreRef {
	using Decimal for Decimal.D256;

	IOracle public override oracle;

	/// @notice OracleRef constructor
	/// @param _core Fei Core to reference
	/// @param _oracle oracle to reference
	constructor(address _core, address _oracle) public CoreRef(_core) {
        _setOracle(_oracle);
    }

	function setOracle(address _oracle) external override onlyGovernor {
		_setOracle(_oracle);
        emit OracleUpdate(_oracle);
	}

    function invert(Decimal.D256 memory price) public override pure returns(Decimal.D256 memory) {
    	return Decimal.one().div(price);
    }

    function updateOracle() public override returns(bool) {
    	return oracle.update();
    }

    function peg() public override view returns(Decimal.D256 memory) {
    	(Decimal.D256 memory _peg, bool valid) = oracle.read();
    	require(valid, "OracleRef: oracle invalid");
    	return _peg;
    }

    function _setOracle(address _oracle) internal {
    	oracle = IOracle(_oracle);
    }
}
