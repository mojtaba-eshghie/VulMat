// File: ../sc_datasets/DAppSCAN/consensys-AZTEC_Protocol/AZTEC-develop/packages/protocol/contracts/interfaces/ProxyAdmin.sol

pragma solidity ^0.5.0;

/**
 * @title ProxyAdmin
 * @dev Minimal interface for the proxy contract
 */
contract ProxyAdmin {
    function admin() external returns (address);

    function upgradeTo(address _newImplementation) external;

    function changeAdmin(address _newAdmin) external;
}
