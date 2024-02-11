// File: ../sc_datasets/DAppSCAN/consensys-1inch_Liquidity_Protocol/liquidity-protocol-d3652c992073efed6367ff93f9e8a18dcbd80e9c/contracts/interfaces/IMooniswapFactoryGovernance.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;


interface IMooniswapFactoryGovernance {
    function parameters() external view returns(uint256 referralShare, uint256 governanceShare, address governanceFeeReceiver, address referralFeeReceiver);

    function defaultFee() external view returns(uint256);
    function defaultSlippageFee() external view returns(uint256);
    function defaultDecayPeriod() external view returns(uint256);
    function referralShare() external view returns(uint256);
    function governanceShare() external view returns(uint256);
    function governanceFeeReceiver() external view returns(address);
    function referralFeeReceiver() external view returns(address);
}
