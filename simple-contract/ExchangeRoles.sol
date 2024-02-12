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

// File: ../sc_datasets/DAppSCAN/PeckShield-TranchessV1.1/contract-core-68a86350313c1cb9e5467e791d3e9efaf228a0df/contracts/interfaces/IVotingEscrow.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;
pragma experimental ABIEncoderV2;

interface IVotingEscrow {
    struct LockedBalance {
        uint256 amount;
        uint256 unlockTime;
    }

    function token() external view returns (address);

    function maxTime() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function balanceOfAtTimestamp(address account, uint256 timestamp)
        external
        view
        returns (uint256);

    function getTimestampDropBelow(address account, uint256 threshold)
        external
        view
        returns (uint256);

    function getLockedBalance(address account) external view returns (LockedBalance memory);
}

// File: ../sc_datasets/DAppSCAN/PeckShield-TranchessV1.1/contract-core-68a86350313c1cb9e5467e791d3e9efaf228a0df/contracts/exchange/ExchangeRoles.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

/// @title Tranchess's Exchange Role Contract
/// @notice Exchange role management
/// @author Tranchess
abstract contract ExchangeRoles {
    event MakerApplied(address indexed account, uint256 expiration);

    /// @notice Voting Escrow.
    IVotingEscrow public immutable votingEscrow;

    /// @notice Minimum vote-locked governance token balance required to place maker orders.
    uint256 public immutable makerRequirement;

    /// @dev Mapping of account => maker expiration timestamp
    mapping(address => uint256) internal _makerExpiration;

    constructor(address votingEscrow_, uint256 makerRequirement_) public {
        votingEscrow = IVotingEscrow(votingEscrow_);
        makerRequirement = makerRequirement_;
    }

    // ------------------------------ MAKER ------------------------------------
    /// @notice Functions with this modifer can only be invoked by makers
    modifier onlyMaker() {
        require(isMaker(msg.sender), "Only maker");
        _;
    }

    /// @notice Returns maker expiration timestamp of an account.
    ///         When `makerRequirement` is zero, this function always returns
    ///         an extremely large timestamp (2500-01-01 00:00:00 UTC).
    function makerExpiration(address account) external view returns (uint256) {
        return makerRequirement > 0 ? _makerExpiration[account] : 16725225600;
    }

    /// @notice Verify if the account is an active maker or not
    /// @param account Account address to verify
    /// @return True if the account is an active maker; else returns false
    function isMaker(address account) public view returns (bool) {
        return makerRequirement == 0 || _makerExpiration[account] > block.timestamp;
    }

    /// @notice Apply for maker membership
    function applyForMaker() external {
        require(makerRequirement > 0, "No need to apply for maker");
        // The membership will be valid until the current vote-locked governance
        // token balance drop below the requirement.
        uint256 expiration = votingEscrow.getTimestampDropBelow(msg.sender, makerRequirement);
        _makerExpiration[msg.sender] = expiration;
        emit MakerApplied(msg.sender, expiration);
    }
}
