// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/contracts/identity/interfaces/IEscrow.sol

pragma solidity ^0.5.13;

interface IEscrow {
  function transfer(
    bytes32 identifier,
    address token,
    uint256 value,
    uint256 expirySeconds,
    address paymentId,
    uint256 minAttestations
  ) external returns (bool);

  function withdraw(address paymentID, uint8 v, bytes32 r, bytes32 s) external returns (bool);

  function revoke(address paymentID) external returns (bool);

  function getReceivedPaymentIds(bytes32 identifier) external view returns (address[] memory);

  function getSentPaymentIds(address sender) external view returns (address[] memory);
}
