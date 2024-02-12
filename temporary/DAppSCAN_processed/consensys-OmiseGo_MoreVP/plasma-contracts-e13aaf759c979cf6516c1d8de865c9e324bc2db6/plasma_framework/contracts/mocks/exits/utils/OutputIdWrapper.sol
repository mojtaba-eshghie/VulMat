// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/src/exits/utils/OutputId.sol

pragma solidity 0.5.11;

library OutputId {
    /**
     * @notice Computes the output ID for a deposit tx
     * @dev Deposit tx bytes might not be unique because all inputs are empty
     *      Two deposits with the same output value would result in the same tx bytes
     *      As a result, we need to hash with utxoPos to ensure uniqueness
     * @param _txBytes Transaction bytes
     * @param _outputIndex Output index of the output
     * @param _utxoPosValue (Optional) UTXO position of the deposit output
     */
    function computeDepositOutputId(bytes memory _txBytes, uint256 _outputIndex, uint256 _utxoPosValue)
        internal
        pure
        returns(bytes32)
    {
        return keccak256(abi.encodePacked(_txBytes, _outputIndex, _utxoPosValue));
    }

    /**
     * @notice Computes the output ID for normal (non-deposit) tx
     * @dev Since txBytes for non-deposit tx is unique, directly hash the txBytes with outputIndex
     * @param _txBytes Transaction bytes
     * @param _outputIndex Output index of the output
     */
    function computeNormalOutputId(bytes memory _txBytes, uint256 _outputIndex)
        internal
        pure
        returns(bytes32)
    {
        return keccak256(abi.encodePacked(_txBytes, _outputIndex));
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/mocks/exits/utils/OutputIdWrapper.sol

pragma solidity 0.5.11;

contract OutputIdWrapper {
    function computeDepositOutputId(
        bytes memory _txBytes,
        uint8 _outputIndex,
        uint256 _utxoPosValue
    )
        public
        pure
        returns (bytes32)
    {
        return OutputId.computeDepositOutputId(_txBytes, _outputIndex, _utxoPosValue);
    }

    function computeNormalOutputId(
        bytes memory _txBytes,
        uint8 _outputIndex
    )
        public
        pure
        returns (bytes32)
    {
        return OutputId.computeNormalOutputId(_txBytes, _outputIndex);
    }
}