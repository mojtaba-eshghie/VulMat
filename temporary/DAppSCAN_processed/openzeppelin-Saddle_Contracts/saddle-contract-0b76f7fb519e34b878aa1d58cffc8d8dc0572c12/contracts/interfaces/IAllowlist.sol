// File: ../sc_datasets/DAppSCAN/openzeppelin-Saddle_Contracts/saddle-contract-0b76f7fb519e34b878aa1d58cffc8d8dc0572c12/contracts/interfaces/IAllowlist.sol

pragma solidity 0.5.17;

interface IAllowlist {
    function getAllowedAmount(address poolAddress, address user) external view returns (uint256);
    function getPoolCap(address poolAddress) external view returns (uint256);
}
