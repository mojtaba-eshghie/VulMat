// File: ../sc_datasets/DAppSCAN/Solidified-Aztec Lido Bridge/aztec-connect-bridges-d5aca13d4d0a17b21eeddf77f49f4c6613461fb0/src/bridges/element/interfaces/IDeploymentValidator.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

interface IDeploymentValidator {
    function validateWPAddress(address wrappedPosition) external;

    function validatePoolAddress(address pool) external;

    function validateAddresses(address wrappedPosition, address pool) external;

    function checkWPValidation(address wrappedPosition)
        external
        view
        returns (bool);

    function checkPoolValidation(address pool) external view returns (bool);

    function checkPairValidation(address wrappedPosition, address pool)
        external
        view
        returns (bool);
}
