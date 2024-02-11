// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragon-agent-buidler-test-cdaee275d2831168a4ce2b9843a1f62abcf8e210/future-apps/payroll/test/mocks/oracle/OracleInterface.sol

pragma solidity 0.4.18;


// TODO: interface
contract OracleInterface {
    function query(address token, address pr) public returns(bool);
}
