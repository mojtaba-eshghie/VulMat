// File: ../sc_datasets/DAppSCAN/Quantstamp-API3/api3-dao-283e6ba8bbf45a8d51bbb6fc166ca3d4673a0911/packages/api3-voting/contracts/interfaces/IApi3Pool.sol

//SPDX-License-Identifier: MIT
pragma solidity 0.4.24;

interface IApi3Pool {
    function EPOCH_LENGTH()
        external
        view
        returns(uint256);

    function proposalVotingPowerThreshold()
        external
        view
        returns(uint256);

    function balanceOfAt(
        address userAddress,
        uint256 _block
        )
        external
        view
        returns(uint256);

    function totalSupplyOneBlockAgo()
        external
        view
        returns(uint256);

    function updateLastVoteSnapshotBlock(uint256 snapshotBlock)
        external;
}
