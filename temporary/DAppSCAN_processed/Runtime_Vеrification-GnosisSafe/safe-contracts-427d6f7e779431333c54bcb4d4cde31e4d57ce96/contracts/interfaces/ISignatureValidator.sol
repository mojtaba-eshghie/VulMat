// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-GnosisSafe/safe-contracts-427d6f7e779431333c54bcb4d4cde31e4d57ce96/contracts/interfaces/ISignatureValidator.sol

pragma solidity ^0.5.0;

contract ISignatureValidator {
    /**
    * @dev Should return whether the signature provided is valid for the provided data
    * @param _data Arbitrary length data signed on the behalf of address(this)
    * @param _signature Signature byte array associated with _data
    *
    * MUST return a bool upon valid or invalid signature with corresponding _data
    * MUST take (bytes, bytes) as arguments
    */ 
    function isValidSignature(
        bytes calldata _data, 
        bytes calldata _signature)
        external
        returns (bool isValid); 
}
