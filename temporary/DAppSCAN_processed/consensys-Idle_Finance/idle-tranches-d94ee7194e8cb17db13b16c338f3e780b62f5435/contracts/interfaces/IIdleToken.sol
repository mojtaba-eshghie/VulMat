// File: @openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20Upgradeable {
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

// File: ../sc_datasets/DAppSCAN/consensys-Idle_Finance/idle-tranches-d94ee7194e8cb17db13b16c338f3e780b62f5435/contracts/interfaces/IERC20Detailed.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.4;

interface IERC20Detailed is IERC20Upgradeable {
  function name() external view returns(string memory);
  function decimals() external view returns(uint256);
}

// File: ../sc_datasets/DAppSCAN/consensys-Idle_Finance/idle-tranches-d94ee7194e8cb17db13b16c338f3e780b62f5435/contracts/interfaces/IIdleToken.sol

// SPDX-License-Identifier: Apache-2.0
/**
 * @title: Idle Token interface
 * @author: Idle Labs Inc., idle.finance
 */
pragma solidity 0.8.4;

interface IIdleToken is IERC20Detailed {
  function tokenPrice() external view returns (uint256 price);
  function tokenDecimals() external view returns (uint256);
  function token() external view returns (address);
  function getAPRs() external view returns (address[] memory addresses, uint256[] memory aprs);
  function mintIdleToken(uint256 _amount, bool _skipRebalance, address _referral) external returns (uint256 mintedTokens);
  function redeemIdleToken(uint256 _amount) external returns (uint256 redeemedTokens);
  function redeemInterestBearingTokens(uint256 _amount) external;
  function rebalance() external returns (bool);
  function getAvgAPR() external view returns (uint256);
  function govTokens(uint256 index) external view returns (address);
  function getGovTokensAmounts(address _usr) external view returns (uint256[] memory _amounts);
  function getAllocations() external view returns (uint256[] memory);
  function getGovTokens() external view returns (address[] memory);
  function getAllAvailableTokens() external view returns (address[] memory);
  function getProtocolTokenToGov(address _protocolToken) external view returns (address);
  function oracle() external view returns (address);
  function owner() external view returns (address);
  function rebalancer() external view returns (address);
  function protocolWrappers(address) external view returns (address);
  function tokenPriceWithFee(address user) external view returns (uint256 priceWFee);
  function fee() external view returns (uint256);
}
