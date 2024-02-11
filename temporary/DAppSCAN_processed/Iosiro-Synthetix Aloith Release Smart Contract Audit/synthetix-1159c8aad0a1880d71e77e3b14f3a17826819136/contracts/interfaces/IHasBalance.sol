// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Aloith Release Smart Contract Audit/synthetix-1159c8aad0a1880d71e77e3b14f3a17826819136/contracts/interfaces/IHasBalance.sol

pragma solidity >=0.4.24;

// https://docs.synthetix.io/contracts/source/interfaces/ihasbalance
interface IHasBalance {
    // Views
    function balanceOf(address account) external view returns (uint);
}
