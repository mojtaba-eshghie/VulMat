// File: ../sc_datasets/DAppSCAN/Chainsulting-UNILAYERX/openzeppelin-contracts-2.3.0/contracts/access/Roles.sol

// SWC-Floating Pragma: L2
pragma solidity ^0.5.0;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }

    /**
     * @dev Give an account access to this role.
     */
    function add(Role storage role, address account) internal {
        require(!has(role, account), "Roles: account already has role");
        role.bearer[account] = true;
    }

    /**
     * @dev Remove an account's access to this role.
     */
    function remove(Role storage role, address account) internal {
        require(has(role, account), "Roles: account does not have role");
        role.bearer[account] = false;
    }

    /**
     * @dev Check if an account has this role.
     * @return bool
     */
    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0), "Roles: account is the zero address");
        return role.bearer[account];
    }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-UNILAYERX/openzeppelin-contracts-2.3.0/contracts/mocks/RolesMock.sol

pragma solidity ^0.5.0;

contract RolesMock {
    using Roles for Roles.Role;

    Roles.Role private dummyRole;

    function add(address account) public {
        dummyRole.add(account);
    }

    function remove(address account) public {
        dummyRole.remove(account);
    }

    function has(address account) public view returns (bool) {
        return dummyRole.has(account);
    }
}
