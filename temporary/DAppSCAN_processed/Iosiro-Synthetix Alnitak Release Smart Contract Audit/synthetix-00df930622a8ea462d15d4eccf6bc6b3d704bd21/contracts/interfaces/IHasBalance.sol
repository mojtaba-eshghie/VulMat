// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-00df930622a8ea462d15d4eccf6bc6b3d704bd21/contracts/interfaces/IHasBalance.sol

pragma solidity >=0.4.24;

// https://docs.synthetix.io/contracts/source/interfaces/ihasbalance
interface IHasBalance {
    // Views
    function balanceOf(address account) external view returns (uint);
}
