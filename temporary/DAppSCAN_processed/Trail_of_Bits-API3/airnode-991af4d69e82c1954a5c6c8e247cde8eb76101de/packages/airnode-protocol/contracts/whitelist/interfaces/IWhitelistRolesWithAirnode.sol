// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol/contracts/whitelist/interfaces/IWhitelistRoles.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IWhitelistRoles {
    function adminRoleDescription() external view returns (string memory);

    // solhint-disable-next-line func-name-mixedcase
    function WHITELIST_EXPIRATION_EXTENDER_ROLE_DESCRIPTION()
        external
        view
        returns (string memory);

    // solhint-disable-next-line func-name-mixedcase
    function WHITELIST_EXPIRATION_SETTER_ROLE_DESCRIPTION()
        external
        view
        returns (string memory);

    // solhint-disable-next-line func-name-mixedcase
    function INDEFINITE_WHITELISTER_ROLE_DESCRIPTION()
        external
        view
        returns (string memory);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol/contracts/whitelist/interfaces/IWhitelistRolesWithAirnode.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IWhitelistRolesWithAirnode is IWhitelistRoles {
    function deriveAdminRole(address airnode)
        external
        view
        returns (bytes32 role);

    function deriveWhitelistExpirationExtenderRole(address airnode)
        external
        view
        returns (bytes32 role);

    function deriveWhitelistExpirationSetterRole(address airnode)
        external
        view
        returns (bytes32 role);

    function deriveIndefiniteWhitelisterRole(address airnode)
        external
        view
        returns (bytes32 role);
}
