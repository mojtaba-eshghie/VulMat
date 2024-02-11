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

// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/mocks/exits/SpendingConditionMock.sol

pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;

contract SpendingConditionMock is ISpendingCondition {
    bool internal expectedResult;
    bool internal shouldRevert;
    Args internal expectedArgs;

    string constant internal REVERT_MESSAGE = "Test spending condition reverts";

    struct Args {
        bytes inputTx;
        uint16 outputIndex;
        uint256 inputTxPos;
        bytes spendingTx;
        uint16 inputIndex;
        bytes witness;
        bytes optionalArgs;
    }

    /** mock what would "verify()" returns */
    function mockResult(bool result) public {
        expectedResult = result;
    }

    /** when called, the spending condition would always revert on purpose */
    function mockRevert() public {
        shouldRevert = true;
    }

    /** provide the expected args, it would check with the value called for "verify()" */
    function shouldVerifyArgumentEquals(Args memory args) public {
        expectedArgs = args;
    }

    /** override */
    function verify(
        bytes calldata inputTx,
        uint16 outputIndex,
        uint256 inputTxPos,
        bytes calldata spendingTx,
        uint16 inputIndex,
        bytes calldata witness,
        bytes calldata optionalArgs
    )
        external
        view
        returns (bool)
    {
        if (shouldRevert) {
            revert(REVERT_MESSAGE);
        }

        // only run the check when "shouldVerifyArgumentEqauals" is called
        if (expectedArgs.inputTx.length > 0) {
            require(keccak256(expectedArgs.inputTx) == keccak256(inputTx), "input tx not as expected");
            require(expectedArgs.outputIndex == outputIndex, "output index not as expected");
            require(expectedArgs.inputTxPos == inputTxPos, "input tx pos not as expected");
            require(keccak256(expectedArgs.spendingTx) == keccak256(spendingTx), "spending tx not as expected");
            require(expectedArgs.inputIndex == inputIndex, "input index not as expected");
            require(keccak256(expectedArgs.witness) == keccak256(witness), "witness not as expected");
            require(keccak256(expectedArgs.optionalArgs) == keccak256(optionalArgs), "optional args not as expected");
        }
        return expectedResult;
    }
}
