// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/interfaces/IAccessControlRegistryUser.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAccessControlRegistryUser {
    function accessControlRegistry() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/interfaces/IAccessControlRegistryAdminned.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAccessControlRegistryAdminned is IAccessControlRegistryUser {
    function adminRoleDescription() external view returns (string memory);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/utils/interfaces/IRegistryRolesWithManager.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IRegistryRolesWithManager is IAccessControlRegistryAdminned {
    // solhint-disable-next-line func-name-mixedcase
    function REGISTRAR_ROLE_DESCRIPTION() external view returns (string memory);

    function registrarRole() external view returns (bytes32);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/utils/interfaces/IAddressRegistry.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAddressRegistry is IRegistryRolesWithManager {
    function tryReadRegisteredAddress(bytes32 id)
        external
        view
        returns (bool success, address address_);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/monetization/interfaces/IRequesterAuthorizerRegistry.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IRequesterAuthorizerRegistry is IAddressRegistry {
    event RegisteredChainRequesterAuthorizer(
        uint256 chainId,
        address requesterAuthorizer,
        address sender
    );

    function registerChainRequesterAuthorizer(
        uint256 chainId,
        address requesterAuthorizer
    ) external;

    function tryReadChainRequesterAuthorizer(uint256 chainId)
        external
        view
        returns (bool success, address requesterAuthorizer);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/monetization/interfaces/IRequesterAuthorizerRegistryUser.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IRequesterAuthorizerRegistryUser {
    function requesterAuthorizerRegistry() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/monetization/RequesterAuthorizerRegistryUser.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


/// @title Contract that should be inherited by contracts that will interact
/// with RequesterAuthorizerRegistry
contract RequesterAuthorizerRegistryUser is IRequesterAuthorizerRegistryUser {
    /// @notice RequesterAuthorizerRegistry contract address
    address public immutable override requesterAuthorizerRegistry;

    /// @param _requesterAuthorizerRegistry RequesterAuthorizerRegistry contract address
    constructor(address _requesterAuthorizerRegistry) {
        require(
            _requesterAuthorizerRegistry != address(0),
            "Authorizer registry address zero"
        );
        requesterAuthorizerRegistry = _requesterAuthorizerRegistry;
    }
}
