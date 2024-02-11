// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-Zunami_protocol/ZunamiProtocol-37dccabf5aa3697dce5eaf6457debb3ac7404fdd/contracts/interfaces/IZunami.sol

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IZunami {
    function totalSupply() external returns (uint256);

    function totalDeposited() external returns (uint256);

    function deposited(address account) external returns (uint256);

    function totalHoldings() external returns (uint256);

    function calcManagementFee(uint256 amount) external returns (uint256);
}
