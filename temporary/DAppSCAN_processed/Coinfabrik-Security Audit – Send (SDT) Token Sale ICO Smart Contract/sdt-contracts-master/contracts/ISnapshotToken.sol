// File: ../sc_datasets/DAppSCAN/Coinfabrik-Security Audit – Send (SDT) Token Sale ICO Smart Contract/sdt-contracts-master/contracts/ISnapshotToken.sol

pragma solidity ^0.4.18;


/**
 * @title Snapshot Token
 *
 * @dev Snapshot Token interface
 * @dev https://send.sd/token
 */
interface ISnapshotToken {
  function requestSnapshots(uint256 _blockNumber) public;
  function takeSnapshot(address _owner) public returns(uint256);
}
