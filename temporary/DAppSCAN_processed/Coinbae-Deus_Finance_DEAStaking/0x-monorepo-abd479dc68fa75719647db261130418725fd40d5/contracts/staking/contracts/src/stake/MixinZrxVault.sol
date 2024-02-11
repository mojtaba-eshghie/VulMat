// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/interfaces/IZrxVault.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;


/// @dev This vault manages Zrx Tokens.
/// When a user mints stake, their Zrx Tokens are deposited into this vault.
/// Similarly, when they burn stake, their Zrx Tokens are withdrawn from this vault.
/// There is a "Catastrophic Failure Mode" that, when invoked, only
/// allows withdrawals to be made. Once this vault is in catastrophic
/// failure mode, it cannot be returned to normal mode; this prevents
/// corruption of related state in the staking contract.
interface IZrxVault {

    /// @dev Emitted when Zrx Tokens are deposited into the vault.
    /// @param sender Address of sender (`msg.sender`).
    /// @param owner of Zrx Tokens.
    /// @param amount of Zrx Tokens deposited.
    event ZrxDepositedIntoVault(
        address indexed sender,
        address indexed owner,
        uint256 amount
    );

    /// @dev Emitted when Zrx Tokens are withdrawn from the vault.
    /// @param sender Address of sender (`msg.sender`).
    /// @param owner of Zrx Tokens.
    /// @param amount of Zrx Tokens withdrawn.
    event ZrxWithdrawnFromVault(
        address indexed sender,
        address indexed owner,
        uint256 amount
    );

    /// @dev Emitted when the ERC20 Proxy is changed.
    /// @param erc20ProxyAddress Address of the new ERC20 proxy.
    event Erc20ProxyChanged(
        address erc20ProxyAddress
    );

    /// @dev Sets the ERC20 proxy.
    /// Note that only the contract owner can call this.
    /// Note that this can only be called when *not* in Catastrophic Failure mode.
    /// @param erc20ProxyAddress Address of the 0x ERC20 Proxy.
    function setErc20Proxy(address erc20ProxyAddress)
        external;

    /// @dev Deposit an `amount` of Zrx Tokens from `owner` into the vault.
    /// Note that only the Staking contract can call this.
    /// Note that this can only be called when *not* in Catastrophic Failure mode.
    /// @param owner of Zrx Tokens.
    /// @param amount of Zrx Tokens to deposit.
    function depositFrom(address owner, uint256 amount)
        external;

    /// @dev Withdraw an `amount` of Zrx Tokens to `owner` from the vault.
    /// Note that only the Staking contract can call this.
    /// Note that this can only be called when *not* in Catastrophic Failure mode.
    /// @param owner of Zrx Tokens.
    /// @param amount of Zrx Tokens to withdraw.
    function withdrawFrom(address owner, uint256 amount)
        external;

    /// @dev Withdraw ALL Zrx Tokens to `owner` from the vault.
    /// Note that this can only be called when *in* Catastrophic Failure mode.
    /// @param owner of Zrx Tokens.
    function withdrawAllFrom(address owner)
        external
        returns (uint256);

    /// @dev Returns the balance in Zrx Tokens of the `owner`
    /// @return Balance in Zrx.
    function balanceOf(address owner)
        external
        view
        returns (uint256);
}

// File: @0x/contracts-utils/contracts/src/interfaces/IOwnable.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;

contract IOwnable {
    /// @dev Emitted by Ownable when ownership is transferred.
    /// @param previousOwner The previous owner of the contract.
    /// @param newOwner The new owner of the contract.
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /// @dev Transfers ownership of the contract to a new address.
    /// @param newOwner The address that will become the owner.
    function transferOwnership(address newOwner) public;
}

// File: @0x/contracts-utils/contracts/src/LibOwnableRichErrors.sol

pragma solidity ^0.5.9;

library LibOwnableRichErrors {
    // bytes4(keccak256("OnlyOwnerError(address,address)"))
    bytes4 internal constant ONLY_OWNER_ERROR_SELECTOR = 0x1de45ad1;

    // bytes4(keccak256("TransferOwnerToZeroError()"))
    bytes internal constant TRANSFER_OWNER_TO_ZERO_ERROR_BYTES = hex"e69edc3e";

    function OnlyOwnerError(address sender, address owner) internal pure returns (bytes memory) {
        return abi.encodeWithSelector(ONLY_OWNER_ERROR_SELECTOR, sender, owner);
    }

    function TransferOwnerToZeroError() internal pure returns (bytes memory) {
        return TRANSFER_OWNER_TO_ZERO_ERROR_BYTES;
    }
}

// File: @0x/contracts-utils/contracts/src/LibRichErrors.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;

library LibRichErrors {
    // bytes4(keccak256("Error(string)"))
    bytes4 internal constant STANDARD_ERROR_SELECTOR = 0x08c379a0;

    /// @dev ABI encode a standard, string revert error payload.
    ///      This is the same payload that would be included by a `revert(string)`
    ///      solidity statement. It has the function signature `Error(string)`.
    /// @param message The error string.
    /// @return The ABI encoded error.
    function StandardError(string memory message) internal pure returns (bytes memory) {
        return abi.encodeWithSelector(STANDARD_ERROR_SELECTOR, bytes(message));
    }

    /// @dev Reverts an encoded rich revert reason `errorData`.
    /// @param errorData ABI encoded error data.
    function rrevert(bytes memory errorData) internal pure {
        assembly {
            revert(add(errorData, 0x20), mload(errorData))
        }
    }
}

// File: @0x/contracts-utils/contracts/src/Ownable.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;



contract Ownable is IOwnable {
    /// @dev The owner of this contract.
    /// @return 0 The owner address.
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        _assertSenderIsOwner();
        _;
    }

    /// @dev Change the owner of this contract.
    /// @param newOwner New owner address.
    function transferOwnership(address newOwner) public onlyOwner {
        if (newOwner == address(0)) {
            LibRichErrors.rrevert(LibOwnableRichErrors.TransferOwnerToZeroError());
        } else {
            owner = newOwner;
            emit OwnershipTransferred(msg.sender, newOwner);
        }
    }

    function _assertSenderIsOwner() internal view {
        if (msg.sender != owner) {
            LibRichErrors.rrevert(LibOwnableRichErrors.OnlyOwnerError(msg.sender, owner));
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/immutable/MixinDeploymentConstants.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;


contract MixinDeploymentConstants {

    // @TODO SET THESE VALUES FOR DEPLOYMENT

    uint256 constant internal EPOCH_DURATION_IN_SECONDS = 1000;

    uint256 constant internal TIMELOCK_DURATION_IN_EPOCHS = 3;

    // How much delegated stake is weighted vs operator stake, in ppm.
    uint32 constant internal REWARD_DELEGATED_STAKE_WEIGHT = 900000; // 90%

    uint256 constant internal CHAIN_ID = 1;

    uint256 constant internal MAX_MAKERS_IN_POOL = 10;
}

// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/immutable/MixinConstants.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;

contract MixinConstants is
    MixinDeploymentConstants
{
    uint32 constant internal PPM_DENOMINATOR = 1000000;

    // The upper 16 bytes represent the pool id, so this would be pool id 1. See MixinStakinPool for more information.
    bytes32 constant internal INITIAL_POOL_ID = 0x0000000000000000000000000000000100000000000000000000000000000000;

    // The upper 16 bytes represent the pool id, so this would be an increment of 1. See MixinStakinPool for more information.
    uint256 constant internal POOL_ID_INCREMENT_AMOUNT = 0x0000000000000000000000000000000100000000000000000000000000000000;

    bytes32 constant internal NIL_POOL_ID = 0x0000000000000000000000000000000000000000000000000000000000000000;

    address constant internal NIL_ADDRESS = 0x0000000000000000000000000000000000000000;

    bytes32 constant internal UNKNOWN_STAKING_POOL_ID = 0x0000000000000000000000000000000000000000000000000000000000000000;

    uint64 constant internal INITIAL_EPOCH = 0;

    uint64 constant internal INITIAL_TIMELOCK_PERIOD = INITIAL_EPOCH;

    uint256 constant internal MIN_TOKEN_VALUE = 10**18;
}

// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/interfaces/IEthVault.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;


/// @dev This vault manages Ether.
interface IEthVault {

    /// @dev Emitted when Ether are deposited into the vault.
    /// @param sender Address of sender (`msg.sender`).
    /// @param owner of Ether.
    /// @param amount of Ether deposited.
    event EthDepositedIntoVault(
        address indexed sender,
        address indexed owner,
        uint256 amount
    );

    /// @dev Emitted when Ether are withdrawn from the vault.
    /// @param sender Address of sender (`msg.sender`).
    /// @param owner of Ether.
    /// @param amount of Ether withdrawn.
    event EthWithdrawnFromVault(
        address indexed sender,
        address indexed owner,
        uint256 amount
    );

    /// @dev Deposit an `amount` of ETH from `owner` into the vault.
    /// Note that only the Staking contract can call this.
    /// Note that this can only be called when *not* in Catostrophic Failure mode.
    /// @param owner of ETH Tokens.
    function depositFor(address owner)
        external
        payable;

    /// @dev Withdraw an `amount` of ETH to `msg.sender` from the vault.
    /// Note that only the Staking contract can call this.
    /// Note that this can only be called when *not* in Catostrophic Failure mode.
    /// @param amount of ETH to withdraw.
    function withdraw(uint256 amount)
        external;

    /// @dev Withdraw ALL ETH to `msg.sender` from the vault.
    function withdrawAll()
        external
        returns (uint256);

    /// @dev Returns the balance in ETH of the `owner`
    /// @return Balance in ETH.
    function balanceOf(address owner)
        external
        view
        returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/interfaces/IStakingPoolRewardVault.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;


/// @dev This vault manages staking pool rewards.
/// Rewards can be deposited and withdraw by the staking contract.
/// There is a "Catastrophic Failure Mode" that, when invoked, only
/// allows withdrawals to be made. Once this vault is in catastrophic
/// failure mode, it cannot be returned to normal mode; this prevents
/// corruption of related state in the staking contract.
interface IStakingPoolRewardVault {

    /// @dev Holds the balance for a staking pool.
    /// @param initialzed True iff the balance struct is initialized.
    /// @param operatorShare Fraction of the total balance owned by the operator, in ppm.
    /// @param operatorBalance Balance in ETH of the operator.
    /// @param membersBalance Balance in ETH co-owned by the pool members.
    struct Balance {
        bool initialized;
        uint32 operatorShare;
        uint96 operatorBalance;
        uint96 membersBalance;
    }

    /// @dev Emitted when the eth vault is changed
    /// @param newEthVault address of new rth vault.
    event EthVaultChanged(
        address newEthVault
    );

    /// @dev Emitted when reward is deposited.
    /// @param poolId The pool the reward was deposited for.
    ///               Note that a poolId of "0" means "unknown" at time of deposit.
    ///               In this case, the reward would be deposited later in the transaction.
    ///               This is an optimization for the staking contract, which may make many deposits
    ///               in the same transaction.
    /// @param amount The amount in ETH deposited.
    event RewardDeposited(
        bytes32 poolId,
        uint256 amount
    );

    /// @dev Emitted when a reward is withdrawn for an operator.
    /// @param amount The amount in ETH withdrawn.
    /// @param poolId The pool the reward was deposited for.
    event RewardWithdrawnForOperator(
        bytes32 poolId,
        uint256 amount
    );

    /// @dev Emitted when a reward is withdrawn for a pool member.
    /// @param amount The amount in ETH withdrawn.
    /// @param poolId The pool the reward was deposited for.
    event RewardWithdrawnForMember(
        bytes32 poolId,
        uint256 amount
    );

    /// @dev Emitted when a staking pool is registered.
    /// @param poolId Unique Id of pool that was registered.
    /// @param operatorShare Share of rewards owned by operator. in ppm.
    event StakingPoolRegistered(
        bytes32 poolId,
        uint32 operatorShare
    );

    /// @dev Fallback function.
    /// Note that this is only callable by the staking contract, and when
    /// not in catastrophic failure mode.
    function ()
        external
        payable;

    function setEthVault(address ethVaultAddress)
        external;

     /// @dev Record a deposit for a pool. This deposit should be in the same transaction,
    /// which is enforced by the staking contract. We do not enforce it here to save (a lot of) gas.
    /// Note that this is only callable by the staking contract, and when
    /// not in catastrophic failure mode.
    /// @param poolId Unique Id of pool.
    /// @param amount Amount in ETH to record.
    /// @param operatorOnly Only attribute amount to operator.
    /// @return operatorPortion Portion of amount attributed to the operator.
    /// @return operatorPortion Portion of amount attributed to the delegators.
    function recordDepositFor(
        bytes32 poolId,
        uint256 amount,
        bool operatorOnly
    )
        external
        returns (
            uint256 operatorPortion,
            uint256 delegatorsPortion
        );

    /// @dev Withdraw some amount in ETH of an operator's reward.
    /// Note that this is only callable by the staking contract, and when
    /// not in catastrophic failure mode.
    /// @param poolId Unique Id of pool.
    function transferOperatorBalanceToEthVault(
        bytes32 poolId,
        address operator,
        uint256 amount
    )
        external;

    /// @dev Withdraw some amount in ETH of a pool member.
    /// Note that this is only callable by the staking contract, and when
    /// not in catastrophic failure mode.
    /// @param poolId Unique Id of pool.
    /// @param amount Amount in ETH to transfer.
    function transferMemberBalanceToEthVault(
        bytes32 poolId,
        address member,
        uint256 amount
    )
        external;

    /// @dev Register a new staking pool.
    /// Note that this is only callable by the staking contract, and when
    /// not in catastrophic failure mode.
    /// @param poolId Unique Id of pool.
    /// @param poolOperatorShare Share of rewards given to the pool operator, in ppm.
    function registerStakingPool(bytes32 poolId, uint32 poolOperatorShare)
        external;

    /// @dev Returns the total balance of a pool.
    /// @param poolId Unique Id of pool.
    /// @return Balance in ETH.
    function balanceOf(bytes32 poolId)
        external
        view
        returns (uint256);

    /// @dev Returns the balance of a pool operator.
    /// @param poolId Unique Id of pool.
    /// @return Balance in ETH.
    function balanceOfOperator(bytes32 poolId)
        external
        view
        returns (uint256);

    /// @dev Returns the balance co-owned by members of a pool.
    /// @param poolId Unique Id of pool.
    /// @return Balance in ETH.
    function balanceOfMembers(bytes32 poolId)
        external
        view
        returns (uint256);

    /// @dev Returns the operator share of a pool's balance.
    /// @param poolId Unique Id of pool.
    /// @return Operator share (integer out of 100)
    function getOperatorShare(bytes32 poolId)
        external
        view
        returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/interfaces/IStructs.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;


interface IStructs {

    /// @dev Allowed signature types.
    enum SignatureType {
        Illegal,            // 0x00, default value
        Invalid,            // 0x01
        EIP712,             // 0x02
        EthSign,            // 0x03
        Wallet,             // 0x04
        NSignatureTypes     // 0x05, number of signature types. Always leave at end.
    }

    /// @dev Status for Staking Pools (see MixinStakingPool).
    /// @param operatorAddress Address of pool operator.
    /// @param operatorShare Portion of pool rewards owned by operator, in ppm.
    struct Pool {
        address payable operatorAddress;
        uint32 operatorShare;
    }

    /// @dev Status for a pool that actively traded during the current epoch.
    /// (see MixinExchangeFees).
    /// @param poolId Unique Id of staking pool.
    /// @param feesCollected Fees collected in ETH by this pool in the current epoch.
    /// @param weightedStake Amount of weighted stake currently held by the pool.
    struct ActivePool {
        bytes32 poolId;
        uint256 feesCollected;
        uint256 weightedStake;
        uint256 delegatedStake;
    }

    /// @dev Encapsulates a balance for the current and next epochs.
    /// Note that these balances may be stale if the current epoch
    /// is greater than `currentEpoch`.
    /// Always load this struct using _loadAndSyncBalance or _loadUnsyncedBalance.
    /// @param currentEpoch the current epoch
    /// @param currentEpochBalance balance in the current epoch.
    /// @param nextEpochBalance balance in the next epoch.
    struct StoredBalance {
        uint64 currentEpoch;
        uint96 currentEpochBalance;
        uint96 nextEpochBalance;
    }

    /// @dev Balance struct for stake.
    /// @param currentEpochBalance Balance in the current epoch.
    /// @param nextEpochBalance Balance in the next epoch.
    struct StakeBalance {
        uint256 currentEpochBalance;
        uint256 nextEpochBalance;
    }

    /// @dev Statuses that stake can exist in.
    enum StakeStatus {
        ACTIVE,
        INACTIVE,
        DELEGATED
    }

    /// @dev Info used to describe a status.
    /// @param status of the stake.
    /// @param poolId Unique Id of pool. This is set when status=DELEGATED.
    struct StakeInfo {
        StakeStatus status;
        bytes32 poolId;
    }

    /// @dev Struct to represent a fraction.
    /// @param numerator of fraction.
    /// @param denominator of fraction.
    struct Fraction {
        uint256 numerator;
        uint256 denominator;
    }

    /// @dev State for keeping track of which pool a maker has joined, and if the operator has
    /// added them (see MixinStakingPool).
    /// @param poolId Unique Id of staking pool.
    /// @param confirmed Whether the operator has added the maker to the pool.
    struct MakerPoolJoinStatus {
        bytes32 poolId;
        bool confirmed;
    }
}

// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/immutable/MixinStorage.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;






// solhint-disable max-states-count, no-empty-blocks
contract MixinStorage is
    MixinDeploymentConstants,
    Ownable,
    MixinConstants
{
    constructor()
        public
        Ownable()
    {}

    // address of staking contract
    address internal stakingContract;

    // address of read-only proxy
    address internal readOnlyProxy;

    // address for read-only proxy to call
    address internal readOnlyProxyCallee;

    // mapping from Owner to Amount of Active Stake
    // (access using _loadAndSyncBalance or _loadUnsyncedBalance)
    mapping (address => IStructs.StoredBalance) internal activeStakeByOwner;

    // mapping from Owner to Amount of Inactive Stake
    // (access using _loadAndSyncBalance or _loadUnsyncedBalance)
    mapping (address => IStructs.StoredBalance) internal inactiveStakeByOwner;

    // mapping from Owner to Amount Delegated
    // (access using _loadAndSyncBalance or _loadUnsyncedBalance)
    mapping (address => IStructs.StoredBalance) internal delegatedStakeByOwner;

    // mapping from Owner to Pool Id to Amount Delegated
    // (access using _loadAndSyncBalance or _loadUnsyncedBalance)
    mapping (address => mapping (bytes32 => IStructs.StoredBalance)) internal delegatedStakeToPoolByOwner;

    // mapping from Pool Id to Amount Delegated
    // (access using _loadAndSyncBalance or _loadUnsyncedBalance)
    mapping (bytes32 => IStructs.StoredBalance) internal delegatedStakeByPoolId;

    // mapping from Owner to Amount of Withdrawable Stake
    mapping (address => uint256) internal withdrawableStakeByOwner;

    // tracking Pool Id
    bytes32 internal nextPoolId = INITIAL_POOL_ID;

    // mapping from Pool Id to Pool
    mapping (bytes32 => IStructs.Pool) internal poolById;

    // mapping from Maker Address to a struct representing the pool the maker has joined and
    // whether the operator of that pool has subsequently added the maker.
    mapping (address => IStructs.MakerPoolJoinStatus) internal poolJoinedByMakerAddress;

    // mapping from Pool Id to number of makers assigned to that pool
    mapping (bytes32 => uint256) internal numMakersByPoolId;

    // current epoch
    uint256 internal currentEpoch = INITIAL_EPOCH;

    // current epoch start time
    uint256 internal currentEpochStartTimeInSeconds;

    // fees collected this epoch
    mapping (bytes32 => uint256) internal protocolFeesThisEpochByPool;

    // pools that were active in the current epoch
    bytes32[] internal activePoolsThisEpoch;

    // mapping from Pool Id to Epoch to Reward Ratio
    mapping (bytes32 => mapping (uint256 => IStructs.Fraction)) internal cumulativeRewardsByPool;

    // mapping from Pool Id to Epoch
    mapping (bytes32 => uint256) internal cumulativeRewardsByPoolLastStored;

    // registered 0x Exchange contracts
    mapping (address => bool) internal validExchanges;

    // ZRX vault (stores staked ZRX)
    IZrxVault internal zrxVault;

    // ETH Vault (stores eth balances of stakers and pool operators)
    IEthVault internal ethVault;

    // Rebate Vault (stores rewards for pools before they are moved to the eth vault on a per-user basis)
    IStakingPoolRewardVault internal rewardVault;

    // Numerator for cobb douglas alpha factor.
    uint256 internal cobbDouglasAlphaNumerator = 1;

    // Denominator for cobb douglas alpha factor.
    uint256 internal cobbDouglasAlphaDenomintor = 6;
}

// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/stake/MixinZrxVault.sol

/*

  Copyright 2019 ZeroEx Intl.

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

pragma solidity ^0.5.9;


/// @dev This mixin contains logic for managing and interfacing with the Zrx Vault.
/// (see vaults/ZrxVault.sol).
contract MixinZrxVault is
    MixinConstants,
    MixinStorage
{
    /// @dev Set the Zrx Vault.
    /// @param zrxVaultAddress Address of the Zrx Vault.
    function setZrxVault(address zrxVaultAddress)
        external
        onlyOwner
    {
        zrxVault = IZrxVault(zrxVaultAddress);
    }

    /// @dev Return the current Zrx Vault
    /// @return Zrx Vault
    function getZrxVault()
        public
        view
        returns (address)
    {
        return address(zrxVault);
    }

    /// @dev Deposits Zrx Tokens from the `owner` into the vault.
    /// @param owner of Zrx Tokens
    /// @param amount of tokens to deposit.
    function _depositFromOwnerIntoZrxVault(address owner, uint256 amount)
        internal
    {
        IZrxVault _zrxVault = zrxVault;
        require(
            address(_zrxVault) != address(0),
            "INVALID_ZRX_VAULT"
        );
        _zrxVault.depositFrom(owner, amount);
    }

    /// @dev Withdraws Zrx Tokens from to `owner` from the vault.
    /// @param owner of deposited Zrx Tokens
    /// @param amount of tokens to withdraw.
    function _withdrawToOwnerFromZrxVault(address owner, uint256 amount)
        internal
    {
        IZrxVault _zrxVault = zrxVault;
        require(
            address(_zrxVault) != address(0),
            "INVALID_ZRX_VAULT"
        );
        _zrxVault.withdrawFrom(owner, amount);
    }

    /// @dev Returns balance of `owner` in the ZRX ault.
    /// @param owner of deposited Zrx Tokens.
    function _balanceOfOwnerInZrxVault(address owner)
        internal
        view
        returns (uint256)
    {
        IZrxVault _zrxVault = zrxVault;
        require(
            address(_zrxVault) != address(0),
            "INVALID_ZRX_VAULT"
        );
        return _zrxVault.balanceOf(owner);
    }
}
