// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragon-agent-buidler-test-cdaee275d2831168a4ce2b9843a1f62abcf8e210/future-apps/payroll/test/mocks/oracle/OracleInterface.sol

pragma solidity 0.4.18;


// TODO: interface
contract OracleInterface {
    function query(address token, address pr) public returns(bool);
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragon-agent-buidler-test-cdaee275d2831168a4ce2b9843a1f62abcf8e210/future-apps/payroll/test/mocks/oracle/OracleMock.sol

pragma solidity 0.4.18;

contract PayrollInterface {
    function setExchangeRate(address, uint256) external;
}


contract OracleMock is OracleInterface {

    event OracleLogSetPayroll(address sender, address pr);
    event OracleLogSetRate(address sender, address token, uint256 value);

    function query(address pr, address token) public returns(bool) {
        uint256 rate = toInt(token);
        setRate(pr, token, rate);
        return true;
    }

    function setRate(address pr, address token, uint256 rate) public {
        PayrollInterface payroll = PayrollInterface(pr);
        payroll.setExchangeRate(token, rate);
        OracleLogSetRate(msg.sender, token, rate);
    }

    /// Gets the first byte of an address as an integer
    function toInt(address x) public pure returns(uint256 i) {
        i = uint(x);
        i = i >> 152;
        if (i == 0)
            i = 1;
        i = i * 10**8;
    }
}
