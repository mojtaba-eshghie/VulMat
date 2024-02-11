// File: ../sc_datasets/DAppSCAN/consensys-ENS_Permanent_Registrar/ethregistrar-e52abfc2799ac361364aca6135fc20f9175a29fd/contracts/DummyOracle.sol

pragma solidity >=0.4.24;

contract DummyOracle {
    uint value;

    constructor(uint _value) public {
        set(_value);
    }

    function set(uint _value) public {
        value = _value;
    }

    function read() external view returns (bytes32) {
        return bytes32(value);
    }
}
