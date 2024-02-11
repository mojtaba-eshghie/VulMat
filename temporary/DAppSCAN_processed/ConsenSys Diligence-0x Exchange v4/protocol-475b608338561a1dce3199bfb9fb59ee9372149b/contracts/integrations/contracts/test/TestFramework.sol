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

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-0x Exchange v4/protocol-475b608338561a1dce3199bfb9fb59ee9372149b/contracts/integrations/contracts/test/TestFramework.sol

pragma solidity ^0.5.9;

// This contract is intended to be used in the unit tests that test the typescript
// test framework found in `test/utils/`
contract TestFramework {

    event Event(string input);

    // bytes4(keccak256("RichRevertErrorSelector(string)"))
    bytes4 internal constant RICH_REVERT_ERROR_SELECTOR = 0x49a7e246;

    function emitEvent(string calldata input)
        external
    {
        emit Event(input);
    }

    function emptyRevert()
        external
        pure
    {
        revert();
    }

    function stringRevert(string calldata message)
        external
        pure
    {
        revert(message);
    }

    function doNothing()
        external
        pure
    {} // solhint-disable-line no-empty-blocks

    function returnInteger(uint256 integer)
        external
        pure
        returns (uint256)
    {
        return integer;
    }
}
