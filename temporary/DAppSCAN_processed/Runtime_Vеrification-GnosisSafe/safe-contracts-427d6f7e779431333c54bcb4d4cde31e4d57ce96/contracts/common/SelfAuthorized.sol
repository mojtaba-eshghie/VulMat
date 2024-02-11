// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-GnosisSafe/safe-contracts-427d6f7e779431333c54bcb4d4cde31e4d57ce96/contracts/common/SelfAuthorized.sol

pragma solidity ^0.5.0;


/// @title SelfAuthorized - authorizes current contract to perform actions
/// @author Richard Meissner - <richard@gnosis.pm>
contract SelfAuthorized {
    modifier authorized() {
        require(msg.sender == address(this), "Method can only be called from this contract");
        _;
    }
}
