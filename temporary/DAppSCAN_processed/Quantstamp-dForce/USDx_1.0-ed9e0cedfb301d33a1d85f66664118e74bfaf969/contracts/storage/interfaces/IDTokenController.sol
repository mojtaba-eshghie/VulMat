// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/storage/interfaces/IDTokenController.sol

pragma solidity ^0.5.2;

interface IDTokenController {
  function getDToken(address _token) external view returns (address);
}
