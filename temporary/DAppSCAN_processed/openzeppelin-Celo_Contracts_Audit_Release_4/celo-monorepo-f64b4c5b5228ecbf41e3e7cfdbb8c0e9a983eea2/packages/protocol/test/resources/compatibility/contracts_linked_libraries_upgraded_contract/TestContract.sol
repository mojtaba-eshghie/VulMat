// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/test/resources/compatibility/contracts_linked_libraries_upgraded_contract/LinkedLibrary1.sol

pragma solidity ^0.5.3;

library LinkedLibrary1 {
  struct Struct {
    uint256 field;
  }

  function get(Struct storage s) public view returns (uint256) {
    return s.field;
  }

  function increase(Struct storage s) public {
    s.field += 1;
  }
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/test/resources/compatibility/contracts_linked_libraries_upgraded_contract/LinkedLibrary3.sol

pragma solidity ^0.5.3;

library LinkedLibrary3 {
  struct Struct {
    uint256 field;
  }

  function get(Struct storage s) public view returns (uint256) {
    return s.field;
  }

  function increase(Struct storage s) public {
    if (s.field == 0) {
      s.field = 1;
    }
    s.field *= 2;
  }
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/test/resources/compatibility/contracts_linked_libraries_upgraded_contract/LinkedLibrary2.sol

pragma solidity ^0.5.3;

library LinkedLibrary2 {
  using LinkedLibrary3 for LinkedLibrary3.Struct;

  struct Struct {
    LinkedLibrary3.Struct s;
  }

  function get(Struct storage s) public view returns (uint256) {
    return s.s.get();
  }

  function increase(Struct storage s) public {
    s.s.increase();
  }
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-Celo_Contracts_Audit_Release_4/celo-monorepo-f64b4c5b5228ecbf41e3e7cfdbb8c0e9a983eea2/packages/protocol/test/resources/compatibility/contracts_linked_libraries_upgraded_contract/TestContract.sol

pragma solidity ^0.5.3;


contract TestContract {
  using LinkedLibrary1 for LinkedLibrary1.Struct;
  using LinkedLibrary2 for LinkedLibrary2.Struct;

  LinkedLibrary1.Struct s1;
  LinkedLibrary2.Struct s2;

  function get1() external view returns (uint256) {
    return s1.get() + 1;
  }

  function get2() external view returns (uint256) {
    return s2.get();
  }

  function doIncreases() external {
    s1.increase();
    s2.increase();
  }
}
