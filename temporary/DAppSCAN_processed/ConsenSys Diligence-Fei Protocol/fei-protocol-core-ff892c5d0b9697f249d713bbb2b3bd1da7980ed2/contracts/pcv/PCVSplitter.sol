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

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/pcv/PCVSplitter.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/// @title abstract contract for splitting PCV into different deposits
/// @author Fei Protocol
abstract contract PCVSplitter {

	/// @notice total allocation allowed representing 100%
	uint public constant ALLOCATION_GRANULARITY = 10_000; 

	uint[] private ratios;
	address[] private pcvDeposits;

	event AllocationUpdate(address[] _pcvDeposits, uint[] _ratios);

	/// @notice PCVSplitter constructor
	/// @param _pcvDeposits list of PCV Deposits to split to
	/// @param _ratios ratios for splitting PCV Deposit allocations
	constructor(address[] memory _pcvDeposits, uint[] memory _ratios) public {
		_setAllocation(_pcvDeposits, _ratios);
	}

	/// @notice make sure an allocation has matching lengths and totals the ALLOCATION_GRANULARITY
	/// @param _pcvDeposits new list of pcv deposits to send to
	/// @param _ratios new ratios corresponding to the PCV deposits
	/// @return true if it is a valid allocation
	function checkAllocation(address[] memory _pcvDeposits, uint[] memory _ratios) public pure returns (bool) {
		require(_pcvDeposits.length == _ratios.length, "PCVSplitter: PCV Deposits and ratios are different lengths");

		uint total;
		for (uint i; i < _ratios.length; i++) {
			total += _ratios[i];
		}

		require(total == ALLOCATION_GRANULARITY, "PCVSplitter: ratios do not total 100%");
		
		return true;
	}
	
	/// @notice gets the pcvDeposits and ratios of the splitter
	function getAllocation() public view returns (address[] memory, uint[] memory) {
		return (pcvDeposits, ratios);
	}

	/// @notice distribute funds to single PCV deposit
	/// @param amount amount of funds to send
	/// @param pcvDeposit the pcv deposit to send funds
	function _allocateSingle(uint amount, address pcvDeposit) internal virtual ;

	/// @notice sets a new allocation for the splitter
	/// @param _pcvDeposits new list of pcv deposits to send to
	/// @param _ratios new ratios corresponding to the PCV deposits. Must total ALLOCATION_GRANULARITY
	function _setAllocation(address[] memory _pcvDeposits, uint[] memory _ratios) internal {
		checkAllocation(_pcvDeposits, _ratios);

		pcvDeposits = _pcvDeposits;
		ratios = _ratios;

		emit AllocationUpdate(_pcvDeposits, _ratios);
	}

	/// @notice distribute funds to all pcv deposits at specified allocation ratios
	/// @param total amount of funds to send
	function _allocate(uint total) internal {
		uint granularity = ALLOCATION_GRANULARITY;
		for (uint i; i < ratios.length; i++) {
			uint amount = total * ratios[i] / granularity;
			_allocateSingle(amount, pcvDeposits[i]);
		}
	}
}
