// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/access/Roles.sol

pragma solidity ^0.4.24;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
  struct Role {
    mapping (address => bool) bearer;
  }

  /**
   * @dev give an account access to this role
   */
  function add(Role storage role, address account) internal {
    require(account != address(0));
    require(!has(role, account));

    role.bearer[account] = true;
  }

  /**
   * @dev remove an account's access to this role
   */
  function remove(Role storage role, address account) internal {
    require(account != address(0));
    require(has(role, account));

    role.bearer[account] = false;
  }

  /**
   * @dev check if an account has this role
   * @return bool
   */
  function has(Role storage role, address account)
    internal
    view
    returns (bool)
  {
    require(account != address(0));
    return role.bearer[account];
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/access/roles/PauserRole.sol

pragma solidity ^0.4.24;

contract PauserRole {
  using Roles for Roles.Role;

  event PauserAdded(address indexed account);
  event PauserRemoved(address indexed account);

  Roles.Role private pausers;

  constructor() internal {
    _addPauser(msg.sender);
  }

  modifier onlyPauser() {
    require(isPauser(msg.sender));
    _;
  }

  function isPauser(address account) public view returns (bool) {
    return pausers.has(account);
  }

  function addPauser(address account) public onlyPauser {
    _addPauser(account);
  }

  function renouncePauser() public {
    _removePauser(msg.sender);
  }

  function _addPauser(address account) internal {
    pausers.add(account);
    emit PauserAdded(account);
  }

  function _removePauser(address account) internal {
    pausers.remove(account);
    emit PauserRemoved(account);
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/mocks/PauserRoleMock.sol

pragma solidity ^0.4.24;

contract PauserRoleMock is PauserRole {
  function removePauser(address account) public {
    _removePauser(account);
  }

  function onlyPauserMock() public view onlyPauser {
  }

  // Causes a compilation error if super._removePauser is not internal
  function _removePauser(address account) internal {
    super._removePauser(account);
  }
}
