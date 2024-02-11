// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/whitelist/Whitelist.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/// @title Contract that implements temporary and permanent whitelists for
/// multiple services identified with a hash
/// @notice This contract implements two kinds of whitelisting:
///   (1) Temporary, ends when the expiration timestamp is in the past
///   (2) Indefinite, ends when the indefinite whitelist count is zero
/// Multiple senders can indefinitely whitelist/unwhitelist independently. The
/// user will be considered whitelisted as long as there is at least one active
/// indefinite whitelisting.
/// @dev The interface of this contract is not implemented. It should be
/// inherited and its functions should be exposed with a sort of an
/// authorization scheme.
contract Whitelist {
    struct WhitelistStatus {
        uint64 expirationTimestamp;
        uint192 indefiniteWhitelistCount;
    }

    mapping(bytes32 => mapping(address => WhitelistStatus))
        internal serviceIdToUserToWhitelistStatus;

    mapping(bytes32 => mapping(address => mapping(address => bool)))
        internal serviceIdToUserToSetterToIndefiniteWhitelistStatus;

    /// @notice Extends the expiration of the temporary whitelist of the user
    /// for the service
    /// @param serviceId Service ID
    /// @param user User address
    /// @param expirationTimestamp Timestamp at which the temporary whitelist
    /// will expire
    function _extendWhitelistExpiration(
        bytes32 serviceId,
        address user,
        uint64 expirationTimestamp
    ) internal {
        require(
            expirationTimestamp >
                serviceIdToUserToWhitelistStatus[serviceId][user]
                    .expirationTimestamp,
            "Does not extend expiration"
        );
        serviceIdToUserToWhitelistStatus[serviceId][user]
            .expirationTimestamp = expirationTimestamp;
    }

    /// @notice Sets the expiration of the temporary whitelist of the user for
    /// the service
    /// @dev Unlike `extendWhitelistExpiration()`, this can hasten expiration
    /// @param serviceId Service ID
    /// @param user User address
    /// @param expirationTimestamp Timestamp at which the temporary whitelist
    /// will expire
    function _setWhitelistExpiration(
        bytes32 serviceId,
        address user,
        uint64 expirationTimestamp
    ) internal {
        serviceIdToUserToWhitelistStatus[serviceId][user]
            .expirationTimestamp = expirationTimestamp;
    }

    /// @notice Sets the indefinite whitelist status of the user for the
    /// service
    /// @dev As long as at least there is at least one account that has set the
    /// indefinite whitelist status of the user for the service as true, the
    /// user will be considered whitelisted
    /// @param serviceId Service ID
    /// @param user User address
    /// @param status Indefinite whitelist status
    function _setIndefiniteWhitelistStatus(
        bytes32 serviceId,
        address user,
        bool status
    ) internal returns (uint192 indefiniteWhitelistCount) {
        indefiniteWhitelistCount = serviceIdToUserToWhitelistStatus[serviceId][
            user
        ].indefiniteWhitelistCount;
        if (
            status &&
            !serviceIdToUserToSetterToIndefiniteWhitelistStatus[serviceId][
                user
            ][msg.sender]
        ) {
            serviceIdToUserToSetterToIndefiniteWhitelistStatus[serviceId][user][
                msg.sender
            ] = true;
            indefiniteWhitelistCount++;
            serviceIdToUserToWhitelistStatus[serviceId][user]
                .indefiniteWhitelistCount = indefiniteWhitelistCount;
        } else if (
            !status &&
            serviceIdToUserToSetterToIndefiniteWhitelistStatus[serviceId][user][
                msg.sender
            ]
        ) {
            serviceIdToUserToSetterToIndefiniteWhitelistStatus[serviceId][user][
                msg.sender
            ] = false;
            indefiniteWhitelistCount--;
            serviceIdToUserToWhitelistStatus[serviceId][user]
                .indefiniteWhitelistCount = indefiniteWhitelistCount;
        }
    }

    /// @notice Revokes the indefinite whitelist status granted to the user for
    /// the service by a specific account
    /// @param serviceId Service ID
    /// @param user User address
    /// @param setter Setter of the indefinite whitelist status
    function _revokeIndefiniteWhitelistStatus(
        bytes32 serviceId,
        address user,
        address setter
    ) internal returns (bool revoked, uint192 indefiniteWhitelistCount) {
        indefiniteWhitelistCount = serviceIdToUserToWhitelistStatus[serviceId][
            user
        ].indefiniteWhitelistCount;
        if (
            serviceIdToUserToSetterToIndefiniteWhitelistStatus[serviceId][user][
                setter
            ]
        ) {
            serviceIdToUserToSetterToIndefiniteWhitelistStatus[serviceId][user][
                setter
            ] = false;
            indefiniteWhitelistCount--;
            serviceIdToUserToWhitelistStatus[serviceId][user]
                .indefiniteWhitelistCount = indefiniteWhitelistCount;
            revoked = true;
        }
    }

    /// @notice Returns if the user is whitelised to use the service
    /// @param serviceId Service ID
    /// @param user User address
    /// @return isWhitelisted If the user is whitelisted
    function userIsWhitelisted(bytes32 serviceId, address user)
        internal
        view
        returns (bool isWhitelisted)
    {
        WhitelistStatus
            storage whitelistStatus = serviceIdToUserToWhitelistStatus[
                serviceId
            ][user];
        return
            whitelistStatus.indefiniteWhitelistCount > 0 ||
            whitelistStatus.expirationTimestamp > block.timestamp;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/whitelist/interfaces/IWhitelistRoles.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IWhitelistRoles {
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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/whitelist/WhitelistRoles.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/// @title Contract that implements generic AccessControlRegistry roles for a
/// whitelist contract
contract WhitelistRoles is IWhitelistRoles {
    // There are four roles implemented in this contract:
    // Root
    // └── (1) Admin (can grant and revoke the roles below)
    //     ├── (2) Whitelist expiration extender
    //     ├── (3) Whitelist expiration setter
    //     └── (4) Indefinite whitelister
    // Their IDs are derived from the descriptions below. Refer to
    // AccessControlRegistry for more information.
    // To clarify, the root role of the manager is the admin of (1), while (1)
    // is the admin of (2), (3) and (4). So (1) is more of a "contract admin",
    // while the `adminRole` used in AccessControl and AccessControlRegistry
    // refers to a more general adminship relationship between roles.

    /// @notice Whitelist expiration extender role description
    string
        public constant
        override WHITELIST_EXPIRATION_EXTENDER_ROLE_DESCRIPTION =
        "Whitelist expiration extender";

    /// @notice Whitelist expiration setter role description
    string
        public constant
        override WHITELIST_EXPIRATION_SETTER_ROLE_DESCRIPTION =
        "Whitelist expiration setter";

    /// @notice Indefinite whitelister role description

    string public constant override INDEFINITE_WHITELISTER_ROLE_DESCRIPTION =
        "Indefinite whitelister";

    bytes32
        internal constant WHITELIST_EXPIRATION_EXTENDER_ROLE_DESCRIPTION_HASH =
        keccak256(
            abi.encodePacked(WHITELIST_EXPIRATION_EXTENDER_ROLE_DESCRIPTION)
        );

    bytes32
        internal constant WHITELIST_EXPIRATION_SETTER_ROLE_DESCRIPTION_HASH =
        keccak256(
            abi.encodePacked(WHITELIST_EXPIRATION_SETTER_ROLE_DESCRIPTION)
        );

    bytes32 internal constant INDEFINITE_WHITELISTER_ROLE_DESCRIPTION_HASH =
        keccak256(abi.encodePacked(INDEFINITE_WHITELISTER_ROLE_DESCRIPTION));
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/RoleDeriver.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/// @title Contract that implements the AccessControlRegistry role derivation
/// logic
/// @notice If a contract interfaces with AccessControlRegistry and needs to
/// derive roles, it should inherit this contract instead of re-implementing
/// the logic
contract RoleDeriver {
    /// @notice Derives the root role of the manager
    /// @param manager Manager address
    /// @return rootRole Root role
    function _deriveRootRole(address manager)
        internal
        pure
        returns (bytes32 rootRole)
    {
        rootRole = keccak256(abi.encodePacked(manager));
    }

    /// @notice Derives the role using its admin role and description
    /// @dev This implies that roles adminned by the same role cannot have the
    /// same description
    /// @param adminRole Admin role
    /// @param description Human-readable description of the role
    /// @return role Role
    function _deriveRole(bytes32 adminRole, string memory description)
        internal
        pure
        returns (bytes32 role)
    {
        role = _deriveRole(adminRole, keccak256(abi.encodePacked(description)));
    }

    /// @notice Derives the role using its admin role and description hash
    /// @dev This implies that roles adminned by the same role cannot have the
    /// same description
    /// @param adminRole Admin role
    /// @param descriptionHash Hash of the human-readable description of the
    /// role
    /// @return role Role
    function _deriveRole(bytes32 adminRole, bytes32 descriptionHash)
        internal
        pure
        returns (bytes32 role)
    {
        role = keccak256(abi.encodePacked(adminRole, descriptionHash));
    }
}

// File: @openzeppelin/contracts/access/IAccessControl.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (access/IAccessControl.sol)

pragma solidity ^0.8.0;

/**
 * @dev External interface of AccessControl declared to support ERC165 detection.
 */
interface IAccessControl {
    /**
     * @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
     *
     * `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
     * {RoleAdminChanged} not being emitted signaling this.
     *
     * _Available since v3.1._
     */
    event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);

    /**
     * @dev Emitted when `account` is granted `role`.
     *
     * `sender` is the account that originated the contract call, an admin role
     * bearer except when using {AccessControl-_setupRole}.
     */
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Emitted when `account` is revoked `role`.
     *
     * `sender` is the account that originated the contract call:
     *   - if using `revokeRole`, it is the admin role bearer
     *   - if using `renounceRole`, it is the role bearer (i.e. `account`)
     */
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) external view returns (bool);

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {AccessControl-_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function grantRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function revokeRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been granted `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `account`.
     */
    function renounceRole(bytes32 role, address account) external;
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/interfaces/IAccessControlRegistry.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAccessControlRegistry is IAccessControl {
    event InitializedManager(bytes32 indexed rootRole, address indexed manager);

    event InitializedRole(
        bytes32 indexed role,
        bytes32 indexed adminRole,
        string description,
        address sender
    );

    function initializeManager(address manager) external;

    function initializeRoleAndGrantToSender(
        bytes32 adminRole,
        string calldata description
    ) external returns (bytes32 role);

    function deriveRootRole(address manager)
        external
        pure
        returns (bytes32 rootRole);

    function deriveRole(bytes32 adminRole, string calldata description)
        external
        pure
        returns (bytes32 role);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/interfaces/IAccessControlRegistryUser.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAccessControlRegistryUser {
    function accessControlRegistry() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/AccessControlRegistryUser.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


/// @title Contract that should be inherited by contracts that will interact
/// with AccessControlRegistry
contract AccessControlRegistryUser is IAccessControlRegistryUser {
    /// @notice AccessControlRegistry contract address
    address public immutable override accessControlRegistry;

    /// @param _accessControlRegistry AccessControlRegistry contract address
    constructor(address _accessControlRegistry) {
        require(_accessControlRegistry != address(0), "ACR address zero");
        accessControlRegistry = _accessControlRegistry;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/interfaces/IAccessControlRegistryAdminned.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAccessControlRegistryAdminned is IAccessControlRegistryUser {
    function adminRoleDescription() external view returns (string memory);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/AccessControlRegistryAdminned.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;



/// @title Contract that should be inherited by contracts whose adminship
/// functionality will be implemented using AccessControlRegistry
contract AccessControlRegistryAdminned is
    RoleDeriver,
    AccessControlRegistryUser,
    IAccessControlRegistryAdminned
{
    /// @notice Admin role description
    string public override adminRoleDescription;

    bytes32 internal immutable adminRoleDescriptionHash;

    /// @dev Contracts deployed with the same admin role descriptions will have
    /// the same roles, meaning that granting an account a role will authorize
    /// it in multiple contracts. Unless you want your deployed contract to
    /// share the role configuration of another contract, use a unique admin
    /// role description.
    /// @param _accessControlRegistry AccessControlRegistry contract address
    /// @param _adminRoleDescription Admin role description
    constructor(
        address _accessControlRegistry,
        string memory _adminRoleDescription
    ) AccessControlRegistryUser(_accessControlRegistry) {
        require(
            bytes(_adminRoleDescription).length > 0,
            "Admin role description empty"
        );
        adminRoleDescription = _adminRoleDescription;
        adminRoleDescriptionHash = keccak256(
            abi.encodePacked(_adminRoleDescription)
        );
    }

    /// @notice Derives the admin role for the specific manager address
    /// @param manager Manager address
    /// @return adminRole Admin role
    function _deriveAdminRole(address manager)
        internal
        view
        returns (bytes32 adminRole)
    {
        adminRole = _deriveRole(
            _deriveRootRole(manager),
            adminRoleDescriptionHash
        );
    }
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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/AccessControlRegistryAdminnedWithManager.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


/// @title Contract that should be inherited by contracts with manager whose
/// adminship functionality will be implemented using AccessControlRegistry
/// @notice The manager address here is expected to belong to an
/// AccessControlRegistry user that is a multisig/DAO
contract AccessControlRegistryAdminnedWithManager is
    AccessControlRegistryAdminned,
    IAccessControlRegistryAdminnedWithManager
{
    /// @notice Address of the manager that manages the related
    /// AccessControlRegistry roles
    /// @dev The mutability of the manager role can be implemented by
    /// designating an OwnableCallForwarder contract as the manager. The
    /// ownership of this contract can then be transferred, effectively
    /// transferring managership.
    address public immutable override manager;

    /// @notice Admin role
    /// @dev Since `manager` is immutable, so is `adminRole`
    bytes32 public immutable override adminRole;

    /// @param _accessControlRegistry AccessControlRegistry contract address
    /// @param _adminRoleDescription Admin role description
    /// @param _manager Manager address
    constructor(
        address _accessControlRegistry,
        string memory _adminRoleDescription,
        address _manager
    )
        AccessControlRegistryAdminned(
            _accessControlRegistry,
            _adminRoleDescription
        )
    {
        require(_manager != address(0), "Manager address zero");
        manager = _manager;
        adminRole = _deriveAdminRole(_manager);
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/whitelist/interfaces/IWhitelistRolesWithManager.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


interface IWhitelistRolesWithManager is
    IWhitelistRoles,
    IAccessControlRegistryAdminnedWithManager
{
    function whitelistExpirationExtenderRole() external view returns (bytes32);

    function whitelistExpirationSetterRole() external view returns (bytes32);

    function indefiniteWhitelisterRole() external view returns (bytes32);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/whitelist/WhitelistRolesWithManager.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;




/// @title Contract that implements AccessControlRegistry roles for a whitelist
/// contract controlled by a manager
contract WhitelistRolesWithManager is
    WhitelistRoles,
    AccessControlRegistryAdminnedWithManager,
    IWhitelistRolesWithManager
{
    // Since there will be a single manager, we can derive the roles beforehand

    /// @notice Whitelist expiration extender role
    bytes32 public immutable override whitelistExpirationExtenderRole;

    /// @notice Whitelist expiration setter role
    bytes32 public immutable override whitelistExpirationSetterRole;

    /// @notice Indefinite whitelister role
    bytes32 public immutable override indefiniteWhitelisterRole;

    /// @param _accessControlRegistry AccessControlRegistry contract address
    /// @param _adminRoleDescription Admin role description
    /// @param _manager Manager address
    constructor(
        address _accessControlRegistry,
        string memory _adminRoleDescription,
        address _manager
    )
        AccessControlRegistryAdminnedWithManager(
            _accessControlRegistry,
            _adminRoleDescription,
            _manager
        )
    {
        whitelistExpirationExtenderRole = _deriveRole(
            adminRole,
            WHITELIST_EXPIRATION_EXTENDER_ROLE_DESCRIPTION_HASH
        );
        whitelistExpirationSetterRole = _deriveRole(
            adminRole,
            WHITELIST_EXPIRATION_SETTER_ROLE_DESCRIPTION_HASH
        );
        indefiniteWhitelisterRole = _deriveRole(
            adminRole,
            INDEFINITE_WHITELISTER_ROLE_DESCRIPTION_HASH
        );
    }

    /// @dev Returns if the account has the whitelist expiration extender role
    /// or is the manager
    /// @param account Account address
    /// @return If the account has the whitelist extender role or is the
    /// manager
    function hasWhitelistExpirationExtenderRoleOrIsManager(address account)
        internal
        view
        returns (bool)
    {
        return
            manager == account ||
            IAccessControlRegistry(accessControlRegistry).hasRole(
                whitelistExpirationExtenderRole,
                account
            );
    }

    /// @dev Returns if the account has the whitelist expriation setter role or
    /// is the manager
    /// @param account Account address
    /// @return If the account has the whitelist setter role or is the
    /// manager
    function hasWhitelistExpirationSetterRoleOrIsManager(address account)
        internal
        view
        returns (bool)
    {
        return
            manager == account ||
            IAccessControlRegistry(accessControlRegistry).hasRole(
                whitelistExpirationSetterRole,
                account
            );
    }

    /// @dev Returns if the account has the indefinite whitelister role or is the
    /// manager
    /// @param account Account address
    /// @return If the account has the indefinite whitelister role or is the
    /// manager
    function hasIndefiniteWhitelisterRoleOrIsManager(address account)
        internal
        view
        returns (bool)
    {
        return
            manager == account ||
            IAccessControlRegistry(accessControlRegistry).hasRole(
                indefiniteWhitelisterRole,
                account
            );
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/whitelist/interfaces/IWhitelistWithManager.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IWhitelistWithManager is IWhitelistRolesWithManager {
    event ExtendedWhitelistExpiration(
        bytes32 indexed serviceId,
        address indexed user,
        address indexed sender,
        uint256 expiration
    );

    event SetWhitelistExpiration(
        bytes32 indexed serviceId,
        address indexed user,
        address indexed sender,
        uint256 expiration
    );

    event SetIndefiniteWhitelistStatus(
        bytes32 indexed serviceId,
        address indexed user,
        address indexed sender,
        bool status,
        uint192 indefiniteWhitelistCount
    );

    event RevokedIndefiniteWhitelistStatus(
        bytes32 indexed serviceId,
        address indexed user,
        address indexed setter,
        address sender,
        uint192 indefiniteWhitelistCount
    );

    function extendWhitelistExpiration(
        bytes32 serviceId,
        address user,
        uint64 expirationTimestamp
    ) external;

    function setWhitelistExpiration(
        bytes32 serviceId,
        address user,
        uint64 expirationTimestamp
    ) external;

    function setIndefiniteWhitelistStatus(
        bytes32 serviceId,
        address user,
        bool status
    ) external;

    function revokeIndefiniteWhitelistStatus(
        bytes32 serviceId,
        address user,
        address setter
    ) external;
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/whitelist/WhitelistWithManager.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;



/// @title Whitelist contract that is controlled by a manager
contract WhitelistWithManager is
    Whitelist,
    WhitelistRolesWithManager,
    IWhitelistWithManager
{
    /// @param _accessControlRegistry AccessControlRegistry contract address
    /// @param _adminRoleDescription Admin role description
    /// @param _manager Manager address
    constructor(
        address _accessControlRegistry,
        string memory _adminRoleDescription,
        address _manager
    )
        WhitelistRolesWithManager(
            _accessControlRegistry,
            _adminRoleDescription,
            _manager
        )
    {}

    /// @notice Extends the expiration of the temporary whitelist of `user` to
    /// be able to use the service with `serviceId` if the sender has the
    /// whitelist expiration extender role
    /// @param serviceId Service ID
    /// @param user User address
    /// @param expirationTimestamp Timestamp at which the temporary whitelist
    /// will expire
    function extendWhitelistExpiration(
        bytes32 serviceId,
        address user,
        uint64 expirationTimestamp
    ) external override {
        require(
            hasWhitelistExpirationExtenderRoleOrIsManager(msg.sender),
            "Cannot extend expiration"
        );
        require(serviceId != bytes32(0), "Service ID zero");
        require(user != address(0), "User address zero");
        _extendWhitelistExpiration(serviceId, user, expirationTimestamp);
        emit ExtendedWhitelistExpiration(
            serviceId,
            user,
            msg.sender,
            expirationTimestamp
        );
    }

    /// @notice Sets the expiration of the temporary whitelist of `user` to be
    /// able to use the service with `serviceId` if the sender has the
    /// whitelist expiration setter role
    /// @param serviceId Service ID
    /// @param user User address
    /// @param expirationTimestamp Timestamp at which the temporary whitelist
    /// will expire
    function setWhitelistExpiration(
        bytes32 serviceId,
        address user,
        uint64 expirationTimestamp
    ) external override {
        require(
            hasWhitelistExpirationSetterRoleOrIsManager(msg.sender),
            "Cannot set expiration"
        );
        require(serviceId != bytes32(0), "Service ID zero");
        require(user != address(0), "User address zero");
        _setWhitelistExpiration(serviceId, user, expirationTimestamp);
        emit SetWhitelistExpiration(
            serviceId,
            user,
            msg.sender,
            expirationTimestamp
        );
    }

    /// @notice Sets the indefinite whitelist status of `user` to be able to
    /// use the service with `serviceId` if the sender has the indefinite
    /// whitelister role
    /// @param serviceId Service ID
    /// @param user User address
    /// @param status Indefinite whitelist status
    function setIndefiniteWhitelistStatus(
        bytes32 serviceId,
        address user,
        bool status
    ) external override {
        require(
            hasIndefiniteWhitelisterRoleOrIsManager(msg.sender),
            "Cannot set indefinite status"
        );
        require(serviceId != bytes32(0), "Service ID zero");
        require(user != address(0), "User address zero");
        uint192 indefiniteWhitelistCount = _setIndefiniteWhitelistStatus(
            serviceId,
            user,
            status
        );
        emit SetIndefiniteWhitelistStatus(
            serviceId,
            user,
            msg.sender,
            status,
            indefiniteWhitelistCount
        );
    }

    /// @notice Revokes the indefinite whitelist status granted by a specific
    /// account that no longer has the indefinite whitelister role
    /// @param serviceId Service ID
    /// @param user User address
    /// @param setter Setter of the indefinite whitelist status
    function revokeIndefiniteWhitelistStatus(
        bytes32 serviceId,
        address user,
        address setter
    ) external override {
        require(
            !hasIndefiniteWhitelisterRoleOrIsManager(setter),
            "setter can set indefinite status"
        );
        (
            bool revoked,
            uint192 indefiniteWhitelistCount
        ) = _revokeIndefiniteWhitelistStatus(serviceId, user, setter);
        if (revoked) {
            emit RevokedIndefiniteWhitelistStatus(
                serviceId,
                user,
                setter,
                msg.sender,
                indefiniteWhitelistCount
            );
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/protocol/interfaces/IStorageUtils.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IStorageUtils {
    event StoredTemplate(
        bytes32 indexed templateId,
        bytes32 endpointId,
        bytes parameters
    );

    event StoredSubscription(
        bytes32 indexed subscriptionId,
        uint256 chainId,
        address airnode,
        bytes32 templateId,
        bytes parameters,
        bytes conditions,
        address relayer,
        address sponsor,
        address requester,
        bytes4 fulfillFunctionId
    );

    function storeTemplate(bytes32 endpointId, bytes calldata parameters)
        external
        returns (bytes32 templateId);

    function storeSubscription(
        uint256 chainId,
        address airnode,
        bytes32 templateId,
        bytes calldata parameters,
        bytes calldata conditions,
        address relayer,
        address sponsor,
        address requester,
        bytes4 fulfillFunctionId
    ) external returns (bytes32 subscriptionId);

    // solhint-disable-next-line func-name-mixedcase
    function MAXIMUM_PARAMETER_LENGTH() external view returns (uint256);

    function templates(bytes32 templateId)
        external
        view
        returns (bytes32 endpointId, bytes memory parameters);

    function subscriptions(bytes32 subscriptionId)
        external
        view
        returns (
            uint256 chainId,
            address airnode,
            bytes32 templateId,
            bytes memory parameters,
            bytes memory conditions,
            address relayer,
            address sponsor,
            address requester,
            bytes4 fulfillFunctionId
        );
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/protocol/interfaces/ISponsorshipUtils.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface ISponsorshipUtils {
    event SetRrpSponsorshipStatus(
        address indexed sponsor,
        address indexed requester,
        bool status
    );

    event SetPspSponsorshipStatus(
        address indexed sponsor,
        bytes32 indexed subscriptionId,
        bool status
    );

    function setRrpSponsorshipStatus(address requester, bool status) external;

    function setPspSponsorshipStatus(bytes32 subscriptionId, bool status)
        external;

    function sponsorToRequesterToRrpSponsorshipStatus(
        address sponsor,
        address requester
    ) external view returns (bool status);

    function sponsorToSubscriptionIdToPspSponsorshipStatus(
        address sponsor,
        bytes32 subscriptionId
    ) external view returns (bool status);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/protocol/interfaces/IWithdrawalUtils.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IWithdrawalUtils {
    event RequestedWithdrawal(
        address indexed airnodeOrRelayer,
        address indexed sponsor,
        bytes32 indexed withdrawalRequestId,
        uint256 protocolId
    );

    event FulfilledWithdrawal(
        address indexed airnodeOrRelayer,
        address indexed sponsor,
        bytes32 indexed withdrawalRequestId,
        uint256 protocolId,
        address sponsorWallet,
        uint256 amount
    );

    event ClaimedBalance(address indexed sponsor, uint256 amount);

    function requestWithdrawal(address airnodeOrRelayer, uint256 protocolId)
        external;

    function fulfillWithdrawal(
        bytes32 withdrawalRequestId,
        address airnodeOrRelayer,
        uint256 protocolId,
        address sponsor,
        uint256 timestamp,
        bytes calldata signature
    ) external payable;

    function claimBalance() external;

    function withdrawalRequestIsAwaitingFulfillment(bytes32 withdrawalRequestId)
        external
        view
        returns (bool);

    function sponsorToBalance(address sponsor) external view returns (uint256);

    function sponsorToWithdrawalRequestCount(address sponsor)
        external
        view
        returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/protocol/interfaces/IAirnodeProtocol.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;



interface IAirnodeProtocol is
    IStorageUtils,
    ISponsorshipUtils,
    IWithdrawalUtils
{
    event MadeRequest(
        address indexed airnode,
        bytes32 indexed requestId,
        address requester,
        uint256 requesterRequestCount,
        bytes32 templateId,
        bytes parameters,
        address sponsor,
        bytes4 fulfillFunctionId
    );

    event FulfilledRequest(
        address indexed airnode,
        bytes32 indexed requestId,
        uint256 timestamp,
        bytes data
    );

    event FailedRequest(
        address indexed airnode,
        bytes32 indexed requestId,
        uint256 timestamp,
        string errorMessage
    );

    event MadeRequestRelayed(
        address indexed relayer,
        bytes32 indexed requestId,
        address indexed airnode,
        address requester,
        uint256 requesterRequestCount,
        bytes32 templateId,
        bytes parameters,
        address sponsor,
        bytes4 fulfillFunctionId
    );

    event FulfilledRequestRelayed(
        address indexed relayer,
        bytes32 indexed requestId,
        address indexed airnode,
        uint256 timestamp,
        bytes data
    );

    event FailedRequestRelayed(
        address indexed relayer,
        bytes32 indexed requestId,
        address indexed airnode,
        uint256 timestamp,
        string errorMessage
    );

    function makeRequest(
        address airnode,
        bytes32 templateId,
        bytes calldata parameters,
        address sponsor,
        bytes4 fulfillFunctionId
    ) external returns (bytes32 requestId);

    function fulfillRequest(
        bytes32 requestId,
        address airnode,
        address requester,
        bytes4 fulfillFunctionId,
        uint256 timestamp,
        bytes calldata data,
        bytes calldata signature
    ) external returns (bool callSuccess, bytes memory callData);

    function failRequest(
        bytes32 requestId,
        address airnode,
        address requester,
        bytes4 fulfillFunctionId,
        uint256 timestamp,
        string calldata errorMessage,
        bytes calldata signature
    ) external;

    function makeRequestRelayed(
        address airnode,
        bytes32 templateId,
        bytes calldata parameters,
        address relayer,
        address sponsor,
        bytes4 fulfillFunctionId
    ) external returns (bytes32 requestId);

    function fulfillRequestRelayed(
        bytes32 requestId,
        address airnode,
        address requester,
        address relayer,
        bytes4 fulfillFunctionId,
        uint256 timestamp,
        bytes calldata data,
        bytes calldata signature
    ) external returns (bool callSuccess, bytes memory callData);

    function failRequestRelayed(
        bytes32 requestId,
        address airnode,
        address requester,
        address relayer,
        bytes4 fulfillFunctionId,
        uint256 timestamp,
        string calldata errorMessage,
        bytes calldata signature
    ) external;

    function requestIsAwaitingFulfillment(bytes32 requestId)
        external
        view
        returns (bool);

    function requesterToRequestCount(address requester)
        external
        view
        returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/protocol/interfaces/IAirnodeRequester.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAirnodeRequester {
    function airnodeProtocol() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/protocol/AirnodeRequester.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


/// @title Contract to be inherited to make Airnode requests and receive
/// fulfillments
contract AirnodeRequester is IAirnodeRequester {
    /// @notice AirnodeProtocol contract address
    address public immutable override airnodeProtocol;

    /// @dev Reverts if the sender is not the AirnodeProtocol contract. Use
    /// this modifier with methods that are meant to receive RRP fulfillments.
    modifier onlyAirnodeProtocol() {
        require(
            msg.sender == address(airnodeProtocol),
            "Sender not Airnode protocol"
        );
        _;
    }

    /// @dev Reverts if the timestamp is not valid. Use this modifier with
    /// methods that are meant to receive RRP and PSP fulfillments.
    /// @param timestamp Timestamp used in the signature
    modifier onlyValidTimestamp(uint256 timestamp) {
        require(timestampIsValid(timestamp), "Timestamp not valid");
        _;
    }

    /// @param _airnodeProtocol AirnodeProtocol contract address
    constructor(address _airnodeProtocol) {
        require(_airnodeProtocol != address(0), "AirnodeProtocol address zero");
        airnodeProtocol = _airnodeProtocol;
    }

    /// @notice Returns if the timestamp used in the signature is valid
    /// @dev Returns `false` if the timestamp is not at most 1 hour old to
    /// prevent replays. Returns `false` if the timestamp is not from the past,
    /// with some leeway to accomodate for some benign time drift. These values
    /// are appropriate in most cases, but you can adjust them if you are aware
    /// of the implications.
    /// @param timestamp Timestamp used in the signature
    function timestampIsValid(uint256 timestamp) internal view returns (bool) {
        return
            timestamp + 1 hours > block.timestamp &&
            timestamp < block.timestamp + 15 minutes;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/dapis/Sort.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/// @title Contract that sorts an array using an unrolled implementation
/// @notice The operation will be in-place, i.e., the array provided as the
/// argument will be modified.
contract Sort {
    uint256 internal constant MAX_SORT_LENGTH = 9;

    /// @notice Sorts the array
    /// @param array Array to be sorted
    function sort(int256[] memory array) internal pure {
        uint256 arrayLength = array.length;
        require(arrayLength <= MAX_SORT_LENGTH, "Array too long to sort");
        // Do a binary search
        if (arrayLength < 6) {
            // Possible lengths: 1, 2, 3, 4, 5
            if (arrayLength < 4) {
                // Possible lengths: 1, 2, 3
                if (arrayLength == 3) {
                    // Length: 3
                    swapIfFirstIsLarger(array, 0, 1);
                    swapIfFirstIsLarger(array, 1, 2);
                    swapIfFirstIsLarger(array, 0, 1);
                } else if (arrayLength == 2) {
                    // Length: 2
                    swapIfFirstIsLarger(array, 0, 1);
                }
                // Do nothing for Length: 1
            } else {
                // Possible lengths: 4, 5
                if (arrayLength == 5) {
                    // Length: 5
                    swapIfFirstIsLarger(array, 1, 2);
                    swapIfFirstIsLarger(array, 3, 4);
                    swapIfFirstIsLarger(array, 1, 3);
                    swapIfFirstIsLarger(array, 0, 2);
                    swapIfFirstIsLarger(array, 2, 4);
                    swapIfFirstIsLarger(array, 0, 3);
                    swapIfFirstIsLarger(array, 0, 1);
                    swapIfFirstIsLarger(array, 2, 3);
                    swapIfFirstIsLarger(array, 1, 2);
                } else {
                    // Length: 4
                    swapIfFirstIsLarger(array, 0, 1);
                    swapIfFirstIsLarger(array, 2, 3);
                    swapIfFirstIsLarger(array, 1, 3);
                    swapIfFirstIsLarger(array, 0, 2);
                    swapIfFirstIsLarger(array, 1, 2);
                }
            }
        } else {
            // Possible lengths: 6, 7, 8, 9
            if (arrayLength < 8) {
                // Possible lengths: 6, 7
                if (arrayLength == 7) {
                    // Length: 7
                    swapIfFirstIsLarger(array, 1, 2);
                    swapIfFirstIsLarger(array, 3, 4);
                    swapIfFirstIsLarger(array, 5, 6);
                    swapIfFirstIsLarger(array, 0, 2);
                    swapIfFirstIsLarger(array, 4, 6);
                    swapIfFirstIsLarger(array, 3, 5);
                    swapIfFirstIsLarger(array, 2, 6);
                    swapIfFirstIsLarger(array, 1, 5);
                    swapIfFirstIsLarger(array, 0, 4);
                    swapIfFirstIsLarger(array, 2, 5);
                    swapIfFirstIsLarger(array, 0, 3);
                    swapIfFirstIsLarger(array, 2, 4);
                    swapIfFirstIsLarger(array, 1, 3);
                    swapIfFirstIsLarger(array, 0, 1);
                    swapIfFirstIsLarger(array, 2, 3);
                    swapIfFirstIsLarger(array, 4, 5);
                } else {
                    // Length: 6
                    swapIfFirstIsLarger(array, 0, 1);
                    swapIfFirstIsLarger(array, 2, 3);
                    swapIfFirstIsLarger(array, 4, 5);
                    swapIfFirstIsLarger(array, 1, 3);
                    swapIfFirstIsLarger(array, 3, 5);
                    swapIfFirstIsLarger(array, 1, 3);
                    swapIfFirstIsLarger(array, 2, 4);
                    swapIfFirstIsLarger(array, 0, 2);
                    swapIfFirstIsLarger(array, 2, 4);
                    swapIfFirstIsLarger(array, 3, 4);
                    swapIfFirstIsLarger(array, 1, 2);
                    swapIfFirstIsLarger(array, 2, 3);
                }
            } else {
                // Possible lengths: 8, 9
                if (arrayLength == 9) {
                    // Length: 9
                    swapIfFirstIsLarger(array, 1, 8);
                    swapIfFirstIsLarger(array, 2, 7);
                    swapIfFirstIsLarger(array, 3, 6);
                    swapIfFirstIsLarger(array, 4, 5);
                    swapIfFirstIsLarger(array, 1, 4);
                    swapIfFirstIsLarger(array, 5, 8);
                    swapIfFirstIsLarger(array, 0, 2);
                    swapIfFirstIsLarger(array, 6, 7);
                    swapIfFirstIsLarger(array, 2, 6);
                    swapIfFirstIsLarger(array, 7, 8);
                    swapIfFirstIsLarger(array, 0, 3);
                    swapIfFirstIsLarger(array, 4, 5);
                    swapIfFirstIsLarger(array, 0, 1);
                    swapIfFirstIsLarger(array, 3, 5);
                    swapIfFirstIsLarger(array, 6, 7);
                    swapIfFirstIsLarger(array, 2, 4);
                    swapIfFirstIsLarger(array, 1, 3);
                    swapIfFirstIsLarger(array, 5, 7);
                    swapIfFirstIsLarger(array, 4, 6);
                    swapIfFirstIsLarger(array, 1, 2);
                    swapIfFirstIsLarger(array, 3, 4);
                    swapIfFirstIsLarger(array, 5, 6);
                    swapIfFirstIsLarger(array, 7, 8);
                    swapIfFirstIsLarger(array, 2, 3);
                    swapIfFirstIsLarger(array, 4, 5);
                } else {
                    // Length: 8
                    swapIfFirstIsLarger(array, 0, 7);
                    swapIfFirstIsLarger(array, 1, 6);
                    swapIfFirstIsLarger(array, 2, 5);
                    swapIfFirstIsLarger(array, 3, 4);
                    swapIfFirstIsLarger(array, 0, 3);
                    swapIfFirstIsLarger(array, 4, 7);
                    swapIfFirstIsLarger(array, 1, 2);
                    swapIfFirstIsLarger(array, 5, 6);
                    swapIfFirstIsLarger(array, 0, 1);
                    swapIfFirstIsLarger(array, 2, 3);
                    swapIfFirstIsLarger(array, 4, 5);
                    swapIfFirstIsLarger(array, 6, 7);
                    swapIfFirstIsLarger(array, 3, 5);
                    swapIfFirstIsLarger(array, 2, 4);
                    swapIfFirstIsLarger(array, 1, 2);
                    swapIfFirstIsLarger(array, 3, 4);
                    swapIfFirstIsLarger(array, 5, 6);
                    swapIfFirstIsLarger(array, 2, 3);
                    swapIfFirstIsLarger(array, 4, 5);
                    swapIfFirstIsLarger(array, 3, 4);
                }
            }
        }
    }

    /// @notice Swaps two elements of an array if the first element is greater
    /// than the second
    /// @param array Array whose elements are to be swapped
    /// @param ind1 Index of the first element
    /// @param ind2 Index of the second element
    function swapIfFirstIsLarger(
        int256[] memory array,
        uint256 ind1,
        uint256 ind2
    ) private pure {
        if (array[ind1] > array[ind2]) {
            (array[ind1], array[ind2]) = (array[ind2], array[ind1]);
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/dapis/QuickSelect.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/// @title Contract that calculates the index of the k-th and optionally
/// (k+1)-th largest elements in the array
/// @notice Uses quickselect, which operates in-place, i.e., the array provided
/// as the argument will be modified.
contract Quickselect {
    /// @notice Returns the index of the k-th largest element in the array
    /// @param array Array in which k-th largest element will be searched
    /// @param k K
    /// @return indK Index of the k-th largest element
    function quickselectK(int256[] memory array, uint256 k)
        internal
        pure
        returns (uint256 indK)
    {
        (indK, ) = quickselect(array, 0, array.length - 1, k, false);
    }

    /// @notice Returns the index of the k-th and (k+1)-th largest elements in
    /// the array
    /// @param array Array in which k-th and (k+1)-th largest elements will be
    /// searched
    /// @param k K
    /// @return indK Index of the k-th largest element
    /// @return indKPlusOne Index of the (k+1)-th largest element
    function quickselectKPlusOne(int256[] memory array, uint256 k)
        internal
        pure
        returns (uint256 indK, uint256 indKPlusOne)
    {
        uint256 arrayLength = array.length;
        require(arrayLength > 1, "Array too short to select k+1");
        return quickselect(array, 0, arrayLength - 1, k, true);
    }

    /// @notice Returns the index of the k-th largest element in the specified
    /// section of the (potentially unsorted) array
    /// @param array Array in which K will be searched for
    /// @param lo Starting index of the section of the array that K will be
    /// searched in
    /// @param hi Last index of the section of the array that K will be
    /// searched in
    /// @param k K
    /// @param selectKPlusOne If the index of the (k+1)-th largest element is
    /// to be returned
    /// @return indK Index of the k-th largest element
    /// @return indKPlusOne Index of the (k+1)-th largest element (only set if
    /// `selectKPlusOne` is `true`)
    function quickselect(
        int256[] memory array,
        uint256 lo,
        uint256 hi,
        uint256 k,
        bool selectKPlusOne
    ) private pure returns (uint256 indK, uint256 indKPlusOne) {
        if (lo == hi) {
            return (k, 0);
        }
        uint256 indPivot = partition(array, lo, hi);
        if (k < indPivot) {
            (indK, ) = quickselect(array, lo, indPivot - 1, k, false);
        } else if (k > indPivot) {
            (indK, ) = quickselect(array, indPivot + 1, hi, k, false);
        } else {
            indK = indPivot;
        }
        // Since Quickselect ends in the array being partitioned around the
        // k-th largest element, we can continue searching towards right for
        // the (k+1)-th largest element, which is useful in calculating the
        // median of an array with even length
        if (selectKPlusOne) {
            indKPlusOne = indK + 1;
            for (uint256 i = indKPlusOne + 1; i < array.length; i++) {
                if (array[i] < array[indKPlusOne]) {
                    indKPlusOne = i;
                }
            }
        }
    }

    /// @notice Partitions the array into two around a pivot
    /// @param array Array that will be partitioned
    /// @param lo Starting index of the section of the array that will be
    /// partitioned
    /// @param hi Last index of the section of the array that will be
    /// partitioned
    /// @return pivotInd Pivot index
    function partition(
        int256[] memory array,
        uint256 lo,
        uint256 hi
    ) private pure returns (uint256 pivotInd) {
        if (lo == hi) {
            return lo;
        }
        int256 pivot = array[lo];
        uint256 i = lo;
        pivotInd = hi + 1;
        while (true) {
            do {
                i++;
            } while (i < array.length && array[i] < pivot);
            do {
                pivotInd--;
            } while (array[pivotInd] > pivot);
            if (i >= pivotInd) {
                (array[lo], array[pivotInd]) = (array[pivotInd], array[lo]);
                return pivotInd;
            }
            (array[i], array[pivotInd]) = (array[pivotInd], array[i]);
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/dapis/Median.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


/// @title Contract that calculates the median of an array
/// @notice The operation will be in-place, i.e., the array provided as the
/// argument will be modified.
contract Median is Sort, Quickselect {
    /// @notice Returns the median of the array
    /// @dev Uses an unrolled sorting implementation for shorter arrays and
    /// quickselect for longer arrays for gas cost efficiency
    /// @param array Array whose median is to be calculated
    /// @return Median of the array
    function median(int256[] memory array) internal pure returns (int256) {
        uint256 arrayLength = array.length;
        if (arrayLength <= MAX_SORT_LENGTH) {
            sort(array);
            if (arrayLength % 2 == 1) {
                return array[arrayLength / 2];
            } else {
                return
                    (array[arrayLength / 2 - 1] + array[arrayLength / 2]) / 2;
            }
        } else {
            if (arrayLength % 2 == 1) {
                return array[quickselectK(array, arrayLength / 2)];
            } else {
                (uint256 mid1, uint256 mid2) = quickselectKPlusOne(
                    array,
                    arrayLength / 2 - 1
                );
                return (array[mid1] + array[mid2]) / 2;
            }
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/dapis/interfaces/IDapiServer.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IDapiServer is IAirnodeRequester {
    event SetRrpBeaconUpdatePermissionStatus(
        address indexed sponsor,
        address indexed rrpBeaconUpdateRequester,
        bool status
    );

    event RequestedRrpBeaconUpdate(
        bytes32 indexed beaconId,
        address indexed sponsor,
        address indexed requester,
        bytes32 requestId,
        address airnode,
        bytes32 templateId
    );

    event RequestedRrpBeaconUpdateRelayed(
        bytes32 indexed beaconId,
        address indexed sponsor,
        address indexed requester,
        bytes32 requestId,
        address airnode,
        address relayer,
        bytes32 templateId
    );

    event UpdatedBeaconWithRrp(
        bytes32 indexed beaconId,
        bytes32 requestId,
        int256 value,
        uint256 timestamp
    );

    event RegisteredBeaconUpdateSubscription(
        bytes32 indexed subscriptionId,
        address airnode,
        bytes32 templateId,
        bytes parameters,
        bytes conditions,
        address relayer,
        address sponsor,
        address requester,
        bytes4 fulfillFunctionId
    );

    event UpdatedBeaconWithPsp(
        bytes32 indexed beaconId,
        bytes32 subscriptionId,
        int224 value,
        uint32 timestamp
    );

    event UpdatedBeaconWithSignedData(
        bytes32 indexed beaconId,
        int256 value,
        uint256 timestamp
    );

    event UpdatedDapiWithBeacons(
        bytes32 indexed dapiId,
        int224 value,
        uint32 timestamp
    );

    event UpdatedDapiWithSignedData(
        bytes32 indexed dapiId,
        int224 value,
        uint32 timestamp
    );

    event SetName(
        bytes32 indexed name,
        bytes32 dataPointId,
        address indexed sender
    );

    function setRrpBeaconUpdatePermissionStatus(
        address rrpBeaconUpdateRequester,
        bool status
    ) external;

    function requestRrpBeaconUpdate(
        address airnode,
        bytes32 templateId,
        address sponsor
    ) external returns (bytes32 requestId);

    function requestRrpBeaconUpdateRelayed(
        address airnode,
        bytes32 templateId,
        address relayer,
        address sponsor
    ) external returns (bytes32 requestId);

    function fulfillRrpBeaconUpdate(
        bytes32 requestId,
        uint256 timestamp,
        bytes calldata data
    ) external;

    function registerBeaconUpdateSubscription(
        address airnode,
        bytes32 templateId,
        bytes memory conditions,
        address relayer,
        address sponsor
    ) external returns (bytes32 subscriptionId);

    function conditionPspBeaconUpdate(
        bytes32 subscriptionId,
        bytes calldata data,
        bytes calldata conditionParameters
    ) external view returns (bool);

    function fulfillPspBeaconUpdate(
        bytes32 subscriptionId,
        address airnode,
        address relayer,
        address sponsor,
        uint256 timestamp,
        bytes calldata data,
        bytes calldata signature
    ) external;

    function updateBeaconWithSignedData(
        address airnode,
        bytes32 beaconId,
        uint256 timestamp,
        bytes calldata data,
        bytes calldata signature
    ) external;

    function updateDapiWithBeacons(bytes32[] memory beaconIds)
        external
        returns (bytes32 dapiId);

    function conditionPspDapiUpdate(
        bytes32 subscriptionId,
        bytes calldata data,
        bytes calldata conditionParameters
    ) external returns (bool);

    function fulfillPspDapiUpdate(
        bytes32 subscriptionId,
        address airnode,
        address relayer,
        address sponsor,
        uint256 timestamp,
        bytes calldata data,
        bytes calldata signature
    ) external;

    function updateDapiWithSignedData(
        address[] memory airnodes,
        bytes32[] memory templateIds,
        uint256[] memory timestamps,
        bytes[] memory data,
        bytes[] memory signatures
    ) external returns (bytes32 dapiId);

    function setName(bytes32 name, bytes32 dataPointId) external;

    function nameToDataPointId(bytes32 name) external view returns (bytes32);

    function readWithDataPointId(bytes32 dataPointId)
        external
        view
        returns (int224 value, uint32 timestamp);

    function readWithName(bytes32 name)
        external
        view
        returns (int224 value, uint32 timestamp);

    function readerCanReadDataPoint(bytes32 dataPointId, address reader)
        external
        view
        returns (bool);

    function dataPointIdToReaderToWhitelistStatus(
        bytes32 dataPointId,
        address reader
    )
        external
        view
        returns (uint64 expirationTimestamp, uint192 indefiniteWhitelistCount);

    function dataPointIdToReaderToSetterToIndefiniteWhitelistStatus(
        bytes32 dataPointId,
        address reader,
        address setter
    ) external view returns (bool indefiniteWhitelistStatus);

    function deriveBeaconId(address airnode, bytes32 templateId)
        external
        pure
        returns (bytes32 beaconId);

    function deriveDapiId(bytes32[] memory beaconIds)
        external
        pure
        returns (bytes32 dapiId);

    // solhint-disable-next-line func-name-mixedcase
    function UNLIMITED_READER_ROLE_DESCRIPTION()
        external
        view
        returns (string memory);

    // solhint-disable-next-line func-name-mixedcase
    function NAME_SETTER_ROLE_DESCRIPTION()
        external
        view
        returns (string memory);

    // solhint-disable-next-line func-name-mixedcase
    function HUNDRED_PERCENT() external view returns (uint256);

    function unlimitedReaderRole() external view returns (bytes32);

    function nameSetterRole() external view returns (bytes32);

    function sponsorToRrpBeaconUpdateRequesterToPermissionStatus(
        address sponsor,
        address updateRequester
    ) external view returns (bool);

    function subscriptionIdToBeaconId(bytes32 subscriptionId)
        external
        view
        returns (bytes32);
}

// File: @openzeppelin/contracts/utils/math/Math.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (utils/math/Math.sol)

pragma solidity ^0.8.0;

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
library Math {
    enum Rounding {
        Down, // Toward negative infinity
        Up, // Toward infinity
        Zero // Toward zero
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    /**
     * @dev Returns the average of two numbers. The result is rounded towards
     * zero.
     */
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow.
        return (a & b) + (a ^ b) / 2;
    }

    /**
     * @dev Returns the ceiling of the division of two numbers.
     *
     * This differs from standard division with `/` in that it rounds up instead
     * of rounding down.
     */
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b - 1) / b can overflow on addition, so we distribute.
        return a == 0 ? 0 : (a - 1) / b + 1;
    }

    /**
     * @notice Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or denominator == 0
     * @dev Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv)
     * with further edits by Uniswap Labs also under MIT license.
     */
    function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
        unchecked {
            // 512-bit multiply [prod1 prod0] = x * y. Compute the product mod 2^256 and mod 2^256 - 1, then use
            // use the Chinese Remainder Theorem to reconstruct the 512 bit result. The result is stored in two 256
            // variables such that product = prod1 * 2^256 + prod0.
            uint256 prod0; // Least significant 256 bits of the product
            uint256 prod1; // Most significant 256 bits of the product
            assembly {
                let mm := mulmod(x, y, not(0))
                prod0 := mul(x, y)
                prod1 := sub(sub(mm, prod0), lt(mm, prod0))
            }

            // Handle non-overflow cases, 256 by 256 division.
            if (prod1 == 0) {
                // Solidity will revert if denominator == 0, unlike the div opcode on its own.
                // The surrounding unchecked block does not change this fact.
                // See https://docs.soliditylang.org/en/latest/control-structures.html#checked-or-unchecked-arithmetic.
                return prod0 / denominator;
            }

            // Make sure the result is less than 2^256. Also prevents denominator == 0.
            require(denominator > prod1, "Math: mulDiv overflow");

            ///////////////////////////////////////////////
            // 512 by 256 division.
            ///////////////////////////////////////////////

            // Make division exact by subtracting the remainder from [prod1 prod0].
            uint256 remainder;
            assembly {
                // Compute remainder using mulmod.
                remainder := mulmod(x, y, denominator)

                // Subtract 256 bit number from 512 bit number.
                prod1 := sub(prod1, gt(remainder, prod0))
                prod0 := sub(prod0, remainder)
            }

            // Factor powers of two out of denominator and compute largest power of two divisor of denominator. Always >= 1.
            // See https://cs.stackexchange.com/q/138556/92363.

            // Does not overflow because the denominator cannot be zero at this stage in the function.
            uint256 twos = denominator & (~denominator + 1);
            assembly {
                // Divide denominator by twos.
                denominator := div(denominator, twos)

                // Divide [prod1 prod0] by twos.
                prod0 := div(prod0, twos)

                // Flip twos such that it is 2^256 / twos. If twos is zero, then it becomes one.
                twos := add(div(sub(0, twos), twos), 1)
            }

            // Shift in bits from prod1 into prod0.
            prod0 |= prod1 * twos;

            // Invert denominator mod 2^256. Now that denominator is an odd number, it has an inverse modulo 2^256 such
            // that denominator * inv = 1 mod 2^256. Compute the inverse by starting with a seed that is correct for
            // four bits. That is, denominator * inv = 1 mod 2^4.
            uint256 inverse = (3 * denominator) ^ 2;

            // Use the Newton-Raphson iteration to improve the precision. Thanks to Hensel's lifting lemma, this also works
            // in modular arithmetic, doubling the correct bits in each step.
            inverse *= 2 - denominator * inverse; // inverse mod 2^8
            inverse *= 2 - denominator * inverse; // inverse mod 2^16
            inverse *= 2 - denominator * inverse; // inverse mod 2^32
            inverse *= 2 - denominator * inverse; // inverse mod 2^64
            inverse *= 2 - denominator * inverse; // inverse mod 2^128
            inverse *= 2 - denominator * inverse; // inverse mod 2^256

            // Because the division is now exact we can divide by multiplying with the modular inverse of denominator.
            // This will give us the correct result modulo 2^256. Since the preconditions guarantee that the outcome is
            // less than 2^256, this is the final result. We don't need to compute the high bits of the result and prod1
            // is no longer required.
            result = prod0 * inverse;
            return result;
        }
    }

    /**
     * @notice Calculates x * y / denominator with full precision, following the selected rounding direction.
     */
    function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
        uint256 result = mulDiv(x, y, denominator);
        if (rounding == Rounding.Up && mulmod(x, y, denominator) > 0) {
            result += 1;
        }
        return result;
    }

    /**
     * @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded down.
     *
     * Inspired by Henry S. Warren, Jr.'s "Hacker's Delight" (Chapter 11).
     */
    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        // For our first guess, we get the biggest power of 2 which is smaller than the square root of the target.
        //
        // We know that the "msb" (most significant bit) of our target number `a` is a power of 2 such that we have
        // `msb(a) <= a < 2*msb(a)`. This value can be written `msb(a)=2**k` with `k=log2(a)`.
        //
        // This can be rewritten `2**log2(a) <= a < 2**(log2(a) + 1)`
        // → `sqrt(2**k) <= sqrt(a) < sqrt(2**(k+1))`
        // → `2**(k/2) <= sqrt(a) < 2**((k+1)/2) <= 2**(k/2 + 1)`
        //
        // Consequently, `2**(log2(a) / 2)` is a good first approximation of `sqrt(a)` with at least 1 correct bit.
        uint256 result = 1 << (log2(a) >> 1);

        // At this point `result` is an estimation with one bit of precision. We know the true value is a uint128,
        // since it is the square root of a uint256. Newton's method converges quadratically (precision doubles at
        // every iteration). We thus need at most 7 iteration to turn our partial result with one bit of precision
        // into the expected uint128 result.
        unchecked {
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            return min(result, a / result);
        }
    }

    /**
     * @notice Calculates sqrt(a), following the selected rounding direction.
     */
    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = sqrt(a);
            return result + (rounding == Rounding.Up && result * result < a ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 2, rounded down, of a positive value.
     * Returns 0 if given 0.
     */
    function log2(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 128;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 64;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 32;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 16;
            }
            if (value >> 8 > 0) {
                value >>= 8;
                result += 8;
            }
            if (value >> 4 > 0) {
                value >>= 4;
                result += 4;
            }
            if (value >> 2 > 0) {
                value >>= 2;
                result += 2;
            }
            if (value >> 1 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 2, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log2(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log2(value);
            return result + (rounding == Rounding.Up && 1 << result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 10, rounded down, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10 ** 64) {
                value /= 10 ** 64;
                result += 64;
            }
            if (value >= 10 ** 32) {
                value /= 10 ** 32;
                result += 32;
            }
            if (value >= 10 ** 16) {
                value /= 10 ** 16;
                result += 16;
            }
            if (value >= 10 ** 8) {
                value /= 10 ** 8;
                result += 8;
            }
            if (value >= 10 ** 4) {
                value /= 10 ** 4;
                result += 4;
            }
            if (value >= 10 ** 2) {
                value /= 10 ** 2;
                result += 2;
            }
            if (value >= 10 ** 1) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log10(value);
            return result + (rounding == Rounding.Up && 10 ** result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 256, rounded down, of a positive value.
     * Returns 0 if given 0.
     *
     * Adding one to the result gives the number of pairs of hex symbols needed to represent `value` as a hex string.
     */
    function log256(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 16;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 8;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 4;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 2;
            }
            if (value >> 8 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 256, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log256(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log256(value);
            return result + (rounding == Rounding.Up && 1 << (result << 3) < value ? 1 : 0);
        }
    }
}

// File: @openzeppelin/contracts/utils/math/SignedMath.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (utils/math/SignedMath.sol)

pragma solidity ^0.8.0;

/**
 * @dev Standard signed math utilities missing in the Solidity language.
 */
library SignedMath {
    /**
     * @dev Returns the largest of two signed numbers.
     */
    function max(int256 a, int256 b) internal pure returns (int256) {
        return a > b ? a : b;
    }

    /**
     * @dev Returns the smallest of two signed numbers.
     */
    function min(int256 a, int256 b) internal pure returns (int256) {
        return a < b ? a : b;
    }

    /**
     * @dev Returns the average of two signed numbers without overflow.
     * The result is rounded towards zero.
     */
    function average(int256 a, int256 b) internal pure returns (int256) {
        // Formula from the book "Hacker's Delight"
        int256 x = (a & b) + ((a ^ b) >> 1);
        return x + (int256(uint256(x) >> 255) & (a ^ b));
    }

    /**
     * @dev Returns the absolute unsigned value of a signed value.
     */
    function abs(int256 n) internal pure returns (uint256) {
        unchecked {
            // must be unchecked in order to support `n = type(int256).min`
            return uint256(n >= 0 ? n : -n);
        }
    }
}

// File: @openzeppelin/contracts/utils/Strings.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (utils/Strings.sol)

pragma solidity ^0.8.0;


/**
 * @dev String operations.
 */
library Strings {
    bytes16 private constant _SYMBOLS = "0123456789abcdef";
    uint8 private constant _ADDRESS_LENGTH = 20;

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = Math.log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            /// @solidity memory-safe-assembly
            assembly {
                ptr := add(buffer, add(32, length))
            }
            while (true) {
                ptr--;
                /// @solidity memory-safe-assembly
                assembly {
                    mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
                }
                value /= 10;
                if (value == 0) break;
            }
            return buffer;
        }
    }

    /**
     * @dev Converts a `int256` to its ASCII `string` decimal representation.
     */
    function toString(int256 value) internal pure returns (string memory) {
        return string(abi.encodePacked(value < 0 ? "-" : "", toString(SignedMath.abs(value))));
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) internal pure returns (string memory) {
        unchecked {
            return toHexString(value, Math.log256(value) + 1);
        }
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }

    /**
     * @dev Converts an `address` with fixed length of 20 bytes to its not checksummed ASCII `string` hexadecimal representation.
     */
    function toHexString(address addr) internal pure returns (string memory) {
        return toHexString(uint256(uint160(addr)), _ADDRESS_LENGTH);
    }

    /**
     * @dev Returns true if the two strings are equal.
     */
    function equal(string memory a, string memory b) internal pure returns (bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }
}

// File: @openzeppelin/contracts/utils/cryptography/ECDSA.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (utils/cryptography/ECDSA.sol)

pragma solidity ^0.8.0;

/**
 * @dev Elliptic Curve Digital Signature Algorithm (ECDSA) operations.
 *
 * These functions can be used to verify that a message was signed by the holder
 * of the private keys of a given address.
 */
library ECDSA {
    enum RecoverError {
        NoError,
        InvalidSignature,
        InvalidSignatureLength,
        InvalidSignatureS,
        InvalidSignatureV // Deprecated in v4.8
    }

    function _throwError(RecoverError error) private pure {
        if (error == RecoverError.NoError) {
            return; // no error: do nothing
        } else if (error == RecoverError.InvalidSignature) {
            revert("ECDSA: invalid signature");
        } else if (error == RecoverError.InvalidSignatureLength) {
            revert("ECDSA: invalid signature length");
        } else if (error == RecoverError.InvalidSignatureS) {
            revert("ECDSA: invalid signature 's' value");
        }
    }

    /**
     * @dev Returns the address that signed a hashed message (`hash`) with
     * `signature` or error string. This address can then be used for verification purposes.
     *
     * The `ecrecover` EVM opcode allows for malleable (non-unique) signatures:
     * this function rejects them by requiring the `s` value to be in the lower
     * half order, and the `v` value to be either 27 or 28.
     *
     * IMPORTANT: `hash` _must_ be the result of a hash operation for the
     * verification to be secure: it is possible to craft signatures that
     * recover to arbitrary addresses for non-hashed data. A safe way to ensure
     * this is by receiving a hash of the original message (which may otherwise
     * be too long), and then calling {toEthSignedMessageHash} on it.
     *
     * Documentation for signature generation:
     * - with https://web3js.readthedocs.io/en/v1.3.4/web3-eth-accounts.html#sign[Web3.js]
     * - with https://docs.ethers.io/v5/api/signer/#Signer-signMessage[ethers]
     *
     * _Available since v4.3._
     */
    function tryRecover(bytes32 hash, bytes memory signature) internal pure returns (address, RecoverError) {
        if (signature.length == 65) {
            bytes32 r;
            bytes32 s;
            uint8 v;
            // ecrecover takes the signature parameters, and the only way to get them
            // currently is to use assembly.
            /// @solidity memory-safe-assembly
            assembly {
                r := mload(add(signature, 0x20))
                s := mload(add(signature, 0x40))
                v := byte(0, mload(add(signature, 0x60)))
            }
            return tryRecover(hash, v, r, s);
        } else {
            return (address(0), RecoverError.InvalidSignatureLength);
        }
    }

    /**
     * @dev Returns the address that signed a hashed message (`hash`) with
     * `signature`. This address can then be used for verification purposes.
     *
     * The `ecrecover` EVM opcode allows for malleable (non-unique) signatures:
     * this function rejects them by requiring the `s` value to be in the lower
     * half order, and the `v` value to be either 27 or 28.
     *
     * IMPORTANT: `hash` _must_ be the result of a hash operation for the
     * verification to be secure: it is possible to craft signatures that
     * recover to arbitrary addresses for non-hashed data. A safe way to ensure
     * this is by receiving a hash of the original message (which may otherwise
     * be too long), and then calling {toEthSignedMessageHash} on it.
     */
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, signature);
        _throwError(error);
        return recovered;
    }

    /**
     * @dev Overload of {ECDSA-tryRecover} that receives the `r` and `vs` short-signature fields separately.
     *
     * See https://eips.ethereum.org/EIPS/eip-2098[EIP-2098 short signatures]
     *
     * _Available since v4.3._
     */
    function tryRecover(bytes32 hash, bytes32 r, bytes32 vs) internal pure returns (address, RecoverError) {
        bytes32 s = vs & bytes32(0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        uint8 v = uint8((uint256(vs) >> 255) + 27);
        return tryRecover(hash, v, r, s);
    }

    /**
     * @dev Overload of {ECDSA-recover} that receives the `r and `vs` short-signature fields separately.
     *
     * _Available since v4.2._
     */
    function recover(bytes32 hash, bytes32 r, bytes32 vs) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, r, vs);
        _throwError(error);
        return recovered;
    }

    /**
     * @dev Overload of {ECDSA-tryRecover} that receives the `v`,
     * `r` and `s` signature fields separately.
     *
     * _Available since v4.3._
     */
    function tryRecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal pure returns (address, RecoverError) {
        // EIP-2 still allows signature malleability for ecrecover(). Remove this possibility and make the signature
        // unique. Appendix F in the Ethereum Yellow paper (https://ethereum.github.io/yellowpaper/paper.pdf), defines
        // the valid range for s in (301): 0 < s < secp256k1n ÷ 2 + 1, and for v in (302): v ∈ {27, 28}. Most
        // signatures from current libraries generate a unique signature with an s-value in the lower half order.
        //
        // If your library generates malleable signatures, such as s-values in the upper range, calculate a new s-value
        // with 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141 - s1 and flip v from 27 to 28 or
        // vice versa. If your library also generates signatures with 0/1 for v instead 27/28, add 27 to v to accept
        // these malleable signatures as well.
        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
            return (address(0), RecoverError.InvalidSignatureS);
        }

        // If the signature is valid (and not malleable), return the signer address
        address signer = ecrecover(hash, v, r, s);
        if (signer == address(0)) {
            return (address(0), RecoverError.InvalidSignature);
        }

        return (signer, RecoverError.NoError);
    }

    /**
     * @dev Overload of {ECDSA-recover} that receives the `v`,
     * `r` and `s` signature fields separately.
     */
    function recover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, v, r, s);
        _throwError(error);
        return recovered;
    }

    /**
     * @dev Returns an Ethereum Signed Message, created from a `hash`. This
     * produces hash corresponding to the one signed with the
     * https://eth.wiki/json-rpc/API#eth_sign[`eth_sign`]
     * JSON-RPC method as part of EIP-191.
     *
     * See {recover}.
     */
    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32 message) {
        // 32 is the length in bytes of hash,
        // enforced by the type signature above
        /// @solidity memory-safe-assembly
        assembly {
            mstore(0x00, "\x19Ethereum Signed Message:\n32")
            mstore(0x1c, hash)
            message := keccak256(0x00, 0x3c)
        }
    }

    /**
     * @dev Returns an Ethereum Signed Message, created from `s`. This
     * produces hash corresponding to the one signed with the
     * https://eth.wiki/json-rpc/API#eth_sign[`eth_sign`]
     * JSON-RPC method as part of EIP-191.
     *
     * See {recover}.
     */
    function toEthSignedMessageHash(bytes memory s) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n", Strings.toString(s.length), s));
    }

    /**
     * @dev Returns an Ethereum Signed Typed Data, created from a
     * `domainSeparator` and a `structHash`. This produces hash corresponding
     * to the one signed with the
     * https://eips.ethereum.org/EIPS/eip-712[`eth_signTypedData`]
     * JSON-RPC method as part of EIP-712.
     *
     * See {recover}.
     */
    function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash) internal pure returns (bytes32 data) {
        /// @solidity memory-safe-assembly
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, "\x19\x01")
            mstore(add(ptr, 0x02), domainSeparator)
            mstore(add(ptr, 0x22), structHash)
            data := keccak256(ptr, 0x42)
        }
    }

    /**
     * @dev Returns an Ethereum Signed Data with intended validator, created from a
     * `validator` and `data` according to the version 0 of EIP-191.
     *
     * See {recover}.
     */
    function toDataWithIntendedValidatorHash(address validator, bytes memory data) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19\x00", validator, data));
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/dapis/DapiServer.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;





/// @title Contract that serves Beacons and dAPIs based on the Airnode protocol
/// @notice A Beacon is a live data point addressed by an ID, which is derived
/// from an Airnode address and a template ID. This is suitable where the more
/// recent data point is always more favorable, e.g., in the context of an
/// asset price data feed. Beacons can also be seen as one-Airnode data feeds
/// that can be used individually or combined to build dAPIs.
/// @dev DapiServer is a PSP requester contract. Unlike RRP, which is
/// implemented as a central contract, PSP implementation is built into the
/// requester for optimization. Accordingly, the checks that are not required
/// are omitted. Some examples:
/// - While executing a PSP beacon update, the condition is not verified
/// because beacon updates where the condition returns `false` (i.e., the
/// on-chain value is already close to the actual value) are not harmful, and
/// are even desirable.
/// - PSP dAPI update subscription IDs are not verified, as the Airnode/relayer
/// cannot be made to "misreport a dAPI update" by spoofing a subscription ID.
/// - While executing a PSP dAPI update, even the signature is not checked
/// because this is a purely keeper job that does not require off-chain data.
/// Similar to beacon updates, any dAPI update is welcome.
contract DapiServer is
    WhitelistWithManager,
    AirnodeRequester,
    Median,
    IDapiServer
{
    using ECDSA for bytes32;

    // Airnodes serve their fulfillment data along with timestamps. This
    // contract casts the reported data to `int224` and the timestamp to
    // `uint32`, which works until year 2106.
    struct DataPoint {
        int224 value;
        uint32 timestamp;
    }

    /// @notice Unlimited reader role description
    string public constant override UNLIMITED_READER_ROLE_DESCRIPTION =
        "Unlimited reader";

    /// @notice Name setter role description
    string public constant override NAME_SETTER_ROLE_DESCRIPTION =
        "Name setter";

    /// @notice Number that represents 100%
    /// @dev 10^8 (and not a larger number) is chosen to avoid overflows in
    /// `calculateUpdateInPercentage()`. Since the reported data needs to fit
    /// into 224 bits, its multiplication by 10^8 is guaranteed not to
    /// overflow.
    uint256 public constant override HUNDRED_PERCENT = 1e8;

    /// @notice Unlimited reader role
    bytes32 public immutable override unlimitedReaderRole;

    /// @notice Name setter role
    bytes32 public immutable override nameSetterRole;

    /// @notice If a sponsor has permitted an account to request RRP-based
    /// updates at this contract
    mapping(address => mapping(address => bool))
        public
        override sponsorToRrpBeaconUpdateRequesterToPermissionStatus;

    /// @notice ID of the beacon that the subscription is registered to update
    mapping(bytes32 => bytes32) public override subscriptionIdToBeaconId;

    mapping(bytes32 => DataPoint) private dataPoints;

    mapping(bytes32 => bytes32) private requestIdToBeaconId;

    mapping(bytes32 => bytes32) private subscriptionIdToHash;

    mapping(bytes32 => bytes32) private nameHashToDataPointId;

    /// @dev Reverts if the sender is not permitted to request an RRP-based
    /// update with the sponsor and is not the sponsor
    /// @param sponsor Sponsor address
    modifier onlyPermittedUpdateRequester(address sponsor) {
        require(
            sponsor == msg.sender ||
                sponsorToRrpBeaconUpdateRequesterToPermissionStatus[sponsor][
                    msg.sender
                ],
            "Sender not permitted"
        );
        _;
    }

    /// @param _accessControlRegistry AccessControlRegistry contract address
    /// @param _adminRoleDescription Admin role description
    /// @param _manager Manager address
    /// @param _airnodeProtocol AirnodeProtocol contract address
    constructor(
        address _accessControlRegistry,
        string memory _adminRoleDescription,
        address _manager,
        address _airnodeProtocol
    )
        WhitelistWithManager(
            _accessControlRegistry,
            _adminRoleDescription,
            _manager
        )
        AirnodeRequester(_airnodeProtocol)
    {
        unlimitedReaderRole = _deriveRole(
            _deriveAdminRole(manager),
            keccak256(abi.encodePacked(UNLIMITED_READER_ROLE_DESCRIPTION))
        );
        nameSetterRole = _deriveRole(
            _deriveAdminRole(manager),
            keccak256(abi.encodePacked(NAME_SETTER_ROLE_DESCRIPTION))
        );
    }

    ///                     ~~~RRP Beacon updates~~~

    /// @notice Called by the sponsor to set the update request permission
    /// status of an account
    /// @param rrpBeaconUpdateRequester RRP-based beacon update requester
    /// address
    /// @param status Permission status
    function setRrpBeaconUpdatePermissionStatus(
        address rrpBeaconUpdateRequester,
        bool status
    ) external override {
        require(
            rrpBeaconUpdateRequester != address(0),
            "Update requester zero"
        );
        sponsorToRrpBeaconUpdateRequesterToPermissionStatus[msg.sender][
            rrpBeaconUpdateRequester
        ] = status;
        emit SetRrpBeaconUpdatePermissionStatus(
            msg.sender,
            rrpBeaconUpdateRequester,
            status
        );
    }

    /// @notice Creates an RRP requests for the Beacon to be updated
    /// @dev In addition to the sponsor sponsoring this contract (by calling
    /// `setRrpSponsorshipStatus()`), the sponsor must also give update request
    /// permission to the sender (by calling
    /// `setRrpBeaconUpdatePermissionStatus()`) before this method is called.
    /// The template must specify a single point of data of type `int256` to be
    /// returned and for it to be small enough to be castable to `int224`
    /// because this is what `fulfillRrpBeaconUpdate()` expects.
    /// @param airnode Airnode address
    /// @param templateId Template ID
    /// @param sponsor Sponsor address
    /// @return requestId Request ID
    function requestRrpBeaconUpdate(
        address airnode,
        bytes32 templateId,
        address sponsor
    )
        external
        override
        onlyPermittedUpdateRequester(sponsor)
        returns (bytes32 requestId)
    {
        bytes32 beaconId = deriveBeaconId(airnode, templateId);
        requestId = IAirnodeProtocol(airnodeProtocol).makeRequest(
            airnode,
            templateId,
            "",
            sponsor,
            this.fulfillRrpBeaconUpdate.selector
        );
        requestIdToBeaconId[requestId] = beaconId;
        emit RequestedRrpBeaconUpdate(
            beaconId,
            sponsor,
            msg.sender,
            requestId,
            airnode,
            templateId
        );
    }

    /// @notice Creates an RRP requests for the Beacon to be updated by the relayer
    /// @param airnode Airnode address
    /// @param templateId Template ID
    /// @param relayer Relayer address
    /// @param sponsor Sponsor address
    /// @return requestId Request ID
    function requestRrpBeaconUpdateRelayed(
        address airnode,
        bytes32 templateId,
        address relayer,
        address sponsor
    )
        external
        override
        onlyPermittedUpdateRequester(sponsor)
        returns (bytes32 requestId)
    {
        bytes32 beaconId = deriveBeaconId(airnode, templateId);
        requestId = IAirnodeProtocol(airnodeProtocol).makeRequestRelayed(
            airnode,
            templateId,
            "",
            relayer,
            sponsor,
            this.fulfillRrpBeaconUpdate.selector
        );
        requestIdToBeaconId[requestId] = beaconId;
        emit RequestedRrpBeaconUpdateRelayed(
            beaconId,
            sponsor,
            msg.sender,
            requestId,
            airnode,
            relayer,
            templateId
        );
    }

    /// @notice Called by the Airnode/relayer using the sponsor wallet through
    /// AirnodeProtocol to fulfill the request
    /// @param requestId Request ID
    /// @param timestamp Timestamp used in the signature
    /// @param data Fulfillment data (an `int256` encoded in contract ABI)
    function fulfillRrpBeaconUpdate(
        bytes32 requestId,
        uint256 timestamp,
        bytes calldata data
    ) external override onlyAirnodeProtocol onlyValidTimestamp(timestamp) {
        bytes32 beaconId = requestIdToBeaconId[requestId];
        delete requestIdToBeaconId[requestId];
        int256 decodedData = processBeaconUpdate(beaconId, timestamp, data);
        emit UpdatedBeaconWithRrp(beaconId, requestId, decodedData, timestamp);
    }

    ///                     ~~~PSP Beacon updates~~~

    /// @notice Registers the Beacon update subscription
    /// @dev Similar to how one needs to call `requestRrpBeaconUpdate()` for
    /// this contract to recognize the incoming RRP fulfillment, this needs to
    /// be called before the subscription fulfillments.
    /// In addition to the subscription being registered, the sponsor must use
    /// `setPspSponsorshipStatus()` to give permission for its sponsor wallet
    /// to be used for the specific subscription.
    /// @param airnode Airnode address
    /// @param templateId Template ID
    /// @param conditions Conditions under which the subscription is requested
    /// to be fulfilled
    /// @param relayer Relayer address
    /// @param sponsor Sponsor address
    /// @return subscriptionId Subscription ID
    function registerBeaconUpdateSubscription(
        address airnode,
        bytes32 templateId,
        bytes memory conditions,
        address relayer,
        address sponsor
    ) external override returns (bytes32 subscriptionId) {
        require(relayer != address(0), "Relayer address zero");
        require(sponsor != address(0), "Sponsor address zero");
        subscriptionId = keccak256(
            abi.encodePacked(
                block.chainid,
                airnode,
                templateId,
                "",
                conditions,
                relayer,
                sponsor,
                address(this),
                this.fulfillPspBeaconUpdate.selector
            )
        );
        subscriptionIdToHash[subscriptionId] = keccak256(
            abi.encodePacked(airnode, relayer, sponsor)
        );
        subscriptionIdToBeaconId[subscriptionId] = deriveBeaconId(
            airnode,
            templateId
        );
        emit RegisteredBeaconUpdateSubscription(
            subscriptionId,
            airnode,
            templateId,
            "",
            conditions,
            relayer,
            sponsor,
            address(this),
            this.fulfillPspBeaconUpdate.selector
        );
    }

    /// @notice Returns if the respective Beacon needs to be updated based on
    /// the fulfillment data and the condition parameters
    /// @dev Reverts if not called by a void signer with zero address because
    /// this method can be used to indirectly read a Beacon.
    /// `conditionParameters` are specified within the `conditions` field of a
    /// Subscription.
    /// @param subscriptionId Subscription ID
    /// @param data Fulfillment data (an `int256` encoded in contract ABI)
    /// @param conditionParameters Subscription condition parameters (a
    /// `uint256` encoded in contract ABI)
    /// @return If the Beacon update subscription should be fulfilled
    function conditionPspBeaconUpdate(
        bytes32 subscriptionId,
        bytes calldata data,
        bytes calldata conditionParameters
    ) external view override returns (bool) {
        require(msg.sender == address(0), "Sender not zero address");
        bytes32 beaconId = subscriptionIdToBeaconId[subscriptionId];
        require(beaconId != bytes32(0), "Subscription not registered");
        return
            calculateUpdateInPercentage(
                dataPoints[beaconId].value,
                decodeFulfillmentData(data)
            ) >= decodeConditionParameters(conditionParameters);
    }

    /// @notice Called by the Airnode/relayer using the sponsor wallet to
    /// fulfill the beacon update subscription
    /// @dev There is no need to verify that `conditionPspBeaconUpdate()`
    /// returns `true` because any Beacon update is a good Beacon update
    /// @param subscriptionId Subscription ID
    /// @param airnode Airnode address
    /// @param relayer Relayer address
    /// @param sponsor Sponsor address
    /// @param timestamp Timestamp used in the signature
    /// @param data Fulfillment data (a single `int256` encoded in contract
    /// ABI)
    /// @param signature Subscription ID, timestamp, sponsor wallet address
    /// (and fulfillment data if the relayer is not the Airnode) signed by the
    /// Airnode wallet
    function fulfillPspBeaconUpdate(
        bytes32 subscriptionId,
        address airnode,
        address relayer,
        address sponsor,
        uint256 timestamp,
        bytes calldata data,
        bytes calldata signature
    ) external override onlyValidTimestamp(timestamp) {
        require(
            subscriptionIdToHash[subscriptionId] ==
                keccak256(abi.encodePacked(airnode, relayer, sponsor)),
            "Subscription not registered"
        );
        if (airnode == relayer) {
            require(
                (
                    keccak256(
                        abi.encodePacked(subscriptionId, timestamp, msg.sender)
                    ).toEthSignedMessageHash()
                ).recover(signature) == airnode,
                "Signature mismatch"
            );
        } else {
            require(
                (
                    keccak256(
                        abi.encodePacked(
                            subscriptionId,
                            timestamp,
                            msg.sender,
                            data
                        )
                    ).toEthSignedMessageHash()
                ).recover(signature) == airnode,
                "Signature mismatch"
            );
        }
        bytes32 beaconId = subscriptionIdToBeaconId[subscriptionId];
        // Beacon ID is guaranteed to not be zero because the subscription is
        // registered
        int256 decodedData = processBeaconUpdate(beaconId, timestamp, data);
        emit UpdatedBeaconWithPsp(
            beaconId,
            subscriptionId,
            int224(decodedData),
            uint32(timestamp)
        );
    }

    ///                     ~~~Signed data Beacon updates~~~

    /// @notice Updates a Beacon using data signed by the respective Airnode,
    /// without requiring a request or subscription
    /// @param airnode Airnode address
    /// @param templateId Template ID
    /// @param timestamp Timestamp used in the signature
    /// @param data Response data (an `int256` encoded in contract ABI)
    /// @param signature Template ID, a timestamp and the response data signed
    /// by the Airnode address
    function updateBeaconWithSignedData(
        address airnode,
        bytes32 templateId,
        uint256 timestamp,
        bytes calldata data,
        bytes calldata signature
    ) external override onlyValidTimestamp(timestamp) {
        require(
            (
                keccak256(abi.encodePacked(templateId, timestamp, data))
                    .toEthSignedMessageHash()
            ).recover(signature) == airnode,
            "Signature mismatch"
        );
        bytes32 beaconId = deriveBeaconId(airnode, templateId);
        int256 decodedData = processBeaconUpdate(beaconId, timestamp, data);
        emit UpdatedBeaconWithSignedData(beaconId, decodedData, timestamp);
    }

    ///                     ~~~PSP dAPI updates~~~

    /// @notice Updates the dAPI that is specified by the beacon IDs
    /// @param beaconIds Beacon IDs
    /// @return dapiId dAPI ID
    function updateDapiWithBeacons(bytes32[] memory beaconIds)
        public
        override
        returns (bytes32 dapiId)
    {
        uint256 beaconCount = beaconIds.length;
        require(beaconCount > 1, "Specified less than two Beacons");
        int256[] memory values = new int256[](beaconCount);
        uint256 accumulatedTimestamp = 0;
        for (uint256 ind = 0; ind < beaconCount; ind++) {
            DataPoint storage datapoint = dataPoints[beaconIds[ind]];
            values[ind] = datapoint.value;
            accumulatedTimestamp += datapoint.timestamp;
        }
        uint32 updatedTimestamp = uint32(accumulatedTimestamp / beaconCount);
        dapiId = deriveDapiId(beaconIds);
        require(
            updatedTimestamp >= dataPoints[dapiId].timestamp,
            "Updated value outdated"
        );
        int224 updatedValue = int224(median(values));
        dataPoints[dapiId] = DataPoint({
            value: updatedValue,
            timestamp: updatedTimestamp
        });
        emit UpdatedDapiWithBeacons(dapiId, updatedValue, updatedTimestamp);
    }

    /// @notice Returns if the respective dAPI needs to be updated based on the
    /// condition parameters
    /// @dev This method does not allow the caller to indirectly read a dAPI,
    /// which is why it does not require the sender to be a void signer with
    /// zero address. This allows the implementation of incentive mechanisms
    /// that rewards keepers that trigger valid dAPI updates.
    /// The template ID used in the respective Subscription is expected to be
    /// zero, which means the `parameters` field of the Subscription will be
    /// forwarded to this function as `data`. This field should be the beacon
    /// ID array encoded in contract ABI.
    /// @param subscriptionId Subscription ID
    /// @param data Fulfillment data (array of beacon IDs, i.e., `bytes32[]`
    /// encoded in contract ABI)
    /// @param conditionParameters Subscription condition parameters (a
    /// `uint256` encoded in contract ABI)
    /// @return If the dAPI update subscription should be fulfilled
    // SWC-Unprotected Ether Withdrawal: L471-L487
    function conditionPspDapiUpdate(
        bytes32 subscriptionId, // solhint-disable-line no-unused-vars
        bytes calldata data,
        bytes calldata conditionParameters
    ) external override returns (bool) {
        bytes32 dapiId = keccak256(data);
        int224 currentDapiValue = dataPoints[dapiId].value;
        require(
            dapiId == updateDapiWithBeacons(abi.decode(data, (bytes32[]))),
            "Data length not correct"
        );
        return
            calculateUpdateInPercentage(
                currentDapiValue,
                dataPoints[dapiId].value
            ) >= decodeConditionParameters(conditionParameters);
    }

    /// @notice Called by the Airnode/relayer using the sponsor wallet to
    /// fulfill the dAPI update subscription
    /// @dev Similar to `conditionPspDapiUpdate()`, if `templateId` of the
    /// Subscription is zero, its `parameters` field will be forwarded to
    /// `data` here, which is expect to be contract ABI-encoded array of beacon
    /// IDs.
    /// It does not make sense for this subscription to be relayed, as there is
    /// no external data being delivered. Nevertheless, this is allowed for the
    /// lack of a reason to prevent it.
    /// Even though the consistency of the arguments are not being checked, if
    /// a standard implementation of Airnode is being used, these can be
    /// expected to be correct. Either way, the assumption is that it does not
    /// matter for the purposes of a dAPI update subscription.
    /// @param subscriptionId Subscription ID
    /// @param airnode Airnode address
    /// @param relayer Relayer address
    /// @param sponsor Sponsor address
    /// @param timestamp Timestamp used in the signature
    /// @param data Fulfillment data (an `int256` encoded in contract ABI)
    /// @param signature Subscription ID, timestamp, sponsor wallet address
    /// (and fulfillment data if the relayer is not the Airnode) signed by the
    /// Airnode wallet
    function fulfillPspDapiUpdate(
        bytes32 subscriptionId, // solhint-disable-line no-unused-vars
        address airnode, // solhint-disable-line no-unused-vars
        address relayer, // solhint-disable-line no-unused-vars
        address sponsor, // solhint-disable-line no-unused-vars
        uint256 timestamp, // solhint-disable-line no-unused-vars
        bytes calldata data,
        bytes calldata signature // solhint-disable-line no-unused-vars
    ) external override {
        require(
            keccak256(data) ==
                updateDapiWithBeacons(abi.decode(data, (bytes32[]))),
            "Data length not correct"
        );
    }

    ///                     ~~~Signed data dAPI updates~~~

    /// @notice Updates a dAPI using data signed by the respective Airnodes
    /// without requiring a request or subscription. The beacons for which the
    /// signature is omitted will be read from the storage.
    /// @param airnodes Airnode addresses
    /// @param templateIds Template IDs
    /// @param timestamps Timestamps used in the signatures
    /// @param data Response data (an `int256` encoded in contract ABI per
    /// Beacon)
    /// @param signatures Template ID, a timestamp and the response data signed
    /// by the respective Airnode address per Beacon
    /// @return dapiId dAPI ID
    function updateDapiWithSignedData(
        address[] memory airnodes,
        bytes32[] memory templateIds,
        uint256[] memory timestamps,
        bytes[] memory data,
        bytes[] memory signatures
    ) external override returns (bytes32 dapiId) {
        uint256 beaconCount = airnodes.length;
        require(
            beaconCount == templateIds.length &&
                beaconCount == timestamps.length &&
                beaconCount == data.length &&
                beaconCount == signatures.length,
            "Parameter length mismatch"
        );
        require(beaconCount > 1, "Specified less than two Beacons");
        bytes32[] memory beaconIds = new bytes32[](beaconCount);
        int256[] memory values = new int256[](beaconCount);
        uint256 accumulatedTimestamp = 0;
        for (uint256 ind = 0; ind < beaconCount; ind++) {
            if (signatures[ind].length != 0) {
                address airnode = airnodes[ind];
                uint256 timestamp = timestamps[ind];
                require(timestampIsValid(timestamp), "Timestamp not valid");
                require(
                    (
                        keccak256(
                            abi.encodePacked(
                                templateIds[ind],
                                timestamp,
                                data[ind]
                            )
                        ).toEthSignedMessageHash()
                    ).recover(signatures[ind]) == airnode,
                    "Signature mismatch"
                );
                values[ind] = decodeFulfillmentData(data[ind]);
                // Timestamp validity is already checked, which means it will
                // be small enough to be typecast into `uint32`
                accumulatedTimestamp += timestamp;
                beaconIds[ind] = deriveBeaconId(airnode, templateIds[ind]);
            } else {
                bytes32 beaconId = deriveBeaconId(
                    airnodes[ind],
                    templateIds[ind]
                );
                DataPoint storage dataPoint = dataPoints[beaconId];
                values[ind] = dataPoint.value;
                accumulatedTimestamp += dataPoint.timestamp;
                beaconIds[ind] = beaconId;
            }
        }
        dapiId = deriveDapiId(beaconIds);
        uint32 updatedTimestamp = uint32(accumulatedTimestamp / beaconCount);
        require(
            updatedTimestamp >= dataPoints[dapiId].timestamp,
            "Updated value outdated"
        );
        int224 updatedValue = int224(median(values));
        dataPoints[dapiId] = DataPoint({
            value: updatedValue,
            timestamp: updatedTimestamp
        });
        emit UpdatedDapiWithSignedData(dapiId, updatedValue, updatedTimestamp);
    }

    /// @notice Sets the data point ID the name points to
    /// @dev While a data point ID refers to a specific Beacon or dAPI, names
    /// provide a more abstract interface for convenience. This means a name
    /// that was pointing at a Beacon can be pointed to a dAPI, then another
    /// dAPI, etc.
    /// @param name Human-readable name
    /// @param dataPointId Data point ID the name will point to
    function setName(bytes32 name, bytes32 dataPointId) external override {
        require(name != bytes32(0), "Name zero");
        require(dataPointId != bytes32(0), "Data point ID zero");
        require(
            msg.sender == manager ||
                IAccessControlRegistry(accessControlRegistry).hasRole(
                    nameSetterRole,
                    msg.sender
                ),
            "Sender cannot set name"
        );
        nameHashToDataPointId[keccak256(abi.encodePacked(name))] = dataPointId;
        emit SetName(name, dataPointId, msg.sender);
    }

    /// @notice Returns the data point ID the name is set to
    /// @param name Name
    /// @return Data point ID
    function nameToDataPointId(bytes32 name)
        external
        view
        override
        returns (bytes32)
    {
        return nameHashToDataPointId[keccak256(abi.encodePacked(name))];
    }

    /// @notice Reads the data point with ID
    /// @param dataPointId Data point ID
    /// @return value Data point value
    /// @return timestamp Data point timestamp
    function readWithDataPointId(bytes32 dataPointId)
        external
        view
        override
        returns (int224 value, uint32 timestamp)
    {
        require(
            readerCanReadDataPoint(dataPointId, msg.sender),
            "Sender cannot read"
        );
        DataPoint storage dataPoint = dataPoints[dataPointId];
        return (dataPoint.value, dataPoint.timestamp);
    }

    /// @notice Reads the data point with name
    /// @dev The read data point may belong to a Beacon or dAPI. The reader
    /// must be whitelisted for the hash of the data point name.
    /// @param name Data point name
    /// @return value Data point value
    /// @return timestamp Data point timestamp
    function readWithName(bytes32 name)
        external
        view
        override
        returns (int224 value, uint32 timestamp)
    {
        bytes32 nameHash = keccak256(abi.encodePacked(name));
        require(
            readerCanReadDataPoint(nameHash, msg.sender),
            "Sender cannot read"
        );
        DataPoint storage dataPoint = dataPoints[
            nameHashToDataPointId[nameHash]
        ];
        return (dataPoint.value, dataPoint.timestamp);
    }

    /// @notice Returns if a reader can read the data point
    /// @param dataPointId Data point ID (or data point name hash)
    /// @param reader Reader address
    /// @return If the reader can read the data point
    function readerCanReadDataPoint(bytes32 dataPointId, address reader)
        public
        view
        override
        returns (bool)
    {
        return
            reader == address(0) ||
            userIsWhitelisted(dataPointId, reader) ||
            IAccessControlRegistry(accessControlRegistry).hasRole(
                unlimitedReaderRole,
                reader
            );
    }

    /// @notice Returns the detailed whitelist status of the reader for the
    /// data point
    /// @param dataPointId Data point ID (or data point name hash)
    /// @param reader Reader address
    /// @return expirationTimestamp Timestamp at which the whitelisting of the
    /// reader will expire
    /// @return indefiniteWhitelistCount Number of times `reader` was
    /// whitelisted indefinitely for `dataPointId`
    function dataPointIdToReaderToWhitelistStatus(
        bytes32 dataPointId,
        address reader
    )
        external
        view
        override
        returns (uint64 expirationTimestamp, uint192 indefiniteWhitelistCount)
    {
        WhitelistStatus
            storage whitelistStatus = serviceIdToUserToWhitelistStatus[
                dataPointId
            ][reader];
        expirationTimestamp = whitelistStatus.expirationTimestamp;
        indefiniteWhitelistCount = whitelistStatus.indefiniteWhitelistCount;
    }

    /// @notice Returns if an account has indefinitely whitelisted the reader
    /// for the data point
    /// @param dataPointId Data point ID (or data point name hash)
    /// @param reader Reader address
    /// @param setter Address of the account that has potentially whitelisted
    /// the reader for the data point indefinitely
    /// @return indefiniteWhitelistStatus If `setter` has indefinitely
    /// whitelisted reader for the data point
    function dataPointIdToReaderToSetterToIndefiniteWhitelistStatus(
        bytes32 dataPointId,
        address reader,
        address setter
    ) external view override returns (bool indefiniteWhitelistStatus) {
        indefiniteWhitelistStatus = serviceIdToUserToSetterToIndefiniteWhitelistStatus[
            dataPointId
        ][reader][setter];
    }

    /// @notice Derives the Beacon ID from the Airnode address and template ID
    /// @param airnode Airnode address
    /// @param templateId Template ID
    /// @return beaconId Beacon ID
    function deriveBeaconId(address airnode, bytes32 templateId)
        public
        pure
        override
        returns (bytes32 beaconId)
    {
        require(airnode != address(0), "Airnode address zero");
        require(templateId != bytes32(0), "Template ID zero");
        beaconId = keccak256(abi.encodePacked(airnode, templateId));
    }

    /// @notice Derives the dAPI ID from the beacon IDs
    /// @dev Notice that `abi.encode()` is used over `abi.encodePacked()`
    /// @param beaconIds Beacon IDs
    /// @return dapiId dAPI ID
    function deriveDapiId(bytes32[] memory beaconIds)
        public
        pure
        override
        returns (bytes32 dapiId)
    {
        dapiId = keccak256(abi.encode(beaconIds));
    }

    /// @notice Called privately to process the Beacon update
    /// @param beaconId Beacon ID
    /// @param timestamp Timestamp used in the signature
    /// @param data Fulfillment data (an `int256` encoded in contract ABI)
    /// @return updatedBeaconValue Updated Beacon value
    function processBeaconUpdate(
        bytes32 beaconId,
        uint256 timestamp,
        bytes calldata data
    ) private returns (int256 updatedBeaconValue) {
        updatedBeaconValue = decodeFulfillmentData(data);
        require(
            timestamp > dataPoints[beaconId].timestamp,
            "Fulfillment older than Beacon"
        );
        // Timestamp validity is already checked by `onlyValidTimestamp`, which
        // means it will be small enough to be typecast into `uint32`
        dataPoints[beaconId] = DataPoint({
            value: int224(updatedBeaconValue),
            timestamp: uint32(timestamp)
        });
    }

    /// @notice Called privately to decode the fulfillment data
    /// @param data Fulfillment data (an `int256` encoded in contract ABI)
    /// @return decodedData Decoded fulfillment data
    function decodeFulfillmentData(bytes memory data)
        private
        pure
        returns (int224)
    {
        require(data.length == 32, "Data length not correct");
        int256 decodedData = abi.decode(data, (int256));
        require(
            decodedData >= type(int224).min && decodedData <= type(int224).max,
            "Value typecasting error"
        );
        return int224(decodedData);
    }

    /// @notice Called privately to decode the condition parameters
    /// @param conditionParameters Condition parameters (a `uint256` encoded in
    /// contract ABI)
    /// @return updateThresholdInPercentage Update threshold in percentage
    /// where 100% is represented as `HUNDRED_PERCENT`
    function decodeConditionParameters(bytes calldata conditionParameters)
        private
        pure
        returns (uint256 updateThresholdInPercentage)
    {
        require(conditionParameters.length == 32, "Incorrect parameter length");
        updateThresholdInPercentage = abi.decode(
            conditionParameters,
            (uint256)
        );
    }

    /// @notice Called privately to calculate the update magnitude in
    /// percentages where 100% is represented as `HUNDRED_PERCENT`
    /// @dev The percentage changes will be more pronounced when the first
    /// value is almost zero, which may trigger updates more frequently than
    /// wanted. To avoid this, Beacons should be defined in a way that the
    /// expected values are not small numbers floating around zero, i.e.,
    /// offset and scale.
    /// @param initialValue Initial value
    /// @param updatedValue Updated value
    /// @return updateInPercentage Update in percentage
    function calculateUpdateInPercentage(
        int224 initialValue,
        int224 updatedValue
    ) private pure returns (uint256 updateInPercentage) {
        int256 delta = int256(updatedValue) - int256(initialValue);
        uint256 absoluteDelta = delta > 0 ? uint256(delta) : uint256(-delta);
        uint256 absoluteInitialValue = initialValue > 0
            ? uint256(int256(initialValue))
            : uint256(-int256(initialValue));
        // Avoid division by 0
        if (absoluteInitialValue == 0) {
            absoluteInitialValue = 1;
        }
        updateInPercentage =
            (absoluteDelta * HUNDRED_PERCENT) /
            absoluteInitialValue;
    }
}
