// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Fomalhaut Release Smart Contract Audit/synthetix-bb4c0f3a52db71d03e4630dd9a603247e45dd01d/contracts/interfaces/IHasBalance.sol

pragma solidity >=0.4.24;


interface IHasBalance {
    // Views
    function balanceOf(address account) external view returns (uint);
}
