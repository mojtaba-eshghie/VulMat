// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IERC20.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

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
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

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
}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IERC20Metadata.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IERC20Mintable.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC20Mintable is IERC20 {
    function mint(address dst, uint256 amount) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IERC20Burnable.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC20Burnable is IERC20 {
    function burn(uint256 amount) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IERC20Permit.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20Permit is IERC20 {
    function getDomainSeparator() external view returns (bytes32);
    function DOMAIN_TYPEHASH() external view returns (bytes32);
    function VERSION_HASH() external view returns (bytes32);
    function PERMIT_TYPEHASH() external view returns (bytes32);
    function nonces(address) external view returns (uint);
    function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;
}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IERC20TransferWithAuth.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20TransferWithAuth is IERC20 {
    function transferWithAuthorization(address from, address to, uint256 value, uint256 validAfter, uint256 validBefore, bytes32 nonce, uint8 v, bytes32 r, bytes32 s) external;
    function receiveWithAuthorization(address from, address to, uint256 value, uint256 validAfter, uint256 validBefore, bytes32 nonce, uint8 v, bytes32 r, bytes32 s) external;
    function TRANSFER_WITH_AUTHORIZATION_TYPEHASH() external view returns (bytes32);
    function RECEIVE_WITH_AUTHORIZATION_TYPEHASH() external view returns (bytes32);
    event AuthorizationUsed(address indexed authorizer, bytes32 indexed nonce);
}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IERC20SafeAllowance.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20SafeAllowance is IERC20 {
    function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IERC20Extended.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;






interface IERC20Extended is 
    IERC20Metadata, 
    IERC20Mintable, 
    IERC20Burnable, 
    IERC20Permit,
    IERC20TransferWithAuth,
    IERC20SafeAllowance 
{}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IEdenToken.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IEdenToken is IERC20Extended {
    function maxSupply() external view returns (uint256);
    function updateTokenMetadata(string memory tokenName, string memory tokenSymbol) external returns (bool);
    function metadataManager() external view returns (address);
    function setMetadataManager(address newMetadataManager) external returns (bool);
    event MetadataManagerChanged(address indexed oldManager, address indexed newManager);
    event TokenMetaUpdated(string indexed name, string indexed symbol);
}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/IVault.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IVault {
    
    struct Lock {
        address token;
        address receiver;
        uint48 startTime;
        uint16 vestingDurationInDays;
        uint16 cliffDurationInDays;
        uint256 amount;
        uint256 amountClaimed;
        uint256 votingPower;
    }

    struct LockBalance {
        uint256 id;
        uint256 claimableAmount;
        Lock lock;
    }

    struct TokenBalance {
        uint256 totalAmount;
        uint256 claimableAmount;
        uint256 claimedAmount;
        uint256 votingPower;
    }

    function lockTokens(address token, address locker, address receiver, uint48 startTime, uint256 amount, uint16 lockDurationInDays, uint16 cliffDurationInDays, bool grantVotingPower) external;
    function lockTokensWithPermit(address token, address locker, address receiver, uint48 startTime, uint256 amount, uint16 lockDurationInDays, uint16 cliffDurationInDays, bool grantVotingPower, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;
    function claimUnlockedTokenAmounts(uint256[] memory lockIds, uint256[] memory amounts) external;
    function claimAllUnlockedTokens(uint256[] memory lockIds) external;
    function tokenLocks(uint256 lockId) external view returns(Lock memory);
    function allActiveLockIds() external view returns(uint256[] memory);
    function allActiveLocks() external view returns(Lock[] memory);
    function allActiveLockBalances() external view returns(LockBalance[] memory);
    function activeLockIds(address receiver) external view returns(uint256[] memory);
    function allLocks(address receiver) external view returns(Lock[] memory);
    function activeLocks(address receiver) external view returns(Lock[] memory);
    function activeLockBalances(address receiver) external view returns(LockBalance[] memory);
    function totalTokenBalance(address token) external view returns(TokenBalance memory balance);
    function tokenBalance(address token, address receiver) external view returns(TokenBalance memory balance);
    function lockBalance(uint256 lockId) external view returns (LockBalance memory);
    function claimableBalance(uint256 lockId) external view returns (uint256);
    function extendLock(uint256 lockId, uint16 vestingDaysToAdd, uint16 cliffDaysToAdd) external;
}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/interfaces/ITokenRegistry.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITokenRegistry {
    function owner() external view returns (address);
    function tokenFormulas(address) external view returns (address);
    function setTokenFormula(address token, address formula) external;
    function removeToken(address token) external;
    function changeOwner(address newOwner) external;
    event ChangedOwner(address indexed oldOwner, address indexed newOwner);
    event TokenAdded(address indexed token, address indexed formula);
    event TokenRemoved(address indexed token);
    event TokenFormulaUpdated(address indexed token, address indexed formula);
}

// File: ../sc_datasets/DAppSCAN/SlowMist-eden-network Smart Contract Security Audit Report/governance-e7b55f6e3f9c0d3ede7fd8bb39ae4fa7a4f4e79e/contracts/lib/VotingPowerStorage.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/// @notice App metadata storage
struct AppStorage {
    // A record of states for signing / validating signatures
    mapping (address => uint) nonces;

    // Eden token
    IEdenToken edenToken;

    // Voting Power owner
    address owner;
    
    // lockManager contract
    address lockManager;

    // Token registry contract
    ITokenRegistry tokenRegistry;
}

/// @notice A checkpoint for marking number of votes from a given block
struct Checkpoint {
    uint32 fromBlock;
    uint256 votes;
}

/// @notice All storage variables related to checkpoints
struct CheckpointStorage {
     // A record of vote checkpoints for each account, by index
    mapping (address => mapping (uint32 => Checkpoint)) checkpoints;

    // The number of checkpoints for each account
    mapping (address => uint32) numCheckpoints;
}

/// @notice The amount of a given token that has been staked, and the resulting voting power
struct Stake {
    uint256 amount;
    uint256 votingPower;
}

/// @notice All storage variables related to staking
struct StakeStorage {
    // Official record of staked balances for each account > token > stake
    mapping (address => mapping (address => Stake)) stakes;
}

library VotingPowerStorage {
    bytes32 constant VOTING_POWER_APP_STORAGE_POSITION = keccak256("voting.power.app.storage");
    bytes32 constant VOTING_POWER_CHECKPOINT_STORAGE_POSITION = keccak256("voting.power.checkpoint.storage");
    bytes32 constant VOTING_POWER_STAKE_STORAGE_POSITION = keccak256("voting.power.stake.storage");
    
    /**
     * @notice Load app storage struct from specified VOTING_POWER_APP_STORAGE_POSITION
     * @return app AppStorage struct
     */
    function appStorage() internal pure returns (AppStorage storage app) {        
        bytes32 position = VOTING_POWER_APP_STORAGE_POSITION;
        assembly {
            app.slot := position
        }
    }

    /**
     * @notice Load checkpoint storage struct from specified VOTING_POWER_CHECKPOINT_STORAGE_POSITION
     * @return cs CheckpointStorage struct
     */
    function checkpointStorage() internal pure returns (CheckpointStorage storage cs) {        
        bytes32 position = VOTING_POWER_CHECKPOINT_STORAGE_POSITION;
        assembly {
            cs.slot := position
        }
    }

    /**
     * @notice Load stake storage struct from specified VOTING_POWER_STAKE_STORAGE_POSITION
     * @return ss StakeStorage struct
     */
    function stakeStorage() internal pure returns (StakeStorage storage ss) {        
        bytes32 position = VOTING_POWER_STAKE_STORAGE_POSITION;
        assembly {
            ss.slot := position
        }
    }
}
