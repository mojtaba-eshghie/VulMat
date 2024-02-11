// File: ../sc_datasets/DAppSCAN/PeckShield-VeChain/vvet-818fa11f7595e257cb28fa5475c17c60c11a4902/vvet/interfaces/IStakingModel.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

interface IStakingModel {
    function vetBalance(address addr) external view returns (uint256 amount);
    function vthoBalance(address addr) external view returns (uint256 amount);    
}
