// File: ../sc_datasets/DAppSCAN/QuillAudits-Akropolis-Vesting/AkropolisToken-28a415392489a1a88073c3d0fd22b141f4d3170e/contracts/upgradeability/mocks/DummyContract.sol

pragma solidity >=0.4.24;

contract DummyContractV0 {
    function hello() public pure returns(string) {
        return "Konichiwa!";
    }
}

contract DummyContractV1 is DummyContractV0 {
    function hello() public pure returns(string) {
        return "Hello!";
    }

    function goodbye() public pure returns(string) {
        return "Adios";
    }
}
