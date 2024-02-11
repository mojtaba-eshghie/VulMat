// File: ../sc_datasets/DAppSCAN/PeckShield-VeChain/vvet-818fa11f7595e257cb28fa5475c17c60c11a4902/vvet/interfaces/IEnergy.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

interface IEnergy {
	function balanceOf(address _owner) external view returns(uint256);
	function transfer(address _to, uint256 _amount) external returns(bool);
}
