// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-3b03563c0808adf13227bf729df42d8b7869c55a/contracts/interfaces/IHasBalance.sol

pragma solidity >=0.4.24;


// https://docs.synthetix.io/contracts/source/interfaces/ihasbalance
interface IHasBalance {
    // Views
    function balanceOf(address account) external view returns (uint);
}
