// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/Roles.sol

pragma solidity 0.4.25;

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
    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0));
        return role.bearer[account];
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/ManagerRole.sol

pragma solidity 0.4.25;

contract ManagerRole {

    event HumanManagerAdded(address indexed account);
    event HumanManagerRemoved(address indexed account);
    event ContractManagerAdded(address indexed account);

    address public feeManager;
    address public settingsManager;
    address public tBoxManager;

    constructor () internal {
        settingsManager = msg.sender;
        feeManager = msg.sender;
    }

    modifier onlyFeeManager() {
        require(isFeeManager(msg.sender));
        _;
    }

    modifier onlySettingsManager() {
        require(isSettingsManager(msg.sender));
        _;
    }

    modifier onlyManagerContract() {
        require(isContractManager(msg.sender));
        _;
    }

    function isFeeManager(address account) public view returns (bool) {
        return account == feeManager;
    }

    function isSettingsManager(address account) public view returns (bool) {
        return account == settingsManager;
    }

    function isContractManager(address account) public view returns (bool) {
        return account == tBoxManager;
    }

    function setContractManager(address account) public onlySettingsManager {
        _setContract(account);
    }

    function changeFeeManager(address account) public onlyFeeManager {
        require(account != address(0));
        feeManager = account;
    }

    function renounceSettingsManager() public onlySettingsManager {
        settingsManager = address(0);
    }


    function _setContract(address account) internal {
        tBoxManager = account;
        emit ContractManagerAdded(account);
    }
}
