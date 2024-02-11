// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IStakingHBBFT.sol

pragma solidity 0.5.9;


interface IStakingHBBFT {
    function initialize(
        address,
        address[] calldata,
        uint256,
        uint256,
        bool
    ) external;
}
