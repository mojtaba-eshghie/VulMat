// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-golem/golem-contracts-62a1e0dab3baf8e9bff79b653dffa7df5f2d10a0/contracts/ReceivingContract.sol

// SWC-Outdated Compiler Version: L2
pragma solidity ^0.4.19;

/// Contracts implementing this interface are compatible with
/// GolemNetworkTokenBatching's transferAndCall method
contract ReceivingContract {
    function onTokenReceived(address _from, uint _value, bytes _data) public;
}
