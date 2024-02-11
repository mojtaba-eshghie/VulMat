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

// File: ../sc_datasets/DAppSCAN/Inspex-SpookySwap Integration & Fantom Expansion/bsc-alpaca-contract-4553a34a6dcfcfbf7aebc693bb5c5c6074c73129/contracts/6.12/protocol/apis/mars-ecosystem/ILiquidityMiningMaster.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

interface ILiquidityMiningMaster {
  // Info of each user.
  struct UserInfo {
    uint256 amount; // How many LP tokens the user has provided.
    uint256 rewardDebt; // Reward debt. See explanation below.
    //
    // We do some fancy math here. Basically, any point in time, the amount of XMS
    // entitled to a user but is pending to be distributed is:
    //
    //   pending reward = (user.amount * pool.accXMSPerShare) - user.rewardDebt
    //
    // Whenever a user deposits or withdraws LP tokens to a pool. Here's what happens:
    //   1. The pool's `accXMSPerShare` (and `lastRewardBlock`) gets updated.
    //   2. User receives the pending reward sent to his/her address.
    //   3. User's `amount` gets updated.
    //   4. User's `rewardDebt` gets updated.
  }

  // Info of each pool.
  struct PoolInfo {
    IERC20 lpToken; // Address of LP token contract.
    uint256 allocPoint; // How many allocation points assigned to this pool. XMS to distribute per block.
    uint256 lastRewardBlock; // Last block number that XMS distribution occurs.
    uint256 accXMSPerShare; // Accumulated XMS per share, times 1e12. See below.
  }

  // ----------- Events -----------

  event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
  event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
  event EmergencyWithdraw(address indexed user, uint256 indexed pid, uint256 amount);
  event UpdateEmissionRate(address indexed user, uint256 xmsPerBlock);
  event UpdateEndBlock(address indexed user, uint256 endBlock);
  event UpdateVestingMaster(address indexed user, address vestingMaster);

  // ----------- State changing api -----------

  function massUpdatePools() external;

  function updatePool(uint256 pid) external;

  function deposit(uint256 pid, uint256 amount) external;

  function withdraw(uint256 pid, uint256 amount) external;

  function emergencyWithdraw(uint256 pid) external;

  // ----------- Governor only state changing API -----------

  function addPool(
    uint256 allocPoint,
    IERC20 lpToken,
    bool withUpdate
  ) external;

  function setPool(
    uint256 pid,
    uint256 allocPoint,
    bool withUpdate
  ) external;

  function updateXmsPerBlock(uint256 _xmsPerBlock) external;

  function updateEndBlock(uint256 _endBlock) external;

  function updateVestingMaster(address _vestingMaster) external;

  // ----------- Getters -----------

  function pair2Pid(address pair) external view returns (uint256);

  function pendingXMS(uint256 pid, address user) external view returns (uint256);

  function poolInfo(uint256 pid)
    external
    view
    returns (
      IERC20 lpToken,
      uint256 allocPoint,
      uint256 lastRewardBlock,
      uint256 accXMSPerShare
    );

  function userInfo(uint256 pid, address user) external view returns (uint256 amount, uint256 rewardDebt);

  function poolExistence(IERC20 lp) external view returns (bool);

  function xmsPerBlock() external view returns (uint256);

  function BONUS_MULTIPLIER() external view returns (uint256);

  function totalAllocPoint() external view returns (uint256);

  function startBlock() external view returns (uint256);

  function endBlock() external view returns (uint256);

  function poolLength() external view returns (uint256);

  function getMultiplier(uint256 from, uint256 to) external pure returns (uint256);
}
