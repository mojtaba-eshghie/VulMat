// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-AZTEC Protocol/AZTEC-7a020f4ced9680f6e4a452fe570671aac0802471/packages/protocol/contracts/ACE/validators/joinSplit/JoinSplitABIEncoder.sol

pragma solidity >=0.5.0 <0.6.0;

/**
 * @title Library to ABI encode the output of a join split proof verification operation
 * @author AZTEC
 * @dev Don't include this as an internal library. This contract uses a static memory table to cache
 * elliptic curve primitives and hashes.
 * Calling this internally from another function will lead to memory mutation and undefined behaviour.
 * The intended use case is to call this externally via `staticcall`.
 * External calls to OptimizedAZTEC can be treated as pure functions as this contract contains no
 * storage and makes no external calls (other than to precompiles)
 * Copyright Spilsbury Holdings Ltd 2019. All rights reserved.
 **/
library JoinSplitABIEncoder {

    // keccak256 hash of "JoinSplitSignature(uint24 proof,bytes32 noteHash,uint256 challenge,address sender)"
    bytes32 constant internal JOIN_SPLIT_SIGNATURE_TYPE_HASH =
        0xf671f176821d4c6f81e66f9704cdf2c5c12d34bd23561179229c9fe7a9e85462;

        /**
        * Calldata map
        * 0x04:0x24      = calldata location of proofData byte array
        * 0x24:0x44      = message sender
        * 0x44:0x64      = h_x
        * 0x64:0x84      = h_y
        * 0x84:0xa4      = t2_x0
        * 0xa4:0xc4      = t2_x1
        * 0xc4:0xe4      = t2_y0
        * 0xe4:0x104     = t2_y1
        * 0x104:0x124    = length of proofData byte array
        * 0x124:0x144    = m
        * 0x144:0x164    = challenge
        * 0x164:0x184    = publicOwner
        * 0x184:0x1a4    = offset in byte array to notes
        * 0x1a4:0x1c4    = offset in byte array to inputSignatures
        * 0x1c4:0x1e4    = offset in byte array to inputOwners
        * 0x1e4:0x204    = offset in byte array to outputOwners
        * 0x204:0x224    = offset in byte array to metadata
        */

    function encodeAndExit(bytes32 domainHash) internal view {
        bytes32 typeHash = JOIN_SPLIT_SIGNATURE_TYPE_HASH;
        assembly {
            // set up initial variables
            let notes := add(0x104, calldataload(0x184))
            let n := calldataload(notes)
            let m := calldataload(0x124)
            let inputOwners := add(0x124, calldataload(0x1c4)) // one word after inputOwners = 1st
            let outputOwners := add(0x124, calldataload(0x1e4)) // one word after outputOwners = 1st
            let signatures := add(0x124, calldataload(0x1a4)) // one word after signatures = 1st
            let metadata := add(0x144, calldataload(0x204)) // two words after metadata = 1st

            // memory map of `proofOutputs`

            // 0x00 - 0x160  = scratch data for EIP712 signature computation and note hash computation
            // JOIN_SPLIT_SIGNATURE struct hash variables
            // 0x80 = type hash
            // 0xa0 = proof object (65793)
            // 0xc0 = noteHash
            // 0xe0 = challenge
            // 0x100 = sender
            // type hash of 'JOIN_SPLIT_SIGNATURE'
            mstore(0x80, typeHash)
            mstore(0xa0, 0x10101)
            mstore(0xe0, calldataload(0x144)) // challenge
            mstore(0x100, calldataload(0x24))

            // EIP712 Signature variables
            // 0x13e - 0x140 = 0x1901
            // 0x140 - 0x160 = domainHash
            // 0x160 - 0x180 = structHash
            mstore(0x120, 0x1901)
            mstore(0x140, domainHash) // domain hash

            // `returndata` starts at 0x160
            // `proofOutputs` starts at 0x180
            // 0x160 - 0x180 = relative offset in returndata to first bytes argument (0x20)
            // 0x180 - 0x1a0 = byte length of `proofOutputs`
            // 0x1a0 - 0x1c0 = number of `proofOutputs` entries (1)
            // 0x1c0 - 0x1e0 = relative memory offset between `v` and start of `proofOutput`

            // `proofOutput` - t, starts at 0x1e0
            // 0x1e0 - 0x200 = length of `proofOutput`
            // 0x200 - 0x220 = relative offset between `t` and `inputNotes`
            // 0x220 - 0x240 = relative offset between `t` and `outputNotes`
            // 0x240 - 0x260 = `publicOwner`
            // 0x260 - 0x280 = `publicValue`
            // 0x280 - 0x2a0 = `challenge`

            // `inputNotes` starts at 0x280
            // structure of `inputNotes` and `outputNotes`
            // 0x00 - 0x20 = byte length of notes array
            // 0x20 - 0x40 = number of notes `i`
            // the next `i` consecutive blocks of 0x20-sized memory contain relative offset between
            // start of notes array and the location of the `note`

            // structure of a `note`
            // 0x00 - 0x20 = size of `note`
            // 0x20 - 0x40 = type
            // 0x40 - 0x60 = `owner`
            // 0x60 - 0x80 = `noteHash`
            // 0x80 - 0xa0 = size of note `data`
            // 0xa0 - 0xc0 = compressed note coordinate `gamma` (part of `data`)
            // 0xc0 - 0xe0 = compressed note coordinate `sigma` (part of `data`)
            // 0xe0 - ???? = remaining note metadata

            // `proofOutputs` must form a monolithic block of memory that we can return.
            // `s` points to the memory location of the start of the current note
            // `inputPtr` points to the start of the current `notes` dynamic bytes array

            // length of proofOutputs is at s
            mstore(0x1a0, 0x01)                            // number of proofs
            mstore(0x1c0, 0x60)                            // offset to 1st proof
            // length of proofOutput is at s + 0x60
            mstore(0x200, 0xc0)                            // location of inputNotes
            // location of outputNotes is at s + 0xc0
            mstore(0x240, calldataload(0x164))             // publicOwner
            // store kPublic. If kPublic is negative, store correct signed representation,
            // relative to 2^256, not to the order of the bn128 group
            let kPublic := calldataload(sub(add(notes, mul(calldataload(notes), 0xc0)), 0xa0))
            switch gt(kPublic, 10944121435919637611123202872628637544274182200208017171849102093287904247808)
            case 1 {
                mstore(0x260, sub(kPublic, 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001))
            }
            case 0 {
                mstore(0x260, kPublic)
            }

            mstore(0x280, calldataload(0x144))                    // store challenge
            let inputPtr := 0x2a0                                 // point to inputNotes
            mstore(add(inputPtr, 0x20), m)                        // number of input notes
            // set note pointer, offsetting lookup indices for each input note
            let s := add(0x2e0, mul(m, 0x20))

            for { let i := 0 } lt(i, m) { i := add(i, 0x01) } {
                let noteIndex := add(add(notes, 0x20), mul(i, 0xc0))
                // get pointer to input signatures
                let signatureIndex := add(signatures, mul(i, 0x60))
                // copy note data to 0x00 - 0x80
                mstore(0x00, 0x01) // note type
                calldatacopy(0x20, add(noteIndex, 0x40), 0x80) // get gamma, sigma
                // construct EIP712 signature parameters
                mstore(0xc0, keccak256(0x00, 0xa0)) // note hash
                mstore(0x80, typeHash)              // typeHash - eip signature params
                // construct EIP712 signature message
                mstore(0x160, keccak256(0x80, 0xa0))
                mstore(0x00, keccak256(0x13e, 0x42))
                // recover address of EIP712 signature
                mstore(0x20, and(calldataload(signatureIndex), 0xff)) // get 8-bit v
                calldatacopy(0x40, add(signatureIndex, 0x20), 0x40) // copy r, s into memory

                // store note length in `s`
                mstore(s, 0xc0)
                // store note type (1)
                mstore(add(s, 0x20), 0x01)
                mstore(0x80, typeHash)
                mstore(0xa0, 0x10101)   // proof id 0x010101
                
                // store note owner in `s + 0x40`
                mstore(add(s, 0x40), calldataload(add(inputOwners, mul(i, 0x20))))

                let t := staticcall(gas, 0x01, 0x00, 0x80, 0x00, 0x20)
                let owner := mload(add(s, 0x40))
                let recoveredAddress := mload(0x00)

                // Check recovered address matches now owner, throw if not
                if iszero(eq(recoveredAddress, owner)) {
                    mstore(0x00, 400)
                    revert(0x00, 0x20)
                } 

                if iszero(owner) {
                    mstore(0x00, 400)
                    revert(0x00, 0x20)
                } 
                // store note hash in `s + 0x60`
                mstore(add(s, 0x60), mload(0xc0))
                // store note metadata length in `s + 0x60` (just the coordinates)
                mstore(add(s, 0x80), 0x40)
                // store compressed note coordinate gamma in `s + 0x80`
                mstore(
                    add(s, 0xa0),
                    or(
                        calldataload(add(noteIndex, 0x40)),
                        mul(
                            and(calldataload(add(noteIndex, 0x60)), 0x01),
                            0x8000000000000000000000000000000000000000000000000000000000000000
                        )
                    )
                )
                // store compressed note coordinate sigma in `s + 0xa0`
                mstore(
                    add(s, 0xc0),
                    or(
                        calldataload(add(noteIndex, 0x80)),
                        mul(
                            and(calldataload(add(noteIndex, 0xa0)), 0x01),
                            0x8000000000000000000000000000000000000000000000000000000000000000
                        )
                    )
                )
                // compute the relative offset to index this note in our returndata
                mstore(add(add(inputPtr, 0x40), mul(i, 0x20)), sub(s, inputPtr)) // relative offset to note
        
                // increase s by note length
                s := add(s, 0xe0)
            }

            // transition between input and output notes
            // store total length of inputNotes at 1st index of inputNotes 
            mstore(inputPtr, sub(sub(s, inputPtr), 0x20))
            mstore(0x220, add(0xc0, sub(s, inputPtr))) // store relative memory offset to outputNotes
            inputPtr := s
            mstore(add(inputPtr, 0x20), sub(n, m)) // store number of output notes
            s := add(s, add(0x40, mul(sub(n, m), 0x20)))

            // output notes
            for { let i := m } lt(i, n) { i := add(i, 0x01) } {
                // get note index
                let noteIndex := add(add(notes, 0x20), mul(i, 0xc0))
                // get pointer to metadata
                let metadataIndex := calldataload(add(metadata, mul(sub(i, m), 0x20)))
                // get size of metadata
                let metadataLength := calldataload(add(sub(metadata, 0x40), metadataIndex))

                // copy note data to 0x00 - 0x80
                mstore(0x00, 0x01) // note type
                calldatacopy(0x20, add(noteIndex, 0x40), 0x80) // get gamma, sigma

                // store note length in `s`
                mstore(s, add(0xc0, metadataLength))
                // store note type (1)
                mstore(add(s, 0x20), 0x01)
                // store the owner of the note in `s + 0x20`
                mstore(add(s, 0x40), calldataload(add(outputOwners, mul(sub(i, m), 0x20))))
                // store note hash
                mstore(add(s, 0x60), keccak256(0x00, 0xa0))
                // store note metadata length if `s + 0x60`
                mstore(add(s, 0x80), add(0x40, metadataLength))
                // store compressed note coordinate gamma in `s + 0x80`
                mstore(
                    add(s, 0xa0),
                    or(
                        mload(0x20),
                        mul(
                            and(mload(0x40), 0x01),
                            0x8000000000000000000000000000000000000000000000000000000000000000
                        )
                    )
                )
                // store compressed note coordinate sigma in `s + 0xa0`
                mstore(
                add(s, 0xc0),
                or(
                    mload(0x60),
                    mul(
                        and(mload(0x80), 0x01),
                        0x8000000000000000000000000000000000000000000000000000000000000000
                    )
                )
                )
                // copy metadata into `s + 0xc0`
                calldatacopy(add(s, 0xe0), add(metadataIndex, sub(metadata, 0x20)), metadataLength)
                // compute the relative offset to index this note in our returndata
                mstore(add(add(inputPtr, 0x40), mul(sub(i, m), 0x20)), sub(s, inputPtr)) // relative offset to note

                // increase s by note length
                s := add(s, add(mload(s), 0x20))
            }

            // cleanup. the length of the outputNotes = s - inputPtr
            mstore(inputPtr, sub(sub(s, inputPtr), 0x20)) // store length of outputNotes at start of outputNotes
            let notesLength := sub(s, 0x2a0)
            mstore(0x1e0, add(0xa0, notesLength)) // store length of proofOutput at 0x160
            mstore(0x180, add(0x100, notesLength)) // store length of proofOutputs at 0x100
            mstore(0x160, 0x20)
            return(0x160, add(0x140, notesLength)) // return the final byte array
        }
    }
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-AZTEC Protocol/AZTEC-7a020f4ced9680f6e4a452fe570671aac0802471/packages/protocol/contracts/libs/LibEIP712.sol

pragma solidity >=0.5.0 <0.6.0;


/**
 * @title Library of EIP712 utility constants and functions
 * @author AZTEC
 * Copyright Spilbury Holdings Ltd 2019. All rights reserved.
 **/
contract LibEIP712 {

    // EIP712 Domain Name value
    string constant internal EIP712_DOMAIN_NAME = "AZTEC_CRYPTOGRAPHY_ENGINE";

    // EIP712 Domain Version value
    string constant internal EIP712_DOMAIN_VERSION = "1";

    // Hash of the EIP712 Domain Separator Schema
    bytes32 constant internal EIP712_DOMAIN_SEPARATOR_SCHEMA_HASH = keccak256(abi.encodePacked(
        "EIP712Domain(",
            "string name,",
            "string version,",
            "address verifyingContract",
        ")"
    ));

    // Hash of the EIP712 Domain Separator data
    // solhint-disable-next-line var-name-mixedcase
    bytes32 public EIP712_DOMAIN_HASH;

    constructor ()
        public
    {
        EIP712_DOMAIN_HASH = keccak256(abi.encode(
            EIP712_DOMAIN_SEPARATOR_SCHEMA_HASH,
            keccak256(bytes(EIP712_DOMAIN_NAME)),
            keccak256(bytes(EIP712_DOMAIN_VERSION)),
            address(this)
        ));
    }

    /// @dev Calculates EIP712 encoding for a hash struct in this EIP712 Domain.
    /// @param _hashStruct The EIP712 hash struct.
    /// @return EIP712 hash applied to this EIP712 Domain.
    function hashEIP712Message(bytes32 _hashStruct)
        internal
        view
        returns (bytes32 _result)
    {
        bytes32 eip712DomainHash = EIP712_DOMAIN_HASH;

        // Assembly for more efficient computing:
        // keccak256(abi.encodePacked(
        //     EIP191_HEADER,
        //     EIP712_DOMAIN_HASH,
        //     hashStruct
        // ));

        assembly {
            // Load free memory pointer. We're not going to use it - we're going to overwrite it!
            // We need 0x60 bytes of memory for this hash,
            // cheaper to overwrite the free memory pointer at 0x40, and then replace it, than allocating free memory
            let memPtr := mload(0x40)
            mstore(0x00, 0x1901)               // EIP191 header
            mstore(0x20, eip712DomainHash)     // EIP712 domain hash
            mstore(0x40, _hashStruct)          // Hash of struct
            _result := keccak256(0x1e, 0x42)   // compute hash
            // replace memory pointer
            mstore(0x40, memPtr)
        }
    }

    /// @dev Extracts the address of the signer with ECDSA.
    /// @param _message The EIP712 message.
    /// @param _signature The ECDSA values, v, r and s.
    /// @return The address of the message signer.
    function recoverSignature(
        bytes32 _message,
        bytes memory _signature
    ) internal view returns (address _signer) {
        bool result;
        assembly {
            // Here's a little trick we can pull. We expect `_signature` to be a byte array, of length 0x60, with
            // 'v', 'r' and 's' located linearly in memory. Preceeding this is the length parameter of `_signature`.
            // We *replace* the length param with the signature msg to get a memory block formatted for the precompile

            // load length as a temporary variable
            let byteLength := mload(_signature)

            // store the signature message
            mstore(_signature, _message)

            // load 'v' - we need it for a condition check
            let v := mload(add(_signature, 0x20))

            result := and(
                and(
                    // validate signature length == 0x60 bytes
                    eq(byteLength, 0x60),
                    // validate v == 27 or v == 28
                    or(eq(v, 27), eq(v, 28))
                ),
                // validate call to precompile succeeds
                staticcall(gas, 0x01, _signature, 0x80, _signature, 0x20)
            )
            // save the _signer only if the first word in _signature is not `_message` anymore
            switch eq(_message, mload(_signature))
            case 0 {
                _signer := mload(_signature)
            }
            mstore(_signature, byteLength) // and put the byte length back where it belongs
        }
        // wrap failure states in a single if test, so that happy path only has 1 conditional jump
        if (!(result && (_signer == address(0x0)))) {
            require(_signer != address(0x0), "signer address cannot be 0");
            require(result, "signature recovery failed");
        }
    }
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-AZTEC Protocol/AZTEC-7a020f4ced9680f6e4a452fe570671aac0802471/packages/protocol/contracts/ACE/validators/joinSplit/JoinSplitABIEncoderTest.sol

pragma solidity >=0.5.0 <0.6.0;


contract JoinSplitABIEncoderTest is LibEIP712 {
    function validateJoinSplit(
        bytes calldata, 
        address, 
        uint[6] calldata
    ) 
        external view
        returns (bytes memory) 
    {
        JoinSplitABIEncoder.encodeAndExit(EIP712_DOMAIN_HASH);
    }
}
