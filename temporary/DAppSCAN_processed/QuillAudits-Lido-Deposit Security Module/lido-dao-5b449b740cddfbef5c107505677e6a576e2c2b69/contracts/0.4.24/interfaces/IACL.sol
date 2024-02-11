// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Deposit Security Module/lido-dao-5b449b740cddfbef5c107505677e6a576e2c2b69/contracts/0.4.24/interfaces/IACL.sol

/*
 * SPDX-License-Identifier:    MIT
 */

pragma solidity ^0.4.24;


interface IACL {
    function initialize(address permissionsCreator) external;

    // TODO: this should be external
    // See https://github.com/ethereum/solidity/issues/4832
    function hasPermission(address who, address where, bytes32 what, bytes how) public view returns (bool);
}
