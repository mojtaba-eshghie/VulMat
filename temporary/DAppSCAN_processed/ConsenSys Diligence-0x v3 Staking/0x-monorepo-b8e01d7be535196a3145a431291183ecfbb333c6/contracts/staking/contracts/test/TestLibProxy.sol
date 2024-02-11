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

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-0x v3 Staking/0x-monorepo-b8e01d7be535196a3145a431291183ecfbb333c6/contracts/staking/contracts/src/interfaces/IStructs.sol

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

    /// @dev Status for a pool that actively traded during the current epoch.
    /// (see MixinExchangeFees).
    /// @param feesCollected Fees collected in ETH by this pool.
    /// @param weightedStake Amount of weighted stake in the pool.
    /// @param membersStake Amount of non-operator stake in the pool.
    struct ActivePool {
        uint256 feesCollected;
        uint256 weightedStake;
        uint256 membersStake;
    }

    /// @dev Holds state for unfinalized epoch rewards.
    /// @param rewardsAvailable Rewards (ETH) available to the epoch
    ///        being finalized (the previous epoch). This is simply the balance
    ///        of the contract at the end of the epoch.
    /// @param poolsRemaining The number of active pools in the last
    ///        epoch that have yet to be finalized through `finalizePools()`.
    /// @param totalFeesCollected The total fees collected for the epoch being finalized.
    /// @param totalWeightedStake The total fees collected for the epoch being finalized.
    /// @param totalRewardsFinalized Amount of rewards that have been paid during finalization.
    struct UnfinalizedState {
        uint256 rewardsAvailable;
        uint256 poolsRemaining;
        uint256 totalFeesCollected;
        uint256 totalWeightedStake;
        uint256 totalRewardsFinalized;
    }

    /// @dev Encapsulates a balance for the current and next epochs.
    /// Note that these balances may be stale if the current epoch
    /// is greater than `currentEpoch`.
    /// Always load this struct using _loadSyncedBalance or _loadUnsyncedBalance.
    /// @param isInitialized
    /// @param currentEpoch the current epoch
    /// @param currentEpochBalance balance in the current epoch.
    /// @param nextEpochBalance balance in `currentEpoch+1`.
    struct StoredBalance {
        bool isInitialized;
        uint32 currentEpoch;
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

    /// @dev Holds the metadata for a staking pool.
    /// @param initialized True iff the balance struct is initialized.
    /// @param operator of the pool.
    /// @param operatorShare Fraction of the total balance owned by the operator, in ppm.
    /// @param numberOfMakers Number of makers in the pool.
    struct Pool {
        bool initialized;
        address payable operator;
        uint32 operatorShare;
        uint32 numberOfMakers;
    }
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-0x v3 Staking/0x-monorepo-b8e01d7be535196a3145a431291183ecfbb333c6/contracts/staking/contracts/src/libs/LibStakingRichErrors.sol

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


library LibStakingRichErrors {

    enum OperatorShareErrorCodes {
        OperatorShareTooLarge,
        CanOnlyDecreaseOperatorShare
    }

    enum ProtocolFeePaymentErrorCodes {
        ZeroProtocolFeePaid,
        MismatchedFeeAndPayment
    }

    enum InitializationErrorCodes {
        MixinSchedulerAlreadyInitialized,
        MixinParamsAlreadyInitialized
    }

    enum InvalidParamValueErrorCodes {
        InvalidCobbDouglasAlpha,
        InvalidRewardDelegatedStakeWeight,
        InvalidMaximumMakersInPool,
        InvalidMinimumPoolStake,
        InvalidEpochDuration
    }

    enum MakerPoolAssignmentErrorCodes {
        MakerAddressAlreadyRegistered,
        MakerAddressNotRegistered,
        MakerAddressNotPendingAdd,
        PoolIsFull
    }

    enum ExchangeManagerErrorCodes {
        ExchangeAlreadyRegistered,
        ExchangeNotRegistered
    }

    // bytes4(keccak256("OnlyCallableByExchangeError(address)"))
    bytes4 internal constant ONLY_CALLABLE_BY_EXCHANGE_ERROR_SELECTOR =
        0xb56d2df0;

    // bytes4(keccak256("ExchangeManagerError(uint8,address)"))
    bytes4 internal constant EXCHANGE_MANAGER_ERROR_SELECTOR =
        0xb9588e43;

    // bytes4(keccak256("InsufficientBalanceError(uint256,uint256)"))
    bytes4 internal constant INSUFFICIENT_BALANCE_ERROR_SELECTOR =
        0x84c8b7c9;

    // bytes4(keccak256("OnlyCallableByPoolOperatorOrMakerError(address,bytes32)"))
    bytes4 internal constant ONLY_CALLABLE_BY_POOL_OPERATOR_OR_MAKER_ERROR_SELECTOR =
        0x7677eb13;

    // bytes4(keccak256("MakerPoolAssignmentError(uint8,address,bytes32)"))
    bytes4 internal constant MAKER_POOL_ASSIGNMENT_ERROR_SELECTOR =
        0x69945e3f;

    // bytes4(keccak256("BlockTimestampTooLowError(uint256,uint256)"))
    bytes4 internal constant BLOCK_TIMESTAMP_TOO_LOW_ERROR_SELECTOR =
        0xa6bcde47;

    // bytes4(keccak256("OnlyCallableByStakingContractError(address)"))
    bytes4 internal constant ONLY_CALLABLE_BY_STAKING_CONTRACT_ERROR_SELECTOR =
        0xca1d07a2;

    // bytes4(keccak256("OnlyCallableIfInCatastrophicFailureError()"))
    bytes internal constant ONLY_CALLABLE_IF_IN_CATASTROPHIC_FAILURE_ERROR =
        hex"3ef081cc";

    // bytes4(keccak256("OnlyCallableIfNotInCatastrophicFailureError()"))
    bytes internal constant ONLY_CALLABLE_IF_NOT_IN_CATASTROPHIC_FAILURE_ERROR =
        hex"7dd020ce";

    // bytes4(keccak256("OperatorShareError(uint8,bytes32,uint32)"))
    bytes4 internal constant OPERATOR_SHARE_ERROR_SELECTOR =
        0x22df9597;

    // bytes4(keccak256("PoolExistenceError(bytes32,bool)"))
    bytes4 internal constant POOL_EXISTENCE_ERROR_SELECTOR =
        0x9ae94f01;

    // bytes4(keccak256("InvalidStakeStatusError(uint8)"))
    bytes4 internal constant INVALID_STAKE_STATUS_ERROR_SELECTOR =
        0x7cf20260;

    // bytes4(keccak256("ProxyDestinationCannotBeNilError()"))
    bytes internal constant PROXY_DESTINATION_CANNOT_BE_NIL_ERROR =
        hex"6eff8285";

    // bytes4(keccak256("InitializationError(uint8)"))
    bytes4 internal constant INITIALIZATION_ERROR_SELECTOR =
        0x0b02d773;

    // bytes4(keccak256("InvalidParamValueError(uint8)"))
    bytes4 internal constant INVALID_PARAM_VALUE_ERROR_SELECTOR =
        0xfc45bd11;

    // bytes4(keccak256("InvalidProtocolFeePaymentError(uint8,uint256,uint256)"))
    bytes4 internal constant INVALID_PROTOCOL_FEE_PAYMENT_ERROR_SELECTOR =
        0xefd6cb33;

    // bytes4(keccak256("PreviousEpochNotFinalizedError(uint256,uint256)"))
    bytes4 internal constant PREVIOUS_EPOCH_NOT_FINALIZED_ERROR_SELECTOR =
        0x614b800a;

    // solhint-disable func-name-mixedcase
    function OnlyCallableByExchangeError(
        address senderAddress
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            ONLY_CALLABLE_BY_EXCHANGE_ERROR_SELECTOR,
            senderAddress
        );
    }

    function ExchangeManagerError(
        ExchangeManagerErrorCodes errorCodes,
        address exchangeAddress
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            EXCHANGE_MANAGER_ERROR_SELECTOR,
            errorCodes,
            exchangeAddress
        );
    }

    function InsufficientBalanceError(
        uint256 amount,
        uint256 balance
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            INSUFFICIENT_BALANCE_ERROR_SELECTOR,
            amount,
            balance
        );
    }

    function OnlyCallableByPoolOperatorOrMakerError(
        address senderAddress,
        bytes32 poolId
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            ONLY_CALLABLE_BY_POOL_OPERATOR_OR_MAKER_ERROR_SELECTOR,
            senderAddress,
            poolId
        );
    }

    function MakerPoolAssignmentError(
        MakerPoolAssignmentErrorCodes errorCodes,
        address makerAddress,
        bytes32 poolId
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            MAKER_POOL_ASSIGNMENT_ERROR_SELECTOR,
            errorCodes,
            makerAddress,
            poolId
        );
    }

    function BlockTimestampTooLowError(
        uint256 epochEndTime,
        uint256 currentBlockTimestamp
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            BLOCK_TIMESTAMP_TOO_LOW_ERROR_SELECTOR,
            epochEndTime,
            currentBlockTimestamp
        );
    }

    function OnlyCallableByStakingContractError(
        address senderAddress
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            ONLY_CALLABLE_BY_STAKING_CONTRACT_ERROR_SELECTOR,
            senderAddress
        );
    }

    function OnlyCallableIfInCatastrophicFailureError()
        internal
        pure
        returns (bytes memory)
    {
        return ONLY_CALLABLE_IF_IN_CATASTROPHIC_FAILURE_ERROR;
    }

    function OnlyCallableIfNotInCatastrophicFailureError()
        internal
        pure
        returns (bytes memory)
    {
        return ONLY_CALLABLE_IF_NOT_IN_CATASTROPHIC_FAILURE_ERROR;
    }

    function OperatorShareError(
        OperatorShareErrorCodes errorCodes,
        bytes32 poolId,
        uint32 operatorShare
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            OPERATOR_SHARE_ERROR_SELECTOR,
            errorCodes,
            poolId,
            operatorShare
        );
    }

    function PoolExistenceError(
        bytes32 poolId,
        bool alreadyExists
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            POOL_EXISTENCE_ERROR_SELECTOR,
            poolId,
            alreadyExists
        );
    }

    function InvalidProtocolFeePaymentError(
        ProtocolFeePaymentErrorCodes errorCodes,
        uint256 expectedProtocolFeePaid,
        uint256 actualProtocolFeePaid
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            INVALID_PROTOCOL_FEE_PAYMENT_ERROR_SELECTOR,
            errorCodes,
            expectedProtocolFeePaid,
            actualProtocolFeePaid
        );
    }

    function InvalidStakeStatusError(IStructs.StakeStatus status)
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            INVALID_STAKE_STATUS_ERROR_SELECTOR,
            status
        );
    }

    function InitializationError(InitializationErrorCodes code)
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            INITIALIZATION_ERROR_SELECTOR,
            uint8(code)
        );
    }

    function InvalidParamValueError(InvalidParamValueErrorCodes code)
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            INVALID_PARAM_VALUE_ERROR_SELECTOR,
            uint8(code)
        );
    }

    function ProxyDestinationCannotBeNilError()
        internal
        pure
        returns (bytes memory)
    {
        return PROXY_DESTINATION_CANNOT_BE_NIL_ERROR;
    }

    function PreviousEpochNotFinalizedError(
        uint256 unfinalizedEpoch,
        uint256 unfinalizedPoolsRemaining
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            PREVIOUS_EPOCH_NOT_FINALIZED_ERROR_SELECTOR,
            unfinalizedEpoch,
            unfinalizedPoolsRemaining
        );
    }
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-0x v3 Staking/0x-monorepo-b8e01d7be535196a3145a431291183ecfbb333c6/contracts/staking/contracts/src/libs/LibProxy.sol

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


library LibProxy {

    enum RevertRule {
        REVERT_ON_ERROR,
        ALWAYS_REVERT,
        NEVER_REVERT
    }

    /// @dev Proxies incoming call to destination contract.
    /// @param destination Address to call.
    /// @param revertRule Describes scenarios in which this function reverts.
    /// @param customEgressSelector Custom selector used to call destination contract.
    /// @param ignoreIngressSelector Ignore the selector used to call into this contract.
    function proxyCall(
        address destination,
        RevertRule revertRule,
        bytes4 customEgressSelector,
        bool ignoreIngressSelector
    )
        internal
    {
        if (destination == address(0)) {
            LibRichErrors.rrevert(
                LibStakingRichErrors.ProxyDestinationCannotBeNilError()
            );
        }

        assembly {
            // store selector of destination function
            let freeMemPtr := 0
            if gt(customEgressSelector, 0) {
                mstore(0x0, customEgressSelector)
                freeMemPtr := add(freeMemPtr, 4)
            }

            // adjust the calldata offset, if we should ignore the selector
            let calldataOffset := 0
            if gt(ignoreIngressSelector, 0) {
                calldataOffset := 4
            }

            // copy calldata to memory
            calldatacopy(
                freeMemPtr,
                calldataOffset,
                calldatasize()
            )
            freeMemPtr := add(
                freeMemPtr,
                sub(calldatasize(), calldataOffset)
            )

            // delegate call into staking contract
            let success := delegatecall(
                gas,                        // forward all gas
                destination,                // calling staking contract
                0x0,                        // start of input (calldata)
                freeMemPtr,                 // length of input (calldata)
                0x0,                        // write output over input
                0                           // length of output is unknown
            )

            // copy return data to memory and *return*
            returndatacopy(
                0x0,
                0x0,
                returndatasize()
            )

            switch revertRule
            case 1 {    // ALWAYS_REVERT
                revert(0, returndatasize())
            }
            case 2 {    // NEVER_REVERT
                return(0, returndatasize())
            }
            // solhint-disable no-empty-blocks
            default {} // REVERT_ON_ERROR (handled below)

            // rethrow any exceptions
            if iszero(success) {
                revert(0, returndatasize())
            }
            // return call results
            return(0, returndatasize())
        }
    }
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-0x v3 Staking/0x-monorepo-b8e01d7be535196a3145a431291183ecfbb333c6/contracts/staking/contracts/test/TestLibProxy.sol

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

/**********************************************

   THIS IS AN EXTREMELY DANGEROUS CONTRACT!

   IT IS ONLY INTENDED FOR TESTING AND SHOULD
       NEVER BE USED IN PRODUCTION!

**********************************************/

pragma solidity ^0.5.9;
pragma experimental ABIEncoderV2;

// solhint-disable payable-fallback
contract TestLibProxy {

    using LibProxy for address;

    // The arguments of `proxyCall()`.
    struct ProxyCallArguments {
        address destination;
        LibProxy.RevertRule revertRule;
        bytes4 customEgressSelector;
        bool ignoreIngressSelector;
    }

    // The current arguments that should be passed in the call to `proxyCall()`. This
    // state allows us to send in the exact calldata that should be sent to `proxyCall()`
    // while still being able to test any combination of inputs to `proxyCall()`.
    ProxyCallArguments internal proxyCallArgs;

    /// @dev Exposes the `proxyCall()` library function from LibProxy.
    function ()
        external
    {
        proxyCallArgs.destination.proxyCall(
            proxyCallArgs.revertRule,
            proxyCallArgs.customEgressSelector,
            proxyCallArgs.ignoreIngressSelector
        );
    }

    /// @dev Calls back into this contract with the calldata that should be sent in the call
    ///      to `proxyCall()` after setting the `proxyCallArgs` appropriately.
    /// @param args The struct that should be set to `proxyCallArgs`.
    /// @param data The bytes that should be used to call back into this contract.
    function publicProxyCall(ProxyCallArguments memory args, bytes memory data)
        public
        returns (bool success, bytes memory returnData)
    {
        proxyCallArgs = args;
        (success, returnData) = address(this).call(data);
    }
}
