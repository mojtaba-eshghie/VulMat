// File: ../sc_datasets/DAppSCAN/consensys-The_LAO/moloch-4bc443f4dad60279b47978fc6987bb978d3dfc58/v1_contracts/gnosis-safe/common/SelfAuthorized.sol

pragma solidity ^0.5.0;


/// @title SelfAuthorized - authorizes current contract to perform actions
/// @author Richard Meissner - <richard@gnosis.pm>
contract SelfAuthorized {
    modifier authorized() {
        require(msg.sender == address(this), "Method can only be called from this contract");
        _;
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-The_LAO/moloch-4bc443f4dad60279b47978fc6987bb978d3dfc58/v1_contracts/gnosis-safe/common/MasterCopy.sol

pragma solidity ^0.5.0;

/// @title MasterCopy - Base for master copy contracts (should always be first super contract)
/// @author Richard Meissner - <richard@gnosis.pm>
contract MasterCopy is SelfAuthorized {
  // masterCopy always needs to be first declared variable, to ensure that it is at the same location as in the Proxy contract.
  // It should also always be ensured that the address is stored alone (uses a full word)
    address masterCopy;

  /// @dev Allows to upgrade the contract. This can only be done via a Safe transaction.
  /// @param _masterCopy New contract address.
    function changeMasterCopy(address _masterCopy)
        public
        authorized
    {
        // Master copy address cannot be null.
        require(_masterCopy != address(0), "Invalid master copy address provided");
        masterCopy = _masterCopy;
    }
}
