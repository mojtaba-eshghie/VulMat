// File: ../sc_datasets/DAppSCAN/openzeppelin-PoolTogether/pooltogether-pool-contracts-78ac6863f4616269f7d04a0ddd1d60bdfc454937/contracts/test/maker/MockJoinLike.sol

pragma solidity ^0.5.12;

// import { GemLike, JoinLike } from "scd-mcd-migration/src/Interfaces.sol";

contract MockJoinLike {
  address public gem;
  address public dai;

  constructor(
    address _gem,
    address _dai
  ) public {
    gem = _gem;
    dai = _dai;
  }
}
