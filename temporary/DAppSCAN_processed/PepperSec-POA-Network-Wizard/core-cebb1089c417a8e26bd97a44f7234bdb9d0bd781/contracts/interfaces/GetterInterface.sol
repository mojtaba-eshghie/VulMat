// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/contracts/interfaces/GetterInterface.sol

pragma solidity ^0.4.23;

interface GetterInterface {
  function read(bytes32 exec_id, bytes32 location) external view returns (bytes32 data);
  function readMulti(bytes32 exec_id, bytes32[] locations) external view returns (bytes32[] data);
}
