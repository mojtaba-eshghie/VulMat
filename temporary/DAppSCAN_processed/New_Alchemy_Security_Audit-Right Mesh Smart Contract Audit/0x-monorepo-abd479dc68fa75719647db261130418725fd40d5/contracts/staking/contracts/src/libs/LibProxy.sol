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

// File: ../sc_datasets/DAppSCAN/New_Alchemy_Security_Audit-Right Mesh Smart Contract Audit/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/libs/LibStakingRichErrors.sol

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
    // bytes4(keccak256("MiscalculatedRewardsError(uint256,uint256)"))
    bytes4 internal constant MISCALCULATED_REWARDS_ERROR_SELECTOR =
        0xf7806c4e;

    // bytes4(keccak256("OnlyCallableByExchangeError(address)"))
    bytes4 internal constant ONLY_CALLABLE_BY_EXCHANGE_ERROR_SELECTOR =
        0xb56d2df0;

    // bytes4(keccak256("ExchangeAddressAlreadyRegisteredError(address)"))
    bytes4 internal constant EXCHANGE_ADDRESS_ALREADY_REGISTERED_ERROR_SELECTOR =
        0xc87a78b7;

    // bytes4(keccak256("ExchangeAddressNotRegisteredError(address)"))
    bytes4 internal constant EXCHANGE_ADDRESS_NOT_REGISTERED_ERROR_SELECTOR =
        0x7dc025b0;

    // bytes4(keccak256("InsufficientBalanceError(uint256,uint256)"))
    bytes4 internal constant INSUFFICIENT_BALANCE_ERROR_SELECTOR =
        0x84c8b7c9;

    // bytes4(keccak256("OnlyCallableByPoolOperatorError(address,address)"))
    bytes4 internal constant ONLY_CALLABLE_BY_POOL_OPERATOR_ERROR_SELECTOR =
        0x6cfa0c22;

    // bytes4(keccak256("OnlyCallableByPoolOperatorOrMakerError(address,address,address)"))
    bytes4 internal constant ONLY_CALLABLE_BY_POOL_OPERATOR_OR_MAKER_ERROR_SELECTOR =
        0x7d9e1c10;

    // bytes4(keccak256("MakerPoolAssignmentError(uint8,address,bytes32)"))
    bytes4 internal constant MAKER_POOL_ASSIGNMENT_ERROR_SELECTOR =
        0x69945e3f;

    // bytes4(keccak256("WithdrawAmountExceedsMemberBalanceError(uint256,uint256)"))
    bytes4 internal constant WITHDRAW_AMOUNT_EXCEEDS_MEMBER_BALANCE_ERROR_SELECTOR =
        0xfc9c065f;

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

    // bytes4(keccak256("AmountExceedsBalanceOfPoolError(uint256,uint96)"))
    bytes4 internal constant AMOUNT_EXCEEDS_BALANCE_OF_POOL_ERROR_SELECTOR =
        0x4c5c09dd;

    // bytes4(keccak256("InvalidPoolOperatorShareError(bytes32,uint32)"))
    bytes4 internal constant INVALID_POOL_OPERATOR_SHARE_ERROR_SELECTOR =
        0x70f55b5a;

    // bytes4(keccak256("PoolAlreadyExistsError(bytes32)"))
    bytes4 internal constant POOL_ALREADY_EXISTS_ERROR_SELECTOR =
        0x2a5e4dcf;

    // bytes4(keccak256("InvalidCobbDouglasAlphaError(uint256,uint256)"))
    bytes4 internal constant INVALID_COBB_DOUGLAS_ALPHA_ERROR_SELECTOR =
        0x8f8e73de;

    // bytes4(keccak256("EthVaultNotSetError()"))
    bytes4 internal constant ETH_VAULT_NOT_SET_ERROR_SELECTOR =
        0xa067f596;

    // bytes4(keccak256("RewardVaultNotSetError()"))
    bytes4 internal constant REWARD_VAULT_NOT_SET_ERROR_SELECTOR =
        0xe6976d70;

    // bytes4(keccak256("InvalidStakeStatusError(uint256)"))
    bytes4 internal constant INVALID_STAKE_STATUS_ERROR_SELECTOR =
        0xb7161acd;

    // bytes4(keccak256("ProxyDestinationCannotBeNil()"))
    bytes internal constant PROXY_DESTINATION_CANNOT_BE_NIL =
        hex"01ecebea";

    enum MakerPoolAssignmentErrorCodes {
        MAKER_ADDRESS_ALREADY_REGISTERED,
        MAKER_ADDRESS_NOT_REGISTERED,
        MAKER_ADDRESS_NOT_PENDING_ADD,
        POOL_IS_FULL
    }

    // solhint-disable func-name-mixedcase
    function MiscalculatedRewardsError(
        uint256 totalRewardsPaid,
        uint256 initialContractBalance
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            MISCALCULATED_REWARDS_ERROR_SELECTOR,
            totalRewardsPaid,
            initialContractBalance
        );
    }

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

    function ExchangeAddressAlreadyRegisteredError(
        address exchangeAddress
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            EXCHANGE_ADDRESS_ALREADY_REGISTERED_ERROR_SELECTOR,
            exchangeAddress
        );
    }

    function ExchangeAddressNotRegisteredError(
        address exchangeAddress
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            EXCHANGE_ADDRESS_NOT_REGISTERED_ERROR_SELECTOR,
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

    function OnlyCallableByPoolOperatorError(
        address senderAddress,
        address poolOperatorAddress
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            ONLY_CALLABLE_BY_POOL_OPERATOR_ERROR_SELECTOR,
            senderAddress,
            poolOperatorAddress
        );
    }

    function OnlyCallableByPoolOperatorOrMakerError(
        address senderAddress,
        address poolOperatorAddress,
        address makerAddress
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            ONLY_CALLABLE_BY_POOL_OPERATOR_OR_MAKER_ERROR_SELECTOR,
            senderAddress,
            poolOperatorAddress,
            makerAddress
        );
    }

    function MakerPoolAssignmentError(
        MakerPoolAssignmentErrorCodes errorCode,
        address makerAddress,
        bytes32 poolId
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            MAKER_POOL_ASSIGNMENT_ERROR_SELECTOR,
            errorCode,
            makerAddress,
            poolId
        );
    }

    function WithdrawAmountExceedsMemberBalanceError(
        uint256 withdrawAmount,
        uint256 balance
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            WITHDRAW_AMOUNT_EXCEEDS_MEMBER_BALANCE_ERROR_SELECTOR,
            withdrawAmount,
            balance
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

    function AmountExceedsBalanceOfPoolError(
        uint256 amount,
        uint96 poolBalance
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            AMOUNT_EXCEEDS_BALANCE_OF_POOL_ERROR_SELECTOR,
            amount,
            poolBalance
        );
    }

    function InvalidPoolOperatorShareError(
        bytes32 poolId,
        uint32 poolOperatorShare
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            INVALID_POOL_OPERATOR_SHARE_ERROR_SELECTOR,
            poolId,
            poolOperatorShare
        );
    }

    function PoolAlreadyExistsError(
        bytes32 poolId
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            POOL_ALREADY_EXISTS_ERROR_SELECTOR,
            poolId
        );
    }

    function InvalidCobbDouglasAlphaError(
        uint256 numerator,
        uint256 denominator
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            INVALID_COBB_DOUGLAS_ALPHA_ERROR_SELECTOR,
            numerator,
            denominator
        );
    }

    function EthVaultNotSetError()
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            ETH_VAULT_NOT_SET_ERROR_SELECTOR
        );
    }

    function RewardVaultNotSetError()
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            REWARD_VAULT_NOT_SET_ERROR_SELECTOR
        );
    }

    function InvalidStakeStatusError(uint256 status)
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(
            INVALID_STAKE_STATUS_ERROR_SELECTOR,
            status
        );
    }

    function ProxyDestinationCannotBeNil()
        internal
        pure
        returns (bytes memory)
    {
        return PROXY_DESTINATION_CANNOT_BE_NIL;
    }

}

// File: ../sc_datasets/DAppSCAN/New_Alchemy_Security_Audit-Right Mesh Smart Contract Audit/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/libs/LibProxy.sol

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
                LibStakingRichErrors.ProxyDestinationCannotBeNil()
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
