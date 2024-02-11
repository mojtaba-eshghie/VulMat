// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/src/exits/interfaces/ISpendingCondition.sol

pragma solidity 0.5.11;

/**
 * @notice Interface of the spending condition
 * @dev For the interface design and discussion, see the following GH issue
 *      https://github.com/omisego/plasma-contracts/issues/214
 */
interface ISpendingCondition {

    /**
     * @notice Verifies the spending condition
     * @param inputTx Encoded input transaction, in bytes
     * @param outputIndex The output index of the input transaction
     * @param inputTxPos The tx position of the input tx (0 if in-flight)
     * @param spendingTx Spending transaction, in bytes
     * @param inputIndex The input index of the spending tx that points to the output
     * @param witness The witness data of the spending condition
     * @param optionalArgs Optional data for the spending condition (for example, output guard preimage)
     */
    function verify(
        bytes calldata inputTx,
        uint16 outputIndex,
        uint256 inputTxPos,
        bytes calldata spendingTx,
        uint16 inputIndex,
        bytes calldata witness,
        bytes calldata optionalArgs
    ) external view returns (bool);
}
