// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-PoolTogether - Pods/pods-v3-contracts-879dc8b911fc506dd6bead1f36eade919ccfea57/contracts/interfaces/uniswap/IUniswapV2Callee.sol

pragma solidity >=0.5.0;

interface IUniswapV2Callee {
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
