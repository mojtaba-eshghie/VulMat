// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-Zunami_protocol/ZunamiProtocol-37dccabf5aa3697dce5eaf6457debb3ac7404fdd/contracts/interfaces/IConvexBooster.sol

//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

interface IConvexBooster {
    function depositAll(uint256 pid, bool stake) external returns (bool);

    function withdrawAll(uint256 pid) external returns (bool);

    function balanceOf(address account) external view returns (uint256);

    function withdraw(uint256 pid, uint256 amount) external returns (bool);
}
