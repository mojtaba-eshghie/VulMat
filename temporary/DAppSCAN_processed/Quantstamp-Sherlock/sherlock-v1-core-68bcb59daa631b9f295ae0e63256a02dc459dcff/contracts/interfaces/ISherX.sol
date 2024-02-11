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

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sherlock/sherlock-v1-core-68bcb59daa631b9f295ae0e63256a02dc459dcff/contracts/interfaces/ILock.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.4;

/******************************************************************************\
* Author: Evert Kors <dev@sherlock.xyz> (https://twitter.com/evert0x)
* Sherlock Protocol: https://sherlock.xyz
/******************************************************************************/

/// @title Lock Token
/// @author Evert Kors
/// @notice Lock tokens represent a stake in Sherlock
interface ILock is IERC20 {
  /// @notice Returns the owner of this contract
  /// @return Owner address
  /// @dev Should be equal to the Sherlock address
  function getOwner() external view returns (address);

  /// @notice Returns token it represents
  /// @return Token address
  function underlying() external view returns (IERC20);

  /// @notice Mint `_amount` tokens for `_account`
  /// @param _account Account to receive tokens
  /// @param _amount Amount to be minted
  function mint(address _account, uint256 _amount) external;

  /// @notice Burn `_amount` tokens for `_account`
  /// @param _account Account to be burned
  /// @param _amount Amount to be burned
  function burn(address _account, uint256 _amount) external;
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sherlock/sherlock-v1-core-68bcb59daa631b9f295ae0e63256a02dc459dcff/contracts/interfaces/ISherX.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.4;

/******************************************************************************\
* Author: Evert Kors <dev@sherlock.xyz> (https://twitter.com/evert0x)
* Sherlock Protocol: https://sherlock.xyz
/******************************************************************************/

/// @title SHERX Logic Controller
/// @author Evert Kors
/// @notice This contract is used to manage functions related to the SHERX token
/// @dev Contract is meant to be included as a facet in the diamond
interface ISherX {
  //
  // Events
  //

  /// @notice Sends an event whenever a staker "harvests" earned SHERX
  /// @notice Harvesting is when SHERX "interest" is staked in the SHERX pool
  /// @param user Address of the user for whom SHERX is harvested
  /// @param token Token which had accumulated the harvested SHERX
  event Harvest(address indexed user, IERC20 indexed token);

  //
  // View methods
  //

  /// @notice Returns the USD amount of tokens being added to the SHERX pool each block
  /// @return USD amount added to SHERX pool per block
  function getTotalUsdPerBlock() external view returns (uint256);

  /// @notice Returns the internal USD amount of tokens represented by SHERX
  /// @return Last stored value of total internal USD underlying SHERX
  function getTotalUsdPoolStored() external view returns (uint256);

  /// @notice Returns the total USD amount of tokens represented by SHERX
  /// @return Current total internal USD underlying SHERX
  function getTotalUsdPool() external view returns (uint256);

  /// @notice Returns block number at which the total USD underlying SHERX was last stored
  /// @return Block number for stored USD underlying SHERX
  function getTotalUsdLastSettled() external view returns (uint256);

  /// @notice Returns stored USD amount for `_token`
  /// @param _token Token used for protocol premiums
  /// @return Stored USD amount
  function getStoredUsd(IERC20 _token) external view returns (uint256);

  /// @notice Returns SHERX that has not been minted yet
  /// @return Unminted amount of SHERX tokens
  function getTotalSherXUnminted() external view returns (uint256);

  /// @notice Returns total amount of SHERX, including unminted
  /// @return Total amount of SHERX tokens
  function getTotalSherX() external view returns (uint256);

  /// @notice Returns the amount of SHERX created per block
  /// @return SHERX per block
  function getSherXPerBlock() external view returns (uint256);

  /// @notice Returns the total amount of SHERX accrued by the sender
  /// @return Total SHERX balance
  function getSherXBalance() external view returns (uint256);

  /// @notice Returns the amount of SHERX accrued by `_user`
  /// @param _user address to get the SHERX balance of
  /// @return Total SHERX balance
  function getSherXBalance(address _user) external view returns (uint256);

  /// @notice Returns the total supply of SHERX from storage (only used internally)
  /// @return Total supply of SHERX
  function getInternalTotalSupply() external view returns (uint256);

  /// @notice Returns the block number when total SHERX supply was last set in storage
  /// @return block number of last write to storage for the total SHERX supply
  function getInternalTotalSupplySettled() external view returns (uint256);

  /// @notice Returns the tokens and amounts underlying msg.sender's SHERX balance
  /// @return tokens Array of ERC-20 tokens representing the underlying
  /// @return amounts Corresponding amounts of the underlying tokens
  function calcUnderlying()
    external
    view
    returns (IERC20[] memory tokens, uint256[] memory amounts);

  /// @notice Returns the tokens and amounts underlying `_user` SHERX balance
  /// @param _user Account whose underlying SHERX tokens should be queried
  /// @return tokens Array of ERC-20 tokens representing the underlying
  /// @return amounts Corresponding amounts of the underlying tokens
  function calcUnderlying(address _user)
    external
    view
    returns (IERC20[] memory tokens, uint256[] memory amounts);

  /// @notice Returns the tokens and amounts underlying the given amount of SHERX
  /// @param _amount Amount of SHERX tokens to calculate the underlying tokens of
  /// @return tokens Array of ERC-20 tokens representing the underlying
  /// @return amounts Corresponding amounts of the underlying tokens
  function calcUnderlying(uint256 _amount)
    external
    view
    returns (IERC20[] memory tokens, uint256[] memory amounts);

  /// @notice Returns the internal USD amount underlying senders SHERX
  /// @return USD value of SHERX accrued to sender
  function calcUnderlyingInStoredUSD() external view returns (uint256);

  /// @notice Returns the internal USD amount underlying the given amount SHERX
  /// @param _amount Amount of SHERX tokens to find the underlying USD value of
  /// @return usd USD value of the given amount of SHERX
  function calcUnderlyingInStoredUSD(uint256 _amount) external view returns (uint256 usd);

  //
  // State changing methods
  //

  /// @notice Function called by lockTokens before transfer
  /// @param from Address from which lockTokens are being transferred
  /// @param to Address to which lockTokens are being transferred
  /// @param amount Amount of lockTokens to be transferred
  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) external;

  /// @notice Set initial SHERX distribution to Watsons
  function setInitialWeight() external;

  /// @notice Set SHERX distribution
  /// @param _tokens Array of tokens to set the weights of
  /// @param _weights Respective weighting for each token
  /// @param _watsons Weighting to set for the Watsons
  function setWeights(
    IERC20[] memory _tokens,
    uint256[] memory _weights,
    uint256 _watsons
  ) external;

  /// @notice Harvest all tokens on behalf of the sender
  function harvest() external;

  /// @notice Harvest `_token` on behalf of the sender
  /// @param _token Token to harvest accrued SHERX for
  function harvest(ILock _token) external;

  /// @notice Harvest `_tokens` on behalf of the sender
  /// @param _tokens Array of tokens to harvest accrued SHERX for
  function harvest(ILock[] calldata _tokens) external;

  /// @notice Harvest all tokens for `_user`
  /// @param _user Account for which to harvest SHERX
  function harvestFor(address _user) external;

  /// @notice Harvest `_token` for `_user`
  /// @param _user Account for which to harvest SHERX
  /// @param _token Token to harvest
  function harvestFor(address _user, ILock _token) external;

  /// @notice Harvest `_tokens` for `_user`
  /// @param _user Account for which to harvest SHERX
  /// @param _tokens Array of tokens to harvest accrued SHERX for
  function harvestFor(address _user, ILock[] calldata _tokens) external;

  /// @notice Redeems SHERX tokens for the underlying collateral
  /// @param _amount Amount of SHERX tokens to redeem
  /// @param _receiver Address to send redeemed tokens to
  function redeem(uint256 _amount, address _receiver) external;

  /// @notice Accrue SHERX based on internal weights
  function accrueSherX() external;

  /// @notice Accrues SHERX to specific token
  /// @param _token Token to accure SHERX to.
  function accrueSherX(IERC20 _token) external;

  /// @notice Accrues SHERX to the Watsons.
  function accrueSherXWatsons() external;
}
