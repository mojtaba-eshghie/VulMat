// File: ../sc_datasets/DAppSCAN/PeckShield-IronLend/iron-lend-f9a669850885895215579e3c2ae8d7124f0ef5c8/src/controller/IronDelegateControllerAdminStorage.sol

pragma solidity ^0.5.16;


contract IronDelegateControllerAdminStorage {
    /**
    * @notice Administrator for this contract
    */
    address public admin;

    /**
    * @notice Pending administrator for this contract
    */
    address public pendingAdmin;

    /**
    * @notice Active brains of IronDelegateController
    */
    address public ironControllerImplementation;

    /**
    * @notice Pending brains of IronDelegateController
    */
    address public pendingIronControllerImplementation;
}
