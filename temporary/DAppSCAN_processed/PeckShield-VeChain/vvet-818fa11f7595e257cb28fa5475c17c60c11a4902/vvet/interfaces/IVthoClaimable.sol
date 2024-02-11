// File: ../sc_datasets/DAppSCAN/PeckShield-VeChain/vvet-818fa11f7595e257cb28fa5475c17c60c11a4902/vvet/interfaces/IVthoClaimable.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

interface IVthoClaimable {
    function claimVTHO(address to, uint256 amount) external returns (bool);
}
