// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IStaking.sol

pragma solidity 0.5.9;


interface IStaking {
    function clearUnremovableValidator(address) external;
    function incrementStakingEpoch() external;
    function removePool(address) external;
    function erc20Restricted() external view returns(bool);
    function erc20TokenContract() external view returns(address);
    function getPoolsLikelihood() external view returns(int256[] memory, int256);
    function getPoolsToBeElected() external view returns(address[] memory);
    function getPoolsToBeRemoved() external view returns(address[] memory);
    function poolDelegators(address) external view returns(address[] memory);
    function stakeAmountMinusOrderedWithdraw(address, address) external view returns(uint256);
    function stakeAmountTotalMinusOrderedWithdraw(address) external view returns(uint256);
    function stakingEpoch() external view returns(uint256);
}
