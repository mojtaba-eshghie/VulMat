// File: ../sc_datasets/DAppSCAN/consensys-The_LAO/moloch-4bc443f4dad60279b47978fc6987bb978d3dfc58/v1_contracts/gnosis-safe/common/SelfAuthorized.sol

pragma solidity ^0.5.0;


/// @title SelfAuthorized - authorizes current contract to perform actions
/// @author Richard Meissner - <richard@gnosis.pm>
contract SelfAuthorized {
    modifier authorized() {
        require(msg.sender == address(this), "Method can only be called from this contract");
        _;
    }
}
