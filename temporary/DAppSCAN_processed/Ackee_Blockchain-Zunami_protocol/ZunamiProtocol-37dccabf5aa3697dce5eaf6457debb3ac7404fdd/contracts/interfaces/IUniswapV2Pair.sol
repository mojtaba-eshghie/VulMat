// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-Zunami_protocol/ZunamiProtocol-37dccabf5aa3697dce5eaf6457debb3ac7404fdd/contracts/interfaces/IUniswapV2Pair.sol

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IUniswapV2Pair {
    function getReserves()
        external
        view
        returns (
            uint112,
            uint112,
            uint32
        );

    function token0() external view returns (address);

    function token1() external view returns (address);
}
