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

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/dao/ITimelockedDelegator.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


interface ITribe is IERC20 {
	function delegate(address delegatee) external;
}

/// @title a timelock for TRIBE allowing for sub-delegation
/// @author Fei Protocol
/// @notice allows the timelocked TRIBE to be delegated by the beneficiary while locked
interface ITimelockedDelegator {

	// ----------- Events -----------

    event Delegate(address indexed _delegatee, uint _amount);

    event Undelegate(address indexed _delegatee, uint _amount);

    // ----------- Beneficiary only state changing api -----------

	/// @notice delegate locked TRIBE to a delegatee
	/// @param delegatee the target address to delegate to
	/// @param amount the amount of TRIBE to delegate. Will increment existing delegated TRIBE
    function delegate(address delegatee, uint amount) external;

	/// @notice return delegated TRIBE to the timelock
	/// @param delegatee the target address to undelegate from
	/// @return the amount of TRIBE returned
    function undelegate(address delegatee) external returns(uint);

    // ----------- Getters -----------

	/// @notice associated delegate proxy contract for a delegatee
	/// @param delegatee The delegatee
	/// @return the corresponding delegate proxy contract
    function delegateContract(address delegatee) external view returns(address);

	/// @notice associated delegated amount for a delegatee
	/// @param delegatee The delegatee
	/// @return uint amount of TRIBE delegated
    /// @dev Using as source of truth to prevent accounting errors by transferring to Delegate contracts
    function delegateAmount(address delegatee) external view returns(uint);

	/// @notice the total delegated amount of TRIBE
    function totalDelegated() external view returns(uint);

	/// @notice the TRIBE token contract
    function tribe() external view returns(ITribe);

}
