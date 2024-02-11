// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-b4acf144c10b1d9f3ecde4ee2820931df1cb8e4a/contracts/lib/Bytes32Library.sol

/*
    Copyright 2018 Set Labs Inc.

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

pragma solidity 0.5.4;


library Bytes32Library {
    /**
     * Converts a bytes32 data structure into a bytes array.
     *
     * @param  data       Piece of data encoded as bytes32
     * @return bytes          
     */
    function bytes32ToBytes(bytes32 data)
        internal
        pure
        returns (bytes memory)
    {
        uint256 i = 0;
        while (i < 32 && uint256(bytes32(data[i])) != 0) {
            ++i;
        }
        bytes memory result = new bytes(i);
        i = 0;
        while (i < 32 && data[i] != 0) {
            result[i] = data[i];
            ++i;
        }
        return result;
    }

    /**
     * Converts a piece of data encoded as bytes32 into a string.
     *
     * @param  data       Piece of data encoded as bytes32
     * @return string          
     */
    function bytes32ToString(bytes32 data)
        internal
        pure
        returns (string memory)
    {
        bytes memory intermediate = bytes32ToBytes(data);
        return string(abi.encodePacked(intermediate));
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-b4acf144c10b1d9f3ecde4ee2820931df1cb8e4a/contracts/mocks/lib/Bytes32LibraryMock.sol

pragma solidity 0.5.4;

contract Bytes32LibraryMock {
    function testBytes32ToBytes(bytes32 data)
        external
        pure
        returns (bytes memory)
    {
        return Bytes32Library.bytes32ToBytes(data);
    }

    function testBytes32ToString(bytes32 data)
        external
        pure
        returns (string memory)
    {
        return Bytes32Library.bytes32ToString(data);
    }
}
