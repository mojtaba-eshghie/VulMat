// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Aloith Release Smart Contract Audit/synthetix-b16096e70ab88eff7d0e423974a2958edff42b2a/contracts/interfaces/IHasBalance.sol

pragma solidity >=0.4.24;

// https://docs.synthetix.io/contracts/source/interfaces/ihasbalance
interface IHasBalance {
    // Views
    function balanceOf(address account) external view returns (uint);
}
