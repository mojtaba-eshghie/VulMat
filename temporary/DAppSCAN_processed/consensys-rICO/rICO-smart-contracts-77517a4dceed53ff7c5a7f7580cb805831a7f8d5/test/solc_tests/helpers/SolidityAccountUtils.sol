// File: ../sc_datasets/DAppSCAN/consensys-rICO/rICO-smart-contracts-77517a4dceed53ff7c5a7f7580cb805831a7f8d5/test/solc_tests/helpers/SolidityAccountUtils.sol

pragma solidity ^0.5.10;

contract SolidityAccountUtils {
    function transferTo(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function getBalance(address _address) public view returns (uint256) {
        return _address.balance;
    }
}
