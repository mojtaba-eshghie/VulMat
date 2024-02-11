// File: ../sc_datasets/DAppSCAN/QuillAudits-AliumSwap Smart Contract/alium-swap-periphery-6aff4c5ad4695b77358eae0627c98d72621256bc/contracts/interfaces/IAliumMigrator.sol

pragma solidity >=0.5.0;

interface IAliumMigrator {
    function migrate(address token, uint amountTokenMin, uint amountETHMin, address to, uint deadline) external;
}
