// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/src/utils/RLPReader.sol

/**
 * @author Hamdi Allam hamdi.allam97@gmail.com
 * @notice RLP decoding library forked from https://github.com/hamdiallam/Solidity-RLP
 * @dev Some changes that were made to the library are:
 *      - Added more test cases from https://github.com/ethereum/tests/tree/master/RLPTests
 *      - Created more custom invalid test cases
 *      - Added more checks to ensure the decoder reads within bounds of the input length
 *      - Moved utility functions necessary to run some of the tests to the RLPMock.sol
*/

pragma solidity 0.5.11;

library RLPReader {
    uint8 constant internal STRING_SHORT_START = 0x80;
    uint8 constant internal STRING_LONG_START  = 0xb8;
    uint8 constant internal LIST_SHORT_START   = 0xc0;
    uint8 constant internal LIST_LONG_START    = 0xf8;
    uint8 constant internal MAX_SHORT_LEN      = 55;
    uint8 constant internal WORD_SIZE = 32;

    struct RLPItem {
        uint256 len;
        uint256 memPtr;
    }

    /**
     * @notice Convert a dynamic bytes array into an RLPItem
     * @param item RLP encoded bytes
     * @return An RLPItem
     */
    function toRlpItem(bytes memory item) internal pure returns (RLPItem memory) {
        uint256 memPtr;

        // solhint-disable-next-line no-inline-assembly
        assembly {
            memPtr := add(item, 0x20)
        }

        return RLPItem(item.length, memPtr);
    }

    /**
    * @notice Convert a dynamic bytes array into a list of RLPItems
    * @param item RLP encoded list in bytes
    * @return A list of RLPItems
    */
    function toList(RLPItem memory item) internal pure returns (RLPItem[] memory) {
        require(isList(item), "Item is not a list");

        (uint256 listLength, uint256 offset) = decodeLengthAndOffset(item.memPtr);
        require(listLength == item.len, "Decoded RLP length for list is invalid");

        uint256 items = countEncodedItems(item);
        RLPItem[] memory result = new RLPItem[](items);

        uint256 dataMemPtr = item.memPtr + offset;
        uint256 dataLen;
        for (uint256 i = 0; i < items; i++) {
            (dataLen, ) = decodeLengthAndOffset(dataMemPtr);
            result[i] = RLPItem(dataLen, dataMemPtr);
            dataMemPtr = dataMemPtr + dataLen;
        }

        return result;
    }

    /**
    * @notice Check whether the RLPItem is either a list
    * @param item RLP encoded list in bytes
    * @return A boolean whether the RLPItem is a list
    */
    function isList(RLPItem memory item) internal pure returns (bool) {
        if (item.len == 0) return false;

        uint8 byte0;
        uint256 memPtr = item.memPtr;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            byte0 := byte(0, mload(memPtr))
        }

        if (byte0 < LIST_SHORT_START)
            return false;
        return true;
    }

    /**
     * @notice Create an address from a RLPItem
     * @dev Function is not a standard RLP decoding function and it used to decode to the Solidity native address type
     * @param item RLPItem
     */
    function toAddress(RLPItem memory item) internal pure returns (address) {
        require(item.len == 21, "Item length must be 21");
        require(!isList(item), "Item must not be a list");

        (uint256 itemLen, uint256 offset) = decodeLengthAndOffset(item.memPtr);
        require(itemLen == 21, "Decoded item length must be 21");

        uint256 dataMemPtr = item.memPtr + offset;
        uint256 result;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            result := mload(dataMemPtr)
            // right shift by 12 to make bytes20
            result := div(result, exp(256, 12))
        }

        return address(result);
    }

    /**
     * @notice Create a uint256 from a RLPItem. Leading zeros are invalid.
     * @dev Function is not a standard RLP decoding function and it used to decode to the Solidity native uint256 type
     * @param item RLPItem
     */
    function toUint(RLPItem memory item) internal pure returns (uint256) {
        require(item.len > 0 && item.len <= 33, "Item length must be between 1 and 33 bytes");
        require(!isList(item), "Item must not be a list");
        (uint256 itemLen, uint256 offset) = decodeLengthAndOffset(item.memPtr);
        require(itemLen == item.len, "Decoded item length must be equal to the input data length");

        uint256 dataLen = itemLen - offset;

        uint result;
        uint dataByte0;
        uint dataMemPtr = item.memPtr + offset;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            result := mload(dataMemPtr)
            dataByte0 := byte(0, result)
            // shift to the correct location if necessary
            if lt(dataLen, WORD_SIZE) {
                result := div(result, exp(256, sub(WORD_SIZE, dataLen)))
            }
        }
        // Special case: scalar 0 should be encoded as 0x80 and _not_ as 0x00
        require(!(dataByte0 == 0 && offset == 0), "Scalar 0 should be encoded as 0x80");

        // Disallow leading zeros
        require(!(dataByte0 == 0 && dataLen > 1), "Leading zeros are invalid");

        return result;
    }

    /**
     * @notice Create a bytes32 from a RLPItem
    * @dev Function is not a standard RLP decoding function and it used to decode to the Solidity native bytes32 type
     * @param item RLPItem
     */
    function toBytes32(RLPItem memory item) internal pure returns (bytes32) {
        // 1 byte for the length prefix
        require(item.len == 33, "Item length must be 33");
        require(!isList(item), "Item must not be a list");

        (uint256 itemLen, uint256 offset) = decodeLengthAndOffset(item.memPtr);
        require(itemLen == 33, "Decoded item length must be 33");

        uint256 dataMemPtr = item.memPtr + offset;
        bytes32 result;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            result := mload(dataMemPtr)
        }

        return result;
    }

    /**
    * @notice Counts the number of payload items inside an RLP encoded list
    * @param item RLPItem
    * @return The number of items in a inside an RLP encoded list
    */
    function countEncodedItems(RLPItem memory item) private pure returns (uint256) {
        uint256 count = 0;
        (, uint256 offset) = decodeLengthAndOffset(item.memPtr);
        uint256 currPtr = item.memPtr + offset;
        uint256 endPtr = item.memPtr + item.len;
        while (currPtr < endPtr) {
            (uint256 currLen, ) = decodeLengthAndOffset(currPtr);
            currPtr = currPtr + currLen;
            require(currPtr <= endPtr, "Invalid decoded length of RLP item found during counting items in a list");
            count++;
        }

        return count;
    }

    /**
     * @notice Decodes the RLPItem's length and offset.
     * @dev This function is dangerous. Ensure that the returned length is within bounds that memPtr points to.
     * @param memPtr Pointer to the dynamic bytes array in memory
     * @return The length of the RLPItem (including the length field) and the offset of the payload
     */
    function decodeLengthAndOffset(uint256 memPtr) internal pure returns (uint256, uint256) {
        uint256 decodedLength;
        uint256 offset;
        uint256 byte0;

        // solhint-disable-next-line no-inline-assembly
        assembly {
            byte0 := byte(0, mload(memPtr))
        }

        if (byte0 < STRING_SHORT_START) {
            // Item is a single byte
            decodedLength = 1;
            offset = 0;
        } else if (STRING_SHORT_START <= byte0 && byte0 < STRING_LONG_START) {
            // The range of the first byte is between 0x80 and 0xb7 therefore it is a short string
            // decodedLength is between 1 and 56 bytes
            decodedLength = (byte0 - STRING_SHORT_START) + 1;
            if (decodedLength == 2){
                uint256 byte1;
                // solhint-disable-next-line no-inline-assembly
                assembly {
                    byte1 := byte(0, mload(add(memPtr, 1)))
                }
                // A single byte below 0x80 must be encoded as itself.
                require(byte1 >= STRING_SHORT_START, "Invalid short string encoding");
            }
            offset = 1;
        } else if (STRING_LONG_START <= byte0 && byte0 < LIST_SHORT_START) {
            // The range of the first byte is between 0xb8 and 0xbf therefore it is a long string
            // lengthLen is between 1 and 8 bytes
            // dataLen is greater than 55 bytes
            uint256 dataLen;
            uint256 byte1;
            uint256 lengthLen;

            // solhint-disable-next-line no-inline-assembly
            assembly {
                lengthLen := sub(byte0, 0xb7) // The length of the length of the payload is encoded in the first byte.
                memPtr := add(memPtr, 1) // skip over the first byte

                // right shift to the correct position
                dataLen := div(mload(memPtr), exp(256, sub(WORD_SIZE, lengthLen)))
                decodedLength := add(dataLen, add(lengthLen, 1))
                byte1 := byte(0, mload(memPtr))
            }

            // Check that the length has no leading zeros
            require(byte1 != 0, "Invalid leading zeros in length of the length for a long string");
            // Check that the value of length > MAX_SHORT_LEN
            require(dataLen > MAX_SHORT_LEN, "Invalid length for a long string");
            // Calculate the offset
            offset = lengthLen + 1;
        } else if (LIST_SHORT_START <= byte0 && byte0 < LIST_LONG_START) {
            // The range of the first byte is between 0xc0 and 0xf7 therefore it is a short list
            // decodedLength is between 1 and 56 bytes
            decodedLength = (byte0 - LIST_SHORT_START) + 1;
            offset = 1;
        } else {
            // The range of the first byte is between 0xf8 and 0xff therefore it is a long list
            // lengthLen is between 1 and 8 bytes
            // dataLen is greater than 55 bytes
            uint256 dataLen;
            uint256 byte1;
            uint256 lengthLen;

            // solhint-disable-next-line no-inline-assembly
            assembly {
                lengthLen := sub(byte0, 0xf7) // The length of the length of the payload is encoded in the first byte.
                memPtr := add(memPtr, 1) // skip over the first byte

                // right shift to the correct position
                dataLen := div(mload(memPtr), exp(256, sub(WORD_SIZE, lengthLen)))
                decodedLength := add(dataLen, add(lengthLen, 1))
                byte1 := byte(0, mload(memPtr))
            }

            // Check that the length has no leading zeros
            require(byte1 != 0, "Invalid leading zeros in length of the length for a long list");
            // Check that the value of length > MAX_SHORT_LEN
            require(dataLen > MAX_SHORT_LEN, "Invalid length for a long list");
            // Calculate the offset
            offset = lengthLen + 1;
        }

        return (decodedLength, offset);
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/src/transactions/GenericTransaction.sol

pragma solidity 0.5.11;

/**
 * @title GenericTransaction
 * @notice GenericTransaction is a generic transaction format that makes few assumptions about the
 * content of the transaction. A transaction must satisy the following requirements:
 * - It must be a list of 5 items: [txType, inputs, outputs, txData, metaData]
 * - `txType` must be a uint not equal to zero
 * - inputs must be a list of RLP items.
 * - outputs must be a list of `Output`s
 * - an `Output` is a list of 2 items: [outputType, data]
 * - `Output.outputType` must be a uint not equal to zero
 * - `Output.data` is an RLP item. It can be a list.
 * - no assumptions are made about `txData`. Note that `txData` can be a list.
 * - `metaData` must be 32 bytes long.
 */
library GenericTransaction {

    uint8 constant private TX_NUM_ITEMS = 5;

    using RLPReader for bytes;
    using RLPReader for RLPReader.RLPItem;

    struct Transaction {
        uint256 txType;
        RLPReader.RLPItem[] inputs;
        Output[] outputs;
        RLPReader.RLPItem txData;
        bytes32 metaData;
    }

    struct Output {
        uint256 outputType;
        RLPReader.RLPItem data;
    }

    /**
    * @dev Decodes an RLP encoded transaction into the generic format.
    */
    function decode(bytes memory transaction) internal pure returns (Transaction memory) {
        RLPReader.RLPItem[] memory rlpTx = transaction.toRlpItem().toList();
        require(rlpTx.length == TX_NUM_ITEMS, "Invalid encoding of transaction");
        uint256 txType = rlpTx[0].toUint();
        require(txType > 0, "Transaction type must not be 0");

        RLPReader.RLPItem[] memory outputList = rlpTx[2].toList();
        Output[] memory outputs = new Output[](outputList.length);
        for (uint i = 0; i < outputList.length; i++) {
            outputs[i] = decodeOutput(outputList[i]);
        }

        bytes32 metaData = rlpTx[4].toBytes32();

        return Transaction({
            txType: txType,
            inputs: rlpTx[1].toList(),
            outputs: outputs,
            txData: rlpTx[3],
            metaData: metaData
        });
    }

    /**
    * @dev Returns the output at a specific index in the transaction
    */
    function getOutput(Transaction memory transaction, uint16 outputIndex)
        internal
        pure
        returns (Output memory)
    {
        require(outputIndex < transaction.outputs.length, "Output index out of bounds");
        return transaction.outputs[outputIndex];
    }

    /**
    * @dev Decodes an RLPItem to an output
    */
    function decodeOutput(RLPReader.RLPItem memory encodedOutput)
        internal
        pure
        returns (Output memory)
    {
        RLPReader.RLPItem[] memory rlpList = encodedOutput.toList();
        require(rlpList.length == 2, "Output must have 2 items");

        Output memory output = Output({
            outputType: rlpList[0].toUint(),
            data: rlpList[1]
        });

        require(output.outputType != 0, "Output type must not be 0");
        return output;
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/mocks/transactions/GenericTransactionWrapper.sol

pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;

contract GenericTransactionWrapper {

    function decode(bytes memory transaction) public pure returns (GenericTransaction.Transaction memory) {
        return GenericTransaction.decode(transaction);
    }

    function getOutput(bytes memory transaction, uint16 outputIndex) public pure returns (GenericTransaction.Output memory) {
        GenericTransaction.Transaction memory genericTx = GenericTransaction.decode(transaction);
        return GenericTransaction.getOutput(genericTx, outputIndex);
    }
}
