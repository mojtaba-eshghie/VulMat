// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-AragonOS and Aragon Apps/aragon-apps-cdaee275d2831168a4ce2b9843a1f62abcf8e210/future-apps/payroll/test/mocks/oracle/OracleInterface.sol

pragma solidity 0.4.18;


// TODO: interface
contract OracleInterface {
    function query(address token, address pr) public returns(bool);
}
