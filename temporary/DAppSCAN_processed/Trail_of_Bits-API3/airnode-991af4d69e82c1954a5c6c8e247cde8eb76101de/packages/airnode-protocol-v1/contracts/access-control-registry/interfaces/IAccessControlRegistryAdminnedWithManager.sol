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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/interfaces/IAccessControlRegistryAdminnedWithManager.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAccessControlRegistryAdminnedWithManager is
    IAccessControlRegistryAdminned
{
    function manager() external view returns (address);

    function adminRole() external view returns (bytes32);
}
