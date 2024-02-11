// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-YieldProtocol/fyDai-4422fda75931f2bfea49f5041ec90dc026e5c03d/contracts/helpers/Delegable.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.10;


/// @dev Delegable enables users to delegate their account management to other users
contract Delegable {
    event Delegate(address indexed user, address indexed delegate, bool enabled);

    mapping(address => mapping(address => bool)) public delegated;

    /// @dev Require that msg.sender is the account holder or a delegate
    modifier onlyHolderOrDelegate(address holder, string memory errorMessage) {
        require(
            msg.sender == holder || delegated[holder][msg.sender],
            errorMessage
        );
        _;
    }

    /// @dev Enable a delegate to act on the behalf of caller
    function addDelegate(address delegate) public {
        delegated[msg.sender][delegate] = true;
        emit Delegate(msg.sender, delegate, true);
    }

    /// @dev Stop a delegate from acting on the behalf of caller
    function revokeDelegate(address delegate) public {
        delegated[msg.sender][delegate] = false;
        emit Delegate(msg.sender, delegate, false);
    }
}
