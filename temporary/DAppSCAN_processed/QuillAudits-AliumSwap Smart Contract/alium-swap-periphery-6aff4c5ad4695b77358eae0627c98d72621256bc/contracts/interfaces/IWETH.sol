// File: ../sc_datasets/DAppSCAN/QuillAudits-AliumSwap Smart Contract/alium-swap-periphery-6aff4c5ad4695b77358eae0627c98d72621256bc/contracts/interfaces/IWETH.sol

pragma solidity >=0.5.0;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}
