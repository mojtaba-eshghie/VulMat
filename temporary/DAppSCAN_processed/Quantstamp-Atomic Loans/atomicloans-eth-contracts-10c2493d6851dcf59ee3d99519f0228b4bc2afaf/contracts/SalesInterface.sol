// File: ../sc_datasets/DAppSCAN/Quantstamp-Atomic Loans/atomicloans-eth-contracts-10c2493d6851dcf59ee3d99519f0228b4bc2afaf/contracts/SalesInterface.sol

pragma solidity ^0.5.10;

interface SalesInterface {
    function saleIndexByLoan(bytes32, uint256) external returns(bytes32);
    function settlementExpiration(bytes32) external view returns (uint256);
    function accepted(bytes32) external view returns (bool);
    function next(bytes32) external view returns (uint256);
    function create(bytes32, address, address, address, address, bytes32, bytes32, bytes32, bytes32, bytes20) external returns(bytes32);
}
