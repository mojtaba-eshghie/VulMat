// File: ../sc_datasets/DAppSCAN/Coinfabrik-Polymath Core Audit/polymath-core-dev-3.1.0/contracts/modules/TransferManager/RPTM/RestrictedPartialSaleTMStorage.sol

pragma solidity ^0.5.8;

contract RestrictedPartialSaleTMStorage {

    // permission definition
    bytes32 internal constant OPERATOR = "OPERATOR";

    address[] exemptAddresses;

    mapping(address => uint256) exemptIndex;

}
