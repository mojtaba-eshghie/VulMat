// File: ../sc_datasets/DAppSCAN/Ackee_Blockchain-Zunami_protocol/ZunamiProtocol-37dccabf5aa3697dce5eaf6457debb3ac7404fdd/contracts/interfaces/IConvexRewards.sol

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IConvexRewards {
    function balanceOf(address account) external view returns (uint256);

    function earned(address account) external view returns (uint256);

    function rewardRate() external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function withdrawAllAndUnwrap(bool claim) external;

    function withdrawAndUnwrap(uint256 amount, bool claim) external;
}
