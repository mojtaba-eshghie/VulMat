// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Fomalhaut Release Smart Contract Audit/synthetix-b1bbcf88cc3f49e5d67954003313ede4520ba00a/contracts/interfaces/IHasBalance.sol

pragma solidity >=0.4.24;


interface IHasBalance {
    // Views
    function balanceOf(address account) external view returns (uint);
}
