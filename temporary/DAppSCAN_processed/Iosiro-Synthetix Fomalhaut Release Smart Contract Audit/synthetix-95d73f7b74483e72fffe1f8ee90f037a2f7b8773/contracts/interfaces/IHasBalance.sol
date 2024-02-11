// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Fomalhaut Release Smart Contract Audit/synthetix-95d73f7b74483e72fffe1f8ee90f037a2f7b8773/contracts/interfaces/IHasBalance.sol

pragma solidity >=0.4.24;


interface IHasBalance {
    // Views
    function balanceOf(address account) external view returns (uint);
}
