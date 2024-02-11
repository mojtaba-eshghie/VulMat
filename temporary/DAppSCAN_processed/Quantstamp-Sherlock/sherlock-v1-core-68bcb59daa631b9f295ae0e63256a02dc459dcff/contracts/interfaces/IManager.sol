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

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sherlock/sherlock-v1-core-68bcb59daa631b9f295ae0e63256a02dc459dcff/contracts/interfaces/IManager.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.4;
pragma abicoder v2;

/******************************************************************************\
* Author: Evert Kors <dev@sherlock.xyz> (https://twitter.com/evert0x)
* Sherlock Protocol: https://sherlock.xyz
/******************************************************************************/

/// @title Sherlock Protocol Manager
/// @author Evert Kors
/// @notice Managing the amounts protocol are due to Sherlock
interface IManager {
  //
  // State changing methods
  //

  /// @notice Set internal price of `_token` to `_newUsd`
  /// @param _token Token to be updated
  /// @param _newUsd USD amount of token
  /// @dev Updating token price for 1 token
  function setTokenPrice(IERC20 _token, uint256 _newUsd) external;

  /// @notice Set internal price of multiple tokens
  /// @param _token Array of token addresses
  /// @param _newUsd Array of USD amounts
  /// @dev Updating token price for 1+ tokens
  function setTokenPrice(IERC20[] memory _token, uint256[] memory _newUsd) external;

  /// @notice Set `_token` premium for `_protocol` to `_premium` per block
  /// @param _protocol Protocol identifier
  /// @param _token Token address
  /// @param _premium Amount of tokens to be paid per block
  /// @dev Updating protocol premium for 1 token
  function setProtocolPremium(
    bytes32 _protocol,
    IERC20 _token,
    uint256 _premium
  ) external;

  /// @notice Set multiple token premiums for `_protocol`
  /// @param _protocol Protocol identifier
  /// @param _token Array of token addresses
  /// @param _premium Array of amount of tokens to be paid per block
  /// @dev Updating protocol premium for 1+ tokens
  function setProtocolPremium(
    bytes32 _protocol,
    IERC20[] memory _token,
    uint256[] memory _premium
  ) external;

  // NOTE: note implemented for now, same call with price has better use case
  // updating multiple protocol's premiums for 1 tokens
  // function setProtocolPremium(
  //   bytes32[] memory _protocol,
  //   IERC20 memory _token,
  //   uint256[] memory _premium
  // ) external;

  /// @notice Set multiple tokens premium for multiple protocols
  /// @param _protocol Array of protocol identifiers
  /// @param _token 2 dimensional array of token addresses
  /// @param _premium 2 dimensional array of amount of tokens to be paid per block
  /// @dev Updating multiple protocol's premium for 1+ tokens
  function setProtocolPremium(
    bytes32[] memory _protocol,
    IERC20[][] memory _token,
    uint256[][] memory _premium
  ) external;

  /// @notice Set `_token` premium for `_protocol` to `_premium` per block and internal price to `_newUsd`
  /// @param _protocol Protocol identifier
  /// @param _token Token address
  /// @param _premium Amount of tokens to be paid per block
  /// @param _newUsd USD amount of token
  /// @dev Updating protocol premium and token price for 1 token
  function setProtocolPremiumAndTokenPrice(
    bytes32 _protocol,
    IERC20 _token,
    uint256 _premium,
    uint256 _newUsd
  ) external;

  /// @notice Set multiple token premiums for `_protocol` and update internal prices
  /// @param _protocol Protocol identifier
  /// @param _token Array of token addresses
  /// @param _premium Array of amount of tokens to be paid per block
  /// @param _newUsd Array of USD amounts
  /// @dev Updating protocol premiums and token price for 1+ token
  function setProtocolPremiumAndTokenPrice(
    bytes32 _protocol,
    IERC20[] memory _token,
    uint256[] memory _premium,
    uint256[] memory _newUsd
  ) external;

  /// @notice Set `_token` premium for protocols and internal price to `_newUsd`
  /// @param _protocol Array of protocol identifiers
  /// @param _token Token address
  /// @param _premium Array of amount of tokens to be paid per block
  /// @param _newUsd USD amount
  /// @dev Updating multiple protocol premiums for 1 token, including price
  function setProtocolPremiumAndTokenPrice(
    bytes32[] memory _protocol,
    IERC20 _token,
    uint256[] memory _premium,
    uint256 _newUsd
  ) external;

  /// @notice Update multiple token premiums and prices for multiple protocols
  /// @param _protocol Array of protocol identifiers
  /// @param _token 2 dimensional array of tokens
  /// @param _premium 2 dimensional array of amounts to be paid per block
  /// @param _newUsd 2 dimensional array of USD amounts
  /// @dev Updating multiple protocol premiums for multiple tokens, including price
  function setProtocolPremiumAndTokenPrice(
    bytes32[] memory _protocol,
    IERC20[][] memory _token,
    uint256[][] memory _premium,
    uint256[][] memory _newUsd
  ) external;
}
