// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-06ce31002922e91aa40898dacd18d1c7f8d0e48f/contracts/interfaces/IHasBalance.sol

pragma solidity >=0.4.24;

// https://docs.synthetix.io/contracts/source/interfaces/ihasbalance
interface IHasBalance {
    // Views
    function balanceOf(address account) external view returns (uint);
}
