// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/src/framework/utils/Quarantine.sol

pragma solidity 0.5.11;

/**
 * @notice Provides a way to quarantine (disable) contracts for a specified period of time
 * @dev The immunitiesRemaining member allows deployment to the platform with some
 * pre-verified contracts that don't get quarantined
 */
library Quarantine {
    struct Data {
        mapping(address => uint256) store;
        uint256 quarantinePeriod;
        uint256 immunitiesRemaining;
    }

    /**
     * @notice Checks whether a contract is quarantined
     */
    function isQuarantined(Data storage _self, address _contractAddress) internal view returns (bool) {
        return block.timestamp < _self.store[_contractAddress];
    }

    /**
     * @notice Places a contract into quarantine
     * @param _contractAddress The address of the contract
     */
    function quarantine(Data storage _self, address _contractAddress) internal {
        require(_contractAddress != address(0), "An empty address cannot be quarantined");
        require(_self.store[_contractAddress] == 0, "The contract is already quarantined");

        if (_self.immunitiesRemaining == 0) {
            _self.store[_contractAddress] = block.timestamp + _self.quarantinePeriod;
        } else {
            _self.immunitiesRemaining--;
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Omisego Plasma MVP/plasma-contracts-2.0.0/plasma_framework/contracts/mocks/utils/QuarantineMock.sol

pragma solidity 0.5.11;

contract QuarantineMock {
    using Quarantine for Quarantine.Data;
    Quarantine.Data internal _quarantine;

    constructor(uint256 _period, uint256 _initialImmuneCount)
        public
    {
        _quarantine.quarantinePeriod = _period;
        _quarantine.immunitiesRemaining = _initialImmuneCount;
    }

    function quarantineContract(address _contractAddress) public {
        _quarantine.quarantine(_contractAddress);
    }

    function isQuarantined(address _contractAddress) public view returns (bool) {
        return _quarantine.isQuarantined(_contractAddress);
    }
}
