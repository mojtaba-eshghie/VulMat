// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/IOracle.sol

pragma solidity 0.4.25;


/// @title IOracle
/// @dev Interface for getting the data from the oracle contract.
interface IOracle {
    function ethUsdPrice() external view returns(uint256);
}
