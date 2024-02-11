// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/contracts/common/interfaces/IMetaTransactionWallet.sol

pragma solidity ^0.5.13;

interface IMetaTransactionWallet {
  function setEip712DomainSeparator() external;
  function executeMetaTransaction(address, uint256, bytes calldata, uint8, bytes32, bytes32)
    external
    returns (bytes memory);
  function executeTransaction(address, uint256, bytes calldata) external returns (bytes memory);
  function executeTransactions(
    address[] calldata,
    uint256[] calldata,
    bytes calldata,
    uint256[] calldata
  ) external returns (bytes memory, uint256[] memory);

  // view functions
  function getMetaTransactionDigest(address, uint256, bytes calldata, uint256)
    external
    view
    returns (bytes32);
  function getMetaTransactionSigner(
    address,
    uint256,
    bytes calldata,
    uint256,
    uint8,
    bytes32,
    bytes32
  ) external view returns (address);

  //only owner
  function setSigner(address) external;
}
