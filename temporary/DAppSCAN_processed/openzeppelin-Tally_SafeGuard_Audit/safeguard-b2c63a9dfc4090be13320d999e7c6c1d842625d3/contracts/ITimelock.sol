// File: ../sc_datasets/DAppSCAN/openzeppelin-Tally_SafeGuard_Audit/safeguard-b2c63a9dfc4090be13320d999e7c6c1d842625d3/contracts/ITimelock.sol

pragma solidity ^0.8.0;

interface ITimelock {
    function delay() external view returns (uint);
    function GRACE_PERIOD() external view returns (uint);
    function acceptAdmin() external;
    function queuedTransactions(bytes32 hash) external view returns (bool);
    function queueTransaction(address target, uint value, string calldata signature, bytes calldata data, uint eta) external returns (bytes32);
    function cancelTransaction(address target, uint value, string calldata signature, bytes calldata data, uint eta) external;
    function executeTransaction(address target, uint value, string calldata signature, bytes calldata data, uint eta) external payable returns (bytes memory);
}
