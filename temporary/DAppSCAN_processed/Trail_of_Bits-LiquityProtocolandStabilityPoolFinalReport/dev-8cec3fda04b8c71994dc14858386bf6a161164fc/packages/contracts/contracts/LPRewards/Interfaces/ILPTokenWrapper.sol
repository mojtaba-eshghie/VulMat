// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-LiquityProtocolandStabilityPoolFinalReport/dev-8cec3fda04b8c71994dc14858386bf6a161164fc/packages/contracts/contracts/LPRewards/Interfaces/ILPTokenWrapper.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;


interface ILPTokenWrapper {
    function stake(uint256 amount) external;
    function withdraw(uint256 amount) external;
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
}
