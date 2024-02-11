// File: ../sc_datasets/DAppSCAN/QuillAudits-AliumSwap Smart Contract/alium-swap-periphery-6aff4c5ad4695b77358eae0627c98d72621256bc/contracts/interfaces/V1/IUniswapV1Exchange.sol

pragma solidity >=0.5.0;

interface IUniswapV1Exchange {
    function balanceOf(address owner) external view returns (uint);
    function transferFrom(address from, address to, uint value) external returns (bool);
    function removeLiquidity(uint, uint, uint, uint) external returns (uint, uint);
    function tokenToEthSwapInput(uint, uint, uint) external returns (uint);
    function ethToTokenSwapInput(uint, uint) external payable returns (uint);
}
