// File: ../sc_datasets/DAppSCAN/QuillAudits-AliumSwap Smart Contract/alium-swap-periphery-6aff4c5ad4695b77358eae0627c98d72621256bc/contracts/interfaces/IAliumCallee.sol

pragma solidity >=0.5.0;

interface IAliumCallee {
    function aliumCall(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
