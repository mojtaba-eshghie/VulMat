// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Fomalhaut Release Smart Contract Audit/synthetix-95d73f7b74483e72fffe1f8ee90f037a2f7b8773/contracts/Owned.sol

pragma solidity ^0.5.16;


// https://docs.synthetix.io/contracts/Owned
contract Owned {
    address public owner;
    address public nominatedOwner;

    constructor(address _owner) public {
        require(_owner != address(0), "Owner address cannot be 0");
        owner = _owner;
        emit OwnerChanged(address(0), _owner);
    }

    function nominateNewOwner(address _owner) external onlyOwner {
        nominatedOwner = _owner;
        emit OwnerNominated(_owner);
    }

    function acceptOwnership() external {
        require(msg.sender == nominatedOwner, "You must be nominated before you can accept ownership");
        emit OwnerChanged(owner, nominatedOwner);
        owner = nominatedOwner;
        nominatedOwner = address(0);
    }

    modifier onlyOwner {
        _onlyOwner();
        _;
    }

    function _onlyOwner() private view {
        require(msg.sender == owner, "Only the contract owner may perform this action");
    }

    event OwnerNominated(address newOwner);
    event OwnerChanged(address oldOwner, address newOwner);
}

// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Fomalhaut Release Smart Contract Audit/synthetix-95d73f7b74483e72fffe1f8ee90f037a2f7b8773/contracts/DappMaintenance.sol

pragma solidity ^0.5.16;

/**
 * @title DappMaintenance contract.
 * @dev When the Synthetix system is on maintenance (upgrade, release...etc) the dApps also need
 * to be put on maintenance so no transactions can be done. The DappMaintenance contract is here to keep a state of
 * the dApps which indicates if yes or no, they should be up or down.
 */
contract DappMaintenance is Owned {
    bool public isPausedStaking = false;
    bool public isPausedSX = false;

    /**
     * @dev Constructor
     */
    constructor(address _owner) public Owned(_owner) {
        require(_owner != address(0), "Owner address cannot be 0");
        owner = _owner;
        emit OwnerChanged(address(0), _owner);
    }

    function setMaintenanceModeAll(bool isPaused) external onlyOwner {
        isPausedStaking = isPaused;
        isPausedSX = isPaused;
        emit StakingMaintenance(isPaused);
        emit SXMaintenance(isPaused);
    }

    function setMaintenanceModeStaking(bool isPaused) external onlyOwner {
        isPausedStaking = isPaused;
        emit StakingMaintenance(isPausedStaking);
    }

    function setMaintenanceModeSX(bool isPaused) external onlyOwner {
        isPausedSX = isPaused;
        emit SXMaintenance(isPausedSX);
    }

    event StakingMaintenance(bool isPaused);
    event SXMaintenance(bool isPaused);
}
