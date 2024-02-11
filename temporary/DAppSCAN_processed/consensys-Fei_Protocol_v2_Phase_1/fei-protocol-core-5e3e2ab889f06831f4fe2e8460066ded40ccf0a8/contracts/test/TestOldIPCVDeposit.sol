// File: ../sc_datasets/DAppSCAN/consensys-Fei_Protocol_v2_Phase_1/fei-protocol-core-5e3e2ab889f06831f4fe2e8460066ded40ccf0a8/contracts/test/TestOldIPCVDeposit.sol

pragma solidity ^0.8.4;

/// @title A test PCV Deposit interface
/// @author Fei Protocol
interface TestOldIPCVDeposit {
    // ----------- Events -----------
    event Deposit(address indexed _from, uint256 _amount);

    event Withdrawal(
        address indexed _caller,
        address indexed _to,
        uint256 _amount
    );

    // ----------- State changing api -----------

    function deposit(uint256 amount) external payable;

    // ----------- PCV Controller only state changing api -----------

    function withdraw(address to, uint256 amount) external;

    // ----------- Getters -----------

    function totalValue() external view returns (uint256);
}
