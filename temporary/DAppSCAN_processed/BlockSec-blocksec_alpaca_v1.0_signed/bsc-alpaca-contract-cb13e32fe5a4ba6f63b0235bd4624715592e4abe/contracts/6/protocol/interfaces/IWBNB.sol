// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_alpaca_v1.0_signed/bsc-alpaca-contract-cb13e32fe5a4ba6f63b0235bd4624715592e4abe/contracts/6/protocol/interfaces/IWBNB.sol

pragma solidity >=0.5.0;

interface IWBNB {
  function deposit() external payable;

  function transfer(address to, uint256 value) external returns (bool);

  function withdraw(uint256) external;
}
