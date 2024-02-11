// File: ../sc_datasets/DAppSCAN/PeckShield-Convex_Frax/frax-cvx-platform-2f8573ee796daa022c1050b4a749bf08049c439b/contracts/contracts/interfaces/IVoteEscrow.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface IVoteEscrow {
    function locked(address) external view returns(uint256);
    function locked__end(address) external view returns(uint256);
    function create_lock(uint256, uint256) external;
    function increase_amount(uint256) external;
    function increase_unlock_time(uint256) external;
    function withdraw() external;
    function checkpoint() external;
    function smart_wallet_checker() external view returns (address);
}
