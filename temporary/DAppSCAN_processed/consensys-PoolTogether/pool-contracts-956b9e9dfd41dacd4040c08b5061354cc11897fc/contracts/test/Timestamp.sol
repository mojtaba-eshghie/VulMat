// File: ../sc_datasets/DAppSCAN/consensys-PoolTogether/pool-contracts-956b9e9dfd41dacd4040c08b5061354cc11897fc/contracts/test/Timestamp.sol

pragma solidity >=0.6.0 <0.7.0;

/* solium-disable security/no-block-members */
contract Timestamp {
  function blockTime() public view returns (uint256) {
    return block.timestamp;
  }
}
