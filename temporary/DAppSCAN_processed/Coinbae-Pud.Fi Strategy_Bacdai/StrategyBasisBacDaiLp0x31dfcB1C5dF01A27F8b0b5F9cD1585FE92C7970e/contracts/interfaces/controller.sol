// File: ../sc_datasets/DAppSCAN/Coinbae-Pud.Fi Strategy_Bacdai/StrategyBasisBacDaiLp0x31dfcB1C5dF01A27F8b0b5F9cD1585FE92C7970e/contracts/interfaces/controller.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

interface IController {
    function jars(address) external view returns (address);

    function rewards() external view returns (address);

    function devaddr() external view returns (address);

    function treasury() external view returns (address);

    function balanceOf(address) external view returns (uint256);

    function withdraw(address, uint256) external;

    function earn(address, uint256) external;
}
