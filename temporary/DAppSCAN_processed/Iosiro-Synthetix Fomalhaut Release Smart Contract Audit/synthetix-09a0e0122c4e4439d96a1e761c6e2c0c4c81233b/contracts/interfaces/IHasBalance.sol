// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Fomalhaut Release Smart Contract Audit/synthetix-09a0e0122c4e4439d96a1e761c6e2c0c4c81233b/contracts/interfaces/IHasBalance.sol

pragma solidity >=0.4.24;


interface IHasBalance {
    // Views
    function balanceOf(address account) external view returns (uint);
}
