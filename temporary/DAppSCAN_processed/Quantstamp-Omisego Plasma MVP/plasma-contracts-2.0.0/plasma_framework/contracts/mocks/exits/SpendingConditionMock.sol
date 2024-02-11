// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/src/exits/interfaces/ISpendingCondition.sol

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
     * @param utxoPos Position of the utxo
     * @param spendingTx Spending transaction, in bytes
     * @param inputIndex The input index of the spending tx that points to the output
     * @param witness The witness data of the spending condition
     */
    function verify(
        bytes calldata inputTx,
        uint256 utxoPos,
        bytes calldata spendingTx,
        uint16 inputIndex,
        bytes calldata witness
    ) external view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/mocks/exits/SpendingConditionMock.sol

pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;

contract SpendingConditionMock is ISpendingCondition {
    bool internal expectedResult;
    bool internal shouldRevert;
    Args internal expectedArgs;

    string constant internal REVERT_MESSAGE = "Test spending condition reverts";

    struct Args {
        bytes inputTx;
        uint256 utxoPos;
        bytes spendingTx;
        uint16 inputIndex;
        bytes witness;
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
        uint256 utxoPos,
        bytes calldata spendingTx,
        uint16 inputIndex,
        bytes calldata witness
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
            require(expectedArgs.utxoPos == utxoPos, "utxoPos not as expected");
            require(keccak256(expectedArgs.spendingTx) == keccak256(spendingTx), "spending tx not as expected");
            require(expectedArgs.inputIndex == inputIndex, "input index not as expected");
            require(keccak256(expectedArgs.witness) == keccak256(witness), "witness not as expected");
        }
        return expectedResult;
    }
}
