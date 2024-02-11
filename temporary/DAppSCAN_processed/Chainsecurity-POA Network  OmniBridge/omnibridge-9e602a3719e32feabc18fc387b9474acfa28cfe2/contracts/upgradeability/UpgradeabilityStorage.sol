// File: ../sc_datasets/DAppSCAN/Chainsecurity-POA Network  OmniBridge/omnibridge-9e602a3719e32feabc18fc387b9474acfa28cfe2/contracts/upgradeability/UpgradeabilityStorage.sol

pragma solidity 0.7.5;

/**
 * @title UpgradeabilityStorage
 * @dev This contract holds all the necessary state variables to support the upgrade functionality
 */
contract UpgradeabilityStorage {
    // Version name of the current implementation
    uint256 internal _version;

    // Address of the current implementation
    address internal _implementation;

    /**
     * @dev Tells the version name of the current implementation
     * @return uint256 representing the name of the current version
     */
    function version() external view returns (uint256) {
        return _version;
    }

    /**
     * @dev Tells the address of the current implementation
     * @return address of the current implementation
     */
    function implementation() public view virtual returns (address) {
        return _implementation;
    }
}
