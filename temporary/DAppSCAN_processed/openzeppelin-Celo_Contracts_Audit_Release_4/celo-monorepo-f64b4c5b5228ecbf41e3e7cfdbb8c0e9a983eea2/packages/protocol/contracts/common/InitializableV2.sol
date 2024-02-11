// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/contracts/common/InitializableV2.sol

pragma solidity ^0.5.13;

contract InitializableV2 {
  bool public initialized;

  constructor(bool testingDeployment) public {
    if (!testingDeployment) {
      _initialize();
    }
  }

  modifier initializer() {
    require(!initialized, "contract already initialized");
    _initialize();
    _;
  }

  function _initialize() private {
    initialized = true;
  }
}
