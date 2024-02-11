// File: ../sc_datasets/DAppSCAN/openzeppelin-ACO_Protocol/aco-36bcab024c9781d799381f8f973e99fd5b0f4d2d/smart-contracts/contracts/interfaces/IWETH.sol

pragma solidity ^0.6.6;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}
