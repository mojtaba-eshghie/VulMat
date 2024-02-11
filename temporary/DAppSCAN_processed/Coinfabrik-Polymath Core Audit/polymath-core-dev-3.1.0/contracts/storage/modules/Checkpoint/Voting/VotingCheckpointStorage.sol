// File: ../sc_datasets/DAppSCAN/Coinfabrik-Polymath Core Audit/polymath-core-dev-3.1.0/contracts/storage/modules/Checkpoint/Voting/VotingCheckpointStorage.sol

pragma solidity 0.5.8;

contract VotingCheckpointStorage {

    mapping(address => uint256) defaultExemptIndex;
    address[] defaultExemptedVoters;

}
