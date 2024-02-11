// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/contracts/governance/test/TestTransactions.sol

pragma solidity ^0.5.13;

/**
 * @title A contract for transaction testing.
 */
contract TestTransactions {
  mapping(uint256 => uint256) public values;

  function getValue(uint256 key) external view returns (uint256) {
    return values[key];
  }

  function setValue(uint256 key, uint256 value, bool shouldSucceed) external {
    require(shouldSucceed);
    values[key] = value;
  }
}
