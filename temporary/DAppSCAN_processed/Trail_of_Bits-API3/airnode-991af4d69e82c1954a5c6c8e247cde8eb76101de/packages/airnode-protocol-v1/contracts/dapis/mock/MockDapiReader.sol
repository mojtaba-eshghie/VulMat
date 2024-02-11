// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/dapis/interfaces/IDapiReader.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IDapiReader {
    function dapiServer() external view returns (address);
}

/// @dev We use the part of the interface that will persist between
/// DapiServer versions
interface IBaseDapiServer {
    function readWithDataPointId(bytes32 dataPointId)
        external
        view
        returns (int224 value, uint32 timestamp);

    function readWithName(bytes32 name)
        external
        view
        returns (int224 value, uint32 timestamp);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/dapis/DapiReader.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/// @title Contract to be inherited to read from a DapiServer contract
contract DapiReader is IDapiReader {
    /// @notice DapiServer contract address
    address public override dapiServer;

    /// @param _dapiServer DapiServer contract address
    constructor(address _dapiServer) {
        setDapiServer(_dapiServer);
    }

    /// @notice Called internally to update the DapiServer contract address
    /// @dev Inheriting contracts are highly recommended to expose this
    /// functionality to be able to migrate between DapiServer contracts.
    /// Otherwise, when the DapiServer goes out of service for any reason,
    /// the dependent contract will go defunct.
    /// Since this is a critical action, it needs to be protected behind
    /// mechanisms such as decentralized governance, timelocks, etc.
    /// @param _dapiServer DapiServer contract address
    function setDapiServer(address _dapiServer) internal {
        require(_dapiServer != address(0), "dAPI server address zero");
        dapiServer = _dapiServer;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/dapis/mock/MockDapiReader.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract MockDapiReader is DapiReader {
    constructor(address _dapiServer) DapiReader(_dapiServer) {}

    function exposedSetDapiServer(address _dapiServer) external {
        setDapiServer(_dapiServer);
    }

    function exposedReadWithDataPointId(bytes32 dataPointId)
        external
        view
        returns (int224 value, uint32 timestamp)
    {
        return IBaseDapiServer(dapiServer).readWithDataPointId(dataPointId);
    }

    function exposedReadWithName(bytes32 name)
        external
        view
        returns (int224 value, uint32 timestamp)
    {
        return IBaseDapiServer(dapiServer).readWithName(name);
    }
}
