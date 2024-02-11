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

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sherlock/sherlock-v1-core-68bcb59daa631b9f295ae0e63256a02dc459dcff/contracts/interfaces/IRemove.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.4;

/******************************************************************************\
* Author: Evert Kors <dev@sherlock.xyz> (https://twitter.com/evert0x)
* Sherlock Protocol: https://sherlock.xyz
/******************************************************************************/

interface IRemove {
  /// @notice Swap `_token` amounts
  /// @param _token Token to swap
  /// @param _fmo Amount of first money out pool swapped
  /// @param _sherXUnderlying Amount of underlying being swapped
  /// @return newToken Token being swapped to
  /// @return newFmo Share of `_fmo` in newToken
  /// @return newSherxUnderlying Share of `_sherXUnderlying` in newToken
  function swap(
    IERC20 _token,
    uint256 _fmo,
    uint256 _sherXUnderlying
  )
    external
    returns (
      IERC20 newToken,
      uint256 newFmo,
      uint256 newSherxUnderlying
    );
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sherlock/sherlock-v1-core-68bcb59daa631b9f295ae0e63256a02dc459dcff/contracts/interfaces/IGov.sol

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.4;

/******************************************************************************\
* Author: Evert Kors <dev@sherlock.xyz> (https://twitter.com/evert0x)
* Sherlock Protocol: https://sherlock.xyz
/******************************************************************************/


/// @title Sherlock Main Governance
/// @author Evert Kors
/// @notice This contract is used for managing tokens, protocols and more in Sherlock
/// @dev Contract is meant to be included as a facet in the diamond
/// @dev Storage library is used
interface IGov {
  //
  // Events
  //

  //
  // View methods
  //

  /// @notice Returns the main governance address
  /// @return Main governance address
  function getGovMain() external view returns (address);

  /// @notice Returns the compensation address for the Watsons
  /// @return Watsons address
  function getWatsons() external view returns (address);

  /// @notice Returns the weight for the Watsons compensation
  /// @return Watsons compensation weight
  /// @dev Value is scaled by uint16(-1)
  function getWatsonsSherXWeight() external view returns (uint16);

  /// @notice Returns the last block number the SherX was accrued to the Watsons
  /// @return Block number
  function getWatsonsSherxLastAccrued() external view returns (uint40);

  /// @notice Returns the amount of SherX the Watsons receive per block
  /// @return Number of SherX per block
  function getWatsonsSherXPerBlock() external view returns (uint256);

  /// @notice Returns the total amount of uminted SherX for the Watsons
  /// @return SherX to be minted
  /// @dev Based on current block, last accrued and the SherX per block
  function getWatsonsUnmintedSherX() external view returns (uint256);

  /// @notice Returns the window of opportunity in blocks to unstake funds
  /// @notice Cooldown period has to be expired first to start the unstake window
  /// @return Amount of blocks
  function getUnstakeWindow() external view returns (uint40);

  /// @notice Returns the cooldown period in blocks
  /// @notice After the cooldown period funds can be unstaked
  /// @return Amount of blocks
  function getCooldown() external view returns (uint40);

  /// @notice Returns an array of tokens accounts are allowed to stake in
  /// @return Array of ERC20 tokens
  function getTokensStaker() external view returns (IERC20[] memory);

  /// @notice Returns an array of tokens that are included in the SherX as underlying
  /// @notice Registered protocols use one or more of these tokens to compensate Sherlock
  /// @return Array of ERC20 tokens
  function getTokensSherX() external view returns (IERC20[] memory);

  /// @notice Verify if a protocol is included in Sherlock
  /// @param _protocol Protocol identifier
  /// @return Boolean indicating if protocol is included
  function getProtocolIsCovered(bytes32 _protocol) external view returns (bool);

  /// @notice Returns address responsible on behalf of Sherlock for the protocol
  /// @param _protocol Protocol identifier
  /// @return Address of account
  function getProtocolManager(bytes32 _protocol) external view returns (address);

  /// @notice Returns address responsible on behalf of the protocol
  /// @param _protocol Protocol identifier
  /// @return Address of account
  /// @dev Account is able to withdraw protocol balance
  function getProtocolAgent(bytes32 _protocol) external view returns (address);

  //
  // State changing methods
  //

  /// @notice Set initial main governance address
  /// @param _govMain The address of the main governance
  /// @dev Diamond deployer - GovDev - is able to call this function
  function setInitialGovMain(address _govMain) external;

  /// @notice Transfer the main governance
  /// @param _govMain New address for the main governance
  function transferGovMain(address _govMain) external;

  /// @notice Set the compensation address for the Watsons
  /// @param _watsons Address for Watsons
  function setWatsonsAddress(address _watsons) external;

  /// @notice Set unstake window
  /// @param _unstakeWindow Unstake window in amount of blocks
  function setUnstakeWindow(uint40 _unstakeWindow) external;

  /// @notice Set cooldown period
  /// @param _period Cooldown period in amount of blocks
  function setCooldown(uint40 _period) external;

  /// @notice Add a new protocol to Sherlock
  /// @param _protocol Protocol identifier
  /// @param _eoaProtocolAgent Account to be registered as the agent
  /// @param _eoaManager Account to be registered as the manager
  /// @param _tokens Initial array of tokens the protocol is allowed to pay in
  /// @dev _tokens should first be initialized by calling tokenInit()
  function protocolAdd(
    bytes32 _protocol,
    address _eoaProtocolAgent,
    address _eoaManager,
    IERC20[] memory _tokens
  ) external;

  /// @notice Update protocol agent and/or manager
  /// @param _protocol Protocol identifier
  /// @param _eoaProtocolAgent Account to be registered as the agent
  /// @param _eoaManager Account to be registered as the manager
  function protocolUpdate(
    bytes32 _protocol,
    address _eoaProtocolAgent,
    address _eoaManager
  ) external;

  /// @notice Add tokens the protocol is allowed to pay in
  /// @param _protocol Protocol identifier
  /// @param _tokens Array of tokens to be added as valid protocol payment
  /// @dev _tokens should first be initialized by calling tokenInit()
  function protocolDepositAdd(bytes32 _protocol, IERC20[] memory _tokens) external;

  /// @notice Remove protocol from the Sherlock registry
  /// @param _protocol Protocol identifier
  function protocolRemove(bytes32 _protocol) external;

  /// @notice Initialize a new token
  /// @param _token Address of the token
  /// @param _govPool Account responsible for the token
  /// @param _lock Corresponding lock token, indicating staker token
  /// @param _protocolPremium Boolean indicating if token should be registered as protocol payment
  /// @dev Token can be reinitialiezd
  /// @dev Zero address for _lock will not enable stakers to deposit with the _token
  function tokenInit(
    IERC20 _token,
    address _govPool,
    ILock _lock,
    bool _protocolPremium
  ) external;

  /// @notice Disable a token for stakers
  /// @param _token Address of the token
  /// @param _index Index of the token in storage array
  function tokenDisableStakers(IERC20 _token, uint256 _index) external;

  /// @notice Disable a token for protocols
  /// @param _token Address of the token
  /// @param _index Index of the token in storage array
  /// @dev Removes the token as underlying from SherX
  function tokenDisableProtocol(IERC20 _token, uint256 _index) external;

  /// @notice Unload tokens from Sherlock
  /// @param _token Address of the token
  /// @param _native Contract being used to swap existing token in Sherlock
  /// @param _remaining Account used to send the unallocated SherX and remaining balance for _token
  function tokenUnload(
    IERC20 _token,
    IRemove _native,
    address _remaining
  ) external;

  /// @notice Remove a token from storage
  /// @param _token Address of the token
  function tokenRemove(IERC20 _token) external;
}
