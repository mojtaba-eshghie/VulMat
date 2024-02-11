// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-aeb11d986e3b9280215b748491eeece8f4e6ff02/contracts/MinimalProxyFactory.sol

pragma solidity ^0.5.16;

// https://docs.synthetix.io/contracts/source/contracts/minimalproxyfactory
contract MinimalProxyFactory {
    function _cloneAsMinimalProxy(address _base, string memory _revertMsg) internal returns (address clone) {
        bytes memory createData = _generateMinimalProxyCreateData(_base);

        assembly {
            clone := create(
                0, // no value
                add(createData, 0x20), // data
                55 // data is always 55 bytes (10 constructor + 45 code)
            )
        }

        // If CREATE fails for some reason, address(0) is returned
        require(clone != address(0), _revertMsg);
    }

    function _generateMinimalProxyCreateData(address _base) internal pure returns (bytes memory) {
        return
            abi.encodePacked(
                //---- constructor -----
                bytes10(0x3d602d80600a3d3981f3),
                //---- proxy code -----
                bytes10(0x363d3d373d3d3d363d73),
                _base,
                bytes15(0x5af43d82803e903d91602b57fd5bf3)
            );
    }
}

// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-aeb11d986e3b9280215b748491eeece8f4e6ff02/contracts/test-helpers/TestableMinimalProxyFactory.sol

pragma solidity ^0.5.16;

contract TestableMinimalProxyFactory is MinimalProxyFactory {
    function cloneAsMinimalProxy(address _base, string calldata _revertMsg) external returns (address clone) {
        clone = _cloneAsMinimalProxy(_base, _revertMsg);
        emit CloneDeployed(clone, _base);

        return clone;
    }

    function generateMinimalProxyCreateData(address _base) external pure returns (bytes memory) {
        return _generateMinimalProxyCreateData(_base);
    }

    event CloneDeployed(address clone, address base);
}
