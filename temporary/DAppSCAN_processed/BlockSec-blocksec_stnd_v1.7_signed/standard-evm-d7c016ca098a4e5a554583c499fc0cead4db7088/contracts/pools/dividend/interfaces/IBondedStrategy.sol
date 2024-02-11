// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_stnd_v1.7_signed/standard-evm-d7c016ca098a4e5a554583c499fc0cead4db7088/contracts/pools/dividend/interfaces/IBondedStrategy.sol

// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

interface IBondedStrategy {
    function stnd() external view returns (address);
    function totalSupply() external view returns (uint256);
    function bonded(address holder) external view returns (uint256);
    function claim(address token) external returns (bool success);

    event DividendClaimed(address claimer, address claimingWith, uint256 amount);
    event Bonded(address holder, uint256 amount);
    event UnBonded(address holder, uint256 amount);
}
