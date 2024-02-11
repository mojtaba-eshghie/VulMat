// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/src/exits/models/OutputGuardModel.sol

pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;

library OutputGuardModel {
    /**
     * @dev The data structure used for IOutputGuardHandler, containing essential data related to output guard
     * @param guard The output guard inside an output
     * @param preimage Original data of the output guard
     */
    struct Data {
        bytes20 guard;
        bytes preimage;
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/src/exits/interfaces/IOutputGuardHandler.sol

pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;

/**
 * @notice An interface for utils functions needed to process and get essential data from output guard field.
 * @dev This is required since there are multiple ways of using the field 'output guard'. For instance, in normal
 *      payments the output guard field holds the owner's address directly while for DEX deposits, it uses
 *      the privacy deposit mechanism and becomes hash of output type and preimage.
 */
interface IOutputGuardHandler {
    /**
    * @notice Checks a given output guard data
    */
    function isValid(OutputGuardModel.Data calldata object) external view returns (bool);

    /**
    * @notice Gets the 'exit target' from the data set
    */
    function getExitTarget(OutputGuardModel.Data calldata object) external view returns (address payable);

    /**
    * @notice Gets the 'confirm signature address' from the data set. Returns address(0) if none.
    */
    function getConfirmSigAddress(OutputGuardModel.Data calldata object) external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/src/utils/AddressPayable.sol

pragma solidity 0.5.11;

library AddressPayable {

    /**
     * @notice Converts an `address` into `address payable`
     * @dev Note that this is simply a type cast; the actual underlying value remains the same
     */
    function convert(address account) internal pure returns (address payable) {
        return address(uint160(account));
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/src/exits/payment/outputGuardHandlers/PaymentOutputGuardHandler.sol

pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;



contract PaymentOutputGuardHandler is IOutputGuardHandler {
    function isValid(OutputGuardModel.Data memory data) public view returns (bool) {
        require(data.preimage.length == 0, "Pre-image of the output guard should be empty");
        return true;
    }

    function getExitTarget(OutputGuardModel.Data calldata data) external view returns (address payable) {
        return AddressPayable.convert(address(uint160(data.guard)));
    }

    function getConfirmSigAddress(OutputGuardModel.Data calldata /*data*/)
        external
        view
        returns (address)
    {
        // MoreVP transaction, no need to have confirm sig.
        return address(0);
    }
}
