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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/utils/interfaces/IRegistryRolesWithManager.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IRegistryRolesWithManager is IAccessControlRegistryAdminned {
    // solhint-disable-next-line func-name-mixedcase
    function REGISTRAR_ROLE_DESCRIPTION() external view returns (string memory);

    function registrarRole() external view returns (bytes32);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/utils/RegistryRolesWithManager.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


/// @title Contract that implements generic AccessControlRegistry roles for a
/// registry contract
contract RegistryRolesWithManager is
    AccessControlRegistryAdminnedWithManager,
    IRegistryRolesWithManager
{
    /// @notice Registrar role description
    string public constant override REGISTRAR_ROLE_DESCRIPTION = "Registrar";

    /// @notice Registrar role
    bytes32 public registrarRole;

    /// @dev Reverts if the sender is not the manager and does not have the
    /// registrar role
    modifier onlyRegistrarOrManager() {
        require(
            msg.sender == manager ||
                IAccessControlRegistry(accessControlRegistry).hasRole(
                    registrarRole,
                    msg.sender
                ),
            "Sender cannot register"
        );
        _;
    }

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
        registrarRole = _deriveRole(adminRole, REGISTRAR_ROLE_DESCRIPTION);
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/utils/interfaces/IUint256Registry.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IUint256Registry is IRegistryRolesWithManager {
    function tryReadRegisteredUint256(bytes32 id)
        external
        view
        returns (bool success, uint256 uint256_);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/utils/Uint256Registry.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


/// @title Registry with manager that maps IDs to unsigned integers
/// @dev Does not allow zero to be registered as a number
contract Uint256Registry is RegistryRolesWithManager, IUint256Registry {
    mapping(bytes32 => uint256) private idToUint256;

    /// @param _accessControlRegistry AccessControlRegistry contract address
    /// @param _adminRoleDescription Admin role description
    /// @param _manager Manager address
    constructor(
        address _accessControlRegistry,
        string memory _adminRoleDescription,
        address _manager
    )
        RegistryRolesWithManager(
            _accessControlRegistry,
            _adminRoleDescription,
            _manager
        )
    {}

    /// @notice Returns if there is a registered unsigned integer with the ID
    /// and the registered unsigned integer and what it is
    /// @param id Registry ID
    /// @return success If there is a registered unsigned integer with the ID
    /// @return uint256_ Registered unsigned integer
    function tryReadRegisteredUint256(bytes32 id)
        public
        view
        override
        returns (bool success, uint256 uint256_)
    {
        uint256_ = idToUint256[id];
        success = uint256_ != 0;
    }

    /// @notice Called by registrars or the manager to register the unsigned
    /// integer with the ID
    /// @param id Registry ID
    /// @param uint256_ Unsigned integer to be registered
    function _registerUint256(bytes32 id, uint256 uint256_)
        internal
        onlyRegistrarOrManager
    {
        require(uint256_ != 0, "Cannot register zero");
        idToUint256[id] = uint256_;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/monetization/interfaces/IAirnodeEndpointPriceRegistry.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAirnodeEndpointPriceRegistry {
    event RegisterDefaultPrice(uint256 price, address sender);

    event RegisterDefaultChainPrice(
        uint256 chainId,
        uint256 price,
        address sender
    );

    event RegisterAirnodePrice(address airnode, uint256 price, address sender);

    event RegisterAirnodeChainPrice(
        address airnode,
        uint256 chainId,
        uint256 price,
        address sender
    );

    event RegisterAirnodeEndpointPrice(
        address airnode,
        bytes32 endpointId,
        uint256 price,
        address sender
    );

    event RegisterAirnodeChainEndpointPrice(
        address airnode,
        uint256 chainId,
        bytes32 endpointId,
        uint256 price,
        address sender
    );

    event SetEndpointAndChainPricePriority(
        address indexed airnode,
        bool status,
        address sender
    );

    function registerDefaultPrice(uint256 price) external;

    function registerDefaultChainPrice(uint256 chainId, uint256 price) external;

    function registerAirnodePrice(address airnode, uint256 price) external;

    function registerAirnodeChainPrice(
        address airnode,
        uint256 chainId,
        uint256 price
    ) external;

    function registerAirnodeEndpointPrice(
        address airnode,
        bytes32 endpointId,
        uint256 price
    ) external;

    function registerAirnodeChainEndpointPrice(
        address airnode,
        uint256 chainId,
        bytes32 endpointId,
        uint256 price
    ) external;

    function setEndpointAndChainPricePriority(address airnode, bool status)
        external;

    function tryReadDefaultPrice()
        external
        view
        returns (bool success, uint256 price);

    function tryReadDefaultChainPrice(uint256 chainId)
        external
        view
        returns (bool success, uint256 price);

    function tryReadAirnodePrice(address airnode)
        external
        view
        returns (bool success, uint256 price);

    function tryReadAirnodeChainPrice(address airnode, uint256 chainId)
        external
        view
        returns (bool success, uint256 price);

    function tryReadAirnodeEndpointPrice(address airnode, bytes32 endpointId)
        external
        view
        returns (bool success, uint256 price);

    function tryReadAirnodeChainEndpointPrice(
        address airnode,
        uint256 chainId,
        bytes32 endpointId
    ) external view returns (bool success, uint256 price);

    function getPrice(
        address airnode,
        uint256 chainId,
        bytes32 endpointId
    ) external view returns (uint256 price);

    function prioritizeEndpointPriceOverChainPrice(address airnode)
        external
        view
        returns (bool);

    // solhint-disable-next-line func-name-mixedcase
    function DENOMINATION() external view returns (string memory);

    // solhint-disable-next-line func-name-mixedcase
    function DECIMALS() external view returns (uint256);

    // solhint-disable-next-line func-name-mixedcase
    function PRICING_INTERVAL() external view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/monetization/AirnodeEndpointPriceRegistry.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


/// @title Registry for prices of accessing Airnode endpoints across chains
/// @notice AirnodeEndpointPriceRegistry is a central contract that can be queried for
/// the USD price of an Airnode–chain–endpoint pair
contract AirnodeEndpointPriceRegistry is
    Uint256Registry,
    IAirnodeEndpointPriceRegistry
{
    /// @notice A flag to determine which price to default to
    /// @dev See `getPrice()` for details
    mapping(address => bool)
        public
        override prioritizeEndpointPriceOverChainPrice;

    /// @notice Denomination used to specify the prices
    string public constant override DENOMINATION = "USD";

    /// @notice Decimals used to specify the prices
    uint256 public constant override DECIMALS = 18;

    /// @notice Pricing interval used to specify the prices
    uint256 public constant override PRICING_INTERVAL = 30 days;

    bytes32 private constant DEFAULT_PRICE_ID =
        keccak256(abi.encodePacked("Default price"));

    bytes32 private constant SALT =
        keccak256(abi.encodePacked("Salt to avoid hash collision"));

    /// @dev Reverts if the Airnode address is zero
    /// @param airnode Airnode address
    modifier onlyNonZeroAirnode(address airnode) {
        require(airnode != address(0), "Airnode address zero");
        _;
    }

    /// @dev Reverts if the chain ID is zero
    /// @param chainId Chain ID
    modifier onlyNonZeroChainId(uint256 chainId) {
        require(chainId != 0, "Chain ID zero");
        _;
    }

    /// @param _accessControlRegistry AccessControlRegistry contract address
    /// @param _adminRoleDescription Admin role description
    /// @param _manager Manager address
    constructor(
        address _accessControlRegistry,
        string memory _adminRoleDescription,
        address _manager
    )
        Uint256Registry(_accessControlRegistry, _adminRoleDescription, _manager)
    {}

    /// @notice Called by registrars or the manager to register the
    /// default price
    /// @param price 30 day price in USD (times 10^18)
    function registerDefaultPrice(uint256 price)
        external
        override
        onlyRegistrarOrManager
    {
        _registerUint256(DEFAULT_PRICE_ID, price);
        emit RegisterDefaultPrice(price, msg.sender);
    }

    /// @notice Called by registrars or the manager to register the
    /// default chain price
    /// @param chainId Chain ID
    /// @param price 30 day price in USD (times 10^18)
    function registerDefaultChainPrice(uint256 chainId, uint256 price)
        external
        override
        onlyRegistrarOrManager
        onlyNonZeroChainId(chainId)
    {
        _registerUint256(
            keccak256(abi.encodePacked(DEFAULT_PRICE_ID, chainId)),
            price
        );
        emit RegisterDefaultChainPrice(chainId, price, msg.sender);
    }

    /// @notice Called by registrars or the manager to register the
    /// Airnode price
    /// @param airnode Airnode address
    /// @param price 30 day price in USD (times 10^18)
    function registerAirnodePrice(address airnode, uint256 price)
        external
        override
        onlyRegistrarOrManager
        onlyNonZeroAirnode(airnode)
    {
        _registerUint256(keccak256(abi.encodePacked(airnode)), price);
        emit RegisterAirnodePrice(airnode, price, msg.sender);
    }

    /// @notice Called by registrars or the manager to register the
    /// Airnode, chain price
    /// @param airnode Airnode address
    /// @param chainId Chain ID
    /// @param price 30 day price in USD (times 10^18)
    function registerAirnodeChainPrice(
        address airnode,
        uint256 chainId,
        uint256 price
    )
        external
        override
        onlyRegistrarOrManager
        onlyNonZeroAirnode(airnode)
        onlyNonZeroChainId(chainId)
    {
        _registerUint256(keccak256(abi.encodePacked(airnode, chainId)), price);
        emit RegisterAirnodeChainPrice(airnode, chainId, price, msg.sender);
    }

    /// @notice Called by registrars or the manager to register the
    /// Airnode, endpoint price
    /// @dev The registry ID hash is salted in case the Airnode is not using
    /// hashes for `endpointId` as they are supposed to and numbers instead,
    /// which may be the same as chain IDs and result in collision
    /// @param airnode Airnode address
    /// @param endpointId Endpoint ID (allowed to be `bytes32(0)`)
    /// @param price 30 day price in USD (times 10^18)
    function registerAirnodeEndpointPrice(
        address airnode,
        bytes32 endpointId,
        uint256 price
    ) external override onlyRegistrarOrManager onlyNonZeroAirnode(airnode) {
        _registerUint256(
            keccak256(abi.encodePacked(SALT, airnode, endpointId)),
            price
        );
        emit RegisterAirnodeEndpointPrice(
            airnode,
            endpointId,
            price,
            msg.sender
        );
    }

    /// @notice Called by registrars or the manager to register the
    /// Airnode, chain, endpoint price
    /// @param airnode Airnode address
    /// @param chainId Chain ID
    /// @param endpointId Endpoint ID (allowed to be `bytes32(0)`)
    /// @param price 30 day price in USD (times 10^18)
    function registerAirnodeChainEndpointPrice(
        address airnode,
        uint256 chainId,
        bytes32 endpointId,
        uint256 price
    )
        external
        override
        onlyRegistrarOrManager
        onlyNonZeroAirnode(airnode)
        onlyNonZeroChainId(chainId)
    {
        _registerUint256(
            keccak256(abi.encodePacked(airnode, chainId, endpointId)),
            price
        );
        emit RegisterAirnodeChainEndpointPrice(
            airnode,
            chainId,
            endpointId,
            price,
            msg.sender
        );
    }

    /// @notice Sets if the endpoint or the chain price will be prioritized
    /// for the Airnode
    /// @param airnode Airnode address
    /// @param status Flag status, `true` prioritizes the endpoint price,
    /// `false` prioritizes the chain price (default)
    function setEndpointAndChainPricePriority(address airnode, bool status)
        external
        override
        onlyRegistrarOrManager
        onlyNonZeroAirnode(airnode)
    {
        prioritizeEndpointPriceOverChainPrice[airnode] = status;
        emit SetEndpointAndChainPricePriority(airnode, status, msg.sender);
    }

    /// @notice Returns if there is a registered default price and what it is
    /// @return success If the price was registered
    /// @return price 30 day price in USD (times 10^18)
    function tryReadDefaultPrice()
        public
        view
        override
        returns (bool success, uint256 price)
    {
        (success, price) = tryReadRegisteredUint256(DEFAULT_PRICE_ID);
    }

    /// @notice Returns if there is a registered default chain price and what
    /// it is
    /// @param chainId Chain ID
    /// @return success If the price was registered
    /// @return price 30 day price in USD (times 10^18)
    function tryReadDefaultChainPrice(uint256 chainId)
        public
        view
        override
        returns (bool success, uint256 price)
    {
        (success, price) = tryReadRegisteredUint256(
            keccak256(abi.encodePacked(DEFAULT_PRICE_ID, chainId))
        );
    }

    /// @notice Returns if there is a registered Airnode price and what it is
    /// @param airnode Airnode address
    /// @return success If the price was registered
    /// @return price 30 day price in USD (times 10^18)
    function tryReadAirnodePrice(address airnode)
        public
        view
        override
        returns (bool success, uint256 price)
    {
        (success, price) = tryReadRegisteredUint256(
            keccak256(abi.encodePacked(airnode))
        );
    }

    /// @notice Returns if there is a registered Airnode, chain price and what
    /// it is
    /// @param airnode Airnode address
    /// @param chainId Chain ID
    /// @return success If the price was registered
    /// @return price 30 day price in USD (times 10^18)
    function tryReadAirnodeChainPrice(address airnode, uint256 chainId)
        public
        view
        override
        returns (bool success, uint256 price)
    {
        (success, price) = tryReadRegisteredUint256(
            keccak256(abi.encodePacked(airnode, chainId))
        );
    }

    /// @notice Returns if there is a registered Airnode, endpoint price and
    /// what it is
    /// @dev The registry ID hash is salted in case the Airnode is not using
    /// hashes for `endpointId` as they are supposed to and numbers instead,
    /// which may be the same as chain IDs and result in collision.
    /// @param airnode Airnode address
    /// @param endpointId Endpoint ID
    /// @return success If the price was registered
    /// @return price 30 day price in USD (times 10^18)
    function tryReadAirnodeEndpointPrice(address airnode, bytes32 endpointId)
        public
        view
        override
        returns (bool success, uint256 price)
    {
        (success, price) = tryReadRegisteredUint256(
            keccak256(abi.encodePacked(SALT, airnode, endpointId))
        );
    }

    /// @notice Returns if there is a registered Airnode, chain, endpoint price
    /// and what it is
    /// @param airnode Airnode address
    /// @param chainId Chain ID
    /// @param endpointId Endpoint ID
    /// @return success If the price was registered
    /// @return price 30 day price in USD (times 10^18)
    function tryReadAirnodeChainEndpointPrice(
        address airnode,
        uint256 chainId,
        bytes32 endpointId
    ) public view override returns (bool success, uint256 price) {
        (success, price) = tryReadRegisteredUint256(
            keccak256(abi.encodePacked(airnode, chainId, endpointId))
        );
    }

    /// @notice Returns the price that should be used for the given Airnode,
    /// chain and endpoint
    /// @dev The logic prioritizes more specific prices over less specific
    /// prices. There is ambiguity in if Airnode + chain or Airnode + endpoint
    /// should be prioritized, which we made to configurable (defaults to
    /// prioritizing Airnode + chain).
    /// Reverts if no price is set.
    /// @param airnode Airnode address
    /// @param chainId Chain ID
    /// @param endpointId Endpoint ID
    /// @return price 30 day price in USD (times 10^18)
    function getPrice(
        address airnode,
        uint256 chainId,
        bytes32 endpointId
    ) external view override returns (uint256 price) {
        bool success;
        (success, price) = tryReadAirnodeChainEndpointPrice(
            airnode,
            chainId,
            endpointId
        );
        if (success) {
            return price;
        }
        if (prioritizeEndpointPriceOverChainPrice[airnode]) {
            (success, price) = tryReadAirnodeEndpointPrice(airnode, endpointId);
            if (success) {
                return price;
            }
            (success, price) = tryReadAirnodeChainPrice(airnode, chainId);
            if (success) {
                return price;
            }
        } else {
            (success, price) = tryReadAirnodeChainPrice(airnode, chainId);
            if (success) {
                return price;
            }
            (success, price) = tryReadAirnodeEndpointPrice(airnode, endpointId);
            if (success) {
                return price;
            }
        }
        (success, price) = tryReadAirnodePrice(airnode);
        if (success) {
            return price;
        }
        (success, price) = tryReadDefaultChainPrice(chainId);
        if (success) {
            return price;
        }
        (success, price) = tryReadDefaultPrice();
        require(success, "No default price set");
    }
}
